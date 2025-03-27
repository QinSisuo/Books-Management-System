<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <title>我的通知 - 智悦书屋图书管理系统</title>
    <!-- 引入外部 CSS -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@11.0.19/dist/sweetalert2.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
    <!-- 引入外部 JavaScript -->
    <script src="${pageContext.request.contextPath}/js/jquery-3.2.1.js"></script>
    <script src="${pageContext.request.contextPath}/js/bootstrap.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11.0.19/dist/sweetalert2.min.js"></script>
</head>

<body>
    <!-- 引入公共头部: 包含CSS/JS等 -->
    <%@ include file="common/header.jsp" %>
    <%@ include file="common/reader_navbar.jsp" %>
    
    <!-- 通知列表面板 -->
    <div class="panel panel-default" style="width: 90%; margin-left: 5%; margin-top: 5%">
        <div class="panel-heading">
            <h3 class="panel-title">我的通知</h3>
            <button class="btn btn-primary pull-right" id="markAllRead">
                <i class="fas fa-check-double"></i> 一键已读所有
            </button>
        </div>
        <div class="panel-body">
            <c:if test="${not empty notifications}">
                <div class="list-group">
                    <c:forEach var="notification" items="${notifications}">
                        <div class="list-group-item ${notification.status == 0 ? 'list-group-item-warning' : ''}" 
                             data-notification-id="${notification.notificationId}">
                            <div class="d-flex w-100 justify-content-between">
                                <h4 class="list-group-item-heading">${notification.title}</h4>
                                <small><fmt:formatDate value="${notification.createTime}" pattern="yyyy-MM-dd HH:mm:ss"/></small>
                            </div>
                            <p class="list-group-item-text">${notification.content}</p>
                            <c:if test="${notification.status == 0}">
                                <button class="btn btn-sm btn-primary mark-read" 
                                        data-notification-id="${notification.notificationId}">
                                    标记为已读
                                </button>
                            </c:if>
                        </div>
                    </c:forEach>
                </div>
            </c:if>
            <c:if test="${empty notifications}">
                <div class="alert alert-info">
                    暂无通知
                </div>
            </c:if>
        </div>
    </div>

    <%@ include file="common/footer.jsp" %>

    <script>
        $(document).ready(function() {
            // 标记通知为已读
            $('.mark-read').click(function() {
                var notificationId = $(this).data('notification-id');
                $.post('${pageContext.request.contextPath}/notification/read/' + notificationId, function(response) {
                    if (response === 'success') {
                        // 更新UI
                        var item = $('[data-notification-id="' + notificationId + '"]');
                        item.removeClass('list-group-item-warning');
                        $(this).remove();
                        
                        // 更新未读数量
                        updateUnreadCount();
                        
                        Swal.fire({
                            icon: 'success',
                            title: '已标记为已读',
                            showConfirmButton: false,
                            timer: 1500
                        });
                    }
                });
            });

            // 一键已读所有
            $('#markAllRead').click(function() {
                Swal.fire({
                    title: '确认标记所有通知为已读？',
                    text: "此操作不可撤销",
                    icon: 'warning',
                    showCancelButton: true,
                    confirmButtonColor: '#3085d6',
                    cancelButtonColor: '#d33',
                    confirmButtonText: '确认',
                    cancelButtonText: '取消'
                }).then((result) => {
                    if (result.isConfirmed) {
                        $.post('${pageContext.request.contextPath}/notification/read/all', function(response) {
                            if (response === 'success') {
                                // 更新UI
                                $('.list-group-item-warning').removeClass('list-group-item-warning');
                                $('.mark-read').remove();
                                
                                // 更新未读数量
                                updateUnreadCount();
                                
                                Swal.fire({
                                    icon: 'success',
                                    title: '已全部标记为已读',
                                    showConfirmButton: false,
                                    timer: 1500
                                });
                            }
                        });
                    }
                });
            });

            // 更新未读通知数量
            function updateUnreadCount() {
                $.get('${pageContext.request.contextPath}/notification/unread/count', function(count) {
                    $('#notification-count').text(count);
                });
            }
        });
    </script>
</body>
</html> 