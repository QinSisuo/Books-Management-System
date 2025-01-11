package com.book.controller;

import com.book.domain.Admin;
import com.book.domain.ReaderCard;
import com.book.domain.User;
import com.book.service.LoginService;
import com.book.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.HashMap;

@Controller
//@RequestMapping("/book")
public class UserController {

    @Autowired
    private LoginService loginService;

    @Autowired
    private UserService userService;

    // 显示登录页面
    @RequestMapping(value = {"/","/login.html"})
    public String showLoginPage(HttpServletRequest request) {
        request.getSession().invalidate(); // 清除会话
        return "index"; // 登录页面 JSP 文件路径
    }

    // 处理登录逻辑


    @RequestMapping(value = "/api/loginCheck", method = RequestMethod.POST)
    public @ResponseBody Object loginCheck(HttpServletRequest request) {
        System.out.println("进入 loginCheck 方法");  // 记录日志，确认是否进入该方法

        int id = Integer.parseInt(request.getParameter("id"));
        String passwd = request.getParameter("passwd");
        boolean isReader = loginService.hasMatchReader(id, passwd);
        boolean isAdmin = loginService.hasMatchAdmin(id, passwd);

        HashMap<String, String> res = new HashMap<>();
        if (!isAdmin && !isReader) {
            res.put("stateCode", "0");
            res.put("msg", "账号或密码错误！");
        } else if (isAdmin) {
            Admin admin = new Admin();
            admin.setAdminId(id);
            admin.setPassword(passwd);
            request.getSession().setAttribute("admin", admin);
            res.put("stateCode", "1");
            res.put("msg", "管理员登陆成功！");
        } else {
            ReaderCard readerCard = loginService.findReaderCardByUserId(id);
            request.getSession().setAttribute("readercard", readerCard);
            res.put("stateCode", "2");
            res.put("msg", "读者登陆成功！");
        }
        return res;
    }



    // 注销功能
    @GetMapping("/logout")
    public String logout(HttpServletRequest request) {
        request.getSession().invalidate(); // 清除会话
        return "redirect:/user/index"; // 跳转到登录页面
    }

    // 管理员主页
    @RequestMapping("/admin_main.html")
    public ModelAndView toAdminMain(HttpServletRequest request) {
        Admin admin = (Admin) request.getSession().getAttribute("admin");
        String login = (admin != null) ? "true" : "false"; // 根据实际情况设置 login 变量
        ModelAndView modelAndView = new ModelAndView("admin_main"); // 不需要写完整路径
        modelAndView.addObject("login", login);
        modelAndView.addObject("admin", admin);
        return modelAndView;
    }

    // 读者主页
    @GetMapping("/reader/reader_main")
    public ModelAndView toReaderMain() {
        return new ModelAndView("reader/reader_main");
    }

    // 修改管理员密码页面
    @GetMapping("/admin_repasswd")
    public ModelAndView reAdminPasswd() {
        return new ModelAndView("admin_repasswd");
    }

    // 修改管理员密码逻辑
    @PostMapping("/admin_repasswd_do")
    public String reAdminPasswdDo(HttpServletRequest request,
                                  @RequestParam String oldPasswd,
                                  @RequestParam String newPasswd,
                                  RedirectAttributes redirectAttributes) {

        Admin admin = (Admin) request.getSession().getAttribute("admin");
        int id = admin.getAdminId();
        String currentPasswd = loginService.getAdminPasswd(id);

        if (currentPasswd.equals(oldPasswd)) {
            boolean success = loginService.adminRePasswd(id, newPasswd);
            if (success) {
                redirectAttributes.addFlashAttribute("succ", "密码修改成功！");
            } else {
                redirectAttributes.addFlashAttribute("error", "密码修改失败！");
            }
        } else {
            redirectAttributes.addFlashAttribute("error", "旧密码错误！");
        }
        return "redirect:/user/admin_repasswd";
    }

    // 配置 404 页面
    @RequestMapping("/notfound")
    public String notFound() {
        return "404";
    }

}