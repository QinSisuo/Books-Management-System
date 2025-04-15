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

/**
 * 用户控制器
 * 处理所有与用户相关的HTTP请求
 */
@Controller
public class UserController {

    private static final Logger logger = LoggerFactory.getLogger(UserController.class);

    @Autowired
    private UserService userService;

    // =============== 页面跳转相关方法 ===============
    
    /**
     * 显示登录页面
     * @RequestMapping("/admin"): 该控制器的所有路径都会以 /admin 开头。
     */
    @RequestMapping(value = {"/", "/login.html"})
    public String showLoginPage(HttpServletRequest request) {
        request.getSession().invalidate();
        logger.info("访问登录页面");
        return "index";
    }

    /**
     * 显示注册页面
     */
    @RequestMapping("/register.html")
    public String showRegisterPage() {
        logger.info("访问注册页面");
        return "register";
    }

    /**
     * 显示管理员主页面
     */
    @RequestMapping("/admin_main.html")
    public ModelAndView toAdminMain(HttpServletRequest request) {
        User user = (User) request.getSession().getAttribute("user");
        if (user == null || !"admin".equals(user.getRole())) {
            logger.warn("非管理员访问管理员页面 - 跳转登录页面");
            return new ModelAndView("redirect:/login.html");
        }
        logger.info("管理员页面访问成功 - 用户名: {}", user.getUsername());
        return new ModelAndView("admin/admin_main").addObject("user", user);
    }

    /**
     * 显示读者主页面
     */
    @RequestMapping("/reader_main.html")
    public ModelAndView toReaderMain(HttpServletRequest request) {
        User user = (User) request.getSession().getAttribute("user");
        if (user == null || !"reader".equals(user.getRole())) {
            logger.warn("非读者访问读者页面 - 跳转登录页面");
            return new ModelAndView("redirect:/login.html");
        }
        logger.info("读者页面访问成功 - 用户名: {}", user.getUsername());
        return new ModelAndView("reader/reader_main").addObject("user", user);
    }

    // =============== 用户认证相关方法 ===============
    
    /**
     * 处理用户注册请求
     */
    @PostMapping("/api/register")
    @ResponseBody
    public Map<String, Object> register(@RequestParam("username") String username,
                                      @RequestParam("password") String password,
                                      @RequestParam(value = "email", required = false) String email,
                                      @RequestParam(value = "phone", required = false) String phone,
                                      HttpServletRequest request) {
        Map<String, Object> response = new HashMap<>();
        
        try {
            if (userService.getUserByUsername(username) != null) {
                response.put("success", false);
                response.put("message", "用户名已存在！");
                return response;
            }

            User newUser = new User();
            newUser.setUsername(username);
            newUser.setPassword(password);
            newUser.setEmail(email);
            newUser.setPhone(phone);
            newUser.setRole("reader"); // 默认注册为读者角色

            boolean success = userService.addUser(newUser, request);
            
            response.put("success", success);
            response.put("message", success ? "注册成功" : "注册失败");
            
            return response;
        } catch (Exception e) {
            logger.error("注册失败", e);
            response.put("success", false);
            response.put("message", "注册失败：" + e.getMessage());
            return response;
        }
    }

    /**
     * 处理用户登录请求
     */
    @RequestMapping(value = "/api/loginCheck", method = RequestMethod.POST)
    public @ResponseBody Map<String, String> loginCheck(HttpServletRequest request) {
        String username = request.getParameter("username");
        String password = request.getParameter("password");

        logger.info("尝试登录 - 用户名: {}", username);

        User user = userService.login(username, password, request);

        Map<String, String> res = new HashMap<>();
        if (user == null) {
            logger.warn("登录失败 - 用户名: {}", username);
            res.put("stateCode", "0");
            res.put("msg", "账号或密码错误！");
        } else {
            request.getSession().setAttribute("user", user);
            logger.info("登录成功 - 用户名: {}, 角色: {}", user.getUsername(), user.getRole());

            String role = user.getRole().toLowerCase();
            if ("admin".equals(role)) {
                res.put("stateCode", "1");
                res.put("msg", "管理员登录成功！");
            } else if ("reader".equals(role)) {
                res.put("stateCode", "2");
                res.put("msg", "读者登录成功！");
            } else {
                logger.error("未知角色 - 用户名: {}, 角色: {}", user.getUsername(), user.getRole());
                res.put("stateCode", "3");
                res.put("msg", "未知用户角色！");
            }
        }
        return res;
    }

    /**
     * 处理用户注销请求
     */
    @GetMapping("/logout")
    public String logout(HttpServletRequest request) {
        logger.info("用户注销: {}", request.getSession().getAttribute("user"));
        request.getSession().invalidate();
        return "redirect:/login.html";
    }

    // =============== 用户管理相关方法 ===============
    
    /**
     * 查询用户列表
     */
    @RequestMapping(value = "/queryuser.html", method = RequestMethod.GET)
    public ModelAndView adminQueryUser(@RequestParam(required = false) String searchWord) {
        ModelAndView mav = new ModelAndView("admin/admin_user_manage");

        List<User> users;
        if (searchWord == null || searchWord.trim().isEmpty()) {
            users = userService.getAllUsers();
        } else {
            users = userService.searchUsers(searchWord);
        }

        if (!users.isEmpty()) {
            mav.addObject("users", users);
        } else {
            mav.addObject("error", "没有匹配的用户");
        }
        mav.addObject("searchWord", searchWord);

        return mav;
    }

    /**
     * 显示所有用户列表
     */
    @GetMapping("admin_user_manage.html")
    public String showAllUsers(Model model) {
        List<User> userList = userService.getAllUsers();
        model.addAttribute("users", userList);
        return "admin/admin_user_manage";
    }

    /**
     * 删除用户
     */
    @GetMapping("/admin/user/delete")
    public String deleteUser(@RequestParam("userId") Long userId, HttpServletRequest request, Model model) {
        boolean success = userService.deleteUser(userId, request);
        if (success) {
            model.addAttribute("succ", "用户删除成功");
            logger.info("User with ID {} deleted successfully", userId);
        } else {
            model.addAttribute("error", "用户删除失败");
        }
        return "redirect:/admin_user_manage.html";
    }

    /**
     * 添加用户
     */
    @PostMapping("/admin/user/add")
    @ResponseBody
    public Map<String, Object> addUser(@RequestParam("username") String username,
                                     @RequestParam("password") String password,
                                     @RequestParam("role") String role,
                                     @RequestParam(value = "email", required = false) String email,
                                     @RequestParam(value = "phone", required = false) String phone,
                                     HttpServletRequest request) {
        Map<String, Object> response = new HashMap<>();
        
        try {
            User currentUser = (User) request.getSession().getAttribute("user");
            if (currentUser == null || !"admin".equals(currentUser.getRole())) {
                logger.warn("非管理员尝试添加用户");
                response.put("success", false);
                response.put("message", "非管理员无法添加用户");
                return response;
            }

            if (username == null || username.trim().isEmpty()) {
                response.put("success", false);
                response.put("message", "用户名不能为空！");
                return response;
            }
            if (password == null || password.trim().isEmpty()) {
                response.put("success", false);
                response.put("message", "密码不能为空！");
                return response;
            }
            if (role == null || (!role.equals("admin") && !role.equals("reader"))) {
                response.put("success", false);
                response.put("message", "无效的用户角色！");
                return response;
            }

            User newUser = new User();
            newUser.setUsername(username.trim());
            newUser.setPassword(password.trim());
            newUser.setRole(role);
            newUser.setEmail(email != null ? email.trim() : null);
            newUser.setPhone(phone != null ? phone.trim() : null);
            
            logger.info("管理员[{}]正在添加新用户 - 用户名: {}, 角色: {}", 
                       currentUser.getUsername(), username, role);

            boolean success = userService.addUser(newUser, request);
            
            response.put("success", success);
            response.put("message", success ? "用户添加成功" : "用户添加失败");
            
            return response;
        } catch (Exception e) {
            logger.error("添加用户时发生错误", e);
            response.put("success", false);
            response.put("message", "添加失败：" + e.getMessage());
            return response;
        }
    }

    /**
     * 更新用户信息
     */
    @PostMapping("/admin/user/update")
    @ResponseBody
    public Map<String, Object> updateUser(@ModelAttribute User user, HttpServletRequest request) {
        Map<String, Object> response = new HashMap<>();
        try {
            boolean success = userService.updateUser(user, request);
            response.put("success", success);
            response.put("message", success ? "用户更新成功" : "用户更新失败");
        } catch (Exception e) {
            response.put("success", false);
            response.put("message", "更新失败：" + e.getMessage());
        }
        return response;
    }

    // =============== 个人信息管理相关方法 ===============
    
    /**
     * 显示个人信息页面
     */
    @GetMapping("/reader/profile")
    public String showProfilePage(HttpServletRequest request, Model model) {
        User user = (User) request.getSession().getAttribute("user");
        if (user == null) {
            return "redirect:/login.html";
        }
        model.addAttribute("user", user);
        return "reader/profile";
    }

    /**
     * 更新个人信息
     */
    @PostMapping("/reader/profile/update")
    @ResponseBody
    public Map<String, Object> updateProfile(@ModelAttribute User user,
                                           @RequestParam(required = false) String newPassword,
                                           HttpServletRequest request) {
        Map<String, Object> response = new HashMap<>();
        
        try {
            User currentUser = (User) request.getSession().getAttribute("user");
            if (currentUser == null || !currentUser.getUserId().equals(user.getUserId())) {
                response.put("success", false);
                response.put("message", "无权修改其他用户的信息");
                return response;
            }
            
            user.setRole(currentUser.getRole());
            
            boolean success = userService.updateUserProfile(user, newPassword, request);
            
            if (success) {
                request.getSession().setAttribute("user", user);
            }
            
            response.put("success", success);
            response.put("message", success ? "个人信息更新成功" : "个人信息更新失败");
            
        } catch (Exception e) {
            logger.error("更新个人信息时发生错误", e);
            response.put("success", false);
            response.put("message", "更新失败：" + e.getMessage());
        }
        
        return response;
    }
}
