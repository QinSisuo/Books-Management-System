// package com.book.mapper;

// import com.book.domain.Lend;
// import org.apache.ibatis.annotations.Param;
// import org.apache.ibatis.annotations.Select;
// import org.apache.ibatis.annotations.Update;
// import org.apache.ibatis.annotations.Insert;

// import java.util.List;

// /**
//  * 旧版借阅系统的 Mapper
//  * 已废弃，请使用 BorrowRecordMapper 替代
//  * 迁移说明：
//  * 1. 借阅功能：使用 BorrowRecordMapper.insertBorrowRecord
//  * 2. 归还功能：使用 BorrowRecordMapper.updateBorrowRecord
//  * 3. 查询功能：使用 BorrowRecordMapper.findRecordsByReader 或 findAllRecords
//  */
// @Deprecated
// public interface LendMapper {

//     // 归还图书 - 更新 lend_list 的 back_date
//     @Update("UPDATE lend_list SET back_date = #{backDate} WHERE book_id = #{bookId} AND back_date IS NULL")
//     int bookReturnOne(@Param("bookId") long bookId, @Param("backDate") String backDate);

//     // 归还图书 - 更新 books 的 state
//     @Update("UPDATE books SET state = 1 WHERE book_id = #{bookId}")
//     int bookReturnTwo(@Param("bookId") long bookId);

//     // 借阅图书 - 插入 lend_list
//     @Insert("INSERT INTO lend_list (book_id, reader_id, lend_date) VALUES (#{bookId}, #{readerId}, #{lendDate})")
//     int bookLendOne(@Param("bookId") long bookId, @Param("readerId") int readerId, @Param("lendDate") String lendDate);

//     // 借阅图书 - 更新 books 的 state
//     @Update("UPDATE books SET state = 0 WHERE book_id = #{bookId}")
//     int bookLendTwo(@Param("bookId") long bookId);

//     // 获取所有借阅记录
//     @Select("SELECT * FROM lend_list")
//     List<Lend> lendList();

//     // 根据读者 ID 获取借阅记录
//     @Select("SELECT * FROM lend_list WHERE reader_id = #{readerId}")
//     List<Lend> myLendList(@Param("readerId") int readerId);
// }