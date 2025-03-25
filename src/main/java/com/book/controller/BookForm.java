package com.book.controller;

import lombok.Getter;
import lombok.Setter;
import org.springframework.format.annotation.DateTimeFormat;

import javax.validation.constraints.*;
import java.math.BigDecimal;
import java.util.Date;
import java.util.List;

/**
 * 图书表单数据处理类
 * 用于处理图书添加和编辑的表单数据
 */
@Getter
@Setter
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
    private int categoryId;

    @NotNull(message = "索书号不能为空")
    @Min(value = 1, message = "索书号必须大于0")
    private int pressmark;

    @Min(value = 0, message = "状态值不正确")
    @Max(value = 1, message = "状态值不正确")
    private int state;

    private List<Long> tagIds;

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
                ", categoryId=" + categoryId +
                ", pressmark=" + pressmark +
                ", state=" + state +
                '}';
    }
}
