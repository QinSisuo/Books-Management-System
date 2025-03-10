package com.book.mapper;

import org.apache.ibatis.annotations.Select;
import java.util.List;
import java.util.Map;
import com.book.domain.UserBehavior;

public interface UserBehaviorMapper {
    // 获取总用户数（包括读者和管理员）
    @Select("SELECT COUNT(*) FROM reader_info")
    int getTotalUsers();

    // 获取活跃用户数（最近30天有借阅记录的用户）
    @Select("SELECT COUNT(DISTINCT reader_id) FROM lend_list " +
            "WHERE lend_date >= DATE_SUB(NOW(), INTERVAL 30 DAY)")
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
            "r.name as userName, " +
            "COUNT(l.sernum) as borrowCount, " +
            "MAX(l.lend_date) as lastBorrowTime, " +
            "(SELECT ci.class_name " +
            "FROM lend_list ll " +
            "INNER JOIN book_info bi ON ll.book_id = bi.book_id " +
            "INNER JOIN class_info ci ON bi.class_id = ci.class_id " +
            "WHERE ll.reader_id = r.reader_id " +
            "GROUP BY ci.class_id, ci.class_name " +
            "ORDER BY COUNT(*) DESC LIMIT 1) as preferredCategory, " +
            "MAX(CASE WHEN l.back_date > l.lend_date THEN 1 ELSE 0 END) as hasOverdue " +
            "FROM reader_info r " +
            "LEFT JOIN lend_list l ON r.reader_id = l.reader_id " +
            "GROUP BY r.reader_id, r.name")
    List<UserBehavior> getUserBehaviors();

    // 获取各类别图书借阅分布
    @Select("SELECT ci.class_name as name, COUNT(*) as count " +
            "FROM lend_list l " +
            "INNER JOIN book_info bi ON l.book_id = bi.book_id " +
            "INNER JOIN class_info ci ON bi.class_id = ci.class_id " +
            "GROUP BY ci.class_id, ci.class_name")
    List<Map<String, Object>> getCategoryDistribution();

    // 获取用户角色分布
    @Select("SELECT role, COUNT(*) as count " +
            "FROM users " +
            "GROUP BY role")
    List<Map<String, Object>> getUserRoleDistribution();

    // 获取最近注册的用户数量（最近30天）
    @Select("SELECT COUNT(*) FROM users " +
            "WHERE created_at >= DATE_SUB(NOW(), INTERVAL 30 DAY)")
    int getNewUsersCount();
}