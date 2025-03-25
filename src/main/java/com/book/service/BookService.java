package com.book.service;

import com.book.domain.Book;
import java.util.ArrayList;
import java.util.List;

public interface BookService {
    ArrayList<Book> queryBook(String searchWord);
    ArrayList<Book> getAllBooks();
    boolean deleteBook(Long bookId);
    boolean matchBook(String searchWord);
    boolean addBook(Book book);
    Book getBook(Long bookId);
    boolean editBook(Book book);
    boolean updateBook(Book book);
    boolean borrowBook(Long bookId);
    boolean addBookStock(Long bookId, int count);
    boolean reduceBookStock(Long bookId, int count);
    boolean addBookTags(Long bookId, List<Long> tagIds);
    List<Long> getBookTagIds(Long bookId);
    boolean updateBookTags(Long bookId, List<Long> tagIds);
    
    /**
     * 根据标签ID查询图书列表
     * @param tagId 标签ID
     * @return 图书列表
     */
    List<Book> getBooksByTagId(Long tagId);
}
