package com.book.controller;

import com.book.service.UserBehaviorService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import java.util.Map;

@Controller
@RequestMapping("/admin/analysis")
public class UserBehaviorController {
    
    @Autowired
    private UserBehaviorService userBehaviorService;
    
    @GetMapping("/user-behavior")
    public String showUserBehaviorPage(Model model) {
        // 获取关键指标数据
        model.addAttribute("metrics", userBehaviorService.getKeyMetrics());
        
        // 获取借阅趋势数据
        model.addAttribute("borrowTrend", userBehaviorService.getBorrowTrend());
        
        // 获取用户行为数据
        model.addAttribute("userBehaviors", userBehaviorService.getUserBehaviors());
        
        // 获取分类分布数据
        model.addAttribute("categoryDistribution", userBehaviorService.getCategoryDistribution());
        
        return "admin/user-behavior-analysis";
    }

    // 用于AJAX刷新数据的接口
    @GetMapping("/api/metrics")
    @ResponseBody
    public Map<String, Object> getMetrics() {
        return userBehaviorService.getKeyMetrics();
    }

    @GetMapping("/api/trend")
    @ResponseBody
    public Map<String, Object> getTrend() {
        return userBehaviorService.getBorrowTrend();
    }
}