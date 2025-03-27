// package com.book.domain;

// import java.io.Serializable;
// import java.util.Date;

// /**
//  * 旧版借阅系统的实体类
//  * 已废弃，请使用 BorrowRecord 替代
//  * 迁移说明：
//  * 1. 字段映射：
//  *    - sernum -> id
//  *    - book_id -> bookId
//  *    - reader_id -> readerId
//  *    - lend_date -> borrowTime
//  *    - back_date -> returnTime
//  * 2. 新增字段：
//  *    - status: 借阅状态
//  *    - dueTime: 到期时间
//  */
// @Deprecated
// public class Lend implements Serializable {

//     private long sernum;
//     private long bookId;
//     private int readerId;
//     private Date lendDate;
//     private Date backDate;

//     public void setReaderId(int readerId) {
//         this.readerId = readerId;
//     }

//     public void setBookId(long bookId) {
//         this.bookId = bookId;
//     }

//     public void setBackDate(Date backDate) {
//         this.backDate = backDate;
//     }

//     public void setLendDate(Date lendDate) {
//         this.lendDate = lendDate;
//     }

//     public void setSernum(long sernum) {
//         this.sernum = sernum;
//     }

//     public int getReaderId() {
//         return readerId;
//     }

//     public long getBookId() {
//         return bookId;
//     }

//     public Date getBackDate() {
//         return backDate;
//     }

//     public Date getLendDate() {
//         return lendDate;
//     }

//     public long getSernum() {
//         return sernum;
//     }
// }