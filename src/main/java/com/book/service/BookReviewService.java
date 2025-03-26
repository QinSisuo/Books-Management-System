package com.book.service;

import com.book.domain.BookReview;
import java.util.List;

public interface BookReviewService {
    /**
     * 添加书评
     */
    boolean addReview(BookReview review);
    
    /**
     * 获取图书的所有书评
     */
    List<BookReview> getBookReviews(Long bookId);
    
    /**
     * 获取图书的评分统计
     */
    BookReview getBookRatingStats(Long bookId);
    
    /**
     * 删除书评（软删除）
     */
    boolean deleteReview(Long reviewId);
    
    /**
     * 检查用户是否已经评论过该图书
     */
    boolean hasUserReviewed(Long bookId, Long userId);
} 