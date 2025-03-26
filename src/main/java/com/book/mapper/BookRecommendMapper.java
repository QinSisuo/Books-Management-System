package com.book.mapper;

import com.book.domain.Book;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Param;
import java.util.List;

public interface BookRecommendMapper {
    /**
     * 获取热门图书
     * 根据借阅量和评分综合排序
     */
    @Select("SELECT b.*, " +
            "COALESCE(COUNT(DISTINCT l.sernum), 0) as borrow_count, " +
            "COALESCE(AVG(r.rating), 0) as avg_rating " +
            "FROM books b " +
            "LEFT JOIN lend_list l ON b.book_id = l.book_id " +
            "LEFT JOIN book_review r ON b.book_id = r.book_id AND r.status = 0 " +
            "GROUP BY b.book_id " +
            "ORDER BY (COALESCE(COUNT(DISTINCT l.sernum), 0) * 0.6 + COALESCE(AVG(r.rating), 0) * 0.4) DESC " +
            "LIMIT #{limit}")
    List<Book> getHotBooks(@Param("limit") int limit);
} 