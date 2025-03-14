package com.book.controller;

import com.book.domain.Book;
import com.book.service.BookService;
import com.book.service.BookCategoryService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.List;
import java.util.Map;
import java.util.HashMap;

@Controller
//@RequestMapping("/admin/book")
public class BookController {

    private final BookService bookService;
    private final BookCategoryService categoryService;

    @Autowired
    public BookController(BookService bookService, BookCategoryService categoryService) {
        this.bookService = bookService;
        this.categoryService = categoryService;
    }


    /**
     * ========== 管理员相关 ==========
     * 以下是示例方法，你可以根据需要自行增删。
     */

    // 1. 显示所有图书（管理员）
//    @GetMapping("/all")
//    public ModelAndView allBooks() {
//        List<Book> books = bookService.getAllBooks();
//        return new ModelAndView("admin_book_manage", "books", books);
//    }
    @RequestMapping("/admin_book_manage.html")
    public ModelAndView allBooks() {
        ModelAndView mav = new ModelAndView("admin_book_manage");
        try {
            mav.addObject("books", bookService.getAllBooks());
            mav.addObject("categories", categoryService.getAllCategories()); // 添加分类列表
        } catch (Exception e) {
            e.printStackTrace();
            mav.addObject("error", "获取数据失败：" + e.getMessage());
        }
        return mav;
    }

    // 2. 删除图书
    @RequestMapping("/admin/book/delete.html")
    public String deleteBook(@RequestParam long bookId, RedirectAttributes redirectAttributes) {
        boolean result = bookService.deleteBook(bookId);
        redirectAttributes.addFlashAttribute("succ", result ? "图书删除成功！" : "图书删除失败！");
        return "redirect:/admin_book_manage.html";
    }

    // 3. 修改图书
    @PostMapping("/admin/book/edit")
    public String editBook(Book book, RedirectAttributes redirectAttributes) {
        boolean result = bookService.editBook(book);
        redirectAttributes.addFlashAttribute("succ", result ? "图书编辑成功！" : "图书编辑失败！");
        return "redirect:/admin_book_manage.html";
    }

    // 4. 添加图书页面
    @RequestMapping("/admin_book_add.html")
    public ModelAndView addBookPage() {
        return new ModelAndView("admin_book_add");
    }

    // 5. 处理添加图书
    @PostMapping("/book_add_do.html")
    @ResponseBody
    public Map<String, Object> addBook(@ModelAttribute Book book) {
        Map<String, Object> response = new HashMap<>();
        try {
            System.out.println("开始处理新增图书请求");
            System.out.println("接收到的图书数据: " + book.toString());
            
            // 参数验证
            if (book.getName() == null || book.getName().trim().isEmpty()) {
                System.out.println("验证失败：图书名称为空");
                response.put("status", "error");
                response.put("message", "图书名称不能为空");
                return response;
            }
            if (book.getAuthor() == null || book.getAuthor().trim().isEmpty()) {
                System.out.println("验证失败：作者为空");
                response.put("status", "error");
                response.put("message", "作者不能为空");
                return response;
            }
            if (book.getIsbn() == null || !book.getIsbn().matches("^(?=(?:\\D*\\d){10}(?:(?:\\D*\\d){3})?$)[\\d-]+$")) {
                System.out.println("验证失败：ISBN格式不正确");
                response.put("status", "error");
                response.put("message", "ISBN格式不正确");
                return response;
            }
            
            // 检查分类是否存在
            if (book.getClassId() <= 0) {
                System.out.println("验证失败：未选择分类");
                response.put("status", "error");
                response.put("message", "请选择图书分类");
                return response;
            }
            
            if (categoryService.getCategoryById(book.getClassId()) == null) {
                System.out.println("验证失败：分类不存在，分类ID=" + book.getClassId());
                response.put("status", "error");
                response.put("message", "所选分类不存在");
                return response;
            }

            System.out.println("开始保存图书数据");
            boolean success = bookService.addBook(book);
            System.out.println("保存图书结果: " + success);

            if (success) {
                response.put("status", "success");
                response.put("message", "图书添加成功");
            } else {
                response.put("status", "error");
                response.put("message", "图书添加失败");
            }
        } catch (Exception e) {
            System.out.println("添加图书时发生异常: " + e.getMessage());
            e.printStackTrace();
            response.put("status", "error");
            response.put("message", "添加图书时发生错误：" + e.getMessage());
        }
        return response;
    }

    // 6. 管理员查询图书（返回 ModelAndView）
    @RequestMapping(value = "/admin_book_manage.html", method = RequestMethod.GET)
    public ModelAndView adminQueryBook(@RequestParam(required = false) String searchWord) {
        ModelAndView mav = new ModelAndView("admin_book_manage");
        List<Book> books = bookService.queryBook(searchWord);
        if (!books.isEmpty()) {
            mav.addObject("books", books);
        } else {
            mav.addObject("error", "没有匹配的图书");
        }
        mav.addObject("searchWord", searchWord); // 让搜索框回填搜索词
        mav.addObject("categories", categoryService.getAllCategories()); // 添加分类列表
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
