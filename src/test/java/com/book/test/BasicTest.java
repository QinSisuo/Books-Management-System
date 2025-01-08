package com.book.test;

import org.junit.Test;
import static org.junit.Assert.assertEquals;

public class BasicTest {
    @Test
    public void basicTest() {
        int expected = 42;
        int actual = 40 + 2;
        assertEquals("Basic math test failed", expected, actual);
    }
}