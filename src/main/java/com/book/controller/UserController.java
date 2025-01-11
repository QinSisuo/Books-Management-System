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
@RequestMapping("/user")
public class UserController {

    @Autowired
    private LoginService loginService;

    @Autowired
    private UserService userService;

    // 显示登录页面
    @GetMapping("/index")
    public String showLoginPage(HttpServletRequest request) {
        // 清除会话，确保用户重新登录
        request.getSession().invalidate();
        return "index"; // 登录页面 JSP 文件路径
    }

    // 注销功能
    @GetMapping("/logout")
    public String logout(HttpServletRequest request) {
        request.getSession().invalidate(); // 清除会话
        return "redirect:/user/index"; // 跳转回登录页面
    }

    // 处理登录表单提交
    @PostMapping("/index")
    public @ResponseBody HashMap<String, String> loginCheck(@RequestParam int id,
                                                            @RequestParam String password,
                                                            HttpServletRequest request) {
        boolean isReader = loginService.hasMatchReader(id, password);
        boolean isAdmin = loginService.hasMatchAdmin(id, password);
        HashMap<String, String> res = new HashMap<>();

        if (!isAdmin && !isReader) {
            res.put("stateCode", "0");
            res.put("msg", "账号或密码错误！");
        } else if (isAdmin) {
            // 管理员登录成功
            Admin admin = new Admin();
            admin.setAdminId(id);
            admin.setPassword(password);
            request.getSession().setAttribute("admin", admin);
            res.put("stateCode", "1");
            res.put("msg", "管理员登录成功！");
        } else {
            // 读者登录成功
            ReaderCard readerCard = loginService.findReaderCardByUserId(id);
            request.getSession().setAttribute("readerCard", readerCard);
            res.put("stateCode", "2");
            res.put("msg", "读者登录成功！");
        }
        return res;
    }

    // 管理员主页
    @GetMapping("/admin_main")
    public ModelAndView toAdminMain() {
        return new ModelAndView("admin_main");
    }

    // 读者主页
    @GetMapping("/reader_main")
    public ModelAndView toReaderMain() {
        return new ModelAndView("reader_main");
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
                                  @RequestParam String reNewPasswd,
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
    @RequestMapping("*")
    public String notFound() {
        return "404";
    }
}