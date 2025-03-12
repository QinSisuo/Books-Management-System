package com.book.mapper;

import com.book.domain.StatisticsData;
import org.apache.ibatis.annotations.Select;

import java.util.List;
import java.util.Map;

public interface StatisticsMapper {

    // 📌 **修正：添加 getStatistics 方法**

    @Select("SELECT " +
            "(SELECT COUNT(*) FROM borrow_record WHERE DATE(borrow_time) = CURDATE()) AS todayBorrows, " +
            "(SELECT COUNT(*) FROM borrow_record WHERE DATE(return_time) = CURDATE()) AS todayReturns, " +
            "(SELECT COUNT(*) FROM borrow_record WHERE return_time IS NULL) AS currentBorrows, " +
            "(SELECT COUNT(*) FROM borrow_record WHERE return_time IS NULL AND due_time < CURDATE()) AS overdueCount")
    StatisticsData getStatistics();
    // 获取热门借阅书籍
    @Select("SELECT bi.name AS name, bi.author AS author, COUNT(*) AS borrowCount " +
            "FROM borrow_record br " +
            "JOIN book_info bi ON br.book_id = bi.book_id " +
            "GROUP BY bi.book_id " +
            "ORDER BY borrowCount DESC " +
            "LIMIT 10")
    List<Map<String, Object>> getPopularBooks();


    // 获取借阅趋势数据
    @Select("SELECT DATE(borrow_time) AS date, COUNT(*) AS borrows " +
            "FROM borrow_record " +
            "GROUP BY DATE(borrow_time) " +
            "ORDER BY DATE(borrow_time)")
    List<Map<String, Object>> getBorrowTrend();

}
