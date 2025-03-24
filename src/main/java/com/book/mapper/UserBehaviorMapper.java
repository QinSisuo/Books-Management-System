package com.book.mapper;

import org.apache.ibatis.annotations.Select;
import java.util.List;
import java.util.Map;
import com.book.domain.UserBehavior;

public interface UserBehaviorMapper {

    // 获取总用户数（使用users表）
    @Select("SELECT COUNT(*) FROM users")
    int getTotalUsers();

    // 获取活跃用户数（最近30天有借阅记录的用户，不变）
    @Select("SELECT COUNT(DISTINCT reader_id) FROM lend_list " +
            "WHERE lend_date >= DATE_SUB(NOW(), INTERVAL 30 DAY)")
    int getActiveUsers();

    // 获取总借阅量（不变）
    @Select("SELECT COUNT(*) FROM lend_list")
    int getTotalBorrows();

    // 获取当前借阅量（未还的书籍数量，不变）
    @Select("SELECT COUNT(*) FROM lend_list WHERE back_date IS NULL")
    int getCurrentBorrows();

    // 获取借阅趋势数据（最近7天，不变）
    @Select("SELECT DATE(lend_date) as date, COUNT(*) as count " +
            "FROM lend_list " +
            "WHERE lend_date >= DATE_SUB(CURDATE(), INTERVAL 7 DAY) " +
            "GROUP BY DATE(lend_date) " +
            "ORDER BY date")
    List<Map<String, Object>> getBorrowTrend();

    // 获取用户行为数据（使用users表）
    @Select("SELECT " +
            "u.username as userName, " +
            "COUNT(l.sernum) as borrowCount, " +
            "MAX(l.lend_date) as lastBorrowTime, " +
            "(SELECT ci.category_name " +
            " FROM lend_list ll " +
            " INNER JOIN books bi ON ll.book_id = bi.book_id " +
            " INNER JOIN book_category ci ON bi.category_id = ci.category_id " +
            " WHERE ll.reader_id = u.user_id " +
            " GROUP BY ci.category_id, ci.category_name " +
            " ORDER BY COUNT(*) DESC LIMIT 1) as preferredCategory, " +
            "MAX(CASE WHEN l.back_date > l.lend_date THEN 1 ELSE 0 END) as hasOverdue " +
            "FROM users u " +
            "LEFT JOIN lend_list l ON u.user_id = l.reader_id " +
            "GROUP BY u.user_id, u.username")
    List<UserBehavior> getUserBehaviors();

    // 获取各类别图书借阅分布（不变）
    @Select("SELECT ci.category_name as name, COUNT(*) as count " +
            "FROM lend_list l " +
            "INNER JOIN books bi ON l.book_id = bi.book_id " +
            "INNER JOIN book_category ci ON bi.category_id = ci.category_id " +
            "GROUP BY ci.category_id, ci.category_name")
    List<Map<String, Object>> getCategoryDistribution();

    // 获取用户角色分布（不变）
    @Select("SELECT role, COUNT(*) as count " +
            "FROM users " +
            "GROUP BY role")
    List<Map<String, Object>> getUserRoleDistribution();

    // 获取最近注册的用户数量（最近30天）
    @Select("SELECT COUNT(*) FROM users " +
            "WHERE created_at >= DATE_SUB(NOW(), INTERVAL 30 DAY)")
    int getNewUsersCount();
}