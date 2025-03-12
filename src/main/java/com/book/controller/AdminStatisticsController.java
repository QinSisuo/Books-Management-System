package com.book.controller;

import com.book.service.StatisticsService;
import com.book.domain.StatisticsData;
import com.fasterxml.jackson.databind.ObjectMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import java.util.Map;

@Controller
@RequestMapping("/")
public class AdminStatisticsController {

    @Autowired
    private StatisticsService statisticsService;

    @GetMapping("admin_borrow_statistics.html")  // ✅ 修改 URL 以匹配 HTML 请求
    public ModelAndView showStatisticsPage() throws Exception {
        ModelAndView mav = new ModelAndView("admin_borrow_statistics");

        StatisticsData stats = statisticsService.getStatistics();
        mav.addObject("stats", stats);
        mav.addObject("popularBooks", statisticsService.getPopularBooks());

        Map<String, Object> trendData = statisticsService.getBorrowTrend();
        String trendDataJson = new ObjectMapper().writeValueAsString(trendData);
        mav.addObject("trendDataJson", trendDataJson);

        return mav;
    }
}
