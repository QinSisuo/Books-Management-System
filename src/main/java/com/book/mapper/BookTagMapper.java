package com.book.mapper;

import com.book.domain.BookTag;
import org.apache.ibatis.annotations.*;

import java.util.List;

public interface BookTagMapper {
    
    @Select("<script>" +
        "SELECT t.*, " +
        "       COALESCE(COUNT(DISTINCT br.id), 0) as borrow_count, " +
        "       COALESCE(COUNT(DISTINCT br.id), 0) as hot_score " +
        "FROM book_tag t " +
        "LEFT JOIN book_tag_relation r ON t.id = r.tag_id " +
        "LEFT JOIN borrow_record br ON r.book_id = br.book_id " +
        "<where>" +
            "<if test='name != null and name != \"\"'>" +
                "t.name LIKE CONCAT('%',#{name},'%')" +
            "</if>" +
        "</where>" +
        "GROUP BY t.id " +
        "ORDER BY hot_score DESC" +
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

    @Select("SELECT t.*, " +
            "       COALESCE(COUNT(DISTINCT br.id), 0) as borrow_count, " +
            "       COALESCE(COUNT(DISTINCT br.id), 0) as hot_score " +
            "FROM book_tag t " +
            "LEFT JOIN book_tag_relation r ON t.id = r.tag_id " +
            "LEFT JOIN borrow_record br ON r.book_id = br.book_id " +
            "WHERE t.id=#{id} " +
            "GROUP BY t.id")
    BookTag getBookTagById(@Param("id") Long id);

    /**
     * 获取热门标签
     * 基于图书借阅次数计算标签热度
     * @param limit 返回的标签数量
     * @return 热门标签列表
     */
    @Select("SELECT t.*, " +
            "       COALESCE(COUNT(DISTINCT br.id), 0) as borrow_count, " +
            "       COALESCE(COUNT(DISTINCT br.id), 0) as hot_score " +
            "FROM book_tag t " +
            "LEFT JOIN book_tag_relation r ON t.id = r.tag_id " +
            "LEFT JOIN borrow_record br ON r.book_id = br.book_id " +
            "WHERE t.status = '0' " +
            "GROUP BY t.id " +
            "ORDER BY hot_score DESC " +
            "LIMIT #{limit}")
    List<BookTag> getHotTags(@Param("limit") int limit);

    /**
     * 根据ID列表查询标签
     * @param ids 标签ID列表
     * @return 标签列表
     */
    @Select("<script>" +
            "SELECT t.*, " +
            "       COALESCE(COUNT(DISTINCT br.id), 0) as borrow_count, " +
            "       COALESCE(COUNT(DISTINCT br.id), 0) as hot_score " +
            "FROM book_tag t " +
            "LEFT JOIN book_tag_relation r ON t.id = r.tag_id " +
            "LEFT JOIN borrow_record br ON r.book_id = br.book_id " +
            "WHERE t.id IN " +
            "<foreach collection='list' item='id' open='(' separator=',' close=')'>" +
            "#{id}" +
            "</foreach>" +
            "GROUP BY t.id" +
            "</script>")
    List<BookTag> queryBookTagByIds(List<Long> ids);

    @Update("UPDATE book_tag SET hot_score = hot_score + 1 WHERE id = #{id}")
    int incrementHotScore(@Param("id") Long id);

    @Select("SELECT COUNT(*) FROM book_tag_relation WHERE tag_id = #{tagId}")
    int getTagUsageCount(@Param("tagId") Long tagId);

    @Update("UPDATE book_tag SET hot_score = #{score} WHERE id = #{id}")
    int updateHotScore(@Param("id") Long id, @Param("score") int score);
} 