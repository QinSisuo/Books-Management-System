package com.book.domain;

import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.Data;
import java.util.Date;

@Data
public class BorrowRecord {
    private Long id;         // borrow_record表主键
    private Long bookId;     // 关联 books
    private Long readerId;   // 关联用户/读者
    
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss", timezone = "GMT+8")
    private Date borrowTime; // 借书时间
    
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss", timezone = "GMT+8")
    private Date dueTime;    // 到期时间
    
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss", timezone = "GMT+8")
    private Date returnTime; // 归还时间(为空表示还没归还)
    
    private Integer status;  // 0=借出,1=已归还,2=其它
    private String bookName; // 图书名称
    private String readerName; // 读者姓名

    // 省略 getter/setter/toString
    public Long getId() {return id;}
    public void setId(Long id) {this.id = id;}

    public Long getBookId() {return bookId;}
    public void setBookId(Long bookId) {this.bookId = bookId;}

    public Long getReaderId() {return readerId;}
    public void setReaderId(Long readerId) {this.readerId = readerId;}

    public Date getBorrowTime() {return borrowTime;}
    public void setBorrowTime(Date borrowTime) {this.borrowTime = borrowTime;}

    public Date getDueTime() {return dueTime;}
    public void setDueTime(Date dueTime) {this.dueTime = dueTime;}

    public Date getReturnTime() {return returnTime;}
    public void setReturnTime(Date returnTime) {this.returnTime = returnTime;}

    public Integer getStatus() {return status;}
    public void setStatus(Integer status) {this.status = status;}

    public String getBookName() {return bookName;}
    public void setBookName(String bookName) {this.bookName = bookName;}

    public String getReaderName() {return readerName;}
    public void setReaderName(String readerName) {this.readerName = readerName;}
}
