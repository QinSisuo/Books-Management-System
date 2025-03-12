package com.book.service;

import com.book.domain.Lend;
import com.book.mapper.LendMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;

@Service
public class LendService {

    @Autowired
    private LendMapper lendDao;

    //@Autowired
    public void setLendDao(LendMapper lendDao) {
        this.lendDao = lendDao;
    }

    @Transactional
    public boolean bookReturn(long bookId) {
        String currentDate = new SimpleDateFormat("yyyy-MM-dd").format(new Date());
        return lendDao.bookReturnOne(bookId, currentDate) > 0 && lendDao.bookReturnTwo(bookId) > 0;
    }

    @Transactional
    public boolean bookLend(long bookId, int readerId) {
        String currentDate = new SimpleDateFormat("yyyy-MM-dd").format(new Date());
        return lendDao.bookLendOne(bookId, readerId, currentDate) > 0 && lendDao.bookLendTwo(bookId) > 0;
    }

    public ArrayList<Lend> lendList() {
        return new ArrayList<>(lendDao.lendList());
    }

    public ArrayList<Lend> myLendList(int readerId) {
        return new ArrayList<>(lendDao.myLendList(readerId));
    }
}