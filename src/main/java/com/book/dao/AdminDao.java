package com.book.dao;

import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

public interface AdminDao {

    // 获取匹配的管理员记录数
    int getMatchCount(@Param("adminId") int adminId, @Param("password") String password);

    // 更新管理员密码
    int rePassword(@Param("adminId") int adminId, @Param("newPasswd") String newPasswd);

    // 根据 adminId 获取密码
    @Select("SELECT password FROM admin WHERE admin_id = #{id}")
    String getPasswd(int id);
}
