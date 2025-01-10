package com.book.mapper;

import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

public interface AdminMapper {

    // 检查管理员账号和密码是否匹配
    @Select("SELECT COUNT(*) FROM admin WHERE admin_id = #{adminId} AND password = #{password}")
    int getMatchCount(@Param("adminId") int adminId, @Param("password") String password);

    // 更新管理员密码
    @Update("UPDATE admin SET password = #{newPasswd} WHERE admin_id = #{adminId}")
    int rePassword(@Param("adminId") int adminId, @Param("newPasswd") String newPasswd);

    // 根据 adminId 获取密码
    @Select("SELECT password FROM admin WHERE admin_id = #{id}")
    String getPasswd(@Param("id") int id);
}
