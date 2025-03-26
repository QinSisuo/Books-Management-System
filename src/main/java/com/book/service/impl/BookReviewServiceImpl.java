package com.book.service.impl;

import com.book.domain.BookReview;
import com.book.mapper.BookReviewMapper;
import com.book.service.BookReviewService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class BookReviewServiceImpl implements BookReviewService {
    
    @Autowired
    private BookReviewMapper bookReviewMapper;
    
    @Override
    public boolean addReview(BookReview review) {
        // 检查用户是否已经评论过
        if (hasUserReviewed(review.getBookId(), review.getUserId())) {
            return false;
        }
        review.setStatus(0); // 设置状态为正常
        return bookReviewMapper.insert(review) > 0;
    }
    
    @Override
    public List<BookReview> getBookReviews(Long bookId) {
        return bookReviewMapper.findByBookId(bookId);
    }
    
    @Override
    public BookReview getBookRatingStats(Long bookId) {
        return bookReviewMapper.getBookRatingStats(bookId);
    }
    
    @Override
    public boolean deleteReview(Long reviewId) {
        return bookReviewMapper.deleteReview(reviewId) > 0;
    }
    
    @Override
    public boolean hasUserReviewed(Long bookId, Long userId) {
        return bookReviewMapper.hasUserReviewed(bookId, userId) > 0;
    }
} 