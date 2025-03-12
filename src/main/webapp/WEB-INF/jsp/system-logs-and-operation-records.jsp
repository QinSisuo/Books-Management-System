<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <title>系统日志</title>
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
    <%@ include file="common/admin_navbar.jsp" %>
    <%@ include file="common/footer.jsp" %>

    <!-- Loading 指示器 -->
    <div class="loading">
        <div class="spinner-border text-primary" role="status">
            <span class="sr-only">加载中...</span>
        </div>
    </div>

    <!-- 搜索表单 -->
    <div class="container" style="margin-top: 20px; max-width: 600px;">
        <form action="system-logs-and-operation-records.html" method="get" class="form-inline">
            <div class="form-group">
                <input type="text" class="form-control" name="search"
                       placeholder="搜索日志..." value="${searchQuery}" style="width: 300px;" />
            </div>
            &nbsp;
            <button type="submit" class="btn btn-primary">搜索</button>
            <c:if test="${not empty searchQuery}">
                <a href="system-logs-and-operation-records.html" class="btn btn-secondary ml-2">清除</a>
            </c:if>
        </form>
    </div>

    <!-- 显示成功或错误信息（默认隐藏） -->
    <div id="messageContainer" class="container" style="display: none;">
        <c:if test="${not empty succ}">
            <div class="alert alert-success alert-dismissable">
                <button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button>
                ${succ}
            </div>
        </c:if>
        <c:if test="${not empty error}">
            <div class="alert alert-danger alert-dismissable">
                <button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button>
                ${error}
            </div>
        </c:if>
    </div>

    <!-- 日志列表面板 -->
    <div class="container">
        <div class="panel panel-default">
            <div class="panel-heading bg-white">
                <div class="row align-items-center">
                    <div class="col-md-6">
                        <h3 class="panel-title mb-0">系统日志</h3>
                    </div>
                    <div class="col-md-6 text-right">
                        <c:if test="${not empty searchQuery}">
                            <div class="alert alert-info mb-0">
                                搜索结果: "${searchQuery}" (共 ${logs.size()} 条记录)
                            </div>
                        </c:if>
                    </div>
                </div>
            </div>
            <div class="panel-body">
                <div class="table-responsive">
                    <table class="table table-hover">
                        <thead>
                            <tr>
                                <th style="width: 10%">日志ID</th>
                                <th style="width: 15%">操作用户</th>
                                <th style="width: 20%">操作时间</th>
                                <th style="width: 30%">操作内容</th>
                                <th style="width: 15%">IP地址</th>
                                <th style="width: 10%">操作</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach items="${logs}" var="log">
                                <tr>
                                    <td>${log.id}</td>
                                    <td>${log.userName}</td>
                                    <td>${log.timestamp}</td>
                                    <td>${log.operationType}</td>
                                    <td>${log.ipAddress}</td>
                                    <td>
                                        <a href="/logs/delete/${log.id}" 
                                           class="btn btn-danger btn-xs delete-log">删除</a>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>

    <script>
        // 消息显示控制
        $(document).ready(function() {
            if ($("#messageContainer").text().trim() !== "") {
                $("#messageContainer").show();
            }
        });

        // 删除确认
        $(document).on('click', '.delete-log', function(e) {
            e.preventDefault();
            var logId = $(this).attr('href').split('/').pop();
            
            Swal.fire({
                title: '确认删除',
                text: `确定要删除日志ID ${logId} 吗？`,
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
        });

        // Loading 状态控制
        function showLoading() {
            $('.loading').css('display', 'flex');
        }

        function hideLoading() {
            $('.loading').css('display', 'none');
        }
    </script>
</body>
</html>