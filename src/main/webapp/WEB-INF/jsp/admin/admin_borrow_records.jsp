<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <title>借阅记录管理</title>
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
        .search-panel {
            background: white;
            padding: 20px;
            border-radius: 8px;
            margin-bottom: 20px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
        }
        .table-container {
            background: white;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
        }
        .status-badge {
            padding: 5px 10px;
            border-radius: 15px;
            font-size: 12px;
        }
        .status-borrowing {
            background-color: #e3f2fd;
            color: #1976d2;
        }
        .status-returned {
            background-color: #e8f5e9;
            color: #2e7d32;
        }
        .status-overdue {
            background-color: #ffebee;
            color: #c62828;
        }
    </style>
</head>
<body>
    <!-- 引入公共头部 -->
    <%@ include file="../common/header.jsp" %>
    <%@ include file="../common/admin_navbar.jsp" %>
    <%@ include file="../common/footer.jsp" %>

    <div class="container">
        <!-- 页面标题 -->
        <div class="panel panel-default">
            <div class="panel-heading bg-white">
                <div class="row align-items-center">
                    <div class="col-md-6">
                        <h3 class="panel-title mb-0">📚 借阅记录管理</h3>
                    </div>
                </div>
            </div>
        </div>
        
        <!-- 搜索面板 -->
        <div class="search-panel">
            <form id="searchForm" class="form-inline">
                <div class="form-group mx-sm-3 mb-2">
                    <label for="readerId" class="mr-2">用户ID</label>
                    <input type="number" class="form-control" id="readerId" name="readerId" placeholder="请输入用户ID">
                </div>
                <button type="button" class="btn btn-primary mb-2" onclick="searchRecords()">
                    <i class="fas fa-search"></i> 搜索
                </button>
            </form>
        </div>

        <!-- 数据表格 -->
        <div class="table-container">
            <table class="table table-hover">
                <thead>
                    <tr>
                        <th>借阅ID</th>
                        <th>用户ID</th>
                        <th>用户名</th>
                        <th>图书名称</th>
                        <th>借阅时间</th>
                        <th>到期时间</th>
                        <th>归还时间</th>
                        <th>状态</th>
                    </tr>
                </thead>
                <tbody id="recordsTableBody">
                    <c:forEach var="record" items="${records}">
                        <tr>
                            <td>${record.id}</td>
                            <td>${record.readerId}</td>
                            <td>${record.readerName}</td>
                            <td>${record.bookName}</td>
                            <td><fmt:formatDate value="${record.borrowTime}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
                            <td><fmt:formatDate value="${record.dueTime}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
                            <td>
                                <c:choose>
                                    <c:when test="${record.returnTime != null}">
                                        <fmt:formatDate value="${record.returnTime}" pattern="yyyy-MM-dd HH:mm:ss"/>
                                    </c:when>
                                    <c:otherwise>未归还</c:otherwise>
                                </c:choose>
                            </td>
                            <td>
                                <span class="status-badge ${record.status == 0 ? 'status-borrowing' : record.status == 1 ? 'status-returned' : 'status-overdue'}">
                                    <c:choose>
                                        <c:when test="${record.status == 0}">借出中</c:when>
                                        <c:when test="${record.status == 1}">已归还</c:when>
                                        <c:when test="${record.status == 2}">已续借</c:when>
                                        <c:when test="${record.status == 3}">已逾期</c:when>
                                        <c:otherwise>未知</c:otherwise>
                                    </c:choose>
                                </span>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>
    </div>

    <script>
        function searchRecords() {
            const readerId = $('#readerId').val();
            if (!readerId) {
                Swal.fire({
                    icon: 'warning',
                    title: '提示',
                    text: '请输入用户ID'
                });
                return;
            }

            const formData = {
                readerId: parseInt(readerId)
            };

            console.log('发送查询请求:', formData);

            $.ajax({
                url: 'admin_borrow_records_search',
                type: 'POST',
                contentType: 'application/json',
                data: JSON.stringify(formData),
                success: function(response) {
                    console.log('查询结果:', response);
                    updateTable(response);
                },
                error: function(xhr, status, error) {
                    console.error('查询错误:', error);
                    console.error('状态码:', xhr.status);
                    console.error('响应文本:', xhr.responseText);
                    Swal.fire({
                        icon: 'error',
                        title: '查询失败',
                        text: '请稍后重试'
                    });
                }
            });
        }

        function updateTable(records) {
            const tbody = $('#recordsTableBody');
            tbody.empty();

            if (!records || records.length === 0) {
                tbody.append('<tr><td colspan="8" class="text-center">未找到相关记录</td></tr>');
                return;
            }

            records.forEach(record => {
                const row = `
                    <tr>
                        <td>${record.id || ''}</td>
                        <td>${record.readerId || ''}</td>
                        <td>${record.readerName || ''}</td>
                        <td>${record.bookName || ''}</td>
                        <td>${formatDate(record.borrowTime)}</td>
                        <td>${formatDate(record.dueTime)}</td>
                        <td>${record.returnTime ? formatDate(record.returnTime) : '未归还'}</td>
                        <td>
                            <span class="status-badge ${getStatusClass(record.status)}">
                                ${getStatusText(record.status)}
                            </span>
                        </td>
                    </tr>
                `;
                tbody.append(row);
            });
        }

        function formatDate(dateStr) {
            if (!dateStr) return '';
            const date = new Date(dateStr);
            return date.toLocaleString('zh-CN', {
                year: 'numeric',
                month: '2-digit',
                day: '2-digit',
                hour: '2-digit',
                minute: '2-digit',
                second: '2-digit'
            });
        }

        function getStatusClass(status) {
            switch (status) {
                case 0: return 'status-borrowing';
                case 1: return 'status-returned';
                default: return 'status-overdue';
            }
        }

        function getStatusText(status) {
            switch (status) {
                case 0: return '借出中';
                case 1: return '已归还';
                case 2: return '已续借';
                case 3: return '已逾期';
                default: return '未知';
            }
        }
    </script>
</body>
</html> 