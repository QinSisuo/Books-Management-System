package com.book.service;

import com.book.mapper.ReaderInfoMapper;
import com.book.domain.ReaderInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class ReaderInfoService {
    @Autowired
    private ReaderInfoMapper readerInfoMapper;

//    @Autowired
    public void setReaderInfoDao(ReaderInfoMapper readerInfoMapper) {
        this.readerInfoMapper = readerInfoMapper;
    }

    // 获取所有读者信息
    public List<ReaderInfo> readerInfos() {
        return readerInfoMapper.getAllReaderInfo();
    }

    // 删除读者信息
    public boolean deleteReaderInfo(int readerId) {
        return readerInfoMapper.deleteReaderInfo(readerId) > 0;
    }

    // 根据 readerId 获取读者信息
    public ReaderInfo getReaderInfo(int readerId) {
        return readerInfoMapper.findReaderInfoByReaderId(readerId);
    }

    // 编辑读者信息
    public boolean editReaderInfo(ReaderInfo readerInfo) {
        return readerInfoMapper.editReaderInfo(readerInfo) > 0;
    }

    // 添加读者信息
    public boolean addReaderInfo(ReaderInfo readerInfo) {
        return readerInfoMapper.addReaderInfo(readerInfo) > 0;
    }
}
