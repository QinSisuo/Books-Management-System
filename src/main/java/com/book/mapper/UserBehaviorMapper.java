package com.book.mapper;

import org.apache.ibatis.annotations.Select;
import java.util.List;
import java.util.Map;
import com.book.domain.UserBehavior;

public interface UserBehaviorMapper {
    // 获取总用户数
    @Select("SELECT COUNT(*) FROM reader_info")
    int getTotalUsers();

    // 获取活跃用户数（最近30天有借阅记录的用户）
    @Select("SELECT COUNT(DISTINCT reader_id) FROM lend_list WHERE lend_date >= DATE_SUB(NOW(), INTERVAL 30 DAY)")
    int getActiveUsers();

    // 获取总借阅量
    @Select("SELECT COUNT(*) FROM lend_list")
    int getTotalBorrows();

    // 获取当前借阅量（未还的书籍数量）
    @Select("SELECT COUNT(*) FROM lend_list WHERE back_date IS NULL")
    int getCurrentBorrows();

    // 获取借阅趋势数据（最近7天）
    @Select("SELECT DATE(lend_date) as date, COUNT(*) as count " +
            "FROM lend_list " +
            "WHERE lend_date >= DATE_SUB(CURDATE(), INTERVAL 7 DAY) " +
            "GROUP BY DATE(lend_date) " +
            "ORDER BY date")
    List<Map<String, Object>> getBorrowTrend();

    // 获取用户行为数据
    @Select("SELECT " +
            "r.reader_name as userName, " +
            "COUNT(l.ser_num) as borrowCount, " +
            "MAX(l.lend_date) as lastBorrowTime, " +
            "(SELECT category_name FROM class_info WHERE class_id = " +
            "   (SELECT class_id FROM book_info WHERE book_id = l.book_id LIMIT 1) " +
            "LIMIT 1) as preferredCategory, " +
            "EXISTS(SELECT 1 FROM lend_list WHERE reader_id = r.reader_id AND back_date > return_date) as hasOverdue " +
            "FROM reader_info r " +
            "LEFT JOIN lend_list l ON r.reader_id = l.reader_id " +
            "GROUP BY r.reader_id, r.reader_name")
    List<UserBehavior> getUserBehaviors();
} 