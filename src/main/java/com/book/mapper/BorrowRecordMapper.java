package com.book.mapper;

import com.book.domain.BorrowRecord;
import org.apache.ibatis.annotations.*;

import java.util.List;

@Mapper
public interface BorrowRecordMapper {

    // 插入借阅记录
    @Insert("INSERT INTO borrow_record (book_id, reader_id, borrow_time, due_time, status) " +
            "VALUES (#{bookId}, #{readerId}, #{borrowTime}, #{dueTime}, #{status})")
    @Options(useGeneratedKeys = true, keyProperty = "id")
    int insertBorrowRecord(BorrowRecord record);

    // 查询某个读者的所有借阅记录(按借书时间倒序)
    @Select("SELECT br.*, b.name as book_name FROM borrow_record br " +
            "LEFT JOIN books b ON br.book_id = b.book_id " +
            "WHERE br.reader_id = #{readerId} " +
            "ORDER BY br.borrow_time DESC")
    List<BorrowRecord> findRecordsByReader(Long readerId);

    // 根据id查询单条记录
    @Select("SELECT br.*, b.name as book_name FROM borrow_record br " +
            "LEFT JOIN books b ON br.book_id = b.book_id " +
            "WHERE br.id = #{id}")
    BorrowRecord findById(Long id);

    // 更新借阅记录(用于归还、延期等)
    @Update("UPDATE borrow_record SET return_time = #{returnTime}, status = #{status}, due_time = #{dueTime} " +
            "WHERE id = #{id}")
    int updateBorrowRecord(BorrowRecord record);

    /**
     * 查询所有逾期未还的借阅记录
     */
    @Select("SELECT br.*, b.name as book_name FROM borrow_record br " +
            "LEFT JOIN books b ON br.book_id = b.book_id " +
            "WHERE br.status = 0 AND br.due_time < NOW()")
    List<BorrowRecord> findOverdueRecords();

    /**
     * 查询所有借阅记录(按借书时间倒序)
     */
    @Select("SELECT br.*, b.name as book_name, u.username as reader_name " +
            "FROM borrow_record br " +
            "LEFT JOIN books b ON br.book_id = b.book_id " +
            "LEFT JOIN users u ON br.reader_id = u.user_id " +
            "ORDER BY br.borrow_time DESC")
    List<BorrowRecord> findAllRecords();

    /**
     * 根据条件查询借阅记录
     */
    @Select("<script>" +
            "SELECT br.*, b.name as book_name, u.username as reader_name " +
            "FROM borrow_record br " +
            "LEFT JOIN books b ON br.book_id = b.book_id " +
            "LEFT JOIN users u ON br.reader_id = u.user_id " +
            "WHERE 1=1 " +
            "<if test='readerId != null'> AND br.reader_id = #{readerId}</if>" +
            "<if test='bookId != null'> AND br.book_id = #{bookId}</if>" +
            "<if test='status != null'> AND br.status = #{status}</if>" +
            "<if test='startTime != null'> AND br.borrow_time >= #{startTime}</if>" +
            "<if test='endTime != null'> AND br.borrow_time &lt;= #{endTime}</if>" +
            "ORDER BY br.borrow_time DESC" +
            "</script>")
    List<BorrowRecord> findRecordsByCondition(BorrowRecord record);
}
