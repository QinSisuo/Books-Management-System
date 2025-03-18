package com.book.domain;

import lombok.Data;
import java.util.Date;

@Data
public class BorrowRecord {
    private Integer id;         // borrow_record表主键
    private Integer bookId;     // 关联 books
    private Integer readerId;   // 关联用户/读者
    private Date borrowTime; // 借书时间
    private Date dueTime;    // 到期时间
    private Date returnTime; // 归还时间(为空表示还没归还)
    private Integer status;  // 0=借出,1=已归还,2=其它
    private String bookName; // 图书名称

    // 省略 getter/setter/toString
    public Integer getId() {return id;}
    public void setId(Integer id) {this.id = id;}

    public Integer getBookId() {return bookId;}
    public void setBookId(Integer bookId) {this.bookId = bookId;}

    public Integer getReaderId() {return readerId;}
    public void setReaderId(Integer readerId) {this.readerId = readerId;}

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
}
