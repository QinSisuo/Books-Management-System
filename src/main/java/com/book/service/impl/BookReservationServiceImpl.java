package com.book.service.impl;

import com.book.domain.BookReservation;
import com.book.mapper.BookReservationMapper;
import com.book.service.BookReservationService;
import com.book.service.NotificationService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.Date;
import java.util.List;

@Service
public class BookReservationServiceImpl implements BookReservationService {

    @Autowired
    private BookReservationMapper reservationMapper;
    
    @Autowired
    private NotificationService notificationService;

    @Override
    @Transactional
    public boolean createReservation(Long bookId, Long readerId) {
        // 检查是否已有预约
        List<BookReservation> existingReservations = 
            reservationMapper.findActiveReservationsByBook(bookId);
        if (!existingReservations.isEmpty()) {
            return false;
        }
        
        BookReservation reservation = new BookReservation();
        reservation.setBookId(bookId);
        reservation.setReaderId(readerId);
        reservation.setReserveTime(new Date());
        reservation.setStatus(0);
        
        return reservationMapper.insertReservation(reservation) > 0;
    }

    @Override
    public List<BookReservation> getMyReservations(Long readerId) {
        return reservationMapper.findReservationsByReader(readerId);
    }

    @Override
    public boolean hasActiveReservation(Long bookId) {
        List<BookReservation> reservations = 
            reservationMapper.findActiveReservationsByBook(bookId);
        return !reservations.isEmpty();
    }

    @Override
    @Transactional
    public void notifyReservations(Long bookId) {
        List<BookReservation> reservations = 
            reservationMapper.findActiveReservationsByBook(bookId);
        
        for (BookReservation reservation : reservations) {
            // 更新预约状态为已通知
            reservation.setStatus(1);
            reservation.setNotifyTime(new Date());
            reservationMapper.updateReservationStatus(reservation);
            
            // 发送通知
            notificationService.createReservationNotification(
                reservation.getReaderId(),
                reservation.getBookName()
            );
        }
    }

    @Override
    public BookReservation getReservationById(Long reservationId) {
        return reservationMapper.findById(reservationId);
    }

    @Override
    @Transactional
    public boolean cancelReservation(Long reservationId) {
        BookReservation reservation = reservationMapper.findById(reservationId);
        if (reservation == null || reservation.getStatus() != 0) {
            return false;
        }
        
        reservation.setStatus(2); // 设置为已取消状态
        return reservationMapper.updateReservationStatus(reservation) > 0;
    }
} 