package com.book.service;

import com.book.mapper.ReaderCardDao;
import com.book.domain.ReaderInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class ReaderCardService {
    @Autowired
    private ReaderCardDao readerCardDao;

//    @Autowired
    public void setReaderCardDao(ReaderCardDao readerCardDao) {
        this.readerCardDao = readerCardDao;
    }

    // 添加读者卡
    public boolean addReaderCard(ReaderInfo readerInfo) {
        return readerCardDao.addReaderCard(readerInfo.getReaderId(), readerInfo.getName()) > 0;
    }

    // 更新密码
    public boolean updatePasswd(int readerId, String passwd) {
        return readerCardDao.rePassword(readerId, passwd) > 0;
    }

    // 更新姓名
    public boolean updateName(int readerId, String name) {
        return readerCardDao.updateName(readerId, name) > 0;
    }
}
