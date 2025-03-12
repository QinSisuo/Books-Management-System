package com.book.domain;

import java.util.Date;

public class BorrowRecord {
    private Long id;         // borrow_record表主键
    private Long bookId;     // 关联 book_info
    private Long readerId;   // 关联用户/读者
    private Date borrowTime; // 借书时间
    private Date dueTime;    // 到期时间
    private Date returnTime; // 归还时间(为空表示还没归还)
    private Integer status;  // 0=借出,1=已归还,2=其它

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
}
