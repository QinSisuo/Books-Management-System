<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html>
<head>
    <title>图书详情</title>
    <link rel="stylesheet" href="/css/bootstrap.min.css">
    <link rel="stylesheet" href="/css/style.css">
</head>
<body>
    <div class="container">
        <div class="row">
            <div class="col-md-12">
                <h2>图书详情</h2>
                <div class="book-detail">
                    <div class="form-group">
                        <label>书名：</label>
                        <span>${book.name}</span>
                    </div>
                    <div class="form-group">
                        <label>作者：</label>
                        <span>${book.author}</span>
                    </div>
                    <div class="form-group">
                        <label>出版社：</label>
                        <span>${book.publish}</span>
                    </div>
                    <div class="form-group">
                        <label>ISBN：</label>
                        <span>${book.isbn}</span>
                    </div>
                    <div class="form-group">
                        <label>价格：</label>
                        <span>￥${book.price}</span>
                    </div>
                    <div class="form-group">
                        <label>出版日期：</label>
                        <span><fmt:formatDate value="${book.pubdate}" pattern="yyyy-MM-dd"/></span>
                    </div>
                    <div class="form-group">
                        <label>图书分类：</label>
                        <span>${categoryName}</span>
                    </div>
                    <div class="form-group">
                        <label>图书标签：</label>
                        <div class="tag-group">
                            <c:forEach items="${tags}" var="tag">
                                <span class="tag">${tag.name}</span>
                            </c:forEach>
                        </div>
                    </div>
                    <div class="form-group">
                        <label>图书简介：</label>
                        <span>${book.introduction}</span>
                    </div>
                    <div class="form-group">
                        <label>语言：</label>
                        <span>${book.language}</span>
                    </div>
                    <div class="form-group">
                        <label>书架号：</label>
                        <span>${book.pressmark}</span>
                    </div>
                    <div class="form-group">
                        <label>状态：</label>
                        <span>${book.state == 1 ? '在馆' : '借出'}</span>
                    </div>
                </div>
                <div class="mt-3">
                    <a href="/admin_book_manage.html" class="btn btn-primary">返回列表</a>
                </div>
            </div>
        </div>
    </div>

<style>
.book-detail {
    padding: 20px;
    background-color: #f8f9fa;
    border-radius: 5px;
    margin-bottom: 20px;
}

.form-group {
    margin-bottom: 15px;
}

.form-group label {
    font-weight: bold;
    margin-right: 10px;
}

.tag-group {
    display: flex;
    flex-wrap: wrap;
    gap: 8px;
    margin-top: 5px;
}

.tag {
    background-color: #e9ecef;
    color: #495057;
    padding: 4px 8px;
    border-radius: 4px;
    font-size: 14px;
    display: inline-block;
}
</style>

<script src="/js/jquery-3.2.1.js"></script>
<script src="/js/bootstrap.min.js"></script>
</body>
</html> 