package com.book.exception;

import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@ControllerAdvice
public class GlobalExceptionHandler {

    @ExceptionHandler(CategoryException.class)
    public String handleCategoryException(CategoryException e, RedirectAttributes redirectAttributes) {
        redirectAttributes.addFlashAttribute("error", e.getMessage());
        return "redirect:/admin_category_list.html";
    }

    @ExceptionHandler(Exception.class)
    public String handleException(Exception e, RedirectAttributes redirectAttributes) {
        redirectAttributes.addFlashAttribute("error", "系统发生错误：" + e.getMessage());
        return "redirect:/admin_category_list.html";
    }
} 