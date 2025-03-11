package com.book.controller;

import com.book.domain.User;
import com.book.service.UserService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.HttpServletRequest;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

//@Controller: 这是一个 Spring MVC 控制器，处理 HTTP 请求。
@Controller
public class UserController {

    private static final Logger logger = LoggerFactory.getLogger(UserController.class); // 日志对象

    @Autowired
    private UserService userService;

    // 显示登录页面
    //@RequestMapping("/admin"): 该控制器的所有路径都会以 /admin 开头。
    @RequestMapping(value = {"/", "/login.html"})
    public String showLoginPage(HttpServletRequest request) {
        request.getSession().invalidate(); // 清除会话
        logger.info("访问登录页面"); // 添加日志
        return "index"; // 登录页面对应的 JSP 文件
    }

    // 登录校验
    @RequestMapping(value = "/api/loginCheck", method = RequestMethod.POST)
    public @ResponseBody Map<String, String> loginCheck(HttpServletRequest request) {
        String username = request.getParameter("username");
        String password = request.getParameter("password");

        logger.info("尝试登录 - 用户名: {}", username); // 添加日志

        User user = userService.login(username, password); // 调用 Service 层获取用户

        Map<String, String> res = new HashMap<>();
        if (user == null) {
            logger.warn("登录失败 - 用户名: {}", username); // 添加日志
            res.put("stateCode", "0");
            res.put("msg", "账号或密码错误！");
        } else {
            request.getSession().setAttribute("user", user); // 保存用户到 session
            logger.info("登录成功 - 用户名: {}, 角色: {}", user.getUsername(), user.getRole()); // 添加日志

            String role = user.getRole().toLowerCase();
            if ("admin".equals(role)) {
                res.put("stateCode", "1"); // 管理员角色
                res.put("msg", "管理员登录成功！");
            } else if ("reader".equals(role)) {
                res.put("stateCode", "2"); // 读者角色
                res.put("msg", "读者登录成功！");
            } else {
                logger.error("未知角色 - 用户名: {}, 角色: {}", user.getUsername(), user.getRole()); // 添加日志
                res.put("stateCode", "3"); // 未知角色
                res.put("msg", "未知用户角色！");
            }
        }
        return res;
    }


    @GetMapping("/admin_main")
    public String showDashboard(HttpServletRequest request, Model model) {
        User user = (User) request.getSession().getAttribute("user");

        // 将 user 对象添加到模型中
        model.addAttribute("user", user);

        return "admin_main";  // 返回 JSP 页面
    }

    // 注销功能
    @GetMapping("/logout")
    public String logout(HttpServletRequest request) {
        logger.info("用户注销: {}", request.getSession().getAttribute("user")); // 添加日志
        request.getSession().invalidate(); // 清除会话
        return "redirect:/login.html";
    }

    // admin页面
    @RequestMapping("/admin_main.html")
    public ModelAndView toAdminMain(HttpServletRequest request) {
        User user = (User) request.getSession().getAttribute("user");
        if (user == null || !"admin".equals(user.getRole())) {
            logger.warn("非管理员访问管理员页面 - 跳转登录页面"); // 添加日志
            return new ModelAndView("redirect:/login.html");
        }
        logger.info("管理员页面访问成功 - 用户名: {}", user.getUsername()); // 添加日志
        return new ModelAndView("admin_main").addObject("user", user);
    }
    //reader页面
    @RequestMapping("/reader_main.html")
    public ModelAndView toReaderMain(HttpServletRequest request) {
        User user = (User) request.getSession().getAttribute("user");
        if (user == null || !"reader".equals(user.getRole())) {
            logger.warn("非读者访问读者页面 - 跳转登录页面"); // 日志记录
            return new ModelAndView("redirect:/login.html");
        }
        logger.info("读者页面访问成功 - 用户名: {}", user.getUsername()); // 日志记录
        return new ModelAndView("reader_main").addObject("user", user);
    }

    //admin page show all users
    @GetMapping("admin_all_users.html")
    public String showAllUsers(Model model) {
        List<User> userList = userService.getAllUsers();
        model.addAttribute("users", userList);
        return "admin_all_users";  // 显示用户列表的 JSP 页面
    }

    //admin user delete
    @GetMapping("/admin/user/delete")
    public String deleteUser(@RequestParam("userId") int userId, Model model) {
        boolean success = userService.deleteUser(userId);
        if (success) {
            model.addAttribute("succ", "用户删除成功");
            logger.info("User with ID {} deleted successfully", userId);
        } else {
            model.addAttribute("error", "用户删除失败");
        }
        return "redirect:/admin_all_users.html";
    }

    //admin add page
    @GetMapping("/admin_user_add.html")
    public String showAddUserPage() {
        logger.info("管理员正在进入添加用户页面");
        return "admin_user_add";  // 确保这个视图名称与实际的JSP文件名匹配
    }

    //admin add logic
    @PostMapping("/admin/user/add")
    public String addUser(@RequestParam("username") String username,
                          @RequestParam("password") String password,
                          @RequestParam("role") String role,
                          @RequestParam(value = "email", required = false) String email,
                          @RequestParam(value = "phone", required = false) String phone,
                          @RequestParam(value = "address", required = false) String address,
                          RedirectAttributes redirectAttributes) {
        User newUser = new User();
        newUser.setUsername(username);
        newUser.setPassword(password);
        newUser.setRole(role);
        newUser.setEmail(email);
        newUser.setPhone(phone);
        newUser.setAddress(address);

        boolean success = userService.addUser(newUser);
        if (success) {
            redirectAttributes.addFlashAttribute("succ", "用户新增成功！");
        } else {
            redirectAttributes.addFlashAttribute("error", "用户新增失败，请检查输入！");
        }

        return "redirect:/admin_all_users.html";
    }

    //admin edit
    @PostMapping("/admin/user/update")
    public String updateUser(@ModelAttribute User user, RedirectAttributes redirectAttributes) {
        boolean success = userService.updateUser(user);
        if (success) {
            redirectAttributes.addFlashAttribute("succ", "用户更新成功！");
        } else {
            redirectAttributes.addFlashAttribute("error", "用户更新失败，请检查输入！");
        }
        return "redirect:/admin_all_users.html";
    }

    // =============== 整合UserAdminController的功能 ===============
    
    // 1. 查看所有读者
    @GetMapping("/admin/readers")
    public String getAllReaders(Model model) {
        logger.info("管理员正在查看所有读者信息");
        List<User> readers = userService.getAllReaders();
        model.addAttribute("readers", readers);
        return "admin_readers";
    }

    // 2. 添加读者页面
    @GetMapping("/admin/reader/add")
    public String showAddReaderPage() {
        logger.info("管理员正在进入添加读者页面");
        return "admin_reader_add";
    }

    // 3. 添加读者逻辑
    @PostMapping("/admin/reader/add")
    public String addReader(@ModelAttribute User user, RedirectAttributes redirectAttributes) {
        logger.info("管理员正在添加新读者 - 用户名: {}", user.getUsername());
        boolean success = userService.addReader(user);
        if (success) {
            logger.info("读者添加成功 - 用户名: {}", user.getUsername());
            redirectAttributes.addFlashAttribute("success", "读者添加成功！");
        } else {
            logger.error("读者添加失败 - 用户名: {}", user.getUsername());
            redirectAttributes.addFlashAttribute("error", "读者添加失败！");
        }
        return "redirect:/admin/readers";
    }

    // 4. 编辑读者页面
    @GetMapping("/admin/reader/edit/{id}")
    public String showEditReaderPage(@PathVariable("id") int id, Model model) {
        logger.info("管理员正在进入编辑读者页面 - 读者ID: {}", id);
        User reader = userService.getReaderById(id);
        if (reader == null) {
            logger.warn("无法找到指定读者 - 读者ID: {}", id);
            model.addAttribute("error", "无法找到指定的读者！");
            return "admin_readers";
        }
        model.addAttribute("reader", reader);
        return "admin_reader_edit";
    }

    // 5. 更新读者信息
    @PostMapping("/admin/reader/edit")
    public String editReader(@ModelAttribute User user, RedirectAttributes redirectAttributes) {
        logger.info("管理员正在更新读者信息 - 读者ID: {}", user.getUserId());
        boolean success = userService.updateReader(user);
        if (success) {
            logger.info("读者信息更新成功 - 读者ID: {}", user.getUserId());
            redirectAttributes.addFlashAttribute("success", "读者信息更新成功！");
        } else {
            logger.error("读者信息更新失败 - 读者ID: {}", user.getUserId());
            redirectAttributes.addFlashAttribute("error", "读者信息更新失败！");
        }
        return "redirect:/admin/readers";
    }

    // 6. 删除读者
    @PostMapping("/admin/reader/delete/{id}")
    public String deleteReader(@PathVariable("id") int id, RedirectAttributes redirectAttributes) {
        logger.info("管理员正在删除读者 - 读者ID: {}", id);
        boolean success = userService.deleteReader(id);
        if (success) {
            logger.info("读者删除成功 - 读者ID: {}", id);
            redirectAttributes.addFlashAttribute("success", "读者删除成功！");
        } else {
            logger.error("读者删除失败 - 读者ID: {}", id);
            redirectAttributes.addFlashAttribute("error", "读者删除失败！");
        }
        return "redirect:/admin/readers";
    }
}
