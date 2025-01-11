package com.book.controller;

import com.book.domain.Book;
import com.book.domain.BorrowingRecord;
import com.book.domain.User;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpSession;
import java.util.List;

@Controller
@RequestMapping("/user/reader")
public class UserReaderController {


    @GetMapping("/")
    public String readerDashboard(HttpSession session, Model model) {
        // 获取当前登录用户
        User user = (User) session.getAttribute("loggedInUser");
        if (user == null || !"READER".equals(user.getRole())) {
            return "redirect:/user/login"; // 如果不是读者，重定向到登录页面
        }

        // 返回读者主页
        model.addAttribute("readerName", user.getUsername());
        return "reader/reader_dashboard"; // 对应 JSP 文件路径
    }

//    // 读者查看图书页面
//    @GetMapping("/books")
//    public String viewBooks(Model model) {
//        // 返回书籍列表
//        List<Book> books = bookService.getAllBooks();
//        model.addAttribute("books", books);
//        return "reader/view_books"; // 对应 JSP 文件路径
//    }
//
//    // 读者查看借阅记录页面
//    @GetMapping("/borrowing")
//    public String viewBorrowingRecords(HttpSession session, Model model) {
//        User user = (User) session.getAttribute("loggedInUser");
//        List<BorrowingRecord> records = borrowingService.getRecordsByUserId(user.getUserId());
//        model.addAttribute("records", records);
//        return "reader/borrowing_records"; // 对应 JSP 文件路径
//    }
}
