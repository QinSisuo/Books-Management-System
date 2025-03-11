<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>图书管理</title>
    <link rel="stylesheet" href="css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@11.0.19/dist/sweetalert2.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
    <script src="js/jquery-3.2.1.js"></script>
    <script src="js/bootstrap.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11.0.19/dist/sweetalert2.min.js"></script>
    <style>
        body {
            background-color: rgb(240,242,245);
        }
        .search-container {
            max-width: 600px;
            margin: 30px auto;
            padding: 20px;
        }
        .search-box {
            display: flex;
            align-items: center;
            background: #fff;
            border-radius: 24px;
            box-shadow: 0 2px 6px rgba(0,0,0,0.1);
            padding: 5px;
        }
        .search-input {
            flex: 1;
            border: none;
            padding: 10px 15px;
            font-size: 16px;
            outline: none;
            background: transparent;
        }
        .search-btn {
            background: #007bff;
            color: white;
            border: none;
            padding: 10px 20px;
            border-radius: 20px;
            cursor: pointer;
            transition: background-color 0.3s;
            display: flex;
            align-items: center;
            gap: 5px;
        }
        .search-btn:hover {
            background: #0056b3;
        }
        .search-btn i {
            margin-right: 5px;
        }
        .btn-xs {
            padding: 4px 10px;
            font-size: 12px;
            margin: 0 2px;
        }
        .loading {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: rgba(255,255,255,0.8);
            display: none;
            justify-content: center;
            align-items: center;
            z-index: 9999;
        }
        .table-responsive {
            margin-top: 20px;
            background: #fff;
            border-radius: 8px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
            padding: 15px;
        }
        .table {
            margin-bottom: 0;
        }
        .table th {
            border-top: none;
            font-weight: 600;
            color: #333;
            background-color: #f8f9fa;
            padding: 12px 8px;
        }
        .table td {
            padding: 12px 8px;
            vertical-align: middle;
        }
        .pagination {
            display: none;
        }
    </style>
</head>
<body>
    <%@ include file="common/header.jsp" %>
    <%@ include file="common/navbar.jsp" %>

    <!-- Loading 指示器 -->
    <div class="loading">
        <div class="spinner-border text-primary" role="status">
            <span class="sr-only">加载中...</span>
        </div>
    </div>

    <!-- 搜索框 -->
    <div style="padding: 70px 550px 10px">
        <form method="post" action="querybook.html" class="form-inline" id="searchform">
            <div class="input-group">
                <input type="text" placeholder="输入图书名" class="form-control" id="search" name="searchWord">
                <span class="input-group-btn">
                    <input type="submit" value="搜索" class="btn btn-default">
                </span>
            </div>
        </form>
    </div>

    <!-- 显示成功或错误信息 -->
    <div class="container">
        <c:if test="${!empty succ}">
            <div class="alert alert-success alert-dismissable fade show">
                <button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button>
                ${succ}
            </div>
        </c:if>
        <c:if test="${!empty error}">
            <div class="alert alert-danger alert-dismissable fade show">
                <button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button>
                ${error}
            </div>
        </c:if>
    </div>

    <!-- 图书列表面板 -->
    <div class="container">
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
            <div class="panel-body">
                <div class="table-responsive">
                    <table class="table table-hover" id="bookTable">
                        <thead>
                        <tr>
                            <th style="width: 20%">书名</th>
                            <th style="width: 15%">作者</th>
                            <th style="width: 15%">出版社</th>
                            <th style="width: 15%">ISBN</th>
                            <th style="width: 10%">价格</th>
                            <th style="width: 10%">借还</th>
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
                            <td title="${book.price}">￥<c:out value="${book.price}"></c:out></td>
                            <td>
                                <c:if test="${book.state==1}">
                                    <a href="lendbook.html?bookId=<c:out value="${book.bookId}"></c:out>" class="btn btn-primary btn-xs">借阅</a>
                                </c:if>
                                <c:if test="${book.state==0}">
                                    <a href="returnbook.html?bookId=<c:out value="${book.bookId}"></c:out>" class="btn btn-warning btn-xs">归还</a>
                                </c:if>
                            </td>
                            <td>
                                <a href="bookdetail.html?bookId=<c:out value="${book.bookId}"></c:out>" class="btn btn-success btn-xs">详情</a>
                                <button type="button" class="btn btn-info btn-xs" data-toggle="modal" data-target="#editBookModal"
                                        onclick="openEditModal('${book.bookId}', '${book.name}', '${book.author}', '${book.price}', '${book.publish}', '${book.isbn}', '${book.introduction}', '${book.language}', '${book.pubdate}', '${book.classId}', '${book.pressmark}', '${book.state}')">
                                    编辑
                                </button>
                                <a href="/admin/book/delete.html?bookId=<c:out value="${book.bookId}"></c:out>" 
                                   class="btn btn-danger btn-xs">删除</a>
                            </td>
                        </tr>
                        </c:forEach>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>

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
      <form id="editBookForm">
        <div class="modal-body">
            <div class="form-group">
              <label for="bookId">图书ID</label>
              <input type="text" class="form-control" id="bookId" name="bookId" readonly>
            </div>
            <div class="form-group">
              <label for="bookTitle">书名</label>
              <input type="text" class="form-control" id="bookTitle" name="name" required>
            </div>
            <div class="form-group">
              <label for="bookAuthor">作者</label>
              <input type="text" class="form-control" id="bookAuthor" name="author" required>
            </div>
            <div class="form-group">
              <label for="bookPublish">出版社</label>
              <input type="text" class="form-control" id="bookPublish" name="publish">
            </div>
            <div class="form-group">
              <label for="bookIsbn">ISBN</label>
              <input type="text" class="form-control" id="bookIsbn" name="isbn">
            </div>
            <div class="form-group">
              <label for="bookIntroduction">简介</label>
              <textarea class="form-control" id="bookIntroduction" name="introduction"></textarea>
            </div>
            <div class="form-group">
              <label for="bookLanguage">语言</label>
              <input type="text" class="form-control" id="bookLanguage" name="language">
            </div>
            <div class="form-group">
              <label for="bookPrice">价格</label>
              <input type="text" class="form-control" id="bookPrice" name="price" required>
            </div>
            <div class="form-group">
              <label for="bookPubdate">出版日期</label>
              <input type="date" class="form-control" id="bookPubdate" name="pubdate">
            </div>
            <div class="form-group">
              <label for="bookClassId">分类ID</label>
              <input type="text" class="form-control" id="bookClassId" name="classId">
            </div>
            <div class="form-group">
              <label for="bookPressmark">图书标记</label>
              <input type="text" class="form-control" id="bookPressmark" name="pressmark">
            </div>
            <div class="form-group">
              <label for="bookState">状态</label>
              <select class="form-control" id="bookState" name="state">
                <option value="1">可借阅</option>
                <option value="0">不可借阅</option>
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

<script>
    // 删除确认
    $(document).on('click', '.btn-danger', function(e) {
        if ($(this).attr('href')) {
            e.preventDefault();
            var bookId = $(this).attr('href').split('bookId=')[1];
            var bookName = $(this).closest('tr').find('td:first').text();
            
            Swal.fire({
                title: '确认删除',
                text: `确定要删除图书《${bookName}》吗？`,
                icon: 'warning',
                showCancelButton: true,
                confirmButtonText: '确定',
                cancelButtonText: '取消'
            }).then((result) => {
                if (result.isConfirmed) {
                    showLoading();
                    window.location.href = $(this).attr('href');
                }
            });
        }
    });

    // 编辑图书功能
    function openEditModal(bookId, bookName, bookAuthor, bookPrice, bookPublish, bookIsbn, bookIntroduction, bookLanguage, bookPubdate, bookClassId, bookPressmark, bookState) {
        // 清空之前的数据
        $('#editBookForm')[0].reset();
        
        // 填充数据
        $('#bookId').val(bookId);
        $('#bookTitle').val(bookName);
        $('#bookAuthor').val(bookAuthor);
        $('#bookPrice').val(bookPrice);
        $('#bookPublish').val(bookPublish || '');
        $('#bookIsbn').val(bookIsbn || '');
        $('#bookIntroduction').val(bookIntroduction || '');
        $('#bookLanguage').val(bookLanguage || '');
        $('#bookPubdate').val(bookPubdate || '');
        $('#bookClassId').val(bookClassId || '');
        $('#bookPressmark').val(bookPressmark || '');
        $('#bookState').val(bookState || '1');

        // 显示模态框
        $('#editBookModal').modal('show');
    }

    // AJAX 表单提交优化
    $('#editBookForm').on('submit', function(e) {
        e.preventDefault();
        showLoading();
        
        $.ajax({
            type: 'POST',
            url: '/admin/book/edit',
            data: $(this).serialize(),
            success: function(response) {
                hideLoading();
                Swal.fire({
                    title: '成功',
                    text: '图书信息更新成功！',
                    icon: 'success'
                }).then(() => {
                    location.reload();
                });
            },
            error: function(xhr) {
                hideLoading();
                Swal.fire({
                    title: '错误',
                    text: xhr.responseText || '更新失败，请重试！',
                    icon: 'error'
                });
            }
        });
    });

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
</script>

</body>
</html>
