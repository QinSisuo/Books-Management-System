package com.book.mapper;

import com.book.domain.Book;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Param;
import java.util.List;

public interface BookRankMapper {
    /**
     * 获取借阅排行榜
     */
    @Select("SELECT b.book_id, b.name, b.author, b.publish, b.isbn, b.introduction, " +
            "b.language, b.price, b.pub_date, b.class_id, b.pressure_mark, " +
            "COUNT(br.id) as borrowCount " +
            "FROM books b " +
            "LEFT JOIN borrow_record br ON b.book_id = br.book_id " +
            "GROUP BY b.book_id, b.name, b.author, b.publish, b.isbn, b.introduction, " +
            "b.language, b.price, b.pub_date, b.class_id, b.pressure_mark " +
            "ORDER BY borrowCount DESC " +
            "LIMIT #{limit}")
    List<Book> getBorrowRank(@Param("limit") int limit);

    /**
     * 获取评分排行榜
     */
    @Select("SELECT b.book_id, b.name, b.author, b.publish, b.isbn, b.introduction, " +
            "b.language, b.price, b.pub_date, b.class_id, b.pressure_mark, " +
            "COALESCE(AVG(r.rating), 0) as avgRating, " +
            "COUNT(r.review_id) as ratingCount " +
            "FROM books b " +
            "LEFT JOIN book_review r ON b.book_id = r.book_id AND r.status = 0 " +
            "GROUP BY b.book_id, b.name, b.author, b.publish, b.isbn, b.introduction, " +
            "b.language, b.price, b.pub_date, b.class_id, b.pressure_mark " +
            "HAVING ratingCount > 0 " +
            "ORDER BY avgRating DESC, ratingCount DESC " +
            "LIMIT #{limit}")
    List<Book> getRatingRank(@Param("limit") int limit);
} 