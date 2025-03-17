package com.book.controller;

import com.book.domain.Book;
import com.book.service.BookService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
public class BookInventoryController {

    @Autowired
    private BookService bookService;

    @RequestMapping("/admin_book_inventory.html")
    public ModelAndView bookInventory(HttpServletRequest request) {
        String searchWord = request.getParameter("searchWord");
        List<Book> books = bookService.queryBook(searchWord);
        
        // 添加调试日志
        for (Book book : books) {
            System.out.println("Book: " + book.getName() + 
                             ", Total: " + book.getTotalCount() + 
                             ", Lent: " + book.getLentCount());
        }
        
        ModelAndView modelAndView = new ModelAndView("admin_book_inventory");
        modelAndView.addObject("books", books);
        modelAndView.addObject("searchWord", searchWord);
        return modelAndView;
    }

    @RequestMapping("/admin_book_stock_add.html")
    @ResponseBody
    public Object addStock(HttpServletRequest request) {
        Map<String, Object> result = new HashMap<>();
        try {
            long bookId = Long.parseLong(request.getParameter("bookId"));
            int count = Integer.parseInt(request.getParameter("count"));
            
            boolean success = bookService.addBookStock(bookId, count);
            result.put("success", success);
        } catch (Exception e) {
            result.put("success", false);
            result.put("message", e.getMessage());
        }
        return result;
    }

    @RequestMapping("/admin_book_stock_reduce.html")
    @ResponseBody
    public Object reduceStock(HttpServletRequest request) {
        Map<String, Object> result = new HashMap<>();
        try {
            long bookId = Long.parseLong(request.getParameter("bookId"));
            int count = Integer.parseInt(request.getParameter("count"));
            
            boolean success = bookService.reduceBookStock(bookId, count);
            result.put("success", success);
        } catch (Exception e) {
            result.put("success", false);
            result.put("message", e.getMessage());
        }
        return result;
    }
} 