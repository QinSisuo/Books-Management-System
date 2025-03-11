<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<html>
<head>
    <title>图书信息添加</title>
    <link rel="stylesheet" href="css/bootstrap.min.css">
    <script src="js/jquery-3.2.1.js"></script>
    <script src="js/bootstrap.min.js"></script>
    <!-- 添加日期选择器样式 -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.9.0/css/bootstrap-datepicker.min.css">
    <script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.9.0/js/bootstrap-datepicker.min.js"></script>
    <style>
        body{
            background-color: rgb(240,242,245);
        }
        .error-message {
            color: red;
            font-size: 12px;
            margin-top: 5px;
        }
        .form-group {
            margin-bottom: 20px;
        }
    </style>
</head>
<body>
    <%@ include file="common/header.jsp" %>
    <%@ include file="common/navbar.jsp" %>

<div style="position: relative;top: 10%;width: 80%;margin-left: 10%">
    <form action="book_add_do.html" method="post" id="addbook" class="needs-validation" novalidate>
        <div class="form-group">
            <label for="name">图书名</label>
            <input type="text" class="form-control" name="name" id="name" required>
            <div class="error-message"></div>
        </div>
        <div class="form-group">
            <label for="author">作者</label>
            <input type="text" class="form-control" name="author" id="author" required>
            <div class="error-message"></div>
        </div>
        <div class="form-group">
            <label for="publish">出版社</label>
            <input type="text" class="form-control" name="publish" id="publish" required>
            <div class="error-message"></div>
        </div>
        <div class="form-group">
            <label for="isbn">ISBN</label>
            <input type="text" class="form-control" name="isbn" id="isbn" required 
                   pattern="^(?=(?:\\D*\\d){10}(?:(?:\\D*\\d){3})?$)[\\d-]+$">
            <div class="error-message"></div>
        </div>
        <div class="form-group">
            <label for="introduction">简介</label>
            <textarea class="form-control" rows="3" name="introduction" id="introduction"></textarea>
        </div>
        <div class="form-group">
            <label for="language">语言</label>
            <input type="text" class="form-control" name="language" id="language">
        </div>
        <div class="form-group">
            <label for="price">价格</label>
            <input type="number" step="0.01" class="form-control" name="price" id="price" required min="0">
            <div class="error-message"></div>
        </div>
        <div class="form-group">
            <label for="pubdate">出版日期</label>
            <input type="text" class="form-control datepicker" name="pubdate" id="pubdate" required>
            <div class="error-message"></div>
        </div>
        <div class="form-group">
            <label for="classId">分类号</label>
            <input type="number" class="form-control" name="classId" id="classId" required min="1">
            <div class="error-message"></div>
        </div>
        <div class="form-group">
            <label for="pressmark">书架号</label>
            <input type="number" class="form-control" name="pressmark" id="pressmark" required min="1">
            <div class="error-message"></div>
        </div>
        <div class="form-group">
            <label for="state">状态</label>
            <select class="form-control" name="state" id="state" required>
                <option value="1">在馆</option>
                <option value="0">借出</option>
            </select>
        </div>

        <input type="submit" value="添加" class="btn btn-success btn-sm">
    </form>
</div>

<script>
$(document).ready(function() {
    // 初始化日期选择器
    $('.datepicker').datepicker({
        format: 'yyyy-mm-dd',
        autoclose: true,
        language: 'zh-CN'
    });

    // 表单验证
    $("#addbook").submit(function(event) {
        var form = $(this);
        if (!form[0].checkValidity()) {
            event.preventDefault();
            event.stopPropagation();
            
            // 显示具体错误信息
            form.find(':input[required]').each(function() {
                if (!this.validity.valid) {
                    $(this).next('.error-message').text(this.validationMessage || '此字段不能为空');
                } else {
                    $(this).next('.error-message').text('');
                }
            });
        }
        form.addClass('was-validated');
    });

    // ISBN格式验证
    $('#isbn').on('input', function() {
        var isbn = $(this).val();
        var isbnPattern = /^(?=(?:\D*\d){10}(?:(?:\D*\d){3})?$)[\d-]+$/;
        if (!isbnPattern.test(isbn)) {
            $(this).next('.error-message').text('ISBN格式不正确');
        } else {
            $(this).next('.error-message').text('');
        }
    });
});
</script>
</body>
</html>
