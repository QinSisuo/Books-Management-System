package com.book.controller;

import com.book.domain.BookReview;
import com.book.domain.User;
import com.book.service.BookReviewService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpSession;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/review")
public class BookReviewController {

    private static final Logger logger = LoggerFactory.getLogger(BookReviewController.class);

    @Autowired
    private BookReviewService bookReviewService;

    /**
     * 添加书评
     */
    @PostMapping("/add")
    @ResponseBody
    public Map<String, Object> addReview(@RequestBody BookReview review, HttpSession session) {
        Map<String, Object> response = new HashMap<>();
        
        try {
            // 检查用户是否登录
            User user = (User) session.getAttribute("user");
            if (user == null) {
                logger.warn("用户未登录就尝试评论");
                response.put("success", false);
                response.put("message", "请先登录");
                return response;
            }
            
            logger.info("用户 {} 正在评论图书 {}", user.getUserId(), review.getBookId());
            
            // 设置用户ID
            review.setUserId(user.getUserId());
            
            // 添加书评
            boolean success = bookReviewService.addReview(review);
            response.put("success", success);
            response.put("message", success ? "评论成功" : "您已经评论过这本书了");
            
            logger.info("用户 {} 评论图书 {} {}", user.getUserId(), review.getBookId(), 
                    success ? "成功" : "失败");
            
            return response;
        } catch (Exception e) {
            logger.error("添加评论时发生错误", e);
            response.put("success", false);
            response.put("message", "评论失败：" + e.getMessage());
            return response;
        }
    }

    /**
     * 获取图书的书评列表
     */
    @GetMapping("/list/{bookId}")
    @ResponseBody
    public List<BookReview> getBookReviews(@PathVariable Long bookId) {
        return bookReviewService.getBookReviews(bookId);
    }

    /**
     * 获取图书的评分统计
     */
    @GetMapping("/stats/{bookId}")
    @ResponseBody
    public BookReview getBookRatingStats(@PathVariable Long bookId) {
        return bookReviewService.getBookRatingStats(bookId);
    }

    /**
     * 删除书评
     */
    @PostMapping("/delete/{reviewId}")
    @ResponseBody
    public Map<String, Object> deleteReview(@PathVariable Long reviewId, HttpSession session) {
        Map<String, Object> response = new HashMap<>();
        
        // 检查用户是否登录
        User user = (User) session.getAttribute("user");
        if (user == null) {
            response.put("success", false);
            response.put("message", "请先登录");
            return response;
        }
        
        boolean success = bookReviewService.deleteReview(reviewId);
        response.put("success", success);
        response.put("message", success ? "删除成功" : "删除失败");
        return response;
    }
} 