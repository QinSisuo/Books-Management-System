package com.book.mapper;

import com.book.domain.BookReservation;
import org.apache.ibatis.annotations.*;

import java.util.List;

@Mapper
public interface BookReservationMapper {
    
    @Insert("INSERT INTO book_reservation (book_id, reader_id, reserve_time, status) " +
            "VALUES (#{bookId}, #{readerId}, #{reserveTime}, #{status})")
    int insertReservation(BookReservation reservation);
    
    @Select("SELECT br.*, b.name as book_name FROM book_reservation br " +
            "LEFT JOIN books b ON br.book_id = b.book_id " +
            "WHERE br.reader_id = #{readerId} " +
            "ORDER BY br.reserve_time DESC")
    List<BookReservation> findReservationsByReader(Long readerId);
    
    @Select("SELECT br.*, b.name as book_name FROM book_reservation br " +
            "LEFT JOIN books b ON br.book_id = b.book_id " +
            "WHERE br.book_id = #{bookId} AND br.status = 0 " +
            "ORDER BY br.reserve_time ASC")
    List<BookReservation> findActiveReservationsByBook(Long bookId);
    
    @Update("UPDATE book_reservation SET status = #{status}, notify_time = #{notifyTime} " +
            "WHERE id = #{id}")
    int updateReservationStatus(BookReservation reservation);
} 