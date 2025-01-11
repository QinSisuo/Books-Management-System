package com.book.mapper;

import com.book.domain.Book;
import org.apache.ibatis.annotations.*;

import java.util.ArrayList;

public interface BookMapper {

    // 查询图书
    @Select("SELECT book_id, name, author, publish, isbn, introduction, language, price, pubdate, class_id, pressmark, state " +
            "FROM book_info " +
            "WHERE book_id LIKE CONCAT('%', #{searchWord}, '%') " +
            "OR name LIKE CONCAT('%', #{searchWord}, '%')")
    ArrayList<Book> queryBook(@Param("searchWord") String searchWord);

    // 获取所有图书
    @Select("SELECT book_id, name, author, publish, isbn, introduction, language, price, pubdate, class_id, pressmark, state " +
            "FROM book_info")
    ArrayList<Book> getAllBooks();

    // 根据书籍ID获取图书详情
    @Select("SELECT book_id, name, author, publish, isbn, introduction, language, price, pubdate, class_id, pressmark, state " +
            "FROM book_info " +
            "WHERE book_id = #{bookId}")
    Book getBook(@Param("bookId") long bookId);

    // 删除图书
    @Delete("DELETE FROM book_info WHERE book_id = #{bookId}")
    int deleteBook(@Param("bookId") long bookId);

    // 检查图书是否匹配
    @Select("SELECT count(*) " +
            "FROM book_info " +
            "WHERE book_id LIKE CONCAT('%', #{searchWord}, '%') " +
            "OR name LIKE CONCAT('%', #{searchWord}, '%')")
    int matchBook(@Param("searchWord") String searchWord);

    // 添加新图书
    @Insert("INSERT INTO book_info (name, author, publish, isbn, introduction, language, price, pubdate, class_id, pressmark, state) " +
            "VALUES (#{name}, #{author}, #{publish}, #{isbn}, #{introduction}, #{language}, #{price}, #{pubdate}, #{classId}, #{pressmark}, #{state})")
    int addBook(Book book);

    // 更新图书信息
    @Update("UPDATE book_info SET name = #{name}, author = #{author}, publish = #{publish}, isbn = #{isbn}, " +
            "introduction = #{introduction}, language = #{language}, price = #{price}, pubdate = #{pubdate}, " +
            "class_id = #{classId}, pressmark = #{pressmark}, state = #{state} WHERE book_id = #{bookId}")
    int editBook(Book book);

    @Select("SELECT * FROM books WHERE book_id = #{bookId}")
    Book findBookById(int bookId); // 根据 bookId 查询图书

    @Update("UPDATE books SET title = #{title}, author = #{author}, publisher = #{publisher} WHERE book_id = #{bookId}")
    int updateBook(Book book); // 更新图书信息，返回受影响的行数
}
