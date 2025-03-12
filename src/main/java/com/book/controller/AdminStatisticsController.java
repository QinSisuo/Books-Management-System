package com.book.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class AdminStatisticsController {
    
    @RequestMapping(value = "/borrow-statistics", method = RequestMethod.GET)
    public String showBorrowStatistics(Model model) {
        // TODO: 后续添加数据处理逻辑
        return "admin/borrow-statistics";
    }

    @RequestMapping(value = "/user-behavior-analysis", method = RequestMethod.GET)
    public String showUserBehavior(Model model) {
        return "admin/user-behavior-analysis";
    }

    @RequestMapping(value = "/system-logs-and-operation-records", method = RequestMethod.GET)
    public String showSystemLogs(Model model) {
        return "admin/system-logs-and-operation-records";
    }
} 