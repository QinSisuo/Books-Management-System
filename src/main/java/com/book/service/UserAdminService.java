package com.book.service;

import com.book.domain.User;
import com.book.mapper.UserMapper;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class UserAdminService {

    private static final Logger logger = LoggerFactory.getLogger(UserAdminService.class);

    @Autowired
    private UserMapper userMapper;

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
        return rows > 0;
    }

    // 删除读者
    public boolean deleteReader(int id) {
        logger.info("删除读者 - 读者ID: {}", id);
        int rows = userMapper.deleteUser(id);
        return rows > 0;
    }
}
