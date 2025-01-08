package com.book.mapper;

import com.book.domain.ReaderInfo;
import java.util.List;

public interface ReaderInfoMapper {

    // 获取所有读者信息
    List<ReaderInfo> getAllReaderInfo();

    // 根据 readerId 查找读者信息
    ReaderInfo findReaderInfoByReaderId(int readerId);

    // 删除读者信息
    int deleteReaderInfo(int readerId);

    // 编辑读者信息
    int editReaderInfo(ReaderInfo readerInfo);

    // 添加读者信息
    int addReaderInfo(ReaderInfo readerInfo);
}