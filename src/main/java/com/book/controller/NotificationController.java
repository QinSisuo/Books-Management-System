package com.book.controller;

import com.book.domain.Notification;
import com.book.domain.User;
import com.book.service.NotificationService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpSession;
import java.util.List;

@Controller
public class NotificationController {

    @Autowired
    private NotificationService notificationService;

    /**
     * 获取用户的通知列表
     */
    @GetMapping("/notifications.html")
    public String getNotifications(HttpSession session, Model model) {
        User currentUser = (User) session.getAttribute("user");
        if (currentUser == null) {
            return "redirect:/login.html";
        }

        List<Notification> notifications = notificationService.getUserNotifications(currentUser.getUserId());
        model.addAttribute("notifications", notifications);
        return "notifications";
    }

    /**
     * 标记通知为已读
     */
    @PostMapping("/notification/read/{notificationId}")
    @ResponseBody
    public String markAsRead(@PathVariable Long notificationId) {
        notificationService.markAsRead(notificationId);
        return "success";
    }

    /**
     * 获取未读通知数量
     */
    @GetMapping("/notification/unread/count")
    @ResponseBody
    public int getUnreadCount(HttpSession session) {
        User currentUser = (User) session.getAttribute("user");
        if (currentUser == null) {
            return 0;
        }
        return notificationService.getUnreadCount(currentUser.getUserId());
    }

    /**
     * 标记所有通知为已读
     */
    @PostMapping("/notification/read/all")
    @ResponseBody
    public String markAllAsRead(HttpSession session) {
        User currentUser = (User) session.getAttribute("user");
        if (currentUser == null) {
            return "error";
        }
        notificationService.markAllAsRead(currentUser.getUserId());
        return "success";
    }
} 