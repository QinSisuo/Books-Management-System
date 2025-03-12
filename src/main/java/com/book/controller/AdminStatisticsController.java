package com.book.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class AdminStatisticsController {
    
    @RequestMapping(value = "/admin_borrow_statistics.html", method = RequestMethod.GET)
    public String showBorrowStatistics(Model model) {
        // TODO: 后续添加数据处理逻辑
        return "admin_borrow_statistics";
    }

} 