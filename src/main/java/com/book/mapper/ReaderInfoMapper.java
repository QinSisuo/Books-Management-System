package com.book.mapper;

import com.book.domain.ReaderInfo;
import org.apache.ibatis.annotations.*;

import java.util.List;

public interface ReaderInfoMapper {

    // 获取所有读者信息
    @Select("SELECT * FROM reader_info")
    List<ReaderInfo> getAllReaderInfo();

    // 根据 readerId 查找读者信息
    @Select("SELECT * FROM reader_info WHERE reader_id = #{readerId}")
    ReaderInfo findReaderInfoByReaderId(@Param("readerId") int readerId);

    // 删除读者信息
    @Delete("DELETE FROM reader_info WHERE reader_id = #{readerId}")
    int deleteReaderInfo(@Param("readerId") int readerId);

    // 编辑读者信息
    @Update("UPDATE reader_info SET name = #{name}, sex = #{sex}, birth = #{birth}, address = #{address}, telcode = #{telcode} WHERE reader_id = #{readerId}")
    int editReaderInfo(ReaderInfo readerInfo);

    // 添加读者信息
    @Insert("INSERT INTO reader_info (reader_id, name, sex, birth, address, telcode) " +
            "VALUES (#{readerId}, #{name}, #{sex}, #{birth}, #{address}, #{telcode})")
    int addReaderInfo(ReaderInfo readerInfo);
}
