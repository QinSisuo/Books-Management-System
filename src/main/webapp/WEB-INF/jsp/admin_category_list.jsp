<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html lang="zh-CN">
<head>
    <title>图书分类管理</title>
    <link rel="stylesheet" href="<c:url value='/css/bootstrap.min.css'/>">
    <script src="<c:url value='/js/jquery-3.2.1.js'/>"></script>
    <script src="<c:url value='/js/bootstrap.min.js'/>"></script>
</head>

<body>

<!-- 引入公共头部导航栏 -->
<%@ include file="common/header.jsp" %>
<%@ include file="common/admin_navbar.jsp" %>

<div class="container" style="margin-top: 30px;">
    <h3>📚 图书分类管理</h3>

    <a href="#" class="btn btn-primary btn-sm" data-toggle="modal" data-target="#addCategoryModal">新增分类</a>

    <table class="table table-bordered table-hover" style="margin-top:20px;">
        <thead>
            <tr>
                <th>分类ID</th>
                <th>分类名称</th>
                <th>操作</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach var="category" items="${categories}">
                <tr>
                    <td>${category.categoryId}</td>
                    <td>${category.categoryName}</td>
                    <td style="white-space: nowrap;">
                        <a href="#" class="btn btn-success btn-sm">编辑</a>
                        <a href="/admin/category/delete?categoryId=${category.categoryId}"
                           class="btn btn-danger btn-sm"
                           onclick="return confirm('确定删除此分类吗？');">
                            删除
                        </a>
                    </td>
                </tr>
            </c:forEach>
        </tbody>
    </table>
</div>

<!-- 这里可以先不实现模态框，先看列表能否正常显示 -->

<%@ include file="common/footer.jsp" %>

<script src="<c:url value='/js/jquery-3.2.1.js'/>"></script>
<script src="<c:url value='/js/bootstrap.min.js'/>"></script>
</body>
</html>
