<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <title>读者图书查询</title>
    <!-- 否则手动引入 -->
    <link rel="stylesheet" href="css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@11.0.19/dist/sweetalert2.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
    <script src="js/jquery-3.2.1.js"></script>
    <script src="js/bootstrap.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11.0.19/dist/sweetalert2.min.js"></script>    <style>
        body {
            background-color: rgb(240,242,245);
        }
        .search-form {
            margin: 30px auto;
            max-width: 600px;
        }
    </style>
</head>

<body>
    <!-- 引入公共头部: 包含CSS/JS等 -->
    <%@ include file="common/header.jsp" %>
    <!-- 引入读者导航栏 -->
    <%@ include file="common/reader_navbar.jsp" %>
    <%@ include file="common/footer.jsp" %>

    <nav class="navbar navbar-default" role="navigation" style="background-color:#fff">
        <div class="container-fluid">
            <div class="navbar-header" style="margin-left: 8%; margin-right: 1%;">
                <a class="navbar-brand" href="reader_main.html">
                    <p class="text-primary">我的图书馆</p>
                </a>
            </div>
            <div class="collapse navbar-collapse" id="reader-navbar-collapse">
                <ul class="nav navbar-nav navbar-left">
                    <li class="active"><a href="reader_querybook.html">图书查询</a></li>
                    <li><a href="reader_info.html">个人信息</a></li>
                    <li><a href="reader_my_borrow.html">我的借还</a></li>
                    <li><a href="reader_repasswd.html">密码修改</a></li>
                </ul>
                <ul class="nav navbar-nav navbar-right">
                    <li>
                        <a href="reader_info.html">
                            <span class="glyphicon glyphicon-user"></span> 欢迎：<c:out value="${user.username}" />
                        </a>
                    </li>
                    <li>
                        <a href="logout">
                            <span class="glyphicon glyphicon-log-in"></span> 退出
                        </a>
                    </li>
                </ul>
            </div>
        </div>
    </nav>

    <!-- 提示区 -->
    <div class="container" style="margin-top: 20px;">
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

    <!-- 搜索表单：可根据你原先的 method / action 调整 -->
    <div class="container search-form">
        <form action="reader_querybook.html" method="get" class="form-inline">
            <div class="form-group">
                <label for="searchWord" class="sr-only">关键词：</label>
                <input type="text" class="form-control" id="searchWord" name="searchWord"
                       placeholder="输入关键词(书名/作者等)" value="${searchWord}" style="width: 300px;">
            </div>
            &nbsp;
            <button type="submit" class="btn btn-primary">搜索</button>
        </form>
    </div>

    <!-- 查询结果显示 -->
    <div class="container" style="margin-top: 30px;">
        <div class="panel panel-default">
            <div class="panel-heading">
                <h3 class="panel-title">查询结果</h3>
            </div>
            <div class="panel-body">
                <c:if test="${not empty books}">
                    <table class="table table-hover">
                        <thead>
                            <tr>
                                <th>书籍ID</th>
                                <th>书名</th>
                                <th>作者</th>
                                <th>出版社</th>
                                <th>价格</th>
                                <th>ISBN</th>
                                <!-- 如果还要更多列就加 -->
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="bk" items="${books}">
                                <tr>
                                    <td>${bk.bookId}</td>
                                    <td>${bk.name}</td>
                                    <td>${bk.author}</td>
                                    <td>${bk.publish}</td>
                                    <td>${bk.price}</td>
                                    <td>${bk.isbn}</td>
                                    <!-- 你想加"借阅"或"详情"按钮也可以这里写 -->
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </c:if>
                <c:if test="${empty books}">
                    <p>暂无图书信息</p>
                </c:if>
            </div>
        </div>
    </div>

    <script>
    // 如果需要一些额外的JS逻辑可以写在这里
    </script>
</body>
</html>
