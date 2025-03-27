<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <title>图书信息管理</title>
    <!-- 引入外部 CSS -->
    <link rel="stylesheet" href="css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@11.0.19/dist/sweetalert2.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
    <link href="https://cdn.jsdelivr.net/npm/select2@4.1.0-rc.0/dist/css/select2.min.css" rel="stylesheet" />
    <link href="https://cdn.jsdelivr.net/npm/select2-bootstrap-theme@0.1.0-beta.10/dist/select2-bootstrap.min.css" rel="stylesheet" />
    <script src="js/jquery-3.2.1.js"></script>
    <script src="js/bootstrap.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11.0.19/dist/sweetalert2.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/select2@4.1.0-rc.0/dist/js/select2.min.js"></script>
    <style>
        .select2-container {
            width: 100% !important;
        }
        .select2-container--default .select2-selection--multiple {
            border: 1px solid #ced4da;
            border-radius: 4px;
            min-height: 38px;
        }
        .select2-container--default.select2-container--focus .select2-selection--multiple {
            border-color: #80bdff;
        }
        .select2-container--default .select2-selection--multiple .select2-selection__choice {
            background-color: #007bff;
            border: none;
            color: white;
            padding: 2px 8px;
            margin: 3px;
        }
        .select2-container--default .select2-selection--multiple .select2-selection__choice__remove {
            color: white;
            margin-right: 5px;
        }
        .select2-container--default .select2-selection--multiple .select2-selection__choice__remove:hover {
            color: #fff;
            background-color: #0056b3;
        }
    </style>
</head>

<body>
    <!-- 引入公共头部: 包含CSS/JS等 -->
    <%@ include file="../common/header.jsp" %>
    <%@ include file="../common/admin_navbar.jsp" %>
    <%@ include file="../common/footer.jsp" %>

    <!-- 统一面板 -->
    <div class="container">

        <!-- 统一搜索框 -->
        <div class="container" style="margin-top: 20px; margin-bottom: 20px; max-width: 600px; margin-left: -15px;">
            <form action="/admin_book_manage.html" method="get" class="form-inline">
                <div class="form-group">
                    <input type="text" class="form-control" name="searchWord"
                           placeholder="输入搜索关键词" value="${searchWord}" style="width: 300px;" />
                </div>
                &nbsp;
                <button type="submit" class="btn btn-primary">搜索</button>
            </form>
        </div>

        <!-- 标题和新增按钮 -->
        <div class="panel panel-default">
            <div class="panel-heading bg-white">
                <div class="row align-items-center">
                    <div class="col-md-6">
                        <h3 class="panel-title mb-0">图书管理</h3>
                    </div>
                    <div class="col-md-6 text-right">
                        <button class="btn btn-primary" data-toggle="modal" data-target="#addBookModal">
                            <i class="fas fa-plus"></i> 新增图书
                        </button>
                    </div>
                </div>
            </div>
        </div>


        <!-- Loading 指示器 -->
        <div class="loading">
            <div class="spinner-border text-primary" role="status">
                <span class="sr-only">加载中...</span>
            </div>
        </div>

        <div id="messageContainer" style="position: fixed; top: 10%; right: 5%; z-index: 1000;">
            <c:if test="${!empty succ}">
                <div class="alert alert-success alert-dismissable fade show">
                    <button type="button" class="close" data-dismiss="alert">&times;</button>
                        ${succ}
                </div>
            </c:if>
            <c:if test="${!empty error}">
                <div class="alert alert-danger alert-dismissable fade show">
                    <button type="button" class="close" data-dismiss="alert">&times;</button>
                        ${error}
                </div>
            </c:if>
        </div>


        <!-- 图书列表面板 -->
        <div class="panel-body">
            <div class="table-responsive">
                <table class="table table-hover" id="bookTable">
                    <thead>
                    <tr>
                        <th style="width: 20%">书名</th>
                        <th style="width: 15%">作者</th>
                        <th style="width: 15%">出版社</th>
                        <th style="width: 15%">ISBN</th>
                        <th style="width: 10%">语言</th>
                        <th style="width: 10%">价格</th>
                        <th style="width: 15%">操作</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach items="${books}" var="book">
                    <tr>
                        <td title="${book.name}"><c:out value="${book.name}"></c:out></td>
                        <td title="${book.author}"><c:out value="${book.author}"></c:out></td>
                        <td title="${book.publish}"><c:out value="${book.publish}"></c:out></td>
                        <td title="${book.isbn}"><c:out value="${book.isbn}"></c:out></td>
                        <td title="${book.language}"><c:out value="${book.language}"></c:out></td>
                        <td title="${book.price}">￥<c:out value="${book.price}"></c:out></td>
                        <td>
                            <a href="/admin/book/detail?id=<c:out value="${book.bookId}"></c:out>" class="btn btn-success btn-xs">详情</a>
                            <button type="button" class="btn btn-info btn-xs"
                                    onclick="openEditModal('${book.bookId}', '${book.name}', '${book.author}', '${book.price}', '${book.publish}', '${book.isbn}', '${book.introduction}', '${book.language}', '${book.pubdate}', '${book.categoryId}', '${book.pressmark}', '${book.state}')">
                                编辑
                            </button>
                            <a href="/admin/book/delete.html?bookId=<c:out value="${book.bookId}"></c:out>"
                               onclick="return confirm('确定删除图书《<c:out value="${book.name}"></c:out>》吗？')"
                               class="btn btn-danger btn-xs">删除</a>
                        </td>
                    </tr>
                    </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>

        <!-- 新增图书的模态框 -->
        <!-- ========== 新增图书模态框 START ========== -->
        <div class="modal fade" id="addBookModal" tabindex="-1" role="dialog" aria-labelledby="addBookModalLabel" aria-hidden="true">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <form id="addBookForm" method="post" action="/admin_book_add.html">
                        <div class="modal-header">
                            <h5 class="modal-title" id="addBookModalLabel">新增图书</h5>
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div>
                        <div class="modal-body">

                            <div class="form-group">
                                <label for="add_name">书名 <span class="text-danger">*</span></label>
                                <input type="text" class="form-control" name="name" id="add_name" required>
                                <div class="error-message"></div>
                            </div>

                            <div class="form-group">
                                <label for="add_author">作者 <span class="text-danger">*</span></label>
                                <input type="text" class="form-control" name="author" id="add_author" required>
                                <div class="error-message"></div>
                            </div>

                            <div class="form-group">
                                <label for="add_publish">出版社 <span class="text-danger">*</span></label>
                                <input type="text" class="form-control" name="publish" id="add_publish" required>
                                <div class="error-message"></div>
                            </div>

                            <div class="form-group">
                                <label for="add_isbn">ISBN <span class="text-danger">*</span></label>
                                <input type="text" class="form-control" name="isbn" id="add_isbn" required
                                       pattern="^(?=(?:\\D*\\d){10}(?:(?:\\D*\\d){3})?$)[\\d-]+$">
                                <small class="form-text text-muted">ISBN格式：10位或13位数字，可包含连字符</small>
                                <div class="error-message"></div>
                            </div>

                            <div class="form-group">
                                <label for="add_introduction">简介</label>
                                <textarea class="form-control" rows="3" name="introduction" id="add_introduction"></textarea>
                            </div>

                            <div class="form-group">
                                <label for="add_language">语言</label>
                                <input type="text" class="form-control" name="language" id="add_language">
                            </div>

                            <div class="form-group">
                                <label for="add_price">价格 <span class="text-danger">*</span></label>
                                <input type="number" step="0.01" class="form-control" name="price" id="add_price" required min="0">
                                <small class="form-text text-muted">请输入大于等于0的价格</small>
                                <div class="error-message"></div>
                            </div>

                            <div class="form-group">
                                <label for="add_pubdate">出版日期 <span class="text-danger">*</span></label>
                                <input type="date" class="form-control" name="pubdate" id="add_pubdate" required>
                                <div class="error-message"></div>
                            </div>

                            <div class="form-group">
                                <label for="add_categoryId">分类 <span class="text-danger">*</span></label>
                                <select class="form-control" name="categoryId" id="add_categoryId" required>
                                    <option value="">请选择分类</option>
                                    <c:forEach items="${categories}" var="category">
                                        <option value="${category.categoryId}">${category.categoryName}</option>
                                    </c:forEach>
                                </select>
                                <div class="error-message"></div>
                            </div>

                            <div class="form-group">
                                <label for="add_pressmark">书架号 <span class="text-danger">*</span></label>
                                <input type="number" class="form-control" name="pressmark" id="add_pressmark" required min="1">
                                <small class="form-text text-muted">请输入大于0的整数</small>
                                <div class="error-message"></div>
                            </div>
<%--                            这个功能是多余的，图书馆没有这个书就不会有这个信息，有这个信息以后就可以增加库存，只有有没有库存可不可以借阅的情况--%>
<%--                            所以这里应该注释，然后详情页面改成根据库存数量判断是否可借--%>
<%--                            <div class="form-group">--%>
<%--                                <label for="add_state">状态 <span class="text-danger">*</span></label>--%>
<%--                                <select class="form-control" name="state" id="add_state" required>--%>
<%--                                    <option value="1">在馆</option>--%>
<%--                                    <option value="0">借出</option>--%>
<%--                                </select>--%>
<%--                            </div>--%>

                            <div class="form-group">
                                <label for="add_tags">标签</label>
                                <div class="tag-select-container">
                                    <select class="form-control select2" name="tagIds" id="add_tags" multiple="multiple">
                                        <c:forEach items="${tags}" var="tag">
                                            <option value="${tag.id}">${tag.name}</option>
                                        </c:forEach>
                                    </select>
                                </div>
                                <small class="form-text text-muted">可以搜索或直接点击选择多个标签</small>
                            </div>
                        </div>

                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" data-dismiss="modal">关闭</button>
                            <button type="submit" class="btn btn-primary">保存</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
        <!-- ========== 新增图书模态框 END ========== -->
        <!-- 编辑图书的模态框 -->
        <div class="modal fade" id="editBookModal" tabindex="-1" role="dialog" aria-labelledby="editBookModalLabel" aria-hidden="true">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="editBookModalLabel">编辑图书</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <form id="editBookForm" method="post" action="/admin/book/edit">
                        <div class="modal-body">

                            <div class="form-group">
                                <label for="edit_bookId">图书ID</label>
                                <input type="text" class="form-control" name="bookId" id="edit_bookId" readonly>
                            </div>

                            <div class="form-group">
                                <label for="edit_name">书名 <span class="text-danger">*</span></label>
                                <input type="text" class="form-control" name="name" id="edit_name" required>
                                <div class="error-message"></div>
                            </div>

                            <div class="form-group">
                                <label for="edit_author">作者 <span class="text-danger">*</span></label>
                                <input type="text" class="form-control" name="author" id="edit_author" required>
                            </div>

                            <div class="form-group">
                                <label for="edit_publish">出版社</label>
                                <input type="text" class="form-control" name="publish" id="edit_publish">
                            </div>

                            <div class="form-group">
                                <label for="edit_isbn">ISBN</label>
                                <input type="text" class="form-control" name="isbn" id="edit_isbn">
                            </div>

                            <div class="form-group">
                                <label for="edit_introduction">简介</label>
                                <textarea class="form-control" name="introduction" id="edit_introduction"></textarea>
                            </div>

                            <div class="form-group">
                                <label for="edit_language">语言</label>
                                <input type="text" class="form-control" name="language" id="edit_language">
                            </div>

                            <div class="form-group">
                                <label for="edit_price">价格 <span class="text-danger">*</span></label>
                                <input type="number" class="form-control" name="price" id="edit_price" required>
                            </div>

                            <div class="form-group">
                                <label for="edit_pubdate">出版日期</label>
                                <input type="date" class="form-control" name="pubdate" id="edit_pubdate">
                            </div>

                            <div class="form-group">
                                <label for="edit_categoryId">分类 <span class="text-danger">*</span></label>
                                <select class="form-control" name="categoryId" id="edit_categoryId" required>
                                    <option value="">请选择分类</option>
                                    <c:forEach items="${categories}" var="category">
                                        <option value="${category.categoryId}">${category.categoryName}</option>
                                    </c:forEach>
                                </select>
                            </div>

                            <div class="form-group">
                                <label for="edit_pressmark">书架号 <span class="text-danger">*</span></label>
                                <input type="number" class="form-control" name="pressmark" id="edit_pressmark" required min="1">
                                <small class="form-text text-muted">请输入大于0的整数</small>
                                <div class="error-message"></div>
                            </div>

<%--                            这个功能是多余的，图书馆没有这个书就不会有这个信息，有这个信息以后就可以增加库存，只有有没有库存可不可以借阅的情况--%>
<%--                            所以这里应该注释，然后详情页面改成根据库存数量判断是否可借--%>
<%--                            <div class="form-group">--%>
<%--                                <label for="edit_state">状态</label>--%>
<%--                                <select class="form-control" id="edit_state" name="state">--%>
<%--                                    <option value="1">可借阅</option>--%>
<%--                                    <option value="0">不可借阅</option>--%>
<%--                                </select>--%>
<%--                            </div>--%>

                            <div class="form-group">
                                <label for="edit_tags">标签</label>
                                <select class="form-control" name="tagIds" id="edit_tags" multiple>
                                    <c:forEach items="${tags}" var="tag">
                                        <option value="${tag.id}">${tag.name}</option>
                                    </c:forEach>
                                </select>
                            </div>

                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" data-dismiss="modal">关闭</button>
                            <button type="submit" class="btn btn-primary">保存</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>

    <script>
        //消息
            $(document).ready(function(){
            if ($('#messageContainer .alert').length > 0) {
            $('#messageContainer').show();
            setTimeout(function(){
            $('#messageContainer').fadeOut('slow');
        }, 3000); // 3秒后自动隐藏
        }
        });


        // 编辑图书功能
        function openEditModal(bookId, bookName, bookAuthor, bookPrice, bookPublish, bookIsbn, bookIntroduction, bookLanguage, bookPubdate, bookCategoryId, bookPressmark, bookState) {
            // 清空之前的数据
            $('#editBookForm')[0].reset();

            // 处理日期格式
            let formattedDate = '';
            if (bookPubdate) {
                // 将日期字符串转换为 YYYY-MM-DD 格式
                const date = new Date(bookPubdate);
                formattedDate = date.toISOString().split('T')[0];
            }

    // 正确填充数据（注意 ID 全部改成 edit_ 开头）
    $('#edit_bookId').val(bookId);
    $('#edit_name').val(bookName);
    $('#edit_author').val(bookAuthor);
    $('#edit_price').val(bookPrice);
    $('#edit_publish').val(bookPublish || '');
    $('#edit_isbn').val(bookIsbn || '');
    $('#edit_introduction').val(bookIntroduction || '');
    $('#edit_language').val(bookLanguage || '');
    $('#edit_pubdate').val(formattedDate);
    $('#edit_categoryId').val(bookCategoryId);
    $('#edit_pressmark').val(bookPressmark || '');
    $('#edit_state').val(bookState || '1');

    // 打开模态框
    $('#editBookModal').modal('show');
}

        // Loading 状态控制
        function showLoading() {
            $('.loading').css('display', 'flex');
        }

        function hideLoading() {
            $('.loading').css('display', 'none');
        }

        // 搜索验证
        $('#searchform').submit(function(e) {
            var searchValue = $('#search').val().trim();
            if (searchValue === '') {
                e.preventDefault();
                alert('请输入搜索关键词');
                return false;
            }
        });

        // 初始化日期选择器
        $('.datepicker').datepicker({
            format: 'yyyy-mm-dd',
            autoclose: true,
            language: 'zh-CN'
        });

        // 新增图书表单提交
        $(document).ready(function() {
            $('#addBookForm').on('submit', function(e) {
                e.preventDefault();
                console.log("表单提交事件被触发");
                console.log("表单元素:", this);

                // 表单验证
                if (!this.checkValidity()) {
                    console.log("表单验证未通过");
                    $(this).addClass('was-validated');
                    return false;
                }
                console.log("表单验证通过");

                // 显示加载状态
                showLoading();

                // 收集表单数据
                var formData = $(this).serialize();
                console.log("提交的表单数据:", formData);
                console.log("表单字段值:", {
                    name: $('#name').val(),
                    author: $('#author').val(),
                    publish: $('#publish').val(),
                    isbn: $('#isbn').val(),
                    price: $('#price').val(),
                    pubdate: $('#pubdate').val(),
                    categoryId: $('#categoryId').val(),
                    pressmark: $('#pressmark').val(),
                    state: $('#state').val()
                });

                // 确保按钮被禁用，防止重复提交
                var submitButton = $(this).find('button[type="submit"]');
                submitButton.prop('disabled', true);

                // 发送POST请求
                console.log("准备发送AJAX请求");
                $.ajax({
                    type: 'POST',
                    url: '/admin_book_add.html',
                    data: formData,
                    dataType: 'json',
                    contentType: 'application/x-www-form-urlencoded',
                    beforeSend: function() {
                        console.log("AJAX请求即将发送");
                    },
                    success: function(response) {
                        console.log("服务器响应:", response);
                        hideLoading();
                        submitButton.prop('disabled', false);

                        if (response.status === 'success') {
                            Swal.fire({
                                title: '成功',
                                text: response.message || '图书添加成功！',
                                icon: 'success'
                            }).then(() => {
                                // 刷新图书列表
                                refreshBookList();
                                // 关闭模态框
                                $('#addBookModal').modal('hide');
                                // 重置表单
                                $('#addBookForm')[0].reset();
                                // 移除验证样式
                                $('#addBookForm').removeClass('was-validated');
                            });
                        } else {
                            Swal.fire({
                                title: '错误',
                                text: response.message || '添加失败，请重试！',
                                icon: 'error'
                            });
                        }
                    },
                    error: function(xhr, status, error) {
                        console.error("AJAX错误:", {
                            status: status,
                            error: error,
                            response: xhr.responseText,
                            xhr: xhr
                        });
                        hideLoading();
                        submitButton.prop('disabled', false);

                        let errorMsg = '添加失败，请重试！';
                        try {
                            const response = JSON.parse(xhr.responseText);
                            errorMsg = response.message || errorMsg;
                        } catch (e) {
                            errorMsg = xhr.responseText || errorMsg;
                        }

                        Swal.fire({
                            title: '错误',
                            text: errorMsg,
                            icon: 'error'
                        });
                    }
                });
                return false;
            });
        });

        // 刷新图书列表的函数
        function refreshBookList() {
            console.log("开始刷新图书列表");
            $.ajax({
                url: '/admin_book_list.html',
                method: 'GET',
                success: function(response) {
                    console.log("获取到新的图书列表");
                    // 更新表格内容
                    $('#bookTable tbody').html(response);
                },
                error: function(xhr, status, error) {
                    console.error('刷新图书列表失败:', error);
                    Swal.fire({
                        title: '错误',
                        text: '刷新图书列表失败',
                        icon: 'error'
                    });
                }
            });
        }

        // 在页面加载完成后检查分类数据
        $(document).ready(function() {
            var categorySelect = $('#categoryId');
            if (categorySelect.find('option').length <= 1) {
                console.warn("分类数据未加载");
                // 可以选择重新加载分类数据或显示提示
                Swal.fire({
                    title: '警告',
                    text: '分类数据加载失败，请刷新页面重试',
                    icon: 'warning'
                });
            }
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

        $(document).ready(function() {
            // 初始化 Select2
            $('#tags').select2({
                theme: 'bootstrap',
                dropdownParent: $('#addBookModal .modal-content'),
                placeholder: '请选择标签',
                allowClear: true,
                language: 'zh-CN'
            });

            // 在模态框打开时重新计算 Select2 的宽度
            $('#addBookModal').on('shown.bs.modal', function () {
                $('#tags').select2('destroy').select2({
                    theme: 'bootstrap',
                    dropdownParent: $('#addBookModal .modal-content'),
                    placeholder: '请选择标签',
                    allowClear: true,
                    language: 'zh-CN'
                });
            });
        });

        $(document).ready(function() {
            // 初始化标签选择
            $('#edit_tags').select2({
                theme: 'bootstrap',
                language: 'zh-CN',
                dropdownParent: $('#editBookModal .modal-content')
            });

            // 编辑图书
            $('.editBook').click(function() {
                var bookId = $(this).data('id');
                $.get('/admin/book/' + bookId, function(book) {
                    $('#edit_bookId').val(book.bookId);
                    $('#edit_name').val(book.name);
                    $('#edit_author').val(book.author);
                    $('#edit_publish').val(book.publish);
                    $('#edit_isbn').val(book.isbn);
                    $('#edit_introduction').val(book.introduction);
                    $('#edit_language').val(book.language);
                    $('#edit_price').val(book.price);
                    $('#edit_pubdate').val(book.pubdate);
                    $('#edit_categoryId').val(book.categoryId);
                    $('#edit_pressmark').val(book.pressmark);
                    $('#edit_state').val(book.state);
                    
                    // 获取图书的标签
                    $.get('/admin/book/tags/' + bookId, function(tagIds) {
                        $('#edit_tags').val(tagIds).trigger('change');
                    });
                    
                    $('#editBookModal').modal('show');
                });
            });
        });
    </script>

</body>
</html>
