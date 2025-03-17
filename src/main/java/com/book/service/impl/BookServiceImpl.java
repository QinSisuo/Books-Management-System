package com.book.service.impl;

import com.book.domain.Book;
import com.book.mapper.BookMapper;
import com.book.service.BookService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class BookServiceImpl implements BookService {

    @Autowired
    private BookMapper bookMapper;

    @Override
    public boolean addBookStock(long bookId, int count) {
        if (count <= 0) {
            throw new IllegalArgumentException("入库数量必须大于0");
        }
        Book book = bookMapper.getBook(bookId);
        if (book == null) {
            throw new IllegalArgumentException("图书不存在");
        }
        return bookMapper.updateBookStock(bookId, count, true) > 0;
    }

    @Override
    public boolean reduceBookStock(long bookId, int count) {
        if (count <= 0) {
            throw new IllegalArgumentException("出库数量必须大于0");
        }
        Book book = bookMapper.getBook(bookId);
        if (book == null) {
            throw new IllegalArgumentException("图书不存在");
        }
        if (book.getTotalCount() - book.getLentCount() < count) {
            throw new IllegalArgumentException("可用库存不足");
        }
        return bookMapper.updateBookStock(bookId, count, false) > 0;
    }
} 