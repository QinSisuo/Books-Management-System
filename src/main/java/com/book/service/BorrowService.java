package com.book.service;

import com.book.domain.Book;
import com.book.domain.BorrowRecord;
import com.book.mapper.BorrowRecordMapper;
import com.book.mapper.BookMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.Date;
import java.util.List;

@Service
public class BorrowService {

    @Autowired
    private BorrowRecordMapper borrowRecordMapper;

    @Autowired
    private BookMapper bookMapper;

    @Transactional
    public boolean borrowBook(long bookId, long readerId) {
        // 1. 查询该书是否可借
        Book book = bookMapper.getBook(bookId);
        if (book == null) {
            return false;
        }

        // 2. 检查库存是否足够
        if (book.getTotalCount() - book.getLentCount() <= 0) {
            return false;
        }

        // 3. 插入一条借阅记录
        BorrowRecord record = new BorrowRecord();
        record.setBookId(bookId);
        record.setReaderId(readerId);
        record.setBorrowTime(new Date());
        record.setDueTime(new Date(System.currentTimeMillis() + 30L * 24 * 3600 * 1000)); // 默认借期30天
        record.setStatus(0); // 0=借出中
        int recordResult = borrowRecordMapper.insertBorrowRecord(record);
        if (recordResult <= 0) {
            return false;
        }

        // 4. 更新图书已借数量
        int updateResult = bookMapper.updateLentCount(bookId, book.getLentCount() + 1);
        if (updateResult <= 0) {
            return false;
        }

        return true;
    }

    /**
     * 查询我的借阅记录
     */
    public List<BorrowRecord> getMyBorrowRecords(Long readerId) {
        return borrowRecordMapper.findRecordsByReader(readerId);
    }

    /**
     * 归还图书
     */
    @Transactional
    public boolean returnBook(Long borrowId) {
        // 1. 查询借阅记录
        BorrowRecord record = borrowRecordMapper.findById(borrowId);
        if (record == null || record.getStatus() != 0) {
            return false;
        }

        // 2. 更新借阅记录
        record.setReturnTime(new Date());
        record.setStatus(1); // 1=已归还
        int recordResult = borrowRecordMapper.updateBorrowRecord(record);
        if (recordResult <= 0) {
            return false;
        }

        // 3. 更新图书已借数量
        Book book = bookMapper.getBook(record.getBookId());
        if (book != null) {
            int updateResult = bookMapper.updateLentCount(book.getBookId(), book.getLentCount() - 1);
            if (updateResult <= 0) {
                return false;
            }
        }

        return true;
    }

    /**
     * 延期(续借)
     */
    @Transactional
    public boolean extendBook(Long borrowId, int extraDays) {
        // 1. 查询借阅记录
        BorrowRecord record = borrowRecordMapper.findById(borrowId);
        if (record == null || record.getStatus() != 0) {
            return false;
        }

        // 2. 更新到期时间
        if (record.getDueTime() == null) {
            record.setDueTime(new Date(System.currentTimeMillis() + (long) extraDays * 24 * 3600 * 1000));
        } else {
            long newDue = record.getDueTime().getTime() + (long) extraDays * 24 * 3600 * 1000;
            record.setDueTime(new Date(newDue));
        }

        // 3. 更新记录
        return borrowRecordMapper.updateBorrowRecord(record) > 0;
    }
}
