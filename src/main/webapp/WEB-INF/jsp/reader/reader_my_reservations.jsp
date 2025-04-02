<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <title>我的预约记录</title>
    <!-- 引入外部 CSS -->
    <link rel="stylesheet" href="css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@11.0.19/dist/sweetalert2.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
    <script src="js/jquery-3.2.1.js"></script>
    <script src="js/bootstrap.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11.0.19/dist/sweetalert2.min.js"></script>
</head>
<body>
    <!-- 引入公共头部 -->
    <%@ include file="../common/header.jsp" %>
    <%@ include file="../common/reader_navbar.jsp" %>
    <%@ include file="../common/footer.jsp" %>

    <!-- 统一面板 -->
    <div class="container">

        <!-- 标题和新增按钮 -->
        <div class="panel panel-default">
            <div class="panel-heading bg-white">
                <div class="row align-items-center">
                    <div class="col-md-6">
                        <h3 class="panel-title mb-0">我的预约记录</h3>
                    </div>
                </div>
            </div>
        </div>

        <table class="table table-hover">
            <thead>
                <tr>
                    <th>图书名称</th>
                    <th>预约时间</th>
                    <th>状态</th>
                    <th>通知时间</th>
                    <th>操作</th>
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
                        <td>
                            <c:if test="${reservation.status == 0}">
                                <button class="btn btn-danger btn-sm" onclick="cancelReservation(${reservation.id})">
                                    <i class="fas fa-times"></i> 取消预约
                                </button>
                            </c:if>
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </div>

    <script>
        function cancelReservation(reservationId) {
            Swal.fire({
                title: '确认取消预约？',
                text: "取消后将无法恢复！",
                icon: 'warning',
                showCancelButton: true,
                confirmButtonColor: '#d33',
                cancelButtonColor: '#3085d6',
                confirmButtonText: '是的，取消预约',
                cancelButtonText: '返回'
            }).then((result) => {
                if (result.isConfirmed) {
                    $.ajax({
                        url: '${pageContext.request.contextPath}/reader/cancelReservation',
                        type: 'POST',
                        data: { reservationId: reservationId },
                        success: function(response) {
                            if (response.success) {
                                Swal.fire(
                                    '已取消！',
                                    '预约已成功取消。',
                                    'success'
                                ).then(() => {
                                    location.reload();
                                });
                            } else {
                                Swal.fire(
                                    '错误！',
                                    response.message || '取消预约失败，请稍后重试。',
                                    'error'
                                );
                            }
                        },
                        error: function() {
                            Swal.fire(
                                '错误！',
                                '服务器错误，请稍后重试。',
                                'error'
                            );
                        }
                    });
                }
            });
        }
    </script>
</body>
</html> 