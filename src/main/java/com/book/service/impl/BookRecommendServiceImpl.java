package com.book.service.impl;

import com.book.domain.Book;
import com.book.mapper.BookRecommendMapper;
import com.book.service.BookRecommendService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class BookRecommendServiceImpl implements BookRecommendService {

    @Autowired
    private BookRecommendMapper bookRecommendMapper;

    @Override
    public List<Book> getHotBooks(int limit) {
        return bookRecommendMapper.getHotBooks(limit);
    }
} 