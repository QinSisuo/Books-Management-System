package com.book.service;

import com.book.domain.Book;
import com.book.domain.BorrowRecord;
import com.book.mapper.BorrowRecordMapper;
import com.book.mapper.BookMapper;   // 如果需要修改书的 state
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
    private BookMapper bookMapper; // 假如我们想改 book_info.state

    @Transactional
    public boolean borrowBook(long bookId, long readerId) {
        // 1. 查询该书是否可借
        Book book = bookMapper.getBook(bookId);
        if (book == null || book.getState() == 0) {
            // book==null=没这本书, or state=0=已借出(具体看你项目定义)
            return false;
        }

        // 2. 插入一条借阅记录
        BorrowRecord record = new BorrowRecord();
        record.setBookId(bookId);
        record.setReaderId(readerId);
        record.setBorrowTime(new Date());
        record.setStatus(0); // 0=借出中
        // ... 也可以设置 dueTime=到期日
        borrowRecordMapper.insertBorrowRecord(record);

        // 3. 把图书 state 改为 0=已借出
        book.setState(0);
        bookMapper.editBook(book);

        return true;
    }
    /**
     * 借书：插入borrow_record并可更新book_info state=1
     */
    @Transactional
    public boolean borrowBook(Long bookId, Long readerId) {
        // 1) 可先检查该书是否可借(若 book_info.state=0?)
        // Book book = bookMapper.getBook(bookId);
        // if(book.getState() != 0){ return false; }

        // 2) 写入borrow_record
        BorrowRecord record = new BorrowRecord();
        record.setBookId(bookId);
        record.setReaderId(readerId);
        record.setBorrowTime(new Date());
        // 设定默认借期30天，你可自由设定
        record.setDueTime(new Date(System.currentTimeMillis() + 30L * 24 * 3600 * 1000));
        record.setStatus(0); // 0=借出

        int rows = borrowRecordMapper.insertBorrowRecord(record);
        if(rows <= 0) return false;

        // 3) 更新 book_info.state=1(表示已借出)
        // book.setState(1);
        // bookMapper.editBook(book);

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
        BorrowRecord record = borrowRecordMapper.findById(borrowId);
        if (record == null || record.getStatus() != 0) {
            // 记录不存在，或已归还
            return false;
        }
        // 设置return_time, 状态=1
        record.setReturnTime(new Date());
        record.setStatus(1);
        int updated = borrowRecordMapper.updateBorrowRecord(record);
        if(updated <= 0) return false;

        // 同时book_info.state=0(可借)
        // Book book = bookMapper.getBook(record.getBookId());
        // book.setState(0);
        // bookMapper.editBook(book);

        return true;
    }

    /**
     * 延期(续借)
     */
    @Transactional
    public boolean extendBook(Long borrowId, int extraDays) {
        BorrowRecord record = borrowRecordMapper.findById(borrowId);
        if (record == null || record.getStatus() != 0) {
            // 不存在或已归还
            return false;
        }
        // 在当前dueTime基础上加extraDays
        if(record.getDueTime() == null) {
            record.setDueTime(new Date(System.currentTimeMillis() + (long) extraDays * 24 * 3600 * 1000));
        } else {
            long newDue = record.getDueTime().getTime() + (long) extraDays * 24 * 3600 * 1000;
            record.setDueTime(new Date(newDue));
        }
        int updated = borrowRecordMapper.updateBorrowRecord(record);
        return updated > 0;
    }
}
