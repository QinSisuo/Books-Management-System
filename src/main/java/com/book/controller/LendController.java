//package com.book.controller;
//
//import com.book.domain.Lend;
//import com.book.domain.ReaderCard;
//import com.book.service.BookService;
//import com.book.service.LendService;
//import org.springframework.beans.factory.annotation.Autowired;
//import org.springframework.stereotype.Controller;
//import org.springframework.web.bind.annotation.GetMapping;
//import org.springframework.web.bind.annotation.RequestMapping;
//import org.springframework.web.bind.annotation.RequestParam;
//import org.springframework.web.bind.annotation.ResponseBody;
//import org.springframework.web.servlet.ModelAndView;
//import org.springframework.web.servlet.mvc.support.RedirectAttributes;
//
//import javax.servlet.http.HttpServletRequest;
//import java.sql.Date;
//import java.util.List;
//
//@Controller
//@RequestMapping("/reader")
//public class LendController {
//
//    private final LendService lendService;
//    private final BookService bookService;
//
//    @Autowired
//    public LendController(LendService lendService, BookService bookService) {
//        this.lendService = lendService;
//        this.bookService = bookService;
//    }
//
//    @RequestMapping("/lendbook.html")
//    public ModelAndView bookLend(@RequestParam("bookId") long bookId) {
//        ModelAndView modelAndView = new ModelAndView("admin_book_lend");
//        modelAndView.addObject("book", bookService.getBook(bookId));
//        return modelAndView;
//    }
//
//    @RequestMapping("/lendbookdo.html")
//    public String bookLendDo(@RequestParam("id") long bookId, @RequestParam("readerId") int readerId, RedirectAttributes redirectAttributes) {
//        boolean lendsucc = lendService.bookLend(bookId, readerId);
//        redirectAttributes.addFlashAttribute("succ", "图书借阅成功！");
//        return "redirect:/allbooks.html";
//    }
//
//    @RequestMapping("/returnbook.html")
//    public String bookReturn(@RequestParam("bookId") long bookId, RedirectAttributes redirectAttributes) {
//        boolean retSucc = lendService.bookReturn(bookId);
//        redirectAttributes.addFlashAttribute(retSucc ? "succ" : "error", retSucc ? "图书归还成功！" : "图书归还失败！");
//        return "redirect:/allbooks.html";
//    }
//
//    @RequestMapping("/lendlist.html")
//    public ModelAndView lendList() {
//        ModelAndView modelAndView = new ModelAndView("admin_lend_list");
//        modelAndView.addObject("list", lendService.lendList());
//        return modelAndView;
//    }
//
//    @RequestMapping("/mylend.html")
//    public ModelAndView myLendList(HttpServletRequest request) {
//        ReaderCard readerCard = (ReaderCard) request.getSession().getAttribute("readercard");
//        ModelAndView modelAndView = new ModelAndView("reader_lend_list");
//        modelAndView.addObject("list", (readerCard != null) ? lendService.myLendList(readerCard.getReaderId()) : List.of());
//        return modelAndView;
//    }
//
//    @GetMapping("/borrow_return")
//    @ResponseBody
//    public List<Lend> getMyLendRecords(HttpServletRequest request) {
//        ReaderCard readerCard = (ReaderCard) request.getSession().getAttribute("readercard");
//        return (readerCard != null) ? lendService.myLendList(readerCard.getReaderId()) : List.of();
//    }
//}
