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
            <input type="text" id="searchQuery" class="form-control" placeholder="搜索日志..." />
        </div>

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
        // 搜索框事件
        $('#searchQuery').on('input', function() {
            let query = $(this).val();
            window.location.href = "/logs?search=" + query;  // 使用查询参数进行页面跳转
        });

        // 页面加载时加载日志数据
        $(document).ready(function() {
            // 如果你希望在页面加载时自动执行某些操作，可以在这里加上
        });
    </script>
</body>
</html>