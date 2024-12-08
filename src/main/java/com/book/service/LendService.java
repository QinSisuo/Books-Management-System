package com.book.service;

import com.book.dao.LendDao;
import com.book.domain.Lend;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;

@Service
public class LendService {

    @Autowired
    private LendDao lendDao;

    //@Autowired
    public void setLendDao(LendDao lendDao) {
        this.lendDao = lendDao;
    }

    // 归还图书
    public boolean bookReturn(long bookId) {
        String currentDate = new SimpleDateFormat("yyyy-MM-dd").format(new Date());
        return lendDao.bookReturnOne(bookId, currentDate) > 0 && lendDao.bookReturnTwo(bookId) > 0;
    }

    // 借阅图书
    public boolean bookLend(long bookId, int readerId) {
        String currentDate = new SimpleDateFormat("yyyy-MM-dd").format(new Date());
        return lendDao.bookLendOne(bookId, readerId, currentDate) > 0 && lendDao.bookLendTwo(bookId) > 0;
    }

    // 获取所有借阅记录
    public ArrayList<Lend> lendList() {
        return new ArrayList<>(lendDao.lendList());
    }

    // 根据读者 ID 获取借阅记录
    public ArrayList<Lend> myLendList(int readerId) {
        return new ArrayList<>(lendDao.myLendList(readerId));
    }
}
