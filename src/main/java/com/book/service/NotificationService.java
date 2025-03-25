package com.book.service;

import com.book.domain.Notification;
import com.book.mapper.NotificationMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.Date;
import java.util.List;

@Service
public class NotificationService {
    
    @Autowired
    private NotificationMapper notificationMapper;
    
    /**
     * 创建通知
     */
    @Transactional
    public void createNotification(Notification notification) {
        notification.setCreateTime(new Date());
        notification.setStatus(0); // 默认未读
        notificationMapper.insert(notification);
    }
    
    /**
     * 获取用户未读通知
     */
    public List<Notification> getUnreadNotifications(Long userId) {
        return notificationMapper.findUnreadByUserId(userId);
    }
    
    /**
     * 获取用户所有通知
     */
    public List<Notification> getAllNotifications(Long userId) {
        return notificationMapper.findByUserId(userId);
    }
    
    /**
     * 标记通知为已读
     */
    @Transactional
    public void markAsRead(Long notificationId) {
        notificationMapper.updateStatus(notificationId, 1);
    }
    
    /**
     * 标记所有通知为已读
     */
    @Transactional
    public void markAllAsRead(Long userId) {
        notificationMapper.markAllAsRead(userId);
    }
    
    /**
     * 创建逾期提醒通知
     */
    public void createOverdueNotification(Long userId, String bookName, Date dueTime) {
        Notification notification = new Notification();
        notification.setUserId(userId);
        notification.setType(1); // 逾期提醒
        notification.setTitle("图书逾期提醒");
        notification.setContent(String.format("您借阅的图书《%s》已逾期，请尽快归还。应还日期：%s", 
            bookName, dueTime));
        notification.setPriority(3); // 紧急
        createNotification(notification);
    }
    
    /**
     * 创建借阅成功通知
     */
    public void createBorrowSuccessNotification(Long userId, String bookName) {
        Notification notification = new Notification();
        notification.setUserId(userId);
        notification.setType(3); // 借阅成功通知
        notification.setTitle("借阅成功");
        notification.setContent(String.format("您已成功借阅图书《%s》", bookName));
        notification.setPriority(1); // 普通
        createNotification(notification);
    }
    
    /**
     * 创建归还成功通知
     */
    public void createReturnSuccessNotification(Long userId, String bookName) {
        Notification notification = new Notification();
        notification.setUserId(userId);
        notification.setType(3); // 归还成功通知
        notification.setTitle("归还成功");
        notification.setContent(String.format("您已成功归还图书《%s》", bookName));
        notification.setPriority(1); // 普通
        createNotification(notification);
    }

    /**
     * 获取用户的所有通知
     */
    public List<Notification> getUserNotifications(Long userId) {
        return notificationMapper.findByUserId(userId);
    }

    /**
     * 获取用户的未读通知数量
     */
    public int getUnreadCount(Long userId) {
        return notificationMapper.countUnreadByUserId(userId);
    }

    /**
     * 创建预约通知
     */
    public void createReservationNotification(Long userId, String bookName) {
        Notification notification = new Notification();
        notification.setUserId(userId);
        notification.setType(4); // 预约通知
        notification.setTitle("图书预约通知");
        notification.setContent(String.format("您已成功预约图书《%s》，请在预约时间内到馆借阅。", bookName));
        notification.setPriority(1); // 普通
        createNotification(notification);
    }
} 