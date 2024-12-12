package com.book.service;

import com.book.mapper.ReaderCardMapper;
import com.book.domain.ReaderInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class ReaderCardService {
    @Autowired
    private ReaderCardMapper readerCardMapper;

//    @Autowired
    public void setReaderCardDao(ReaderCardMapper readerCardMapper) {
        this.readerCardMapper = readerCardMapper;
    }

    // 添加读者卡
    public boolean addReaderCard(ReaderInfo readerInfo) {
        return readerCardMapper.addReaderCard(readerInfo.getReaderId(), readerInfo.getName()) > 0;
    }

    // 更新密码
    public boolean updatePasswd(int readerId, String passwd) {
        return readerCardMapper.rePassword(readerId, passwd) > 0;
    }

    // 更新姓名
    public boolean updateName(int readerId, String name) {
        return readerCardMapper.updateName(readerId, name) > 0;
    }
}
