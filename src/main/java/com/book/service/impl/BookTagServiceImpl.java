package com.book.service.impl;

import com.book.domain.BookTag;
import com.book.mapper.BookTagMapper;
import com.book.service.BookTagService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

@Service
public class BookTagServiceImpl implements BookTagService {
    
    @Autowired
    private BookTagMapper bookTagMapper;

    @Override
    public List<BookTag> queryBookTags(String name) {
        return bookTagMapper.queryBookTags(name);
    }

    @Override
    public boolean addBookTag(BookTag bookTag) {
        return bookTagMapper.addBookTag(bookTag) > 0;
    }

    @Override
    public boolean updateBookTag(BookTag bookTag) {
        return bookTagMapper.updateBookTag(bookTag) > 0;
    }

    @Override
    public boolean deleteBookTag(Long id) {
        return bookTagMapper.deleteBookTag(id) > 0;
    }

    @Override
    public BookTag getBookTagById(Long id) {
        return bookTagMapper.getBookTagById(id);
    }

    @Override
    public List<BookTag> getHotTags(int limit) {
        return bookTagMapper.getHotTags(limit);
    }

    @Override
    public List<BookTag> queryBookTagByIds(List<Long> ids) {
        if (ids == null || ids.isEmpty()) {
            return new ArrayList<>();
        }
        return bookTagMapper.queryBookTagByIds(ids);
    }

    /**
     * 更新标签热度分数
     * @param tagId 标签ID
     */
    public void updateTagHotScore(Long tagId) {
        // 获取标签的使用次数
        int usageCount = bookTagMapper.getTagUsageCount(tagId);
        // 更新热度分数
        bookTagMapper.updateHotScore(tagId, usageCount);
    }

    /**
     * 增加标签热度
     * @param tagId 标签ID
     */
    public void incrementTagHotScore(Long tagId) {
        bookTagMapper.incrementHotScore(tagId);
    }
} 