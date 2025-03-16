package com.book.service.impl;

import com.book.domain.BookTag;
import com.book.mapper.BookTagMapper;
import com.book.service.BookTagService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

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
} 