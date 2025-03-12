package com.book.service;

import com.book.mapper.StatisticsMapper;
import com.book.domain.StatisticsData;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class StatisticsService {

    @Autowired
    private StatisticsMapper statisticsMapper;

    public StatisticsData getStatistics() {
        return statisticsMapper.getStatistics();
    }

    public List<Map<String, Object>> getPopularBooks() {
        return statisticsMapper.getPopularBooks();
    }

    public Map<String, Object> getBorrowTrend() {
        List<Map<String, Object>> trendList = statisticsMapper.getBorrowTrend();
        Map<String, Object> trendData = new HashMap<>();

        List<String> dates = new ArrayList<>();
        List<Integer> borrows = new ArrayList<>();

        for (Map<String, Object> row : trendList) {
            dates.add(row.get("date").toString());
            borrows.add(Integer.parseInt(row.get("borrows").toString()));
        }

        trendData.put("dates", dates);
        trendData.put("borrows", borrows);
        return trendData;
    }
}
