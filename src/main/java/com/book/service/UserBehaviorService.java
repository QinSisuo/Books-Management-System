package com.book.service;

import com.book.domain.UserBehavior;
import com.book.mapper.UserBehaviorMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

@Service
public class UserBehaviorService {
    
    @Autowired
    private UserBehaviorMapper userBehaviorMapper;

    // 获取关键指标数据
    public Map<String, Object> getKeyMetrics() {
        Map<String, Object> metrics = new HashMap<>();
        metrics.put("totalUsers", userBehaviorMapper.getTotalUsers());
        metrics.put("activeUsers", userBehaviorMapper.getActiveUsers());
        metrics.put("totalBorrows", userBehaviorMapper.getTotalBorrows());
        metrics.put("currentBorrows", userBehaviorMapper.getCurrentBorrows());
        metrics.put("newUsers", userBehaviorMapper.getNewUsersCount());
        return metrics;
    }

    // 获取借阅趋势数据
    public Map<String, Object> getBorrowTrend() {
        List<Map<String, Object>> trendData = userBehaviorMapper.getBorrowTrend();
        
        Map<String, Object> result = new HashMap<>();
        List<String> dates = trendData.stream()
            .map(m -> m.get("date").toString())
            .collect(Collectors.toList());
        List<Integer> counts = trendData.stream()
            .map(m -> ((Number)m.get("count")).intValue())
            .collect(Collectors.toList());
            
        result.put("dates", dates);
        result.put("counts", counts);
        return result;
    }

    // 获取用户行为数据
    public List<UserBehavior> getUserBehaviors() {
        List<UserBehavior> behaviors = userBehaviorMapper.getUserBehaviors();
        
        // 计算活跃度级别
        for (UserBehavior behavior : behaviors) {
            behavior.setActivityLevel(calculateActivityLevel(behavior.getBorrowCount()));
        }
        
        return behaviors;
    }

    // 获取图书分类分布
    public List<Map<String, Object>> getCategoryDistribution() {
        return userBehaviorMapper.getCategoryDistribution();
    }

    // 获取用户角色分布
    public List<Map<String, Object>> getUserRoleDistribution() {
        return userBehaviorMapper.getUserRoleDistribution();
    }

    // 计算活跃度级别
    private String calculateActivityLevel(int borrowCount) {
        if (borrowCount >= 10) {
            return "高度活跃";
        } else if (borrowCount >= 5) {
            return "中度活跃";
        } else if (borrowCount >= 1) {
            return "低度活跃";
        } else {
            return "不活跃";
        }
    }
}