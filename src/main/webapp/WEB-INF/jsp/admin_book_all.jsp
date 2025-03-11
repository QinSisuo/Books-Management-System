<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>图书管理</title>
    <link rel="stylesheet" href="css/bootstrap.min.css">
    <script src="js/jquery-3.2.1.js"></script>
    <script src="js/bootstrap.min.js"></script>
    <style>
        body{
            background-color: rgb(240,242,245);
        }
    </style>
</head>
<body>
    <%@ include file="common/header.jsp" %>
    <%@ include file="common/navbar.jsp" %>

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
    <div style="position: relative;top: 10%">
        <c:if test="${!empty succ}">
            <div class="alert alert-success alert-dismissable">
                <button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button>
                ${succ}
            </div>
        </c:if>
        <c:if test="${!empty error}">
            <div class="alert alert-danger alert-dismissable">
                <button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button>
                ${error}
            </div>
        </c:if>
    </div>

    <!-- 图书列表面板 -->
    <div class="panel panel-default" style="width: 90%;margin-left: 5%">
        <div class="panel-heading" style="background-color: #fff">
            <div class="row">
                <div class="col-md-6">
                    <h3 class="panel-title">图书管理</h3>
                </div>
                <div class="col-md-6 text-right">
                    <button class="btn btn-primary btn-sm" data-toggle="modal" data-target="#addBookModal">新增图书</button>
                </div>
            </div>
        </div>
        <div class="panel-body">
            <table class="table table-hover">
                <thead>
                <tr>
                    <th>书名</th>
                    <th>作者</th>
                    <th>出版社</th>
                    <th>ISBN</th>
                    <th>价格</th>
                    <th>借还</th>
                    <th>操作</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach items="${books}" var="book">
                <tr>
                    <td><c:out value="${book.name}"></c:out></td>
                    <td><c:out value="${book.author}"></c:out></td>
                    <td><c:out value="${book.publish}"></c:out></td>
                    <td><c:out value="${book.isbn}"></c:out></td>
                    <td><c:out value="${book.price}"></c:out></td>
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
                                onclick="openEditModal('${book.bookId}', '${book.name}', '${book.author}', '${book.price}')">
                            编辑
                        </button>
                        <a href="/admin/book/delete.html?bookId=<c:out value="${book.bookId}"></c:out>" 
                           onclick="return confirm('确定删除图书《${book.name}》吗？')"
                           class="btn btn-danger btn-xs">删除</a>
                    </td>
                </tr>
                </c:forEach>
                </tbody>
            </table>
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
      <div class="modal-body">
        <form id="editBookForm">
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
          <button type="submit" class="btn btn-primary">保存</button>
        </form>
      </div>
    </div>
  </div>
</div>

<script>
    // 这个函数用来在点击编辑按钮时填充模态框中的数据
    function openEditModal(bookId, bookTitle, bookAuthor, bookPrice, bookPublish, bookIsbn, bookIntroduction, bookLanguage, bookPubdate, bookClassId, bookPressmark, bookState) {
        document.getElementById('bookId').value = bookId;
        document.getElementById('bookTitle').value = bookTitle;
        document.getElementById('bookAuthor').value = bookAuthor;
        document.getElementById('bookPrice').value = bookPrice;
        document.getElementById('bookPublish').value = bookPublish;
        document.getElementById('bookIsbn').value = bookIsbn;
        document.getElementById('bookIntroduction').value = bookIntroduction;
        document.getElementById('bookLanguage').value = bookLanguage;
        document.getElementById('bookPubdate').value = bookPubdate;
        document.getElementById('bookClassId').value = bookClassId;
        document.getElementById('bookPressmark').value = bookPressmark;
        document.getElementById('bookState').value = bookState;
    }

    $(document).ready(function() {
        $("#editBookForm").submit(function(event) {
            event.preventDefault(); // 防止表单提交刷新页面

            var formData = $(this).serialize(); // 获取表单数据

            $.ajax({
                url: '/admin/book/edit', // 后端编辑图书的 URL
                type: 'POST',
                data: formData,
                success: function(response) {
                    // 在这里你可以处理成功响应（如更新页面数据）
                    alert('图书编辑成功！');
                    location.reload(); // 可选择刷新页面
                    $('#editBookModal').modal('hide'); // 关闭模态框
                },
                error: function(xhr, status, error) {
                    // 处理错误响应
                    alert('图书编辑失败！');
                }
            });
        });
    });
</script>

</body>
</html>
