package com.book.controller;

import com.book.domain.Book;
import com.book.service.BookService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.List;

@Controller
//@RequestMapping("/admin/book")
public class BookController {

    private final BookService bookService;

    @Autowired
    public BookController(BookService bookService) {
        this.bookService = bookService;
    }


    /**
     * ========== 管理员相关 ==========
     * 以下是示例方法，你可以根据需要自行增删。
     */

    // 1. 显示所有图书（管理员）
//    @GetMapping("/all")
//    public ModelAndView allBooks() {
//        List<Book> books = bookService.getAllBooks();
//        return new ModelAndView("admin_book_list", "books", books);
//    }
    @RequestMapping("/admin_book_list.html")
    public ModelAndView allBooks() {
        return new ModelAndView("admin_book_list").addObject("books", bookService.getAllBooks());
    }

    // 2. 删除图书
    @RequestMapping("/admin/book/delete.html")
    public String deleteBook(@RequestParam long bookId, RedirectAttributes redirectAttributes) {
        boolean result = bookService.deleteBook(bookId);
        redirectAttributes.addFlashAttribute("succ", result ? "图书删除成功！" : "图书删除失败！");
        return "redirect:/admin_book_list.html";
    }

    // 3. 修改图书
    @PostMapping("/admin/book/edit")
    public String editBook(Book book, RedirectAttributes redirectAttributes) {
        boolean result = bookService.editBook(book);
        redirectAttributes.addFlashAttribute("succ", result ? "图书编辑成功！" : "图书编辑失败！");
        return "redirect:/admin_book_list.html";
    }

    // 4. 添加图书页面
    @RequestMapping("/admin_book_add.html")
    public ModelAndView addBookPage() {
        return new ModelAndView("admin_book_add");
    }

    // 5. 处理添加图书
    @PostMapping("/book_add_do.html")
    public String addBook(@ModelAttribute Book book, RedirectAttributes redirectAttributes) {
        boolean success = bookService.addBook(book);
        redirectAttributes.addFlashAttribute("succ", success ? "图书添加成功！" : "图书添加失败！");
        return "redirect:/admin_book_list.html";
    }

    // 6. 管理员查询图书（返回 ModelAndView）
    @RequestMapping(value = "/admin_book_list.html", method = RequestMethod.GET)
    public ModelAndView adminQueryBook(@RequestParam(required = false) String searchWord) {
        ModelAndView mav = new ModelAndView("admin_book_list");
        List<Book> books = bookService.queryBook(searchWord);
        if (!books.isEmpty()) {
            mav.addObject("books", books);
        } else {
            mav.addObject("error", "没有匹配的图书");
        }
        mav.addObject("searchWord", searchWord); // 让搜索框回填搜索词
        return mav;
    }


    // 7. 管理员查看书籍详情
    @RequestMapping("/bookdetail.html")
    public ModelAndView adminBookDetail(@RequestParam long bookId) {
        return new ModelAndView("admin_book_detail").addObject("detail", bookService.getBook(bookId));
    }

    /**
     * ========== 读者相关 ==========
     * 当访问 /reader_querybook.html 时：
     *  - 如果没有 searchWord 参数，则显示所有图书。
     *  - 如果有 searchWord，则按关键词搜索并返回结果。
     */
    @GetMapping("/reader_querybook.html")
    public ModelAndView readerQueryBookPage(
            @RequestParam(value = "searchWord", required = false) String searchWord) {
        List<Book> books;
        if (searchWord == null || searchWord.trim().isEmpty()) {
            books = bookService.getAllBooks();
        } else {
            books = bookService.queryBook(searchWord);
        }
        return new ModelAndView("reader_book_list")
                .addObject("books", books)
                .addObject("searchWord", searchWord);
    }

    /**
     * 读者查看书籍详情
     */
    @RequestMapping("/reader_querybook.html")
    public ModelAndView readerBookDetail(@RequestParam long bookId) {
        return new ModelAndView("reader_book_detail").addObject("detail", bookService.getBook(bookId));
    }

    // 读者查看所有图书
    @GetMapping("/reader_book_list.html")
    public ModelAndView readerQueryBook(
            @RequestParam(value = "searchWord", required = false) String searchWord) {
        List<Book> books;
        // 如果没有搜索词，或搜索词为空，则查询所有
        if (searchWord == null || searchWord.trim().isEmpty()) {
            books = bookService.getAllBooks();
        } else {
            // 否则带关键字查询
            books = bookService.queryBook(searchWord);
        }

        // 跳转到 reader_book_list.jsp，并传递 books 和当前搜索词
        return new ModelAndView("reader_book_list")
                .addObject("books", books)
                .addObject("searchWord", searchWord);
    }

    // 读者借阅图书
    @PostMapping("/reader_book_borrow")
    public String borrowBook(@RequestParam("bookId") long bookId,
                             RedirectAttributes redirectAttributes) {
        // 这里假定 Book 的 state=0 表示可借，1 表示已借
        boolean success = bookService.borrowBook(bookId);
        if (success) {
            redirectAttributes.addFlashAttribute("succ", "图书借阅成功！");
        } else {
            redirectAttributes.addFlashAttribute("error", "图书借阅失败或已被借出！");
        }
        // 借完后重定向回读者图书列表
        return "redirect:/reader_book_all.html";
    }

}
