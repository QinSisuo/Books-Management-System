package com.book.mapper;

import com.book.domain.BookCategory;
import org.apache.ibatis.annotations.*;

import java.util.List;

@Mapper
public interface BookCategoryMapper {

    // 获取全部分类
    @Select("SELECT * FROM book_category")
    List<BookCategory> getAllCategories();

    // 插入分类
    @Insert("INSERT INTO book_category(category_name) VALUES(#{categoryName})")
    @Options(useGeneratedKeys = true, keyProperty = "categoryId")
    int insertCategory(BookCategory category);

    // 更新分类
    @Update("UPDATE book_category SET category_name = #{categoryName} WHERE category_id = #{categoryId}")
    int updateCategory(BookCategory category);

    // 删除分类
    @Delete("DELETE FROM book_category WHERE category_id = #{categoryId}")
    int deleteCategory(int categoryId);

    // 根据ID查询分类
    @Select("SELECT * FROM book_category WHERE category_id = #{categoryId}")
    BookCategory getCategoryById(int categoryId);

    // 根据分类名称查询
    @Select("SELECT * FROM book_category WHERE category_name = #{categoryName}")
    BookCategory getCategoryByName(String categoryName);

    // 获取分类下的图书数量
    @Select("SELECT COUNT(*) FROM book_info WHERE class_id = #{categoryId}")
    int getBookCountInCategory(int categoryId);
}
