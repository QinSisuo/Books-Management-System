package com.book.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class ReaderController {

    /**
     * 跳转到排行榜页面
     */
    @RequestMapping("/rank")
    public ModelAndView toRankPage() {
        return new ModelAndView("reader/reader_rank");
    }
} 