package com.book.domain;

import lombok.Data;
import java.util.Date;

@Data
public class BookReservation {
    private Integer id;         // 预约ID
    private Long bookId;        // 图书ID
    private Integer readerId;   // 读者ID
    private Date reserveTime;   // 预约时间
    private Integer status;     // 状态：0=等待中, 1=已通知, 2=已取消
    private Date notifyTime;    // 通知时间
    private String bookName;    // 图书名称（用于显示）
} 