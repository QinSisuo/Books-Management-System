<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <title>《${book.name}》</title>
    <!-- 引入外部 CSS 和 JS -->
    <link rel="stylesheet" href="css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@11.0.19/dist/sweetalert2.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
    <script src="js/jquery-3.2.1.js"></script>
    <script src="js/bootstrap.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11.0.19/dist/sweetalert2.min.js"></script>
    <style>
        .panel {
            border-radius: 8px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        }

        .table th {
            background-color: #f8f9fa;
            width: 150px;
            white-space: nowrap;
        }

        .table td {
            background-color: #fff;
        }
    </style>

</head>

<body>
<!-- 公共头部区域 -->
<%@ include file="../common/header.jsp" %>
<%@ include file="../common/reader_navbar.jsp" %>
<%@ include file="../common/footer.jsp" %>
<!-- 统一面板 -->
<div class="container">
<!-- 主体内容 -->

    <div class="panel panel-default shadow-sm">
        <div class="panel-heading bg-white">
            <h3 class="panel-title">
                <i class="fas fa-book-open"></i> 图书详情：《${book.name}》
            </h3>
        </div>
        <div class="panel-body">
            <table class="table table-bordered">
                <tbody>
                <tr>
                    <th><i class="fas fa-book"></i> 书名</th>
                    <td>${book.name}</td>
                </tr>
                <tr>
                    <th><i class="fas fa-user-edit"></i> 作者</th>
                    <td>${book.author}</td>
                </tr>
                <tr>
                    <th><i class="fas fa-building"></i> 出版社</th>
                    <td>${book.publish}</td>
                </tr>
                <tr>
                    <th><i class="fas fa-barcode"></i> ISBN</th>
                    <td>${book.isbn}</td>
                </tr>
                <tr>
                    <th><i class="fas fa-align-left"></i> 简介</th>
                    <td style="line-height: 1.6;">${book.introduction}</td>
                </tr>
                <tr>
                    <th><i class="fas fa-language"></i> 语言</th>
                    <td>${book.language}</td>
                </tr>
                <tr>
                    <th><i class="fas fa-yen-sign"></i> 价格</th>
                    <td>${book.price}</td>
                </tr>
                <tr>
                    <th><i class="fas fa-calendar-alt"></i> 出版日期</th>
                    <td>${book.pubdate}</td>
                </tr>
                <tr>
                    <th><i class="fas fa-th-large"></i> 分类号</th>
                    <td>${book.categoryId}</td>
                </tr>
                <tr>
                    <th><i class="fas fa-layer-group"></i> 书架号</th>
                    <td>${book.pressmark}</td>
                </tr>
                <tr>
                    <th><i class="fas fa-info-circle"></i> 状态</th>
                    <td>
                        <c:if test="${book.state == 1}">
                            <span class="label label-success">在馆</span>
                        </c:if>
                        <c:if test="${book.state == 0}">
                            <span class="label label-warning">借出</span>
                        </c:if>
                    </td>
                </tr>
                <tr>
                    <th><i class="fas fa-tags"></i> 图书分类</th>
                    <td>${categoryName}</td>
                </tr>
                <tr>
                    <th><i class="fas fa-bookmark"></i> 图书标签</th>
                    <td>
                        <div class="tag-group">
                            <c:forEach items="${tags}" var="tag">
                                <span class="tag">${tag.name}</span>
                            </c:forEach>
                        </div>
                    </td>
                </tr>
                </tbody>
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
