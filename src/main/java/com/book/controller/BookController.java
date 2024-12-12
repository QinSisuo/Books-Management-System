package com.book.controller;

import com.book.domain.Book;
import com.book.service.BookService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.ArrayList;

@Controller
public class BookController {

    private final BookService bookService;

    @Autowired
    public BookController(BookService bookService) {
        this.bookService = bookService;
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

    @RequestMapping("/allbooks.html")
    public ModelAndView allBooks() {
        ArrayList<Book> books = bookService.getAllBooks();
        return buildModelAndView("admin_books").addObject("books", books);
    }

    @RequestMapping("/deletebook.html")
    public String deleteBook(long bookId, RedirectAttributes redirectAttributes) {
        try {
            boolean result = bookService.deleteBook(bookId);
            redirectAttributes.addFlashAttribute("succ", result ? "图书删除成功！" : "图书删除失败！");
        } catch (NumberFormatException e) {
            redirectAttributes.addFlashAttribute("error", "非法的图书 ID！");
        }
        return "redirect:/allbooks.html";
    }

    @RequestMapping("/book_add.html")
    public ModelAndView addBook() {
        return new ModelAndView("admin_book_add");
    }

    @RequestMapping("/book_add_do.html")
    public String addBookDo(BookAddCommand bookAddCommand, RedirectAttributes redirectAttributes) {
        Book book = buildBookFromCommand(bookAddCommand, 0); // bookId = 0 for new books
        boolean success = bookService.addBook(book);
        redirectAttributes.addFlashAttribute("succ", success ? "图书添加成功！" : "图书添加失败！");
        return "redirect:/allbooks.html";
    }

    @RequestMapping("/updatebook.html")
    public ModelAndView bookEdit(long bookId) {
        Book book = bookService.getBook(bookId);
        return buildModelAndView("admin_book_edit").addObject("detail", book);
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