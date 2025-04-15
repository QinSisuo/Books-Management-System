package com.book.service;

import com.book.domain.SystemLog;
import com.book.domain.User;
import com.book.mapper.UserMapper;
import com.book.util.IpUtil;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.servlet.http.HttpServletRequest;
import java.util.List;

@Service
public class UserService {

    private static final Logger logger = LoggerFactory.getLogger(UserService.class);

    @Autowired
    private UserMapper userMapper;

    @Autowired
    private LogService logService;

    // 根据用户名获取用户
    public User getUserByUsername(String username) {
        return userMapper.getUserByUsername(username);
    }

    // 登录验证
    public User login(String username, String password, HttpServletRequest request) {
        User user = userMapper.getUserByUsername(username);
        SystemLog log = new SystemLog();

        if (user != null && user.getPassword().equals(password)) {
            log.setUserId(user.getId());
            log.setUserName(username);
            log.setOperationType("登录");
            log.setDescription("用户登录成功");
            log.setResult("成功");
            log.setIpAddress(IpUtil.getIpAddress(request));
            logService.recordLog(log);
            return user;
        } else {
            log.setUserName(username);
            log.setOperationType("登录");
            log.setDescription("用户登录失败");
            log.setResult("失败");
            log.setIpAddress(IpUtil.getIpAddress(request));
            logService.recordLog(log);
            return null;
        }
    }


    // =============== 整合UserAdminService的功能 ===============

    public List<User> searchUsers(String searchWord) {
        logger.info("搜索用户，关键词: {}", searchWord);
        return userMapper.searchUsers(searchWord);
    }


    // 获取所有读者信息
    public List<User> getAllReaders() {
        logger.info("获取所有读者信息");
        return userMapper.findUsersByRole("reader");
    }

    // 添加读者
    public boolean addReader(User user, HttpServletRequest request) {
        logger.info("添加新读者 - 用户名: {}", user.getUsername());
        user.setRole("reader"); // 确保角色为 reader
        int rows = userMapper.insertUser(user);
        
        // 记录操作日志
        SystemLog log = new SystemLog();
        log.setOperationType("添加读者");
        log.setDescription("添加新读者: " + user.getUsername());
        log.setResult(rows > 0 ? "成功" : "失败");
        log.setIpAddress(IpUtil.getIpAddress(request));
        logService.recordLog(log);
        
        return rows > 0;
    }

    // 根据 ID 获取读者信息
    public User getReaderById(Long id) {
        logger.info("根据 ID 获取读者信息 - 读者ID: {}", id);
        return userMapper.findUserById(id);
    }

    // 更新读者信息
    public boolean updateReader(User user, HttpServletRequest request) {
        logger.info("更新读者信息 - 读者ID: {}", user.getUserId());
        int rows = userMapper.updateUser(user);
        
        // 记录操作日志
        SystemLog log = new SystemLog();
        log.setOperationType("更新读者");
        log.setDescription("更新读者信息: " + user.getUsername());
        log.setResult(rows > 0 ? "成功" : "失败");
        log.setIpAddress(IpUtil.getIpAddress(request));
        logService.recordLog(log);
        
        return rows > 0;
    }

    // =============== 原有的通用用户管理功能 ===============

    public List<User> getAllUsers() {
        logger.info("获取所有用户信息");
        return userMapper.findAllUsers();
    }

    // 删除用户
    public boolean deleteUser(Long userId, HttpServletRequest request) {
        logger.info("删除用户 - 用户ID: {}", userId);
        
        // 获取当前登录用户（操作者）
        User currentUser = (User) request.getSession().getAttribute("user");
        
        int rows = userMapper.deleteUser(userId);
        
        // 记录操作日志
        SystemLog log = new SystemLog();
        if (currentUser != null) {
            log.setUserId(currentUser.getUserId());
            log.setUserName(currentUser.getUsername());
        }
        log.setOperationType("删除用户");
        log.setDescription("删除用户ID: " + userId);
        log.setResult(rows > 0 ? "成功" : "失败");
        log.setIpAddress(IpUtil.getIpAddress(request));
        logService.recordLog(log);
        
        return rows > 0;
    }

    public boolean addUser(User user, HttpServletRequest request) {
        logger.info("添加新用户 - 用户名: {}", user.getUsername());
        int rows = userMapper.insertUser(user);
        
        // 记录操作日志
        SystemLog log = new SystemLog();
        log.setOperationType("添加用户");
        log.setDescription("添加新用户: " + user.getUsername());
        log.setResult(rows > 0 ? "成功" : "失败");
        log.setIpAddress(IpUtil.getIpAddress(request));
        logService.recordLog(log);
        
        return rows > 0;
    }

    public boolean updateUser(User user, HttpServletRequest request) {
        try {
            logger.info("正在更新用户信息 - 用户ID: {}, 角色: {}", user.getUserId(), user.getRole());
            
            // 验证用户是否存在
            User existingUser = userMapper.getUserById(user.getUserId());
            if (existingUser == null) {
                logger.error("更新失败 - 用户不存在，ID: {}", user.getUserId());
                return false;
            }
            
            // 验证角色值
            if (user.getRole() == null || (!user.getRole().equals("admin") && !user.getRole().equals("reader"))) {
                logger.error("更新失败 - 无效的角色值: {}", user.getRole());
                return false;
            }
            
            int rows = userMapper.updateUser(user);
            
            if (rows > 0) {
                logger.info("用户信息更新成功 - 用户ID: {}", user.getUserId());
                // 记录操作日志
                SystemLog log = new SystemLog();
                log.setOperationType("更新用户");
                log.setDescription("更新用户信息: " + user.getUsername());
                log.setResult("成功");
                log.setIpAddress(IpUtil.getIpAddress(request));
                logService.recordLog(log);
                return true;
            } else {
                logger.error("用户信息更新失败 - 用户ID: {}", user.getUserId());
                // 记录操作日志
                SystemLog log = new SystemLog();
                log.setOperationType("更新用户");
                log.setDescription("更新用户信息: " + user.getUsername());
                log.setResult("失败");
                log.setIpAddress(IpUtil.getIpAddress(request));
                logService.recordLog(log);
                return false;
            }
        } catch (Exception e) {
            logger.error("更新用户信息时发生错误 - 用户ID: {}, 错误: {}", user.getUserId(), e.getMessage());
            throw e;
        }
    }

    public boolean updateUserProfile(User user, String newPassword, HttpServletRequest request) {
        try {
            logger.info("正在更新用户个人信息 - 用户ID: {}", user.getUserId());
            
            // 验证用户是否存在
            User existingUser = userMapper.getUserById(user.getUserId());
            if (existingUser == null) {
                logger.error("更新失败 - 用户不存在，ID: {}", user.getUserId());
                return false;
            }
            
            // 更新基本信息
            int rows = userMapper.updateUser(user);
            
            // 如果提供了新密码，则更新密码
            if (newPassword != null && !newPassword.trim().isEmpty()) {
                userMapper.updatePassword(user.getUserId(), newPassword);
            }
            
            if (rows > 0) {
                logger.info("用户个人信息更新成功 - 用户ID: {}", user.getUserId());
                // 记录操作日志
                SystemLog log = new SystemLog();
                log.setOperationType("更新个人信息");
                log.setDescription("更新用户个人信息: " + user.getUsername());
                log.setResult("成功");
                log.setIpAddress(IpUtil.getIpAddress(request));
                logService.recordLog(log);
                return true;
            } else {
                logger.error("用户个人信息更新失败 - 用户ID: {}", user.getUserId());
                // 记录操作日志
                SystemLog log = new SystemLog();
                log.setOperationType("更新个人信息");
                log.setDescription("更新用户个人信息: " + user.getUsername());
                log.setResult("失败");
                log.setIpAddress(IpUtil.getIpAddress(request));
                logService.recordLog(log);
                return false;
            }
        } catch (Exception e) {
            logger.error("更新用户个人信息时发生错误 - 用户ID: {}, 错误: {}", user.getUserId(), e.getMessage());
            throw e;
        }
    }
}