package com.book.service;

import com.book.domain.Book;
import org.junit.Test;  // 使用 JUnit 4
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.test.context.web.WebAppConfiguration;

import java.util.List;

import static org.junit.Assert.assertFalse;  // 使用 JUnit 4 的断言
import static org.junit.Assert.assertNotNull;

@RunWith(SpringJUnit4ClassRunner.class)
@WebAppConfiguration
@ContextConfiguration(locations = {
        "classpath:spring/spring-context.xml"    // 加载 Spring 核心配置文件
})
public class BookServiceTest {

    private static final Logger logger = LoggerFactory.getLogger(BookServiceTest.class);  // 手动创建 Logger 对象

    @Autowired
    private BookService bookService;

    @Test
    public void testGetAllBooks() {
        logger.debug("测试开始：获取所有书籍");
        List<Book> books = bookService.getAllBooks();

        // 断言书籍列表不为空
        assertNotNull("书籍列表不应为 null", books);
        assertFalse("书籍列表不应为空", books.isEmpty());

        logger.debug("测试结束：获取所有书籍");
    }
}