package com.book.controller;

import com.book.domain.BookTag;
import com.book.service.BookTagService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import java.util.Date;
import java.util.List;

@Controller
public class BookTagController {

    @Autowired
    private BookTagService bookTagService;

    @RequestMapping("/admin_tag_manage.html")
    public ModelAndView bookTags(HttpServletRequest request) {
        String searchWord = request.getParameter("searchWord");
        List<BookTag> tags = bookTagService.queryBookTags(searchWord);
        ModelAndView modelAndView = new ModelAndView("admin/admin_tag_manage");
        modelAndView.addObject("tags", tags);
        return modelAndView;
    }

    @RequestMapping("/admin_tag_add.html")
    @ResponseBody
    public Object addTag(HttpServletRequest request) {
        String name = request.getParameter("name");
        String status = request.getParameter("status");
        
        BookTag bookTag = new BookTag();
        bookTag.setName(name);
        bookTag.setStatus(status);
        bookTag.setCreateTime(new Date());
        bookTag.setCreateBy("admin"); // 这里应该从session获取当前用户

        boolean success = bookTagService.addBookTag(bookTag);
        
        return success ? "{\"success\":true}" : "{\"success\":false}";
    }

    @RequestMapping("/admin_tag_edit.html")
    public ModelAndView editTag(HttpServletRequest request) {
        long tagId = Long.parseLong(request.getParameter("id"));
        String name = request.getParameter("name");
        String status = request.getParameter("status");
        
        BookTag bookTag = new BookTag();
        bookTag.setId(tagId);
        bookTag.setName(name);
        bookTag.setStatus(status);
        bookTag.setUpdateTime(new Date());
        bookTag.setUpdateBy("admin"); // 这里应该从session获取当前用户

        boolean success = bookTagService.updateBookTag(bookTag);
        ModelAndView modelAndView = new ModelAndView("redirect:/admin_tag_manage.html");
        return modelAndView;
    }

    @RequestMapping("/admin_tag_delete.html")
    public ModelAndView deleteTag(HttpServletRequest request) {
        long tagId = Long.parseLong(request.getParameter("id"));
        boolean success = bookTagService.deleteBookTag(tagId);
        ModelAndView modelAndView = new ModelAndView("redirect:/admin_tag_manage.html");
        return modelAndView;
    }
} 