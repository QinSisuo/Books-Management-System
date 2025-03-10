<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>系统日志</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/jquery@3.6.0/dist/jquery.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</head>
<body>
    <div class="container mt-4">
        <h2>系统日志</h2>

        <!-- 搜索框 -->
        <div class="mb-3">
            <form action="${pageContext.request.contextPath}/system-logs-and-operation-records.html" method="GET" class="d-flex">
                <input type="text" name="search" class="form-control me-2" placeholder="搜索日志..." value="${searchQuery}"/>
                <button type="submit" class="btn btn-primary">搜索</button>
                <c:if test="${not empty searchQuery}">
                    <a href="${pageContext.request.contextPath}/system-logs-and-operation-records.html" class="btn btn-secondary ms-2">清除</a>
                </c:if>
            </form>
        </div>

        <!-- 搜索结果提示 -->
        <c:if test="${not empty searchQuery}">
            <div class="alert alert-info">
                搜索结果: "${searchQuery}" (共 ${logs.size()} 条记录)
            </div>
        </c:if>

        <!-- 日志表格 -->
        <table class="table table-bordered table-striped">
            <thead>
                <tr>
                    <th>日志ID</th>
                    <th>操作用户</th>
                    <th>操作时间</th>
                    <th>操作内容</th>
                    <th>IP地址</th>
                    <th>操作</th>
                </tr>
            </thead>
            <tbody id="logTableBody">
                <c:forEach var="log" items="${logs}">
                    <tr>
                        <td>${log.id}</td>
                        <td>${log.userName}</td>
                        <td>${log.timestamp}</td>
                        <td>${log.operationType}</td>
                        <td>${log.ipAddress}</td>
                        <td>
                            <!-- 通过链接删除日志 -->
                            <a href="${pageContext.request.contextPath}/logs/delete/${log.id}"
                               onclick="return confirm('确定删除日志ID ${log.id} 吗？')"
                               class="btn btn-danger">删除</a>
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </div>

    <script>
        // 删除确认
        function confirmDelete(logId) {
            return confirm('确定删除日志ID ' + logId + ' 吗？');
        }
    </script>
</body>
</html>