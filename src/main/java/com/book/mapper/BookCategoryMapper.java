package com.book.mapper;

import com.book.domain.BookCategory;
import org.apache.ibatis.annotations.*;

import java.util.List;

@Mapper
public interface BookCategoryMapper {

    // 获取全部分类
    @Select("SELECT * FROM book_category ORDER BY category_id ASC")// ORDER BY category_id ASC加上就是查询并排序
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
    @Select("SELECT COUNT(*) FROM books WHERE category_id = #{categoryId}")
    int getBookCountInCategory(int categoryId);

    // 根据关键词搜索分类
    @Select("SELECT * FROM book_category WHERE category_name LIKE CONCAT('%', #{searchWord}, '%') ORDER BY category_id ASC")
    List<BookCategory> searchCategories(String searchWord);
}
