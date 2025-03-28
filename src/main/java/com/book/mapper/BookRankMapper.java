package com.book.mapper;

import com.book.domain.Book;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Param;
import java.util.List;

public interface BookRankMapper {
    /**
     * 获取借阅排行榜
     */
    @Select("SELECT b.*, COUNT(br.id) as borrowCount " +
            "FROM books b " +
            "LEFT JOIN borrow_record br ON b.book_id = br.book_id " +
            "GROUP BY b.book_id " +
            "ORDER BY borrowCount DESC " +
            "LIMIT #{limit}")
    List<Book> getBorrowRank(@Param("limit") int limit);

    /**
     * 获取评分排行榜
     */
    @Select("SELECT b.*, AVG(r.rating) as avgRating, COUNT(r.review_id) as ratingCount " +
            "FROM books b " +
            "LEFT JOIN book_review r ON b.book_id = r.book_id AND r.status = 0 " +
            "GROUP BY b.book_id " +
            "HAVING ratingCount >= 3 " + // 至少有3个评分才计入排行
            "ORDER BY avgRating DESC " +
            "LIMIT #{limit}")
    List<Book> getRatingRank(@Param("limit") int limit);
} 