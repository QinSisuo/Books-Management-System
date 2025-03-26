package com.book.mapper;

import com.book.domain.BookReview;
import org.apache.ibatis.annotations.*;

import java.util.List;

public interface BookReviewMapper {
    
    @Insert("INSERT INTO book_review (book_id, user_id, rating, content, status) " +
            "VALUES (#{bookId}, #{userId}, #{rating}, #{content}, #{status})")
    @Options(useGeneratedKeys = true, keyProperty = "reviewId")
    int insert(BookReview review);
    
    @Select("SELECT r.*, u.username as userName " +
            "FROM book_review r " +
            "LEFT JOIN users u ON r.user_id = u.user_id " +
            "WHERE r.book_id = #{bookId} AND r.status = 0 " +
            "ORDER BY r.create_time DESC")
    List<BookReview> findByBookId(@Param("bookId") Long bookId);
    
    @Select("SELECT AVG(rating) as avgRating, COUNT(*) as totalReviews " +
            "FROM book_review " +
            "WHERE book_id = #{bookId} AND status = 0")
    @Results({
        @Result(property = "avgRating", column = "avgRating"),
        @Result(property = "totalReviews", column = "totalReviews")
    })
    BookReview getBookRatingStats(@Param("bookId") Long bookId);
    
    @Update("UPDATE book_review SET status = 1 WHERE review_id = #{reviewId}")
    int deleteReview(@Param("reviewId") Long reviewId);
    
    @Select("SELECT COUNT(*) FROM book_review " +
            "WHERE book_id = #{bookId} AND user_id = #{userId} AND status = 0")
    int hasUserReviewed(@Param("bookId") Long bookId, @Param("userId") Long userId);
} 