package com.book.service;

import com.book.domain.SystemLog;
import com.book.mapper.SystemLogMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class LogService {

    @Autowired
    private SystemLogMapper systemLogMapper;

    /**
     * 记录系统日志
     * @param log 系统日志对象
     */
    public void recordLog(SystemLog log) {
        systemLogMapper.insertLog(log);
    }

    // 删除指定的日志
    public void deleteLog(int logId) {
        systemLogMapper.deleteLog(logId);  // 删除日志
    }

    /**
     * 获取所有日志
     * @return 日志列表
     */
    public List<SystemLog> getAllLogs() {
        return systemLogMapper.getAllLogs();
    }

    // 根据用户ID查询日志
    public List<SystemLog> getLogsByUserId(int userId) {
        return systemLogMapper.getLogsByUserId(userId);
    }

    // 根据操作类型查询日志
    public List<SystemLog> getLogsByOperationType(String operationType) {
        return systemLogMapper.getLogsByOperationType(operationType);
    }

    // 根据时间范围查询日志
    public List<SystemLog> getLogsByDateRange(String startDate, String endDate) {
        return systemLogMapper.getLogsByDateRange(startDate, endDate);
    }
}