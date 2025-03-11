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
    public String editBook(BookForm bookForm, RedirectAttributes redirectAttributes) {
        try {
            Book book = buildBookFromForm(bookForm, bookForm.getBookId());
            boolean result = bookService.editBook(book);
            redirectAttributes.addFlashAttribute("succ", result ? "图书编辑成功！" : "图书编辑失败！");
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", "编辑图书时发生错误！");
        }
        return "redirect:/admin_book_all.html";
    }

    //admin add page
    @RequestMapping("/admin_book_add.html")
    public ModelAndView addBook() {
        return new ModelAndView("admin_book_add");
    }

    //admin add do
    @RequestMapping("/book_add_do.html")
    public String addBookDo(BookForm bookForm, RedirectAttributes redirectAttributes) {
        try {
            Book book = buildBookFromForm(bookForm, 0); // bookId = 0 for new books
            boolean success = bookService.addBook(book);
            redirectAttributes.addFlashAttribute("succ", success ? "图书添加成功！" : "图书添加失败！");
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", "添加图书时发生错误！");
        }
        return "redirect:/admin_book_all.html";
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

    // 辅助方法：从BookForm构建Book对象
    private Book buildBookFromForm(BookForm form, long bookId) {
        Book book = new Book();
        book.setBookId(bookId);
        book.setName(form.getName());
        book.setAuthor(form.getAuthor());
        book.setPrice(form.getPrice());
        book.setPublish(form.getPublish());
        book.setIsbn(form.getIsbn());
        book.setIntroduction(form.getIntroduction());
        book.setLanguage(form.getLanguage());
        book.setPubdate(form.getPubdate());
        book.setClassId(form.getClassId());
        book.setPressmark(form.getPressmark());
        book.setState(form.getState());
        return book;
    }
}