package com.book.controller;

import org.springframework.format.annotation.DateTimeFormat;

import javax.validation.constraints.*;
import java.math.BigDecimal;
import java.util.Date;

/**
 * 图书表单数据处理类
 * 用于处理图书添加和编辑的表单数据
 */
public class BookForm {

    private Long bookId;

    @NotBlank(message = "书名不能为空")
    private String name;

    @NotBlank(message = "作者不能为空")
    private String author;

    @NotBlank(message = "出版社不能为空")
    private String publish;

    @NotBlank(message = "ISBN不能为空")
    @Pattern(regexp = "^[0-9-]{10,17}$", message = "ISBN格式不正确")
    private String isbn;

    private String introduction;

    private String language;

    @NotNull(message = "价格不能为空")
    @DecimalMin(value = "0.0", message = "价格必须大于等于0")
    private BigDecimal price;

    @NotNull(message = "出版日期不能为空")
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private Date pubdate;

    @NotNull(message = "分类ID不能为空")
    @Min(value = 1, message = "分类ID必须大于0")
    private int classId;

    @NotNull(message = "索书号不能为空")
    @Min(value = 1, message = "索书号必须大于0")
    private int pressmark;

    @Min(value = 0, message = "状态值不正确")
    @Max(value = 1, message = "状态值不正确")
    private int state;

    public Long getBookId() {
        return bookId;
    }

    public void setBookId(Long bookId) {
        this.bookId = bookId;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name != null ? name.trim() : null;
    }

    public String getAuthor() {
        return author;
    }

    public void setAuthor(String author) {
        this.author = author != null ? author.trim() : null;
    }

    public String getPublish() {
        return publish;
    }

    public void setPublish(String publish) {
        this.publish = publish != null ? publish.trim() : null;
    }

    public String getIsbn() {
        return isbn;
    }

    public void setIsbn(String isbn) {
        this.isbn = isbn != null ? isbn.trim() : null;
    }

    public String getIntroduction() {
        return introduction;
    }

    public void setIntroduction(String introduction) {
        this.introduction = introduction != null ? introduction.trim() : null;
    }

    public String getLanguage() {
        return language;
    }

    public void setLanguage(String language) {
        this.language = language != null ? language.trim() : null;
    }

    public BigDecimal getPrice() {
        return price;
    }

    public void setPrice(BigDecimal price) {
        this.price = price;
    }

    public Date getPubdate() {
        return pubdate;
    }

    public void setPubdate(Date pubdate) {
        this.pubdate = pubdate;
    }

    public int getClassId() {
        return classId;
    }

    public void setClassId(int classId) {
        this.classId = classId;
    }

    public int getPressmark() {
        return pressmark;
    }

    public void setPressmark(int pressmark) {
        this.pressmark = pressmark;
    }

    public int getState() {
        return state;
    }

    public void setState(int state) {
        this.state = state;
    }

    @Override
    public String toString() {
        return "BookForm{" +
                "bookId=" + bookId +
                ", name='" + name + '\'' +
                ", author='" + author + '\'' +
                ", publish='" + publish + '\'' +
                ", isbn='" + isbn + '\'' +
                ", price=" + price +
                ", pubdate=" + pubdate +
                ", classId=" + classId +
                ", state=" + state +
                '}';
    }
}
