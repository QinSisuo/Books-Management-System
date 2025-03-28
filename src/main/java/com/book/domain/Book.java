package com.book.domain;

import lombok.Getter;
import lombok.Setter;

import java.io.Serializable;
import java.math.BigDecimal;
import java.util.Date;
@Setter
@Getter
public class Book implements Serializable{

    private Long bookId;
    private String name;
    private String author;
    private String publish;
    private String isbn;
    private String introduction;
    private String language;
    private BigDecimal price;
    private Date pubdate;
    private Integer categoryId;
    private Integer pressmark;
    private Integer state;
    private Integer totalCount = 0;
    private Integer lentCount = 0;
    
    // 添加用于显示借阅次数和评分的字段
    private Integer borrowCount = 0;
    private Double avgRating = 0.0;

    public Book() {

    }
}
