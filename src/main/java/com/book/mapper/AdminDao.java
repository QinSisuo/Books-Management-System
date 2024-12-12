package com.book.mapper;

import org.apache.ibatis.annotations.Param;

public interface AdminDao {

    // 获取匹配的管理员记录数
    int getMatchCount(@Param("adminId") int adminId, @Param("password") String password);

    // 更新管理员密码
    int rePassword(@Param("adminId") int adminId, @Param("newPasswd") String newPasswd);

    // 根据 adminId 获取密码（使用 XML 定义，无需注解）
    String getPasswd(int id);
}