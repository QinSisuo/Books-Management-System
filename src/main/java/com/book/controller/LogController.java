package com.book.controller;

import com.book.domain.SystemLog;
import com.book.service.LogService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Controller
public class LogController {

    @Autowired
    private LogService logService;

    // 显示系统日志和操作记录页面
    @RequestMapping("/system-logs-and-operation-records.html")
    public String showLogsAndRecords(@RequestParam(required = false) String search, Model model) {
        List<SystemLog> logs;
        if (search != null && !search.trim().isEmpty()) {
            logs = logService.searchLogs(search);
            model.addAttribute("searchQuery", search);  // 保持搜索词在输入框中
        } else {
            logs = logService.getAllLogs();
        }
        model.addAttribute("logs", logs);
        return "system-logs-and-operation-records";
    }

    // 删除日志
    @RequestMapping("/logs/delete/{logId}")  // 确保这里是正确的路径
    public String deleteLog(@PathVariable int logId) {
        logService.deleteLog(logId);  // 删除日志
        return "redirect:/system-logs-and-operation-records.html";  // 删除后重定向到日志列表页面
    }

    // 其他查询日志的方法（如果需要返回数据，可以改为 @ResponseBody）
    @GetMapping
    public List<SystemLog> getAllLogs() {
        return logService.getAllLogs();
    }

    @GetMapping("/user/{userId}")
    public List<SystemLog> getLogsByUserId(@PathVariable int userId) {
        return logService.getLogsByUserId(userId);
    }

    @GetMapping("/operation/{operationType}")
    public List<SystemLog> getLogsByOperationType(@PathVariable String operationType) {
        return logService.getLogsByOperationType(operationType);
    }

    @GetMapping("/date-range")
    public List<SystemLog> getLogsByDateRange(@RequestParam String startDate, @RequestParam String endDate) {
        return logService.getLogsByDateRange(startDate, endDate);
    }
}