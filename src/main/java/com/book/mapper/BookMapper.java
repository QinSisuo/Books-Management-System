package com.book.mapper;

import com.book.domain.Book;
import org.apache.ibatis.annotations.*;

import java.util.ArrayList;
import java.util.List;

public interface BookMapper {

    // 查询图书
    @Select("SELECT book_id, name, author, publish, isbn, introduction, language, price, pubdate, category_id, pressmark, state, total_count, lent_count " +
            "FROM books " +
            "WHERE name LIKE CONCAT('%', #{searchWord}, '%') " +
            "OR author LIKE CONCAT('%', #{searchWord}, '%') ")
    ArrayList<Book> queryBook(@Param("searchWord") String searchWord);


    // 获取所有图书
    @Select("SELECT book_id, name, author, publish, isbn, introduction, language, price, pubdate, category_id, pressmark, state, total_count, lent_count " +
            "FROM books")
    ArrayList<Book> getAllBooks();

    // 根据书籍ID获取图书详情
    @Select("SELECT book_id, name, author, publish, isbn, introduction, language, price, pubdate, category_id, pressmark, state, total_count, lent_count " +
            "FROM books " +
            "WHERE book_id = #{bookId}")
    Book getBook(@Param("bookId") long bookId);

    // 删除图书
    @Delete("DELETE FROM books WHERE book_id = #{bookId}")
    int deleteBook(@Param("bookId") long bookId);

    // 检查图书是否匹配
    @Select("SELECT count(*) " +
            "FROM books " +
            "WHERE book_id LIKE CONCAT('%', #{searchWord}, '%') " +
            "OR name LIKE CONCAT('%', #{searchWord}, '%')")
    int matchBook(@Param("searchWord") String searchWord);

    // 添加新图书
    @Insert("INSERT INTO books (name, author, publish, isbn, introduction, language, price, pubdate, category_id, pressmark, state) " +
            "VALUES (#{name}, #{author}, #{publish}, #{isbn}, #{introduction}, #{language}, #{price}, #{pubdate}, #{categoryId}, #{pressmark}, #{state})")
    int addBook(Book book);

    // 更新图书信息
    @Update("UPDATE books SET name = #{name}, author = #{author}, publish = #{publish}, isbn = #{isbn}, " +
            "introduction = #{introduction}, language = #{language}, price = #{price}, pubdate = #{pubdate}, " +
            "category_id = #{categoryId}, pressmark = #{pressmark}, state = #{state} WHERE book_id = #{bookId}")
    int editBook(Book book);


    @Select("SELECT * FROM books WHERE book_id = #{bookId}")
    Book findBookById(int bookId); // 根据 bookId 查询图书

    @Update("UPDATE books SET title = #{title}, author = #{author}, publisher = #{publisher} WHERE book_id = #{bookId}")
    int updateBook(Book book); // 更新图书信息，返回受影响的行数

    @Update("<script>" +
            "UPDATE books SET " +
            "total_count = CASE " +
            "  WHEN #{isAdd} = true THEN total_count + #{count} " +
            "  ELSE total_count - #{count} " +
            "END " +
            "WHERE book_id = #{bookId} " +
            "AND (#{isAdd} = true OR (total_count - lent_count) >= #{count})" +
            "</script>")
    int updateBookStock(@Param("bookId") long bookId, 
                       @Param("count") int count, 
                       @Param("isAdd") boolean isAdd);

    /**
     * 更新图书已借数量
     * @param bookId 图书ID
     * @param lentCount 新的已借数量
     * @return 更新的行数
     */
    @Update("UPDATE books SET lent_count = #{lentCount} WHERE book_id = #{bookId}")
    int updateLentCount(@Param("bookId") long bookId, @Param("lentCount") int lentCount);

    @Insert("<script>" +
            "INSERT INTO book_tag_relation(book_id, tag_id) VALUES " +
            "<foreach collection='tagIds' item='tagId' separator=','>" +
            "(#{bookId}, #{tagId})" +
            "</foreach>" +
            "</script>")
    int addBookTags(@Param("bookId") Long bookId, @Param("tagIds") List<Long> tagIds);
}
