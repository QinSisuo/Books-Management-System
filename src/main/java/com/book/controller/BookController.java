package com.book.controller;

import com.book.domain.Book;
import com.book.service.BookService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.math.BigDecimal;
import java.sql.Date;
import java.util.ArrayList;

@Controller
public class BookController {

    private final BookService bookService;

    @Autowired
    public BookController(BookService bookService) {
        this.bookService = bookService;
    }

    //admin查
    @RequestMapping("/admin_book_all.html")
    public ModelAndView allBooks() {
        ArrayList<Book> books = bookService.getAllBooks();
        return buildModelAndView("admin_book_all").addObject("books", books);
    }

    //admin删
    @RequestMapping("/admin/book/delete.html")
    public String deleteBook(long bookId, RedirectAttributes redirectAttributes) {
        try {
            boolean result = bookService.deleteBook(bookId);
            redirectAttributes.addFlashAttribute("succ", result ? "图书删除成功！" : "图书删除失败！");
        } catch (NumberFormatException e) {
            redirectAttributes.addFlashAttribute("error", "非法的图书 ID！");
        }
        return "redirect:/admin_book_all.html";
    }

    //admin改
    @PostMapping("/admin/book/edit")
    public String editBook(@RequestParam("bookId") long bookId,
                           @RequestParam("bookTitle") String bookTitle,
                           @RequestParam("bookAuthor") String bookAuthor,
                           @RequestParam("bookPrice") double bookPrice,
                           @RequestParam("bookPublish") String bookPublish,
                           @RequestParam("bookIsbn") String bookIsbn,
                           @RequestParam("bookIntroduction") String bookIntroduction,
                           @RequestParam("bookLanguage") String bookLanguage,
                           @RequestParam("bookPubdate") String bookPubdate,
                           @RequestParam("bookClassId") int bookClassId,
                           @RequestParam("bookPressmark") String bookPressmark,
                           @RequestParam("bookState") int bookState,
                           RedirectAttributes redirectAttributes) {
        try {
            // 创建一个 Book 对象并设置所有字段
            Book book = new Book();
            book.setBookId(bookId);
            book.setName(bookTitle);
            book.setAuthor(bookAuthor);
            book.setPrice(BigDecimal.valueOf(bookPrice));  // 转换为 BigDecimal
            book.setPublish(bookPublish);
            book.setIsbn(bookIsbn);
            book.setIntroduction(bookIntroduction);
            book.setLanguage(bookLanguage);
            book.setPubdate(Date.valueOf(bookPubdate));  // 转换为 java.sql.Date 格式
            book.setClassId(bookClassId);  // 如果需要转换为 Long，请调整类型
            book.setPressmark(Integer.parseInt(bookPressmark));  // 如果 pressmark 是 String 类型，转换为 int
            book.setState(bookState);

            // 调用 service 层的 editBook 方法进行更新
            boolean result = bookService.editBook(book);

            // 设置操作结果的提示信息
            redirectAttributes.addFlashAttribute("succ", result ? "图书编辑成功！" : "图书编辑失败！");
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", "编辑图书时发生错误！");
        }
        // 编辑后重定向到图书列表页面
        return "redirect:/admin_book_all.html";
    }

    //admin add
    @RequestMapping("/admin_book_add.html")
    public ModelAndView addBook() {
        return new ModelAndView("admin_book_add");
    }

    @RequestMapping("/book_add_do.html")
    public String addBookDo(BookAddCommand bookAddCommand, RedirectAttributes redirectAttributes) {
        Book book = buildBookFromCommand(bookAddCommand, 0); // bookId = 0 for new books
        boolean success = bookService.addBook(book);
        redirectAttributes.addFlashAttribute("succ", success ? "图书添加成功！" : "图书添加失败！");
        return "redirect:/admin_book_all.html";
    }


    @RequestMapping("/book_edit_do.html")
    public String bookEditDo(long id, BookAddCommand bookAddCommand, RedirectAttributes redirectAttributes) {
        Book book = buildBookFromCommand(bookAddCommand, id);
        boolean success = bookService.editBook(book);
        redirectAttributes.addFlashAttribute(success ? "succ" : "error", success ? "图书修改成功！" : "图书修改失败！");
        return "redirect:/allbooks.html";
    }

    @RequestMapping("/bookdetail.html")
    public ModelAndView bookDetail(long bookId) {
        Book book = bookService.getBook(bookId);
        return buildModelAndView("admin_book_detail").addObject("detail", book);
    }

    @RequestMapping("/readerbookdetail.html")
    public ModelAndView readerBookDetail(long bookId) {
        Book book = bookService.getBook(bookId);
        return buildModelAndView("reader_book_detail").addObject("detail", book);
    }
    @RequestMapping("/querybook.html")
    public ModelAndView queryBook(String searchWord) {
        if (bookService.matchBook(searchWord)) {
            ArrayList<Book> books = bookService.queryBook(searchWord);
            return buildModelAndView("admin_books").addObject("books", books);
        }
        return buildModelAndView("admin_books").addObject("error", "没有匹配的图书");
    }

    @RequestMapping("/reader_querybook.html")
    public ModelAndView readerQueryBook() {
        return new ModelAndView("reader_book_query");
    }

    @RequestMapping("/reader_querybook_do.html")
    public String readerQueryBookDo(String searchWord, RedirectAttributes redirectAttributes) {
        if (bookService.matchBook(searchWord)) {
            redirectAttributes.addFlashAttribute("books", bookService.queryBook(searchWord));
        } else {
            redirectAttributes.addFlashAttribute("error", "没有匹配的图书！");
        }
        return "redirect:/reader_querybook.html";
    }
    // 辅助方法：构建ModelAndView对象
    private ModelAndView buildModelAndView(String viewName) {
        return new ModelAndView(viewName);
    }

    // 辅助方法：从BookAddCommand构建Book对象
    private Book buildBookFromCommand(BookAddCommand command, long bookId) {
        Book book = new Book();
        book.setBookId(bookId);
        book.setPrice(command.getPrice());
        book.setState(command.getState());
        book.setPublish(command.getPublish());
        book.setPubdate(command.getPubdate());
        book.setName(command.getName());
        book.setIsbn(command.getIsbn());
        book.setClassId(command.getClassId());
        book.setAuthor(command.getAuthor());
        book.setIntroduction(command.getIntroduction());
        book.setPressmark(command.getPressmark());
        book.setLanguage(command.getLanguage());
        return book;
    }
}