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
    List<BorrowRecord> findRecordsByReader(Integer readerId);

    // 根据id查询单条记录
    @Select("SELECT br.*, b.name as book_name FROM borrow_record br " +
            "LEFT JOIN books b ON br.book_id = b.book_id " +
            "WHERE br.id = #{id}")
    BorrowRecord findById(Integer id);

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
}
