package com.book.service;

import com.book.domain.BorrowRecord;
import com.book.mapper.BorrowRecordMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Service;

import java.util.Date;
import java.util.List;

@Service
public class ScheduledTaskService {
    
    @Autowired
    private BorrowRecordMapper borrowRecordMapper;
    
    @Autowired
    private NotificationService notificationService;
    
    /**
     * 每天早上9点检查逾期图书
     */
    @Scheduled(cron = "0 0 9 * * ?")
    public void checkOverdueBooks() {
        // 查询所有逾期未还的借阅记录
        List<BorrowRecord> overdueRecords = borrowRecordMapper.findOverdueRecords();
        
        // 为每个逾期记录创建通知
        for (BorrowRecord record : overdueRecords) {
            notificationService.createOverdueNotification(
                record.getReaderId(),
                record.getBookName(),
                record.getDueTime()
            );
        }
    }
} 