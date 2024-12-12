package com.book.service;

import com.book.mapper.ReaderInfoDao;
import com.book.domain.ReaderInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class ReaderInfoService {
    @Autowired
    private ReaderInfoDao readerInfoDao;

//    @Autowired
    public void setReaderInfoDao(ReaderInfoDao readerInfoDao) {
        this.readerInfoDao = readerInfoDao;
    }

    // 获取所有读者信息
    public List<ReaderInfo> readerInfos() {
        return readerInfoDao.getAllReaderInfo();
    }

    // 删除读者信息
    public boolean deleteReaderInfo(int readerId) {
        return readerInfoDao.deleteReaderInfo(readerId) > 0;
    }

    // 根据 readerId 获取读者信息
    public ReaderInfo getReaderInfo(int readerId) {
        return readerInfoDao.findReaderInfoByReaderId(readerId);
    }

    // 编辑读者信息
    public boolean editReaderInfo(ReaderInfo readerInfo) {
        return readerInfoDao.editReaderInfo(readerInfo) > 0;
    }

    // 添加读者信息
    public boolean addReaderInfo(ReaderInfo readerInfo) {
        return readerInfoDao.addReaderInfo(readerInfo) > 0;
    }
}
