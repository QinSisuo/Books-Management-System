package com.book.controller;

import com.book.domain.User;
import com.book.service.UserAdminService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.List;

@Controller
@RequestMapping("/admin") // 所有路径以 /admin 开头
public class UserAdminController {

    private static final Logger logger = LoggerFactory.getLogger(UserAdminController.class);

    @Autowired
    private UserAdminService userAdminService;

    // 1. 查看所有读者
    @GetMapping("/readers")
    public String getAllReaders(Model model) {
        logger.info("管理员正在查看所有读者信息");
        List<User> readers = userAdminService.getAllReaders();
        model.addAttribute("readers", readers);
        return "admin_readers"; // 对应的 JSP 文件名：/WEB-INF/jsp/admin_readers.jsp
    }

    // 2. 添加读者页面
    @GetMapping("/reader/add")
    public String showAddReaderPage() {
        logger.info("管理员正在进入添加读者页面");
        return "admin_reader_add"; // 对应的 JSP 文件名：/WEB-INF/jsp/admin_reader_add.jsp
    }

    // 3. 添加读者逻辑
    @PostMapping("/reader/add")
    public String addReader(@ModelAttribute User user, RedirectAttributes redirectAttributes) {
        logger.info("管理员正在添加新读者 - 用户名: {}", user.getUsername());
        boolean success = userAdminService.addReader(user);
        if (success) {
            logger.info("读者添加成功 - 用户名: {}", user.getUsername());
            redirectAttributes.addFlashAttribute("success", "读者添加成功！");
        } else {
            logger.error("读者添加失败 - 用户名: {}", user.getUsername());
            redirectAttributes.addFlashAttribute("error", "读者添加失败！");
        }
        return "redirect:/admin/readers"; // 添加完成后重定向到读者列表
    }

    // 4. 编辑读者页面
    @GetMapping("/reader/edit/{id}")
    public String showEditReaderPage(@PathVariable("id") int id, Model model) {
        logger.info("管理员正在进入编辑读者页面 - 读者ID: {}", id);
        User reader = userAdminService.getReaderById(id);
        if (reader == null) {
            logger.warn("无法找到指定读者 - 读者ID: {}", id);
            model.addAttribute("error", "无法找到指定的读者！");
            return "admin_readers"; // 返回读者列表页面
        }
        model.addAttribute("reader", reader);
        return "admin_reader_edit"; // 对应的 JSP 文件名：/WEB-INF/jsp/admin_reader_edit.jsp
    }

    // 5. 更新读者信息
    @PostMapping("/reader/edit")
    public String editReader(@ModelAttribute User user, RedirectAttributes redirectAttributes) {
        logger.info("管理员正在更新读者信息 - 读者ID: {}", user.getUserId());
        boolean success = userAdminService.updateReader(user);
        if (success) {
            logger.info("读者信息更新成功 - 读者ID: {}", user.getUserId());
            redirectAttributes.addFlashAttribute("success", "读者信息更新成功！");
        } else {
            logger.error("读者信息更新失败 - 读者ID: {}", user.getUserId());
            redirectAttributes.addFlashAttribute("error", "读者信息更新失败！");
        }
        return "redirect:/admin/readers"; // 更新完成后重定向到读者列表
    }

    // 6. 删除读者
    @PostMapping("/reader/delete/{id}")
    public String deleteReader(@PathVariable("id") int id, RedirectAttributes redirectAttributes) {
        logger.info("管理员正在删除读者 - 读者ID: {}", id);
        boolean success = userAdminService.deleteReader(id);
        if (success) {
            logger.info("读者删除成功 - 读者ID: {}", id);
            redirectAttributes.addFlashAttribute("success", "读者删除成功！");
        } else {
            logger.error("读者删除失败 - 读者ID: {}", id);
            redirectAttributes.addFlashAttribute("error", "读者删除失败！");
        }
        return "redirect:/admin/readers"; // 删除完成后重定向到读者列表
    }
}
