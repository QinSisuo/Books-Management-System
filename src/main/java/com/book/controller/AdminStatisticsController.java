package com.book.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class AdminStatisticsController {
    
    @RequestMapping(value = "admin_borrow_statistics", method = RequestMethod.GET)
    public String showBorrowStatistics(Model model) {
        // TODO: 后续添加数据处理逻辑
        return "admin/borrow-statistics";
    }

    @RequestMapping(value = "admin_user_behavior", method = RequestMethod.GET)
    public String showUserBehavior(Model model) {
        return "admin/user-behavior-analysis";
    }

    @RequestMapping(value = "admin_system_logs", method = RequestMethod.GET)
    public String showSystemLogs(Model model) {
        return "admin/system-logs-and-operation-records";
    }
} 