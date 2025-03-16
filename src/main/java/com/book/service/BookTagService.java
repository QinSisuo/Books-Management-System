package com.book.service;

import com.book.domain.BookTag;
import java.util.List;

public interface BookTagService {
    List<BookTag> queryBookTags(String name);
    boolean addBookTag(BookTag bookTag);
    boolean updateBookTag(BookTag bookTag);
    boolean deleteBookTag(Long id);
    BookTag getBookTagById(Long id);
} 