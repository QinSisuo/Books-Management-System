package com.book.mapper;

import com.book.domain.BookTag;
import org.apache.ibatis.annotations.*;

import java.util.List;

public interface BookTagMapper {
    
    @Select("<script>" +
        "SELECT * FROM book_tag" +
        "<where>" +
            "<if test='name != null and name != \"\"'>" +
                "name LIKE CONCAT('%',#{name},'%')" +
            "</if>" +
        "</where>" +
        " ORDER BY hot_score DESC" +
        "</script>")
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

    @Select("SELECT * FROM book_tag WHERE status = '0' ORDER BY hot_score DESC LIMIT #{limit}")
    List<BookTag> getHotTags(@Param("limit") int limit);

    /**
     * 根据ID列表查询标签
     * @param ids 标签ID列表
     * @return 标签列表
     */
    @Select("<script>" +
            "SELECT * FROM book_tag WHERE id IN " +
            "<foreach collection='list' item='id' open='(' separator=',' close=')'>" +
            "#{id}" +
            "</foreach>" +
            "</script>")
    List<BookTag> queryBookTagByIds(List<Long> ids);
} 