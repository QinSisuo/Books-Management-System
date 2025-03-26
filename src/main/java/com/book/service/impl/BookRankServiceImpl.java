package com.book.service.impl;

import com.book.domain.Book;
import com.book.mapper.BookRankMapper;
import com.book.service.BookRankService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class BookRankServiceImpl implements BookRankService {

    @Autowired
    private BookRankMapper bookRankMapper;

    @Override
    public List<Book> getBorrowRank(int limit) {
        return bookRankMapper.getBorrowRank(limit);
    }

    @Override
    public List<Book> getRatingRank(int limit) {
        return bookRankMapper.getRatingRank(limit);
    }
} 