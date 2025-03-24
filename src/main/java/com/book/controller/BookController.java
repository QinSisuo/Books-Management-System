package com.book.controller;

import com.book.domain.Book;
import com.book.service.BookService;
import com.book.service.BookCategoryService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.text.SimpleDateFormat;
import java.util.*;
import javax.servlet.http.HttpServletRequest;

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
    @GetMapping("/admin_book_manage.html")
    public ModelAndView allBooks(@RequestParam(required = false) String searchWord) {
        ModelAndView mav = new ModelAndView("admin_book_manage");
        try {
            List<Book> books;
            if (searchWord != null && !searchWord.trim().isEmpty()) {
                books = bookService.queryBook(searchWord);
                if (books.isEmpty()) {
                    mav.addObject("error", "没有匹配的图书");
                }
            } else {
                books = bookService.getAllBooks();
            }
            mav.addObject("books", books);
            mav.addObject("searchWord", searchWord);
            mav.addObject("categories", categoryService.getAllCategories());
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

    @InitBinder
    public void initBinder(WebDataBinder binder) {
        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
        dateFormat.setLenient(false);
        binder.registerCustomEditor(Date.class, new CustomDateEditor(dateFormat, true));
    }


    // 5. 处理添加图书
    @PostMapping("/book_add_do.html")
    public String addBook(@ModelAttribute Book book, HttpServletRequest request, Model model) {

        try {
            System.out.println("========== 开始处理新增图书请求 ==========");
            System.out.println("请求方法: " + request.getMethod());
            System.out.println("请求URL: " + request.getRequestURL());
            System.out.println("Content-Type: " + request.getContentType());
            
            // 打印所有请求参数
            System.out.println("请求参数:");
            request.getParameterMap().forEach((key, value) -> 
                System.out.println(key + " = " + Arrays.toString(value)));
            
            System.out.println("\n接收到的图书数据:");
            System.out.println("图书名称: " + book.getName());
            System.out.println("作者: " + book.getAuthor());
            System.out.println("出版社: " + book.getPublish());
            System.out.println("ISBN: " + book.getIsbn());
            System.out.println("价格: " + book.getPrice());
            System.out.println("出版日期: " + book.getPubdate());
            System.out.println("分类ID: " + book.getClassId());
            System.out.println("索书号: " + book.getPressmark());
            System.out.println("状态: " + book.getState());
            
            // 参数验证
            if (book.getName() == null || book.getName().trim().isEmpty()) {
                System.out.println("验证失败：图书名称为空");
                model.addAttribute("error", "图书名称不能为空");
                return "redirect:/admin_book_manage.html";
            }
            if (book.getAuthor() == null || book.getAuthor().trim().isEmpty()) {
                System.out.println("验证失败：作者为空");
                model.addAttribute("error", "作者不能为空");
                return "redirect:/admin_book_manage.html";
            }
            if (book.getIsbn() == null ) {
                System.out.println("验证失败：ISBN格式不正确");
                model.addAttribute("error", "ISBN格式不正确");
                return "redirect:/admin_book_manage.html";
            }
            
            // 检查分类是否存在
            if (book.getClassId() <= 0) {
                System.out.println("验证失败：未选择分类");
                model.addAttribute("error", "请选择图书分类");
                return "redirect:/admin_book_manage.html";
            }
            
            if (categoryService.getCategoryById(book.getClassId()) == null) {
                System.out.println("验证失败：分类不存在，分类ID=" + book.getClassId());
                model.addAttribute("error", "所选分类不存在");
                return "redirect:/admin_book_manage.html";
            }

            System.out.println("\n开始保存图书数据");
            boolean success = bookService.addBook(book);
            System.out.println("保存图书结果: " + success);

            if (success) {
                System.out.println("图书添加成功，准备重定向");
                model.addAttribute("succ", "图书添加成功");
                return "redirect:/admin_book_manage.html";
            } else {
                System.out.println("图书添加失败，准备返回错误信息");
                model.addAttribute("error", "图书添加失败");
                return "redirect:/admin_book_manage.html";
            }
        } catch (Exception e) {
            System.out.println("添加图书时发生异常: " + e.getMessage());
            e.printStackTrace();
            model.addAttribute("error", "添加图书时发生错误：" + e.getMessage());
            return "redirect:/admin_book_manage.html";
        }
    }

    // 7. 管理员查看书籍详情
    @RequestMapping("/bookdetail.html")
    public ModelAndView adminBookDetail(@RequestParam long bookId) {
        return new ModelAndView("admin_book_detail").addObject("detail", bookService.getBook(bookId));
    }

    /**
     * ========== 读者相关 ==========
     * 当访问 /reader_book_catalog.html 时：
     *  - 如果没有 searchWord 参数，则显示所有图书。
     *  - 如果有 searchWord，则按关键词搜索并返回结果。
     */
    @GetMapping("/reader_book_catalog.html")
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
    @RequestMapping("/reader_book_catalog.html")
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

    // 获取图书列表HTML片段
    @GetMapping("/admin_book_list.html")
    @ResponseBody
    public String getBookListHtml() {
        try {
            List<Book> books = bookService.getAllBooks();
            StringBuilder html = new StringBuilder();
            
            for (Book book : books) {
                html.append("<tr>");
                html.append("<td>").append(book.getBookId()).append("</td>");
                html.append("<td>").append(book.getName()).append("</td>");
                html.append("<td>").append(book.getAuthor()).append("</td>");
                html.append("<td>").append(book.getPublish()).append("</td>");
                html.append("<td>").append(book.getIsbn()).append("</td>");
                html.append("<td>").append(book.getPrice()).append("</td>");
                html.append("<td>").append(book.getPubdate()).append("</td>");
                html.append("<td>").append(book.getClassId()).append("</td>");
                html.append("<td>").append(book.getPressmark()).append("</td>");
                html.append("<td>").append(book.getState() == 0 ? "可借" : "已借出").append("</td>");
                html.append("<td>");
                html.append("<a href='/bookdetail.html?bookId=").append(book.getBookId()).append("' class='btn btn-info btn-sm'>详情</a> ");
                html.append("<a href='/admin_book_edit.html?bookId=").append(book.getBookId()).append("' class='btn btn-warning btn-sm'>编辑</a> ");
                html.append("<a href='/admin_book_delete.html?bookId=").append(book.getBookId()).append("' class='btn btn-danger btn-sm' onclick='return confirm(\"确定要删除这本书吗？\")'>删除</a>");
                html.append("</td>");
                html.append("</tr>");
            }
            
            return html.toString();
        } catch (Exception e) {
            e.printStackTrace();
            return "<tr><td colspan='11' class='text-center text-danger'>获取图书列表失败：" + e.getMessage() + "</td></tr>";
        }
    }

}
