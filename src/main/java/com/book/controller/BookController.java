package com.book.controller;

import com.book.domain.Book;
import com.book.domain.BookTag;
import com.book.service.BookService;
import com.book.service.BookCategoryService;
import com.book.service.BookTagService;
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
    private final BookTagService bookTagService;

    @Autowired
    public BookController(BookService bookService, BookCategoryService categoryService, BookTagService bookTagService) {
        this.bookService = bookService;
        this.categoryService = categoryService;
        this.bookTagService = bookTagService;
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
            mav.addObject("tags", bookTagService.queryBookTags(null)); // 添加标签数据
        } catch (Exception e) {
            e.printStackTrace();
            mav.addObject("error", "获取数据失败：" + e.getMessage());
        }
        return mav;
    }

    // 2. 删除图书
    @RequestMapping("/admin/book/delete.html")
    public String deleteBook(@RequestParam Long bookId, RedirectAttributes redirectAttributes) {
        boolean result = bookService.deleteBook(bookId);
        redirectAttributes.addFlashAttribute("succ", result ? "图书删除成功！" : "图书删除失败！");
        return "redirect:/admin_book_manage.html";
    }

    // 3. 修改图书
    @PostMapping("/admin/book/edit")
    public String editBook(Book book, @RequestParam(required = false) List<Long> tagIds, RedirectAttributes redirectAttributes) {
        try {
            boolean result = bookService.editBook(book);
            if (result) {
                // 更新标签
                bookService.updateBookTags(book.getBookId(), tagIds);
                redirectAttributes.addFlashAttribute("succ", "图书编辑成功！");
            } else {
                redirectAttributes.addFlashAttribute("error", "图书编辑失败！");
            }
            return "redirect:/admin_book_manage.html";
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", "编辑过程中发生错误：" + e.getMessage());
            return "redirect:/admin_book_manage.html";
        }
    }

    // 4. 添加图书页面
    @RequestMapping("/admin_book_add.html")
    public ModelAndView addBookPage() {
        ModelAndView mav = new ModelAndView("admin_book_add");
        mav.addObject("categories", categoryService.getAllCategories());
        mav.addObject("tags", bookTagService.queryBookTags(null)); // 获取所有标签
        return mav;
    }

    @InitBinder
    public void initBinder(WebDataBinder binder) {
        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
        dateFormat.setLenient(false);
        binder.registerCustomEditor(Date.class, new CustomDateEditor(dateFormat, true));
    }


    // 5. 处理添加图书
    @PostMapping("/admin_book_add.html")
    public String addBook(@ModelAttribute Book book, @RequestParam(required = false) List<Long> tagIds, HttpServletRequest request, Model model) {
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
            System.out.println("分类ID: " + book.getCategoryId());
            System.out.println("索书号: " + book.getPressmark());
            System.out.println("状态: " + book.getState());
            System.out.println("标签IDs: " + tagIds);
            
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
                System.out.println("验证失败：ISBN为空");
                model.addAttribute("error", "ISBN不能为空");
                return "redirect:/admin_book_manage.html";
            }
            
            // 添加图书
            boolean result = bookService.addBook(book);
            if (result) {
                // 如果有标签，添加标签关联
                if (tagIds != null && !tagIds.isEmpty()) {
                    bookService.addBookTags(book.getBookId(), tagIds);
                }
                model.addAttribute("succ", "图书添加成功！");
            } else {
                model.addAttribute("error", "图书添加失败！");
            }
            return "redirect:/admin_book_manage.html";
        } catch (Exception e) {
            e.printStackTrace();
            model.addAttribute("error", "添加过程中发生错误：" + e.getMessage());
            return "redirect:/admin_book_manage.html";
        }
    }

    // 6. 图书详情页面（管理员）
    @RequestMapping("/admin/book/detail")
    public String adminBookDetail(@RequestParam("id") Long id, Model model) {
        try {
            Book book = bookService.getBook(id);
            if (book == null) {
                model.addAttribute("error", "图书不存在");
                return "redirect:/admin_book_manage.html";
            }
            model.addAttribute("book", book);
            model.addAttribute("categories", categoryService.getAllCategories());
            model.addAttribute("tags", bookTagService.queryBookTags(null));
            return "admin_book_detail";
        } catch (Exception e) {
            e.printStackTrace();
            model.addAttribute("error", "获取图书详情失败：" + e.getMessage());
            return "redirect:/admin_book_manage.html";
        }
    }

    // 7. 读者图书目录页面
    @GetMapping("/reader_book_catalog.html")
    public ModelAndView readerQueryBookPage(
            @RequestParam(value = "searchWord", required = false) String searchWord) {
        ModelAndView mav = new ModelAndView("reader_book_catalog");
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
        } catch (Exception e) {
            e.printStackTrace();
            mav.addObject("error", "获取数据失败：" + e.getMessage());
        }
        return mav;
    }

    // 8. 图书详情页面（读者）
    @RequestMapping("/reader/book/detail")
    public String readerBookDetail(@RequestParam("id") Long id, Model model) {
        try {
            Book book = bookService.getBook(id);
            if (book == null) {
                model.addAttribute("error", "图书不存在");
                return "redirect:/reader_book_catalog.html";
            }
            model.addAttribute("book", book);
            return "reader_book_detail";
        } catch (Exception e) {
            e.printStackTrace();
            model.addAttribute("error", "获取图书详情失败：" + e.getMessage());
            return "redirect:/reader_book_catalog.html";
        }
    }

    // 9. 借阅图书
    @PostMapping("/reader_book_borrow")
    public String borrowBook(@RequestParam("bookId") Long bookId,
                             RedirectAttributes redirectAttributes) {
        try {
            boolean result = bookService.borrowBook(bookId);
            redirectAttributes.addFlashAttribute("succ", result ? "借阅成功！" : "借阅失败！");
            return "redirect:/reader_book_catalog.html";
        } catch (Exception e) {
            e.printStackTrace();
            redirectAttributes.addFlashAttribute("error", "借阅过程中发生错误：" + e.getMessage());
            return "redirect:/reader_book_catalog.html";
        }
    }

    // 10. 获取图书列表HTML
    @GetMapping("/admin_book_list.html")
    @ResponseBody
    public String getBookListHtml() {
        try {
            List<Book> books = bookService.getAllBooks();
            StringBuilder html = new StringBuilder();
            html.append("<table class='table table-striped'>");
            html.append("<thead><tr>");
            html.append("<th>ID</th>");
            html.append("<th>书名</th>");
            html.append("<th>作者</th>");
            html.append("<th>出版社</th>");
            html.append("<th>ISBN</th>");
            html.append("<th>价格</th>");
            html.append("<th>状态</th>");
            html.append("<th>操作</th>");
            html.append("</tr></thead><tbody>");
            
            for (Book book : books) {
                html.append("<tr>");
                html.append("<td>").append(book.getBookId()).append("</td>");
                html.append("<td>").append(book.getName()).append("</td>");
                html.append("<td>").append(book.getAuthor()).append("</td>");
                html.append("<td>").append(book.getPublish()).append("</td>");
                html.append("<td>").append(book.getIsbn()).append("</td>");
                html.append("<td>").append(book.getPrice()).append("</td>");
                html.append("<td>").append(book.getState() == 0 ? "可借" : "已借出").append("</td>");
                html.append("<td>");
                html.append("<button class='btn btn-sm btn-primary' onclick='editBook(").append(book.getBookId()).append(")'>编辑</button> ");
                html.append("<button class='btn btn-sm btn-danger' onclick='deleteBook(").append(book.getBookId()).append(")'>删除</button>");
                html.append("</td>");
                html.append("</tr>");
            }
            
            html.append("</tbody></table>");
            return html.toString();
        } catch (Exception e) {
            e.printStackTrace();
            return "<div class='alert alert-danger'>获取图书列表失败：" + e.getMessage() + "</div>";
        }
    }

    // 11. 获取图书标签
    @GetMapping("/admin/book/tags/{bookId}")
    @ResponseBody
    public List<Long> getBookTags(@PathVariable Long bookId) {
        return bookService.getBookTagIds(bookId);
    }

    // 12. 获取图书详情
    @GetMapping("/admin/book/{bookId}")
    @ResponseBody
    public Book getBook(@PathVariable Long bookId) {
        return bookService.getBook(bookId);
    }
}
