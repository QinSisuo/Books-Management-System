package com.book.service;

import com.book.domain.BookCategory;
import com.book.mapper.BookCategoryMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
public class BookCategoryService {

    @Autowired
    private BookCategoryMapper categoryMapper;

    // 显示全部分类
    public List<BookCategory> getAllCategories() {
        return categoryMapper.getAllCategories();
    }

    // 添加分类
    @Transactional
    public boolean addCategory(BookCategory category) {
        return categoryMapper.insertCategory(category) > 0;
    }

    // 修改分类
    @Transactional
    public boolean editCategory(BookCategory category) {
        return categoryMapper.updateCategory(category) > 0;
    }

    // 删除分类
    @Transactional
    public boolean deleteCategory(int categoryId) {
        return categoryMapper.deleteCategory(categoryId) > 0;
    }

    // 根据ID获取分类信息
    public BookCategory getCategoryById(int categoryId) {
        return categoryMapper.getCategoryById(categoryId);
    }

}
