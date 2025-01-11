package com.book.mapper;

import com.book.domain.User;
import org.apache.ibatis.annotations.*;

import java.util.List;

@Mapper
public interface UserMapper {

    @Select("SELECT * FROM users")
    List<User> getAllUsers();

    @Insert("INSERT INTO users (username, password, role, email, phone, address) VALUES (#{username}, #{password}, #{role}, #{email}, #{phone}, #{address})")
    void insertUser(User user);

    @Delete("DELETE FROM users WHERE user_id = #{userId}")
    int deleteUser(long userId); // 返回受影响的行数

    @Select("SELECT * FROM users WHERE username = #{username}")
    User getUserByUsername(String username);
}
