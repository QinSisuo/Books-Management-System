package com.book.controller;

import com.book.service.UserBehaviorService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

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
        
        return "admin/user-behavior-analysis";
    }
}