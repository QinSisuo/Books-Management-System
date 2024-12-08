package com.book.dao;

import com.book.domain.Lend;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface LendDao {

    // 归还图书 - 更新 lend_list 的 back_date
    int bookReturnOne(@Param("bookId") long bookId, @Param("backDate") String backDate);

    // 归还图书 - 更新 book_info 的 state
    int bookReturnTwo(@Param("bookId") long bookId);

    // 借阅图书 - 插入 lend_list
    int bookLendOne(@Param("bookId") long bookId, @Param("readerId") int readerId, @Param("lendDate") String lendDate);

    // 借阅图书 - 更新 book_info 的 state
    int bookLendTwo(@Param("bookId") long bookId);

    // 获取所有借阅记录
    List<Lend> lendList();

    // 根据读者 ID 获取借阅记录
    List<Lend> myLendList(@Param("readerId") int readerId);
}
