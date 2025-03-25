package com.book.service;

import com.book.domain.BookTag;
import java.util.List;

public interface BookTagService {
    List<BookTag> queryBookTags(String name);
    boolean addBookTag(BookTag bookTag);
    boolean updateBookTag(BookTag bookTag);
    boolean deleteBookTag(Long id);
    BookTag getBookTagById(Long id);
    List<BookTag> getHotTags(int limit);
    /**
     * 根据ID列表查询标签
     * @param ids 标签ID列表
     * @return 标签列表
     */
    List<BookTag> queryBookTagByIds(List<Long> ids);
} 