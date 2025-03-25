<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <title>reader图书查询</title>
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
    <%@ include file="../common/header.jsp" %>
    <%@ include file="../common/reader_navbar.jsp" %>
    <%@ include file="../common/footer.jsp" %>

    <!-- 统一面板 -->
    <div class="container">

        <!-- 统一搜索框 -->
        <div class="container" style="margin-top: 20px; margin-bottom: 20px; max-width: 600px; margin-left: -15px;">
            <form action="reader_book_catalog.html" method="get" class="form-inline">
                <div class="form-group">
                    <input type="text" class="form-control" name="searchWord"
                           placeholder="输入搜索关键词" value="${searchWord}" style="width: 300px;" />
                </div>
                &nbsp;
                <button type="submit" class="btn btn-primary">搜索</button>
            </form>
        </div>

        <!-- 热门标签区域 -->
        <div class="panel panel-default">
            <div class="panel-heading">
                <h3 class="panel-title">热门标签</h3>
            </div>
            <div class="panel-body">
                <div class="tag-cloud" style="padding: 10px;">
                    <c:forEach items="${hotTags}" var="tag">
                        <a href="reader_book_catalog.html?tagId=${tag.id}" 
                           class="btn btn-info btn-sm" 
                           style="margin: 5px; font-size: ${12 + tag.hotScore/2}px;">
                            ${tag.name} <span class="badge badge-light">${tag.hotScore}</span>
                        </a>
                    </c:forEach>
                </div>
            </div>
        </div>

        <!-- 标题和新增按钮 -->
        <div class="panel panel-default">
            <div class="panel-heading bg-white">
                <div class="row align-items-center">
                    <div class="col-md-6">
                        <h3 class="panel-title mb-0">查询结果</h3>
                    </div>
                </div>
            </div>
        </div>

        <table class="table table-hover">
            <thead>
                <tr>
                    <th>书名</th>
                    <th>作者</th>
                    <th>出版社</th>
                    <th>ISBN</th>
                    <th>价格</th>
                    <th>可借数量</th>
                    <th>操作</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="bk" items="${books}">
                    <tr>
                        <td>${bk.name}</td>
                        <td>${bk.author}</td>
                        <td>${bk.publish}</td>
                        <td>${bk.isbn}</td>
                        <td>${bk.price}</td>
                        <td>${(bk.totalCount == null ? 0 : bk.totalCount) - (bk.lentCount == null ? 0 : bk.lentCount)}</td>

                        <!-- 操作列: 根据可借数量显示借阅按钮 -->
                        <td>
                            <!-- 详情按钮 -->
                            <form action="reader/book/detail" method="get" style="display:inline;">
                                <input type="hidden" name="id" value="${bk.bookId}" />
                                <button type="submit" class="btn btn-info btn-sm">
                                    <i class="fas fa-info-circle"></i> 详情
                                </button>
                            </form>
                            &nbsp;
                            <c:choose>
                                <c:when test="${(bk.totalCount == null ? 0 : bk.totalCount) - (bk.lentCount == null ? 0 : bk.lentCount) > 0}">
                                    <!-- 有可借数量 => 显示绿色借阅按钮 -->
                                    <form action="reader_book_borrow.html" method="post" style="display:inline;">
                                        <input type="hidden" name="bookId" value="${bk.bookId}" />
                                        <button type="submit" class="btn btn-success btn-sm">
                                            <i class="fas fa-book"></i> 借阅
                                        </button>
                                    </form>
                                </c:when>
                                <c:otherwise>
                                    <!-- 无可借数量 => 显示预约按钮 -->
                                    <form action="reader_book_reserve.html" method="post" style="display:inline;">
                                        <input type="hidden" name="bookId" value="${bk.bookId}" />
                                        <button type="submit" class="btn btn-warning btn-sm">
                                            <i class="fas fa-clock"></i> 预约
                                        </button>
                                    </form>
                                </c:otherwise>
                            </c:choose>
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </div>

    <!-- SweetAlert 提示信息 -->
    <c:if test="${not empty succ}">
        <script>
            Swal.fire({
                icon: 'success',
                title: '${succ}',
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
