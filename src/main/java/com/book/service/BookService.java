package com.book.service;

import com.book.dao.BookDao;
import com.book.domain.Book;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;

@Service
public class BookService {

    @Autowired
    private BookDao bookDao;


    public void setBookDao(BookDao bookDao) {
        this.bookDao = bookDao;
    }

    // 根据搜索词查询匹配的图书
    public ArrayList<Book> queryBook(String searchWord) {
        return bookDao.queryBook(searchWord);
    }

    // 获取所有图书
    public ArrayList<Book> getAllBooks() {
        return bookDao.getAllBooks();
    }

    // 删除图书
    public boolean deleteBook(long bookId) {
        return bookDao.deleteBook(bookId) > 0;  // 如果删除成功，返回 true
    }

    // 查询是否有匹配的图书（匹配图书的个数大于 0）
    public boolean matchBook(String searchWord) {
        return bookDao.matchBook(searchWord) > 0;
    }

    // 添加图书
    public boolean addBook(Book book) {
        return bookDao.addBook(book) > 0;
    }

    // 根据书号获取图书
    public Book getBook(Long bookId) {
        return bookDao.getBook(bookId);
    }

    // 更新图书信息
    public boolean editBook(Book book) {
        return bookDao.editBook(book) > 0;
    }
}
