package com.book.mapper;

import com.book.domain.User;
import org.apache.ibatis.annotations.*;

import java.util.List;

@Mapper
public interface UserMapper {

    // all users
    @Select("SELECT * FROM users")
    List<User> findAllUsers();

    // 根据用户名查询用户信息
    @Select("SELECT * FROM users WHERE username = #{username}")
    User getUserByUsername(@Param("username") String username);

    // 根据角色获取用户
    @Select("SELECT * FROM users WHERE role = #{role}")
    List<User> getUsersByRole(@Param("role") String role);

    // 插入新用户
    @Insert("INSERT INTO users (username, password, role, email, phone, address, created_at, updated_at) " +
            "VALUES (#{username}, #{password}, #{role}, #{email}, #{phone}, #{address}, NOW(), NOW())")
    int insertUser(User user);

    // 根据用户 ID 获取用户
    @Select("SELECT * FROM users WHERE user_id = #{userId}")
    User getUserById(@Param("userId") int userId);

    // 更新用户信息
    @Update("UPDATE users SET username = #{username}, email = #{email}, phone = #{phone}, " +
            "address = #{address}, updated_at = NOW() WHERE user_id = #{userId}")
    int updateUser(User user);

    // 删除用户
    @Delete("DELETE FROM users WHERE user_id = #{userId}")
    int deleteUser(@Param("userId") int userId);

    // 根据用户名和密码查找用户（用于登录）
    @Select("SELECT * FROM users WHERE username = #{username} AND password = #{password}")
    User findByUsernameAndPassword(@Param("username") String username, @Param("password") String password);
    // 根据角色查询用户
    @Select("SELECT * FROM users WHERE role = #{role}")
    List<User> findUsersByRole(@Param("role") String role);

    // 根据 ID 查询用户
    @Select("SELECT * FROM users WHERE user_id = #{id}")
    User findUserById(@Param("id") int id);

    @Select("SELECT user_id, username, email, role, phone, address, created_at, updated_at FROM users")
    List<User> getAllUsers();

    @Select("SELECT user_id, username, email, role, phone, address, created_at, updated_at FROM users " +
            "WHERE username LIKE CONCAT('%', #{searchWord}, '%') " +
            "OR email LIKE CONCAT('%', #{searchWord}, '%')")
    List<User> searchUsers(@Param("searchWord") String searchWord);


}