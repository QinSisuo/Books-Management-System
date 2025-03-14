<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <title>reader图书查询</title>
    <!-- 引入外部 CSS -->
    <link rel="stylesheet" href="css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@11.0.19/dist/sweetalert2.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
    <script src="js/jquery-3.2.1.js"></script>
    <script src="js/bootstrap.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11.0.19/dist/sweetalert2.min.js"></script>
</head>

<body>
    <!-- 引入公共头部: 包含CSS/JS等 -->
    <%@ include file="common/header.jsp" %>
    <%@ include file="common/reader_navbar.jsp" %>
    <%@ include file="common/footer.jsp" %>

    <!-- 提示信息 (与admin_book_manage类似), 用来显示后端传的 succ/error -->
    <div class="container" style="margin-top: 20px;">
        <c:if test="${not empty succ}">
            <div class="alert alert-success alert-dismissable fade show">
                <button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button>
                ${succ}
            </div>
        </c:if>
        <c:if test="${not empty error}">
            <div class="alert alert-danger alert-dismissable fade show">
                <button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button>
                ${error}
            </div>
        </c:if>
    </div>

    <!-- 搜索表单：保留原有功能 -->
    <div class="container" style="margin-top: 20px; max-width: 600px;">
        <form action="reader_book_list.html" method="get" class="form-inline">
            <div class="form-group">
                <input type="text" class="form-control" name="searchWord"
                       placeholder="输入搜索关键词" value="${searchWord}" style="width: 300px;" />
            </div>
            &nbsp;
            <button type="submit" class="btn btn-primary">搜索</button>
        </form>
    </div>

    <!-- 查询结果：Bootstrap风格的 Panel + table -->
    <div class="container" style="margin-top: 30px;">
        <div class="panel panel-default">
            <div class="panel-heading">
                <h3 class="panel-title">查询结果</h3>
            </div>
            <div class="panel-body">
                <!-- 如果 books 非空, 显示表格, 否则提示 -->
                <c:if test="${not empty books}">
                    <table class="table table-hover">
                        <thead>
                            <tr>
                                <th>书名</th>
                                <th>作者</th>
                                <th>出版社</th>
                                <th>ISBN</th>
                                <th>价格</th>
                                <th>状态</th>
                                <th>操作</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="bk" items="${books}">
                                <tr>
                                    <td>${bk.name}</td>
                                    <td>${bk.author}</td>
                                    <td>${bk.publish}</td>
                                    <td>${bk.isbn}</td>
                                    <td>${bk.price}</td>

                                    <!-- 状态列 -->
                                    <td>
                                        <c:choose>
                                            <c:when test="${bk.state == 1}">
                                                可借
                                            </c:when>
                                            <c:otherwise>
                                                已借出
                                            </c:otherwise>
                                        </c:choose>
                                    </td>

                                    <!-- 借阅/归还按钮列 -->
                                    <!-- 状态列不变: state=1 => 可借, 0 => 已借出 -->
                                    <td>
                                        <c:choose>
                                            <c:when test="${bk.state == 1}">
                                                可借
                                            </c:when>
                                            <c:otherwise>
                                                已借出
                                            </c:otherwise>
                                        </c:choose>
                                    </td>

                                    <!-- 操作列: 如果可借 => 显示“借阅”，否则 => 显示“预约借阅” -->
                                    <td>
                                        <c:choose>
                                            <c:when test="${bk.state == 1}">
                                                <!-- 可借 => 借阅 -->
                                                <a href="/reader/book/borrow?bookId=${bk.bookId}"
                                                   class="btn btn-primary btn-sm">
                                                   借阅
                                                </a>
                                            </c:when>
                                            <c:otherwise>
                                                <!-- 已借 => 预约借阅 -->
                                                <a href="/reader/book/reserve?bookId=${bk.bookId}"
                                                   class="btn btn-info btn-sm">
                                                   预约借阅
                                                </a>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>

                                </tr>
                            </c:forEach>
                        </tbody>

                    </table>
                </c:if>
                <c:if test="${empty books}">
                    <p>暂无匹配的图书</p>
                </c:if>
            </div>
        </div>
    </div>

</body>
</html>
