package com.book.mapper;

import com.book.domain.Book;
import org.apache.ibatis.annotations.Param;
import java.util.ArrayList;

public interface BookDao {

    // 根据搜索词查询图书
    ArrayList<Book> queryBook(String searchWord);

    // 获取所有图书
    ArrayList<Book> getAllBooks();

    // 根据书号查询图书
    Book getBook(@Param("bookId") Long bookId);

    // 删除图书
    int deleteBook(@Param("bookId") long bookId);

    // 查询匹配的图书数量
    int matchBook(String searchWord);

    // 添加图书
    int addBook(Book book);

    // 更新图书信息
    int editBook(Book book);
}
