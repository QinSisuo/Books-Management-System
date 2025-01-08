package com.book.service;

import com.book.domain.Book;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import static org.junit.Assert.assertNotNull;
import static org.junit.Assert.assertTrue;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {
        "classpath:spring/spring-context.xml" // 只加载核心配置文件
})
public class LendServiceTest {

    @Autowired
    private LendService lendService;

    @Autowired
    private BookService bookService;

    @Test
    public void testGetBook() {
        long bookId = 1;
        Book book = bookService.getBook(bookId);
        assertNotNull("Book should not be null", book);
        System.out.println(book);
    }

    @Test
    public void testLendBook() {
        long bookId = 1;
        int readerId = 1001;
        boolean result = lendService.bookLend(bookId, readerId);
        System.out.println("Lend book result: " + result);
        assertTrue("Book lending should be successful", result);
    }
}