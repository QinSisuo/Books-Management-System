<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <title>《 ${detail.name}》</title>
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
    <%@ include file="../common/admin_navbar.jsp" %>
    <%@ include file="../common/footer.jsp" %>

    <!-- 统一面板 -->
    <div class="container">

        <div class="col-xs-6 col-md-offset-3" style="position: relative;top: 10%">
            <div class="panel panel-primary">
                <div class="panel-heading">
                    <h3 class="panel-title">《 ${detail.name}》</h3>
                </div>
                <div class="panel-body">
                    <table class="table table-hover">
                        <tr>
                            <th width="15%">书名</th>
                            <td>${detail.name}</td>
                        </tr>
                        <tr>
                            <th>作者</th>
                            <td>${detail.author}</td>
                        </tr>
                        <tr>
                            <th>出版社</th>
                            <td>${detail.publish}</td>
                        </tr>
                        <tr>
                            <th>ISBN</th>
                            <td>${detail.isbn}</td>
                        </tr>
                        <tr>
                            <th>简介</th>
                            <td>${detail.introduction}</td>
                        </tr>
                        <tr>
                            <th>语言</th>
                            <td>${detail.language}</td>
                        </tr>
                        <tr>
                            <th>价格</th>
                            <td>${detail.price}</td>
                        </tr>
                        <tr>
                            <th>出版日期</th>
                            <td>${detail.pubdate}</td>
                        </tr>
                        <tr>
                            <th>分类号</th>
                            <td>${detail.classId}</td>
                        </tr>
                        <tr>
                            <th>书架号</th>
                            <td>${detail.pressmark}</td>
                        </tr>
                        <tr>
                            <th>状态</th>
                            <c:if test="${detail.state==1}">
                                <td>在馆</td>
                            </c:if>
                            <c:if test="${detail.state==0}">
                                <td>借出</td>
                            </c:if>

                        </tr>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>

</body>
</html>
