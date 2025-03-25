package com.book.service.impl;

import com.book.domain.Book;
import com.book.mapper.BookMapper;
import com.book.service.BookService;
import com.book.service.BookReservationService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.List;

@Service
public class BookServiceImpl implements BookService {

    @Autowired
    private BookMapper bookMapper;

    @Autowired
    private BookReservationService reservationService;

    @Override
    public ArrayList<Book> queryBook(String searchWord) {
        if (searchWord == null || searchWord.trim().isEmpty()) {
            return bookMapper.getAllBooks();
        }
        return bookMapper.queryBook(searchWord);
    }

    @Override
    public ArrayList<Book> getAllBooks() {
        return bookMapper.getAllBooks();
    }

    @Override
    @Transactional
    public boolean deleteBook(long bookId) {
        return bookMapper.deleteBook(bookId) > 0;
    }

    @Override
    public boolean matchBook(String searchWord) {
        return bookMapper.matchBook(searchWord) > 0;
    }

    @Override
    @Transactional
    public boolean addBook(Book book) {
        return bookMapper.addBook(book) > 0;
    }

    @Override
    public Book getBook(Long bookId) {
        return bookMapper.getBook(bookId);
    }

    @Override
    @Transactional
    public boolean editBook(Book book) {
        return bookMapper.editBook(book) > 0;
    }

    @Override
    public Book getBookById(int bookId) {
        return bookMapper.findBookById(bookId);
    }

    @Override
    public boolean updateBook(Book book) {
        return bookMapper.updateBook(book) > 0;
    }

    @Override
    @Transactional
    public boolean borrowBook(long bookId) {
        Book book = bookMapper.getBook(bookId);
        if (book != null && book.getState() == 0) {
            book.setState(1);
            return bookMapper.editBook(book) > 0;
        }
        return false;
    }

    @Override
    @Transactional
    public boolean addBookStock(long bookId, int count) {
        if (count <= 0) {
            throw new IllegalArgumentException("入库数量必须大于0");
        }
        Book book = bookMapper.getBook(bookId);
        if (book == null) {
            throw new IllegalArgumentException("图书不存在");
        }
        
        // 更新库存
        boolean success = bookMapper.updateBookStock(bookId, count, true) > 0;
        
        // 如果更新成功，检查是否有预约
        if (success && reservationService.hasActiveReservation(bookId)) {
            reservationService.notifyReservations(bookId);
        }
        
        return success;
    }

    @Override
    @Transactional
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

    @Override
    @Transactional
    public boolean addBookTags(Long bookId, List<Long> tagIds) {
        if (bookId == null || tagIds == null || tagIds.isEmpty()) {
            return false;
        }
        return bookMapper.addBookTags(bookId, tagIds) > 0;
    }
} 