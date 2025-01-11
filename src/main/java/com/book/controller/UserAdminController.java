package com.book.controller;

import com.book.domain.Book;
import com.book.domain.User;
import com.book.service.BookService;
import com.book.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import org.springframework.web.bind.annotation.RequestMapping;

import java.util.ArrayList;
import java.util.List;

@Controller
@RequestMapping("/admin")
public class UserAdminController {

    @Autowired
    private BookService bookService;

    @Autowired
    private UserService userService;

    // ========================= 图书管理功能 =========================

    // 查询所有图书
    @RequestMapping("/books")
    public ModelAndView allBooks() {
        List<Book> books = bookService.getAllBooks();
        ModelAndView modelAndView = new ModelAndView("admin/book_list");
        modelAndView.addObject("books", books);
        return modelAndView;
    }

    // 按关键词查询图书（管理员）
    @RequestMapping("/books/search")
    public ModelAndView queryBook(@RequestParam("searchWord") String searchWord) {
        List<Book> books;
        if (bookService.matchBook(searchWord)) {
            books = bookService.queryBook(searchWord);
        } else {
            books = new ArrayList<>();
        }
        ModelAndView modelAndView = new ModelAndView("admin/book_list");
        modelAndView.addObject("books", books);
        return modelAndView;
    }

    // 添加图书页面
    @RequestMapping("/books/add")
    public ModelAndView addBookPage() {
        return new ModelAndView("admin/book_add");
    }

    // 添加图书（通过 Book 对象）
    @PostMapping("/books/add")
    public String addBook(Book book, RedirectAttributes redirectAttributes) {
        boolean success = bookService.addBook(book);
        redirectAttributes.addFlashAttribute("message", success ? "图书添加成功！" : "图书添加失败，请重试！");
        return "redirect:/admin/books";
    }

    // 删除图书
    @GetMapping("/books/delete")
    public String deleteBook(@RequestParam("bookId") long bookId, RedirectAttributes redirectAttributes) {
        boolean success = bookService.deleteBook(bookId);
        redirectAttributes.addFlashAttribute("message", success ? "图书删除成功！" : "图书删除失败！");
        return "redirect:/admin/books";
    }

    // 编辑图书页面
    @GetMapping("/books/edit")
    public ModelAndView editBook(@RequestParam("bookId") long bookId) {
        Book book = bookService.getBook(bookId);
        ModelAndView modelAndView = new ModelAndView("admin/book_edit");
        modelAndView.addObject("book", book);
        return modelAndView;
    }

    // 更新图书信息（通过 Book 对象）
    @PostMapping("/books/update")
    public String updateBook(Book book, RedirectAttributes redirectAttributes) {
        boolean success = bookService.updateBook(book);
        redirectAttributes.addFlashAttribute("message", success ? "图书更新成功！" : "图书更新失败！");
        return "redirect:/admin/books";
    }

    // 图书详情（管理员）
    @RequestMapping("/books/detail")
    public ModelAndView bookDetail(@RequestParam("bookId") long bookId) {
        Book book = bookService.getBook(bookId);
        return new ModelAndView("admin/book_detail").addObject("detail", book);
    }

    // ========================= 用户管理功能（示例） =========================

    // 查询所有用户
    @RequestMapping("/users")
    public ModelAndView allUsers() {
        List<User> users = userService.getAllUsers();
        ModelAndView modelAndView = new ModelAndView("admin/user_list");
        modelAndView.addObject("users", users);
        return modelAndView;
    }

    // 删除用户
    @GetMapping("/users/delete")
    public String deleteUser(@RequestParam("userId") long userId, RedirectAttributes redirectAttributes) {
        boolean success = userService.deleteUser(userId);
        redirectAttributes.addFlashAttribute("message", success ? "用户删除成功！" : "用户删除失败！");
        return "redirect:/admin/users";
    }


}