package com.book.mapper;

import com.book.domain.ReaderCard;

public interface ReaderCardMapper {

    // 查询匹配的数量
    int getMatchCount(int readerId, String passwd);

    // 根据用户 ID 查找 ReaderCard 信息
    ReaderCard findReaderByReaderId(int userId);

    // 修改密码：返回受影响的行数
    int rePassword(int readerId, String newPasswd);

    // 添加读者卡：返回受影响的行数
    int addReaderCard(int readerId, String name);

    // 更新读者姓名：返回受影响的行数
    int updateName(int readerId, String name);
}