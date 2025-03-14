package com.book.service;

import com.book.domain.BookCategory;
import com.book.exception.CategoryException;
import com.book.mapper.BookCategoryMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.StringUtils;

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
        validateCategory(category);
        // 检查分类名是否已存在
        if (isCategoryNameExists(category.getCategoryName())) {
            throw new CategoryException("分类名称已存在，请使用其他名称");
        }
        return categoryMapper.insertCategory(category) > 0;
    }

    // 修改分类
    @Transactional
    public boolean editCategory(BookCategory category) {
        validateCategory(category);
        // 检查分类是否存在
        BookCategory existingCategory = getCategoryById(category.getCategoryId());
        if (existingCategory == null) {
            throw new CategoryException("要修改的分类不存在");
        }
        // 检查新名称是否与其他分类重复（排除自身）
        if (!existingCategory.getCategoryName().equals(category.getCategoryName()) 
            && isCategoryNameExists(category.getCategoryName())) {
            throw new CategoryException("分类名称已存在，请使用其他名称");
        }
        return categoryMapper.updateCategory(category) > 0;
    }

    // 删除分类
    @Transactional
    public boolean deleteCategory(int categoryId) {
        System.out.println("Service层开始处理删除请求，分类ID: " + categoryId);
        
        try {
            // 检查分类是否存在
            BookCategory category = getCategoryById(categoryId);
            System.out.println("查询到的分类信息: " + (category != null ? category.getCategoryName() : "null"));
            
            if (category == null) {
                throw new CategoryException("要删除的分类不存在");
            }

            // 执行删除操作
            System.out.println("开始执行删除SQL");
            int result = categoryMapper.deleteCategory(categoryId);
            System.out.println("删除SQL执行结果: " + result);
            
            if (result <= 0) {
                throw new CategoryException("删除分类失败，请重试");
            }
            return true;
        } catch (Exception e) {
            System.out.println("Service层删除操作发生异常: " + e.getMessage());
            e.printStackTrace();
            throw e;
        }
    }

    // 根据ID获取分类信息
    public BookCategory getCategoryById(int categoryId) {
        if (categoryId <= 0) {
            throw new CategoryException("分类ID不能小于或等于0");
        }
        return categoryMapper.getCategoryById(categoryId);
    }

    // 验证分类信息
    private void validateCategory(BookCategory category) {
        if (category == null) {
            throw new CategoryException("分类信息不能为空");
        }
        if (!StringUtils.hasText(category.getCategoryName())) {
            throw new CategoryException("分类名称不能为空");
        }
        if (category.getCategoryName().length() > 50) {
            throw new CategoryException("分类名称不能超过50个字符");
        }
    }

    // 检查分类名是否已存在
    private boolean isCategoryNameExists(String categoryName) {
        return categoryMapper.getCategoryByName(categoryName) != null;
    }
}
