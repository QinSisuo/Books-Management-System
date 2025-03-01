package com.book.service;

import com.book.domain.SystemLog;
import com.book.domain.User;
import com.book.mapper.UserMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class UserService {

    @Autowired
    private UserMapper userMapper;

    @Autowired
    private LogService logService;  // 注入 LogService

//    // 登录验证
//    public User login(String username, String password) {
//        User user = userMapper.getUserByUsername(username);
//        if (user != null && user.getPassword().equals(password)) {
//            return user; // 如果用户名和密码匹配，则返回用户对象
//        }
//        return null; // 否则返回 null，表示登录失败
//    }
// 登录验证
public User login(String username, String password) {
    User user = userMapper.getUserByUsername(username);
    SystemLog log = new SystemLog();  // 创建日志对象

    if (user != null && user.getPassword().equals(password)) {
        // 登录成功的日志
        log.setUserId(user.getId());  // 设置操作用户
        log.setUserName(username);
        log.setOperationType("登录");
        log.setDescription("用户登录成功");
        log.setResult("成功");
        //;log.setIpAddress(ipAddress);
        logService.recordLog(log);  // 记录登录成功的日志
        return user; // 如果用户名和密码匹配，则返回用户对象
    } else {
        // 登录失败的日志
        log.setUserName(username);
        log.setOperationType("登录");
        log.setDescription("用户登录失败");
        log.setResult("失败");
        //log.setIpAddress(ipAddress);
        logService.recordLog(log);  // 记录登录失败的日志
        return null; // 否则返回 null，表示登录失败
    }
}

    public List<User> getAllUsers() {
            return userMapper.findAllUsers();
    }

    public boolean deleteUser(int userId) {
        return userMapper.deleteUser(userId) > 0;
    }

    public boolean addUser(User user) {
        int rowsAffected = userMapper.insertUser(user);
        return rowsAffected > 0;
    }

    public boolean updateUser(User user) {
        return userMapper.updateUser(user) > 0;
    }
}