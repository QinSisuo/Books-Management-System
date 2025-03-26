package com.book.mapper;

import com.book.domain.Book;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Param;
import java.util.List;

public interface BookRankMapper {
    /**
     * 获取借阅排行榜
     */
    @Select("SELECT b.*, COUNT(l.sernum) as borrow_count " +
            "FROM books b " +
            "LEFT JOIN lend_list l ON b.book_id = l.book_id " +
            "GROUP BY b.book_id " +
            "ORDER BY borrow_count DESC " +
            "LIMIT #{limit}")
    List<Book> getBorrowRank(@Param("limit") int limit);

    /**
     * 获取评分排行榜
     */
    @Select("SELECT b.*, AVG(r.rating) as avg_rating, COUNT(r.review_id) as rating_count " +
            "FROM books b " +
            "LEFT JOIN book_review r ON b.book_id = r.book_id AND r.status = 0 " +
            "GROUP BY b.book_id " +
            "HAVING rating_count >= 3 " + // 至少有3个评分才计入排行
            "ORDER BY avg_rating DESC " +
            "LIMIT #{limit}")
    List<Book> getRatingRank(@Param("limit") int limit);
} 