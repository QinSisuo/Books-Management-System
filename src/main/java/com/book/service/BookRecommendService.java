package com.book.service;

import com.book.domain.Book;
import java.util.List;

public interface BookRecommendService {
    /**
     * 获取热门图书
     * 根据借阅量和评分综合排序
     * @param limit 返回数量
     * @return 热门图书列表
     */
    List<Book> getHotBooks(int limit);
} 