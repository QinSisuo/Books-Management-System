package com.book.controller;

import com.book.domain.BorrowRecord;
import com.book.domain.User;
import com.book.service.BorrowService;
import com.book.service.BookService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.HttpSession;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Collections;
import java.util.Date;
import java.util.List;

@Controller
public class BorrowController {

    @Autowired
    private BorrowService borrowService;

    @Autowired
    private BookService bookService;

    @PostMapping("/reader_book_borrow.html")
    public String borrowBook(@RequestParam("bookId") Long bookId,
                           HttpSession session,
                           RedirectAttributes redirectAttributes) {
        // 1. 检查用户是否登录
        User currentUser = (User) session.getAttribute("user");
        if (currentUser == null) {
            redirectAttributes.addFlashAttribute("error", "请先登录！");
            return "redirect:/login.html";
        }

        // 2. 检查图书是否可借
        if (bookService.getBook(bookId) == null) {
            redirectAttributes.addFlashAttribute("error", "图书不存在！");
            return "redirect:/reader_book_catalog.html";
        }

        // 3. 执行借阅
        boolean success = borrowService.borrowBook(bookId, currentUser.getUserId());
        if (success) {
            redirectAttributes.addFlashAttribute("succ", "借阅成功！");
        } else {
            redirectAttributes.addFlashAttribute("error", "借阅失败，请检查图书是否可借！");
        }

        return "redirect:/reader_book_catalog.html";
    }

    /**
     * 我的借还页面：查询当前读者的所有借阅记录
     */
    @GetMapping("/reader_my_borrow.html")
    public ModelAndView myBorrowPage(HttpSession session) {
        User currentUser = (User) session.getAttribute("user");
        if (currentUser == null) {
            return new ModelAndView("redirect:/login.html");
        }

        List<BorrowRecord> records = borrowService.getMyBorrowRecords(currentUser.getUserId());
        return new ModelAndView("reader/reader_my_borrow")
                .addObject("records", records);
    }

    /**
     * 归还图书
     */
    @PostMapping("/borrow_return")
    public String returnBook(@RequestParam("borrowId") Long borrowId,
                           HttpSession session,
                           RedirectAttributes redirectAttributes) {
        User currentUser = (User) session.getAttribute("user");
        if (currentUser == null) {
            return "redirect:/login.html";
        }

        boolean success = borrowService.returnBook(borrowId);
        redirectAttributes.addFlashAttribute("message", success ? "归还成功！" : "归还失败或已归还过！");
        return "redirect:/reader_my_borrow.html";
    }

    /**
     * 续借(延期)
     */
    @PostMapping("/borrow_extend")
    public String extendBook(@RequestParam("borrowId") Long borrowId,
                           @RequestParam("extraDays") int extraDays,
                           HttpSession session,
                           RedirectAttributes redirectAttributes) {
        User currentUser = (User) session.getAttribute("user");
        if (currentUser == null) {
            return "redirect:/login.html";
        }

        boolean success = borrowService.extendBook(borrowId, extraDays);
        redirectAttributes.addFlashAttribute("message", success ? "续借成功！" : "续借失败！");
        return "redirect:/reader_my_borrow.html";
    }

    /**
     * 管理员查看所有借阅记录
     */
    @GetMapping("/admin_borrow_records.html")
    public ModelAndView adminBorrowRecords(HttpSession session) {
        User currentUser = (User) session.getAttribute("user");
        if (currentUser == null || !currentUser.isAdmin()) {
            return new ModelAndView("redirect:/login.html");
        }

        List<BorrowRecord> records = borrowService.getAllBorrowRecords();
        return new ModelAndView("admin/admin_borrow_records")
                .addObject("records", records);
    }

    /**
     * 管理员按条件查询借阅记录
     */
    @PostMapping("/admin_borrow_records_search")
    @ResponseBody
    public List<BorrowRecord> adminBorrowRecordsSearch(@RequestBody BorrowRecord record,
                                                     HttpSession session) {
        try {
            User currentUser = (User) session.getAttribute("user");
            if (currentUser == null || !currentUser.isAdmin()) {
                return Collections.emptyList();
            }

            // 只根据读者ID查询
            if (record.getReaderId() == null) {
                return Collections.emptyList();
            }

            return borrowService.getBorrowRecordsByCondition(record);
        } catch (Exception e) {
            e.printStackTrace();
            return Collections.emptyList();
        }
    }
}
