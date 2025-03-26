package com.book.controller;

import com.book.domain.Book;
import com.book.service.BookRankService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/rank")
public class BookRankController {

    @Autowired
    private BookRankService bookRankService;

    /**
     * 获取图书排行榜数据
     * 包括借阅排行和评分排行
     */
    @GetMapping("/list")
    public Map<String, Object> getRankList() {
        Map<String, Object> result = new HashMap<>();
        
        // 获取前10名的排行数据
        List<Book> borrowRank = bookRankService.getBorrowRank(10);
        List<Book> ratingRank = bookRankService.getRatingRank(10);
        
        result.put("borrowRank", borrowRank);
        result.put("ratingRank", ratingRank);
        
        return result;
    }
} 