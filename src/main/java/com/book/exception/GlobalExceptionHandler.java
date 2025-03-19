package com.book.exception;

import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import javax.servlet.http.HttpServletRequest;

@ControllerAdvice
public class GlobalExceptionHandler {

    @ExceptionHandler(CategoryException.class)
    public String handleCategoryException(CategoryException e, RedirectAttributes redirectAttributes) {
        redirectAttributes.addFlashAttribute("error", e.getMessage());
        return "redirect:/admin_category_manage.html";
    }

    @ExceptionHandler(Exception.class)
    public String handleException(Exception e, RedirectAttributes redirectAttributes, HttpServletRequest request) {
        redirectAttributes.addFlashAttribute("error", "系统发生错误：" + e.getMessage());
        
        // 根据请求URL返回适当的错误页面
        String requestURI = request.getRequestURI();
        if (requestURI.contains("admin_book")) {
            return "redirect:/admin_book_manage.html";
        } else if (requestURI.contains("admin_category")) {
            return "redirect:/admin_category_manage.html";
        } else {
            return "redirect:/error.html";
        }
    }
} 