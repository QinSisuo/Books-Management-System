package com.book.service;

import com.book.mapper.BookMapper;
import com.book.domain.Book;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;

@Service
public class BookService {

    @Autowired
    private BookMapper bookMapper;

    public void setBookDao(BookMapper bookMapper) {
        this.bookMapper = bookMapper;
    }

    public ArrayList<Book> queryBook(String searchWord) {
        return bookMapper.queryBook(searchWord);
    }

    public ArrayList<Book> getAllBooks() {
        return bookMapper.getAllBooks();
    }

    @Transactional
    public boolean deleteBook(long bookId) {
        return bookMapper.deleteBook(bookId) > 0;
    }

    public boolean matchBook(String searchWord) {
        return bookMapper.matchBook(searchWord) > 0;
    }

    @Transactional
    public boolean addBook(Book book) {
        return bookMapper.addBook(book) > 0;
    }

    public Book getBook(Long bookId) {
        return bookMapper.getBook(bookId);
    }

    @Transactional
    public boolean editBook(Book book) {
        return bookMapper.editBook(book) > 0;
    }

    public Book getBookById(int bookId) {return bookMapper.findBookById(bookId); }

    public boolean updateBook(Book book) {
        int rowsAffected = bookMapper.updateBook(book);
        return rowsAffected > 0; // 返回是否更新成功
    }
}
