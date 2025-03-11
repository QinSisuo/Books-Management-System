<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>编辑《 ${detail.name}》</title>
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
        .input-group {
            margin-bottom: 15px;
        }
    </style>
</head>
<body>
<div class="col-xs-6 col-md-offset-3" style="position: relative;top: 10%">
    <div class="panel panel-primary">
        <div class="panel-heading">
            <h3 class="panel-title">编辑《 ${detail.name}》</h3>
        </div>
        <div class="panel-body">
            <form action="admin/book/edit" method="post" id="editbook" class="needs-validation" novalidate>
                <!-- 添加隐藏的bookId字段 -->
                <input type="hidden" name="bookId" value="${detail.bookId}">

                <div class="input-group">
                    <span class="input-group-addon">书名</span>
                    <input type="text" class="form-control" name="name" id="name" value="${detail.name}" required>
                    <div class="error-message"></div>
                </div>
                <div class="input-group">
                    <span class="input-group-addon">作者</span>
                    <input type="text" class="form-control" name="author" id="author" value="${detail.author}" required>
                    <div class="error-message"></div>
                </div>
                <div class="input-group">
                    <span class="input-group-addon">出版社</span>
                    <input type="text" class="form-control" name="publish" id="publish" value="${detail.publish}" required>
                    <div class="error-message"></div>
                </div>
                <div class="input-group">
                    <span class="input-group-addon">ISBN</span>
                    <input type="text" class="form-control" name="isbn" id="isbn" value="${detail.isbn}" required
                           pattern="^(?=(?:\\D*\\d){10}(?:(?:\\D*\\d){3})?$)[\\d-]+$">
                    <div class="error-message"></div>
                </div>
                <div class="input-group">
                    <span class="input-group-addon">简介</span>
                    <input type="text" class="form-control" name="introduction" id="introduction" value="${detail.introduction}">
                </div>
                <div class="input-group">
                    <span class="input-group-addon">语言</span>
                    <input type="text" class="form-control" name="language" id="language" value="${detail.language}">
                </div>
                <div class="input-group">
                    <span class="input-group-addon">价格</span>
                    <input type="number" step="0.01" class="form-control" name="price" id="price" value="${detail.price}" required min="0">
                    <div class="error-message"></div>
                </div>
                <div class="input-group">
                    <span class="input-group-addon">出版日期</span>
                    <input type="text" class="form-control datepicker" name="pubdate" id="pubdate" value="${detail.pubdate}" required>
                    <div class="error-message"></div>
                </div>
                <div class="input-group">
                    <span class="input-group-addon">分类号</span>
                    <input type="number" class="form-control" name="classId" id="classId" value="${detail.classId}" required min="1">
                    <div class="error-message"></div>
                </div>
                <div class="input-group">
                    <span class="input-group-addon">书架号</span>
                    <input type="number" class="form-control" name="pressmark" id="pressmark" value="${detail.pressmark}" required min="1">
                    <div class="error-message"></div>
                </div>
                <div class="input-group">
                    <span class="input-group-addon">状态</span>
                    <select class="form-control" name="state" id="state" required>
                        <option value="1" ${detail.state == 1 ? 'selected' : ''}>在馆</option>
                        <option value="0" ${detail.state == 0 ? 'selected' : ''}>借出</option>
                    </select>
                </div>
                <input type="submit" value="确定" class="btn btn-success btn-sm">
            </form>
        </div>
    </div>
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
    $("#editbook").submit(function(event) {
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
