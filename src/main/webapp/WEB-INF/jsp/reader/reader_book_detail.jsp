<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <title>《 ${book.name}》</title>
    <!-- 引入外部 CSS -->
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
        .panel {
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
        }
        .panel-heading {
            background-color: #fff !important;
            border-bottom: 1px solid #eee;
        }
        .panel-title {
            color: #333;
            font-weight: 500;
        }
        .table th {
            background-color: #f8f9fa;
            border-bottom: 2px solid #dee2e6;
        }
        .table td {
            vertical-align: middle;
        }
    </style>
</head>
<body>
    <!-- 引入公共头部: 包含CSS/JS等 -->
    <%@ include file="../common/header.jsp" %>
    <%@ include file="../common/reader_navbar.jsp" %>
    <%@ include file="../common/footer.jsp" %>

    <!-- 统一面板 -->
    <div class="container">
        <div class="panel panel-default">
            <div class="panel-heading">
                <h3 class="panel-title">《 ${book.name}》</h3>
            </div>
            <div class="panel-body">
                <table class="table table-hover">
                    <tr>
                        <th width="15%">书名</th>
                        <td>${book.name}</td>
                    </tr>
                    <tr>
                        <th>作者</th>
                        <td>${book.author}</td>
                    </tr>
                    <tr>
                        <th>出版社</th>
                        <td>${book.publish}</td>
                    </tr>
                    <tr>
                        <th>ISBN</th>
                        <td>${book.isbn}</td>
                    </tr>
                    <tr>
                        <th>简介</th>
                        <td>${book.introduction}</td>
                    </tr>
                    <tr>
                        <th>语言</th>
                        <td>${book.language}</td>
                    </tr>
                    <tr>
                        <th>价格</th>
                        <td>${book.price}</td>
                    </tr>
                    <tr>
                        <th>出版日期</th>
                        <td>${book.pubdate}</td>
                    </tr>
                    <tr>
                        <th>分类号</th>
                        <td>${book.categoryId}</td>
                    </tr>
                    <tr>
                        <th>书架号</th>
                        <td>${book.pressmark}</td>
                    </tr>
                    <tr>
                        <th>状态</th>
                        <td>
                            <c:if test="${book.state==1}">
                                <span class="label label-success">在馆</span>
                            </c:if>
                            <c:if test="${book.state==0}">
                                <span class="label label-warning">借出</span>
                            </c:if>
                        </td>
                    </tr>
                    <tr>
                        <th>图书分类</th>
                        <td>${categoryName}</td>
                    </tr>
                    <tr>
                        <th>图书标签</th>
                        <td>
                            <div class="tag-group">
                                <c:forEach items="${tags}" var="tag">
                                    <span class="tag">${tag.name}</span>
                                </c:forEach>
                            </div>
                        </td>
                    </tr>
                </table>
            </div>
        </div>
    </div>

    <!-- SweetAlert 提示信息 -->
    <c:if test="${not empty succ}">
        <script>
            Swal.fire({
                icon: 'success',
                title: '${succ}',
                showConfirmButton: false,
                timer: 2000
            });
        </script>
    </c:if>

    <c:if test="${not empty error}">
        <script>
            Swal.fire({
                icon: 'error',
                title: '${error}',
                showConfirmButton: true
            });
        </script>
    </c:if>
</body>
</html>
