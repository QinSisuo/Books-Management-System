package com.book.mapper;

import com.book.domain.BorrowRecord;
import org.apache.ibatis.annotations.*;

import java.util.List;

@Mapper
public interface BorrowRecordMapper {

    // 插入借阅记录
    @Insert("INSERT INTO borrow_record (book_id, reader_id, borrow_time, due_time, status) " +
            "VALUES (#{bookId}, #{readerId}, #{borrowTime}, #{dueTime}, #{status})")
    int insertBorrowRecord(BorrowRecord record);

    // 查询某个读者的所有借阅记录(按借书时间倒序)
    @Select("SELECT * FROM borrow_record WHERE reader_id = #{readerId} ORDER BY borrow_time DESC")
    List<BorrowRecord> findRecordsByReader(@Param("readerId") Long readerId);

    // 根据id查询单条记录
    @Select("SELECT * FROM borrow_record WHERE id = #{id}")
    BorrowRecord findById(@Param("id") Long id);

    // 更新借阅记录(用于归还、延期等)
    @Update("UPDATE borrow_record SET due_time=#{dueTime}, return_time=#{returnTime}, status=#{status} WHERE id=#{id}")
    int updateBorrowRecord(BorrowRecord record);
}
