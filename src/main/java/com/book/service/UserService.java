package com.book.service;

import com.book.domain.SystemLog;
import com.book.domain.User;
import com.book.mapper.UserMapper;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class UserService {

    private static final Logger logger = LoggerFactory.getLogger(UserService.class);

    @Autowired
    private UserMapper userMapper;

    @Autowired
    private LogService logService;

    // 登录验证
    public User login(String username, String password) {
        User user = userMapper.getUserByUsername(username);
        SystemLog log = new SystemLog();

        if (user != null && user.getPassword().equals(password)) {
            log.setUserId(user.getId());
            log.setUserName(username);
            log.setOperationType("登录");
            log.setDescription("用户登录成功");
            log.setResult("成功");
            logService.recordLog(log);
            return user;
        } else {
            log.setUserName(username);
            log.setOperationType("登录");
            log.setDescription("用户登录失败");
            log.setResult("失败");
            logService.recordLog(log);
            return null;
        }
    }

    // =============== 整合UserAdminService的功能 ===============

    // 获取所有读者信息
    public List<User> getAllReaders() {
        logger.info("获取所有读者信息");
        return userMapper.findUsersByRole("reader");
    }

    // 添加读者
    public boolean addReader(User user) {
        logger.info("添加新读者 - 用户名: {}", user.getUsername());
        user.setRole("reader"); // 确保角色为 reader
        int rows = userMapper.insertUser(user);
        
        // 记录操作日志
        SystemLog log = new SystemLog();
        log.setOperationType("添加读者");
        log.setDescription("添加新读者: " + user.getUsername());
        log.setResult(rows > 0 ? "成功" : "失败");
        logService.recordLog(log);
        
        return rows > 0;
    }

    // 根据 ID 获取读者信息
    public User getReaderById(int id) {
        logger.info("根据 ID 获取读者信息 - 读者ID: {}", id);
        return userMapper.findUserById(id);
    }

    // 更新读者信息
    public boolean updateReader(User user) {
        logger.info("更新读者信息 - 读者ID: {}", user.getUserId());
        int rows = userMapper.updateUser(user);
        
        // 记录操作日志
        SystemLog log = new SystemLog();
        log.setOperationType("更新读者");
        log.setDescription("更新读者信息: " + user.getUsername());
        log.setResult(rows > 0 ? "成功" : "失败");
        logService.recordLog(log);
        
        return rows > 0;
    }

    // 删除读者
    public boolean deleteReader(int id) {
        logger.info("删除读者 - 读者ID: {}", id);
        int rows = userMapper.deleteUser(id);
        
        // 记录操作日志
        SystemLog log = new SystemLog();
        log.setOperationType("删除读者");
        log.setDescription("删除读者ID: " + id);
        log.setResult(rows > 0 ? "成功" : "失败");
        logService.recordLog(log);
        
        return rows > 0;
    }

    // =============== 原有的通用用户管理功能 ===============

    public List<User> getAllUsers() {
        logger.info("获取所有用户信息");
        return userMapper.findAllUsers();
    }

    public boolean deleteUser(int userId) {
        logger.info("删除用户 - 用户ID: {}", userId);
        int rows = userMapper.deleteUser(userId);
        
        // 记录操作日志
        SystemLog log = new SystemLog();
        log.setOperationType("删除用户");
        log.setDescription("删除用户ID: " + userId);
        log.setResult(rows > 0 ? "成功" : "失败");
        logService.recordLog(log);
        
        return rows > 0;
    }

    public boolean addUser(User user) {
        logger.info("添加新用户 - 用户名: {}", user.getUsername());
        int rows = userMapper.insertUser(user);
        
        // 记录操作日志
        SystemLog log = new SystemLog();
        log.setOperationType("添加用户");
        log.setDescription("添加新用户: " + user.getUsername());
        log.setResult(rows > 0 ? "成功" : "失败");
        logService.recordLog(log);
        
        return rows > 0;
    }

    public boolean updateUser(User user) {
        logger.info("更新用户信息 - 用户ID: {}", user.getUserId());
        int rows = userMapper.updateUser(user);
        
        // 记录操作日志
        SystemLog log = new SystemLog();
        log.setOperationType("更新用户");
        log.setDescription("更新用户信息: " + user.getUsername());
        log.setResult(rows > 0 ? "成功" : "失败");
        logService.recordLog(log);
        
        return rows > 0;
    }
}