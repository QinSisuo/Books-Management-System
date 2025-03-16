package com.book.mapper;

import com.book.domain.BookTag;
import org.apache.ibatis.annotations.*;

import java.util.List;

public interface BookTagMapper {
    
    @Select("SELECT * FROM book_tag WHERE name LIKE CONCAT('%',#{name},'%') ORDER BY hot_score DESC")
    List<BookTag> queryBookTags(@Param("name") String name);

    @Insert("INSERT INTO book_tag(name, status, create_time, create_by) " +
            "VALUES(#{name}, #{status}, #{createTime}, #{createBy})")
    int addBookTag(BookTag bookTag);

    @Update("UPDATE book_tag SET name=#{name}, status=#{status}, " +
            "update_time=#{updateTime}, update_by=#{updateBy}, remark=#{remark} " +
            "WHERE id=#{id}")
    int updateBookTag(BookTag bookTag);

    @Delete("DELETE FROM book_tag WHERE id=#{id}")
    int deleteBookTag(@Param("id") Long id);

    @Select("SELECT * FROM book_tag WHERE id=#{id}")
    BookTag getBookTagById(@Param("id") Long id);
} 