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
    
    /**
     * 根据ID获取预约信息
     * @param reservationId 预约ID
     * @return 预约信息
     */
    BookReservation getReservationById(Long reservationId);
    
    /**
     * 取消预约
     * @param reservationId 预约ID
     * @return 是否取消成功
     */
    boolean cancelReservation(Long reservationId);
} 