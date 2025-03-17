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
import java.util.Map;
import java.util.HashMap;

@Controller
public class BookTagController {

    @Autowired
    private BookTagService bookTagService;

    @RequestMapping("/admin_tag_manage.html")
    public ModelAndView bookTags(HttpServletRequest request) {
        String searchWord = request.getParameter("searchWord");
        List<BookTag> tags;
        
        if (searchWord != null && !searchWord.trim().isEmpty()) {
            tags = bookTagService.queryBookTags(searchWord);
        } else {
            tags = bookTagService.queryBookTags(null);
        }
        
        System.out.println("查询到的标签数量: " + (tags != null ? tags.size() : 0));
        
        ModelAndView modelAndView = new ModelAndView("admin_tag_manage");
        modelAndView.addObject("tags", tags);
        return modelAndView;
    }

    @RequestMapping("/admin_tag_add.html")
    @ResponseBody
    public Object addTag(HttpServletRequest request) {
        try {
            String name = request.getParameter("name");
            String status = request.getParameter("status");
            
            BookTag bookTag = new BookTag();
            bookTag.setName(name);
            bookTag.setStatus(status);
            bookTag.setCreateTime(new Date());
            bookTag.setCreateBy("admin");

            boolean success = bookTagService.addBookTag(bookTag);
            return success ? "{\"success\":true}" : "{\"success\":false}";
        } catch (Exception e) {
            // 捕获重复标签异常
            if (e.getMessage().contains("Duplicate entry")) {
                return "{\"success\":false, \"message\":\"标签名称已存在\"}";
            }
            return "{\"success\":false, \"message\":\"添加失败\"}";
        }
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

    @RequestMapping("/hot_tags.html")
    public ModelAndView hotTags() {
        // 获取热门标签，按hot_score降序排序，限制前10个
        List<BookTag> hotTags = bookTagService.getHotTags(10);
        ModelAndView modelAndView = new ModelAndView("hot_tags");
        modelAndView.addObject("hotTags", hotTags);
        return modelAndView;
    }
} 