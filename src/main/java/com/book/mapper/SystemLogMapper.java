package com.book.mapper;

import com.book.domain.SystemLog;
import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Select;

import java.util.List;

public interface SystemLogMapper {

    //记录日志
    @Insert("INSERT INTO system_logs (user_id, user_name, operation_type, description, result, ip_address) " +
            "VALUES (#{userId}, #{userName}, #{operationType}, #{description}, #{result}, #{ipAddress})")
    void insertLog(SystemLog log);

    // 查询所有日志
    @Select("SELECT * FROM system_logs ORDER BY timestamp DESC")
    List<SystemLog> getAllLogs();

    // 删除日志
    @Delete("DELETE FROM system_logs WHERE id = #{logId}")
    void deleteLog(int logId);

    // 根据用户ID查询日志
    @Select("SELECT * FROM system_logs WHERE user_id = #{userId} ORDER BY timestamp DESC")
    List<SystemLog> getLogsByUserId(int userId);

    // 根据操作类型查询日志
    @Select("SELECT * FROM system_logs WHERE operation_type = #{operationType} ORDER BY timestamp DESC")
    List<SystemLog> getLogsByOperationType(String operationType);

    // 根据时间范围查询日志
    @Select("SELECT * FROM system_logs WHERE timestamp BETWEEN #{startDate} AND #{endDate} ORDER BY timestamp DESC")
    List<SystemLog> getLogsByDateRange(String startDate, String endDate);

    // 搜索日志
    @Select("SELECT * FROM system_logs WHERE " +
            "user_name LIKE CONCAT('%', #{query}, '%') OR " +
            "operation_type LIKE CONCAT('%', #{query}, '%') OR " +
            "description LIKE CONCAT('%', #{query}, '%') OR " +
            "result LIKE CONCAT('%', #{query}, '%') OR " +
            "ip_address LIKE CONCAT('%', #{query}, '%') " +
            "ORDER BY timestamp DESC")
    List<SystemLog> searchLogs(String query);

}