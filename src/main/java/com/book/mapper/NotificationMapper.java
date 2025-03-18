package com.book.mapper;

import com.book.domain.Notification;
import org.apache.ibatis.annotations.*;
import java.util.List;

@Mapper
public interface NotificationMapper {
    
    @Insert("INSERT INTO notification (user_id, type, title, content, create_time, status, priority) " +
            "VALUES (#{userId}, #{type}, #{title}, #{content}, NOW(), #{status}, #{priority})")
    @Options(useGeneratedKeys = true, keyProperty = "notificationId")
    void insert(Notification notification);
    
    @Select("SELECT * FROM notification WHERE user_id = #{userId} AND status = 0 ORDER BY create_time DESC")
    List<Notification> findUnreadByUserId(Integer userId);
    
    @Select("SELECT * FROM notification WHERE user_id = #{userId} ORDER BY create_time DESC")
    List<Notification> findByUserId(Integer userId);
    
    @Update("UPDATE notification SET status = #{status}, read_time = NOW() WHERE notification_id = #{notificationId}")
    int updateStatus(@Param("notificationId") Long notificationId, @Param("status") Integer status);
    
    @Update("UPDATE notification SET status = 1, read_time = NOW() WHERE user_id = #{userId} AND status = 0")
    int markAllAsRead(Integer userId);

    @Select("SELECT COUNT(*) FROM notification WHERE user_id = #{userId} AND status = 0")
    int countUnreadByUserId(Integer userId);

    @Update("UPDATE notification SET status = 1, read_time = NOW() WHERE notification_id = #{notificationId}")
    void markAsRead(Long notificationId);
} 