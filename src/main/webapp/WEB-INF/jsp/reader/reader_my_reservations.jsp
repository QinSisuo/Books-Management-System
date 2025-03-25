<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <title>我的预约记录</title>
    <link rel="stylesheet" href="css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
    <script src="js/jquery-3.2.1.js"></script>
    <script src="js/bootstrap.min.js"></script>
</head>
<body>
    <!-- 引入公共头部 -->
    <%@ include file="../common/header.jsp" %>
    <%@ include file="../common/reader_navbar.jsp" %>
    <%@ include file="../common/footer.jsp" %>

    <div class="container">
        <div class="panel panel-default">
            <div class="panel-heading">
                <h3 class="panel-title">我的预约记录</h3>
            </div>
            <div class="panel-body">
                <table class="table table-hover">
                    <thead>
                        <tr>
                            <th>图书名称</th>
                            <th>预约时间</th>
                            <th>状态</th>
                            <th>通知时间</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="reservation" items="${reservations}">
                            <tr>
                                <td>${reservation.bookName}</td>
                                <td>${reservation.reserveTime}</td>
                                <td>
                                    <c:choose>
                                        <c:when test="${reservation.status == 0}">
                                            <span class="label label-warning">等待中</span>
                                        </c:when>
                                        <c:when test="${reservation.status == 1}">
                                            <span class="label label-success">已通知</span>
                                        </c:when>
                                        <c:when test="${reservation.status == 2}">
                                            <span class="label label-default">已取消</span>
                                        </c:when>
                                    </c:choose>
                                </td>
                                <td>${reservation.notifyTime != null ? reservation.notifyTime : '-'}</td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</body>
</html> 