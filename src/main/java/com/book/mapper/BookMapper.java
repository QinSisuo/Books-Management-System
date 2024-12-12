package com.book.mapper;

import com.book.domain.Book;
import org.apache.ibatis.annotations.Param;
import java.util.ArrayList;

public interface BookMapper {

    ArrayList<Book> queryBook(@Param("searchWord") String searchWord);

    ArrayList<Book> getAllBooks();

    Book getBook(@Param("bookId") long bookId);

    int deleteBook(@Param("bookId") long bookId);

    int matchBook(@Param("searchWord") String searchWord);

    int addBook(Book book);

    int editBook(Book book);
}
