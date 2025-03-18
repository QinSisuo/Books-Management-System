package com.book.domain;

import lombok.Data;
import java.util.Date;

@Data
public class Notification {
    private Long notificationId;
    private Integer userId;
    private Integer type;
    private String title;
    private String content;
    private Date createTime;
    private Date readTime;
    private Integer status;
    private Integer priority;
} 