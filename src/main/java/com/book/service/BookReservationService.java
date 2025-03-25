package com.book.service;

import com.book.domain.BookReservation;
import java.util.List;

public interface BookReservationService {
    /**
     * 创建预约
     */
    boolean createReservation(Long bookId, Long readerId);
    
    /**
     * 获取读者的预约记录
     */
    List<BookReservation> getMyReservations(Long readerId);
    
    /**
     * 检查图书是否有有效预约
     */
    boolean hasActiveReservation(Long bookId);
    
    /**
     * 通知预约的读者
     */
    void notifyReservations(Long bookId);
} 