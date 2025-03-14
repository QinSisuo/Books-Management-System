package com.book.controller;

import com.book.domain.BookCategory;
import com.book.service.BookCategoryService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.List;

@Controller
//@RequestMapping("/admin/category")
public class BookCategoryController {

    @Autowired
    private BookCategoryService categoryService;

    // 显示分类列表
    @GetMapping("/admin_category_list.html")
    public ModelAndView categoryList() {
        List<BookCategory> categories = categoryService.getAllCategories();
        return new ModelAndView("admin_category_list").addObject("categories", categories);
    }

    // 新增分类页面
    @GetMapping("/add")
    public String addCategoryPage() {
        return "admin_category_add";
    }

    // 添加分类
    @PostMapping("/add")
    public String addCategory(BookCategory category, RedirectAttributes redirectAttributes) {
        boolean result = categoryService.addCategory(category);
        redirectAttributes.addFlashAttribute("succ", result ? "分类添加成功！" : "分类添加失败！");
        return "redirect:/admin/category/list";
    }

    // 编辑分类页面
    @GetMapping("/edit")
    public ModelAndView editCategoryPage(@RequestParam int categoryId) {
        BookCategory category = categoryService.getCategoryById(categoryId);
        return new ModelAndView("admin_category_edit").addObject("category", category);
    }

    // 执行编辑
    @PostMapping("/edit")
    public String editCategory(BookCategory category, RedirectAttributes redirectAttributes) {
        boolean result = categoryService.editCategory(category);
        redirectAttributes.addFlashAttribute("succ", result ? "分类编辑成功！" : "分类编辑失败！");
        return "redirect:/admin/category/list";
    }

    // 删除分类
    @GetMapping("/delete")
    public String deleteCategory(@RequestParam int categoryId, RedirectAttributes redirectAttributes) {
        boolean result = categoryService.deleteCategory(categoryId);
        redirectAttributes.addFlashAttribute("succ", result ? "分类删除成功！" : "分类删除失败！");
        return "redirect:/admin/category/list";
    }

}
