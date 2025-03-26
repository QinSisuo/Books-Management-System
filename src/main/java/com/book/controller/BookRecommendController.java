package com.book.controller;

import com.book.domain.Book;
import com.book.service.BookRecommendService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/recommend")
public class BookRecommendController {

    @Autowired
    private BookRecommendService bookRecommendService;

    /**
     * 获取热门图书
     */
    @GetMapping("/hot")
    public List<Book> getHotBooks() {
        return bookRecommendService.getHotBooks(8); // 返回8本热门图书
    }
} 