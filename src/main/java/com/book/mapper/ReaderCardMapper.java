package com.book.mapper;

import com.book.domain.ReaderCard;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

public interface ReaderCardMapper {

    // 根据用户查询匹配的数量
    @Select("SELECT count(*) FROM reader_card WHERE reader_id = #{readerId} AND passwd = #{passwd}")
    int getMatchCount(@Param("readerId") int readerId, @Param("passwd") String passwd);

    // 根据用户 ID 查找 ReaderCard 信息
    @Select("SELECT reader_id, name, passwd, card_state FROM reader_card WHERE reader_id = #{userId}")
    ReaderCard findReaderByReaderId(@Param("userId") int userId);

    // 修改密码
    @Update("UPDATE reader_card SET passwd = #{newPasswd} WHERE reader_id = #{readerId}")
    int rePassword(@Param("readerId") int readerId, @Param("newPasswd") String newPasswd);

    // 添加读者卡
    @Update("INSERT INTO reader_card (reader_id, name) VALUES (#{readerId}, #{name})")
    int addReaderCard(@Param("readerId") int readerId, @Param("name") String name);

    // 更新读者姓名
    @Update("UPDATE reader_card SET name = #{name} WHERE reader_id = #{readerId}")
    int updateName(@Param("readerId") int readerId, @Param("name") String name);
}
