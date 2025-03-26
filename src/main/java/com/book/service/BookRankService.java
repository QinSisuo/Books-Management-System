package com.book.service;

import com.book.domain.Book;
import java.util.List;

public interface BookRankService {
    /**
     * 获取借阅排行榜
     * @param limit 返回数量
     * @return 借阅量最多的图书列表
     */
    List<Book> getBorrowRank(int limit);

    /**
     * 获取评分排行榜
     * @param limit 返回数量
     * @return 评分最高的图书列表
     */
    List<Book> getRatingRank(int limit);
} 