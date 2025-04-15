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

/**
 * 用户服务类
 * 处理所有与用户相关的业务逻辑
 */
@Service
public class UserService {

    private static final Logger logger = LoggerFactory.getLogger(UserService.class);

    @Autowired
    private UserMapper userMapper;

    @Autowired
    private LogService logService;

    // =============== 用户查询相关方法 ===============
    
    /**
     * 根据用户名获取用户
     * @param username 用户名
     * @return 用户对象，如果不存在返回null
     */
    public User getUserByUsername(String username) {
        return userMapper.getUserByUsername(username);
    }

    /**
     * 获取所有用户信息
     * @return 用户列表
     */
    public List<User> getAllUsers() {
        logger.info("获取所有用户信息");
        return userMapper.findAllUsers();
    }

    /**
     * 搜索用户
     * @param searchWord 搜索关键词
     * @return 匹配的用户列表
     */
    public List<User> searchUsers(String searchWord) {
        logger.info("搜索用户，关键词: {}", searchWord);
        return userMapper.searchUsers(searchWord);
    }

    // =============== 用户认证相关方法 ===============
    
    /**
     * 用户登录验证
     * @param username 用户名
     * @param password 密码
     * @param request HTTP请求对象
     * @return 登录成功的用户对象，失败返回null
     */
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

    // =============== 用户管理相关方法 ===============
    
    /**
     * 添加新用户
     * @param user 用户对象
     * @param request HTTP请求对象
     * @return 是否添加成功
     */
    public boolean addUser(User user, HttpServletRequest request) {
        logger.info("添加新用户 - 用户名: {}", user.getUsername());
        int rows = userMapper.insertUser(user);
        
        SystemLog log = new SystemLog();
        log.setOperationType("添加用户");
        log.setDescription("添加新用户: " + user.getUsername());
        log.setResult(rows > 0 ? "成功" : "失败");
        log.setIpAddress(IpUtil.getIpAddress(request));
        logService.recordLog(log);
        
        return rows > 0;
    }

    /**
     * 更新用户信息
     * @param user 用户对象
     * @param request HTTP请求对象
     * @return 是否更新成功
     */
    public boolean updateUser(User user, HttpServletRequest request) {
        try {
            logger.info("正在更新用户信息 - 用户ID: {}, 角色: {}", user.getUserId(), user.getRole());
            
            User existingUser = userMapper.getUserById(user.getUserId());
            if (existingUser == null) {
                logger.error("更新失败 - 用户不存在，ID: {}", user.getUserId());
                return false;
            }
            
            if (user.getRole() == null || (!user.getRole().equals("admin") && !user.getRole().equals("reader"))) {
                logger.error("更新失败 - 无效的角色值: {}", user.getRole());
                return false;
            }
            
            int rows = userMapper.updateUser(user);
            
            SystemLog log = new SystemLog();
            log.setOperationType("更新用户");
            log.setDescription("更新用户信息: " + user.getUsername());
            log.setResult(rows > 0 ? "成功" : "失败");
            log.setIpAddress(IpUtil.getIpAddress(request));
            logService.recordLog(log);
            
            return rows > 0;
        } catch (Exception e) {
            logger.error("更新用户信息时发生错误 - 用户ID: {}, 错误: {}", user.getUserId(), e.getMessage());
            throw e;
        }
    }

    /**
     * 更新用户个人信息
     * @param user 用户对象
     * @param newPassword 新密码（可选）
     * @param request HTTP请求对象
     * @return 是否更新成功
     */
    public boolean updateUserProfile(User user, String newPassword, HttpServletRequest request) {
        try {
            logger.info("正在更新用户个人信息 - 用户ID: {}", user.getUserId());
            
            User existingUser = userMapper.getUserById(user.getUserId());
            if (existingUser == null) {
                logger.error("更新失败 - 用户不存在，ID: {}", user.getUserId());
                return false;
            }
            
            int rows = userMapper.updateUser(user);
            
            if (newPassword != null && !newPassword.trim().isEmpty()) {
                userMapper.updatePassword(user.getUserId(), newPassword);
            }
            
            SystemLog log = new SystemLog();
            log.setOperationType("更新个人信息");
            log.setDescription("更新用户个人信息: " + user.getUsername());
            log.setResult(rows > 0 ? "成功" : "失败");
            log.setIpAddress(IpUtil.getIpAddress(request));
            logService.recordLog(log);
            
            return rows > 0;
        } catch (Exception e) {
            logger.error("更新用户个人信息时发生错误 - 用户ID: {}, 错误: {}", user.getUserId(), e.getMessage());
            throw e;
        }
    }

    /**
     * 删除用户
     * @param userId 用户ID
     * @param request HTTP请求对象
     * @return 是否删除成功
     */
    public boolean deleteUser(Long userId, HttpServletRequest request) {
        logger.info("删除用户 - 用户ID: {}", userId);
        
        User currentUser = (User) request.getSession().getAttribute("user");
        int rows = userMapper.deleteUser(userId);
        
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
}