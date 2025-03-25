package com.book.controller;

import com.book.domain.BookReservation;
import com.book.domain.User;
import com.book.service.BookReservationService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.HttpSession;
import java.util.List;

@Controller
public class BookReservationController {

    @Autowired
    private BookReservationService reservationService;

    @PostMapping("/reader_book_reserve.html")
    public String reserveBook(@RequestParam("bookId") Long bookId,
                            HttpSession session,
                            RedirectAttributes redirectAttributes) {
        User currentUser = (User) session.getAttribute("user");
        if (currentUser == null) {
            redirectAttributes.addFlashAttribute("error", "请先登录！");
            return "redirect:/login.html";
        }

        boolean success = reservationService.createReservation(bookId, currentUser.getUserId());
        if (success) {
            redirectAttributes.addFlashAttribute("succ", "预约成功！");
        } else {
            redirectAttributes.addFlashAttribute("error", "预约失败，该图书已有预约！");
        }

        return "redirect:/reader_book_catalog.html";
    }

    @GetMapping("/reader_my_reservations.html")
    public ModelAndView myReservations(HttpSession session) {
        User currentUser = (User) session.getAttribute("user");
        if (currentUser == null) {
            return new ModelAndView("redirect:/login.html");
        }

        List<BookReservation> reservations = 
            reservationService.getMyReservations(currentUser.getUserId());
        return new ModelAndView("reader/reader_my_reservations")
                .addObject("reservations", reservations);
    }
} 