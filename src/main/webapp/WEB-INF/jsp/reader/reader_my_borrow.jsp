<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <title>我的借还</title>
    <!-- 引入外部 CSS -->
    <link rel="stylesheet" href="css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@11.0.19/dist/sweetalert2.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
    <script src="js/jquery-3.2.1.js"></script>
    <script src="js/bootstrap.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11.0.19/dist/sweetalert2.min.js"></script>

    <!-- 如果有需要的自定义样式，可以写这里或单独放到 .css 文件中 -->
    <style>
      /* 这里可以放少量针对本页面的小样式 */
    </style>
</head>

<body>
    <!-- 引入公共头部: 包含CSS/JS等 -->
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
                        <h3 class="panel-title mb-0">我的借还日志</h3>
                    </div>
                </div>
            </div>
        </div>

        <table class="table table-hover">
            <thead>
            <tr>
                <th>记录ID</th>
                <th>书名</th>
                <th>借书时间</th>
                <th>到期时间</th>
                <th>归还时间</th>
                <th>状态</th>
                <th>操作</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach var="r" items="${records}">
                <tr>
                    <td>${r.id}</td>
                    <td>${r.bookName}</td>
                    <td><fmt:formatDate value="${r.borrowTime}" pattern="yyyy年MM月dd日 HH:mm:ss"/></td>
                    <td><fmt:formatDate value="${r.dueTime}" pattern="yyyy年MM月dd日 HH:mm:ss"/></td>
                    <td>
                        <c:choose>
                            <c:when test="${r.returnTime != null}">
                                <fmt:formatDate value="${r.returnTime}" pattern="yyyy年MM月dd日 HH:mm:ss"/>
                            </c:when>
                            <c:otherwise>未归还</c:otherwise>
                        </c:choose>
                    </td>
                    <td>
                        <c:choose>
                            <c:when test="${r.status == 0}">借出中</c:when>
                            <c:when test="${r.status == 1}">已归还</c:when>
                            <c:otherwise>其他状态</c:otherwise>
                        </c:choose>
                    </td>
                    <td>
                        <!-- 只有status=0时，才显示"归还"和"续借"按钮 -->
                        <c:if test="${r.status == 0}">
                            <!-- 归还 -->
                            <form action="borrow_return" method="post" style="display:inline;">
                                <input type="hidden" name="borrowId" value="${r.id}" />
                                <input type="submit" class="btn btn-danger btn-sm" value="归还" />
                            </form>
                            <!-- 续借 -->
                            <form action="borrow_extend" method="post" style="display:inline; margin-left:5px;">
                                <input type="hidden" name="borrowId" value="${r.id}" />
                                <input type="number" name="extraDays" value="7" min="1"
                                       class="form-control input-sm" style="width:60px; display:inline;" />
                                <input type="submit" class="btn btn-info btn-sm" value="续借" />
                            </form>
                        </c:if>
                    </td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
    </div>

    <!-- ================== 提示信息 ================== -->
    <c:if test="${not empty message}">
    <script>
        Swal.fire({
            icon: 'success',
            title: '${message}',
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
