package com.book.test;

import org.junit.jupiter.api.Test;

import static org.junit.jupiter.api.Assertions.assertEquals;

class BasicTest {
    @Test
    void basicTest() {
        int expected = 42;
        int actual = 40 + 2;
        assertEquals(expected, actual, "Basic math test failed");
    }
}