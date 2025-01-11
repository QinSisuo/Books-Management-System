package com.book.service;

import com.book.domain.User;
import com.book.mapper.UserMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
@Service
public class UserService {

    @Autowired
    private UserMapper userMapper;

    public User login(String username, String password) {
        // 根据用户名获取用户
        User user = userMapper.getUserByUsername(username);
        if (user != null && user.getPassword().equals(password)) { // 简单校验
            return user;
        }
        return null; // 登录失败
    }

    public List<User> getAllUsers() {
        return userMapper.getAllUsers();
    }
    public boolean deleteUser(long userId) {
        int rowsAffected = userMapper.deleteUser(userId);
        return rowsAffected > 0; // 返回是否删除成功
    }
}