package com.book.controller;

import com.book.domain.BorrowRecord;
import com.book.domain.User;
import com.book.service.BorrowService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.HttpSession;
import java.util.List;

@Controller
public class BorrowController {

    @Autowired
    private BorrowService borrowService;

    @GetMapping("/reader/book/borrow")
    public String borrowBook(@RequestParam("bookId") long bookId,
                             HttpSession session,
                             RedirectAttributes redirectAttributes) {
        // 1. 从session拿当前登录读者ID（如 userId/readerId），必须先在登录成功后存到session
        User currentUser = (User) session.getAttribute("user"); // 假设session里存的是"user"
        if (currentUser == null) {
            // 未登录
            redirectAttributes.addFlashAttribute("error", "请先登录！");
            return "redirect:/login.html";
        }
        long readerId = currentUser.getUserId(); // 或 getReaderId()

        // 2. 调用Service里的借阅业务逻辑
        boolean success = borrowService.borrowBook(bookId, readerId);
        // borrowBook里应插入 borrow_record 并把 book_info.state 改为0或1(视你项目定义)

        // 3. 给页面一个提示
        if (success) {
            redirectAttributes.addFlashAttribute("succ", "借阅成功！");
        } else {
            redirectAttributes.addFlashAttribute("error", "借阅失败或该书已被借出！");
        }

        // 4. 借阅完后，重定向回全部图书页面或“我的借还”都行
        return "redirect:/reader_querybook.html";
    }


    /**
     * 我的借还页面：查询当前读者的所有借阅记录（从 Session 里获取 readerId）
     */
    @GetMapping("/reader_my_borrow.html")
    public ModelAndView myBorrowPage(HttpSession session) {
        // 原来你可能写了:
        // Long readerId = (Long) session.getAttribute("readerId");
        // 现在我们改成取User对象:
        User currentUser = (User) session.getAttribute("user");
        if (currentUser == null) {
            // Session 中没有 user, 表示没登录
            return new ModelAndView("login_needed");
            // 或 "redirect:/login.html"
        }

        // 取出 userId
        int userId = currentUser.getUserId();

        // 用这个 userId 去查询借阅记录
        List<BorrowRecord> records = borrowService.getMyBorrowRecords((long) userId);

        // 返回页面并携带数据
        return new ModelAndView("reader_my_borrow")
                .addObject("records", records);
    }


    /**
     * 归还图书
     */
    @PostMapping("/borrow_return")
    public String returnBook(@RequestParam("borrowId") Long borrowId,
                             HttpSession session,
                             RedirectAttributes redirectAttributes) {
        // 同样从session拿当前用户ID，如果需要的话
        Long readerId = (Long) session.getAttribute("readerId");
        if (readerId == null) {
            return "redirect:/login.html"; // 或者别的登录页面
        }

        boolean success = borrowService.returnBook(borrowId);
        redirectAttributes.addFlashAttribute("message", success ? "归还成功！" : "归还失败或已归还过！");
        // 重定向回我的借还列表，不带任何参数
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
        Long readerId = (Long) session.getAttribute("readerId");
        if (readerId == null) {
            return "redirect:/login.html";
        }

        boolean success = borrowService.extendBook(borrowId, extraDays);
        redirectAttributes.addFlashAttribute("message", success ? "续借成功！" : "续借失败！");
        return "redirect:/reader_my_borrow.html";
    }
}
