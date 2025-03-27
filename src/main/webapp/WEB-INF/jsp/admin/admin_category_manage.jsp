<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <title>图书分类管理</title>
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
    <%@ include file="../common/admin_navbar.jsp" %>
    <%@ include file="../common/footer.jsp" %>

    <!-- 统一面板 -->
    <div class="container">

        <!-- 统一搜索框 -->
        <div class="container" style="margin-top: 20px; margin-bottom: 20px; max-width: 600px; margin-left: -15px;">
            <form action="admin_category_manage.html" method="get" class="form-inline">
                <div class="form-group">
                    <input type="text" class="form-control" name="searchWord"
                           placeholder="输入搜索关键词" value="${searchWord}" style="width: 300px;" />
                </div>
                &nbsp;
                <button type="submit" class="btn btn-primary">搜索</button>
            </form>
        </div>

        <!-- Loading 指示器 -->
        <div class="loading" style="display:none;">
            <div class="spinner-border text-primary" role="status">
                <span class="sr-only">加载中...</span>
            </div>
        </div>

        <!-- 显示成功或错误信息（默认隐藏） -->
        <div id="messageContainer" class="container" style="display: none;">
            <c:if test="${!empty succ}">
                <div class="alert alert-success alert-dismissable fade show">
                    <button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button>
                        ${succ}
                </div>
            </c:if>
            <c:if test="${!empty error}">
                <div class="alert alert-danger alert-dismissable fade show">
                    <button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button>
                        ${error}
                </div>
            </c:if>
        </div>

        <!-- 标题和新增按钮 -->
        <div class="panel panel-default">
            <div class="panel-heading bg-white">
                <div class="row align-items-center">
                    <div class="col-md-6">
                        <h3 class="panel-title mb-0">📚 图书分类管理</h3>
                    </div>
                    <div class="col-md-6 text-right">
                        <button class="btn btn-primary" data-toggle="modal" data-target="#addCategoryModal">
                            <i class="fas fa-plus"></i> 新增分类
                        </button>
                    </div>
                </div>
            </div>
        </div>

        <table class="table table-hover">
            <thead>
            <tr>
                <th style="width: 40%">分类ID</th>
                <th style="width: 50%">分类名称</th>
                <th style="width: 10%">操作</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach var="category" items="${categories}">
                <tr>
                    <td>${category.categoryId}</td>
                    <td>${category.categoryName}</td>
                    <td>
                        <button type="button" class="btn btn-info btn-xs"
                                onclick="openEditModal('${category.categoryId}', '${category.categoryName}')">
                            编辑
                        </button>
                        <a href="<c:url value='/admin_category_delete.html?categoryId=${category.categoryId}'/>"
                           class="btn btn-danger btn-xs"
                           onclick="return confirm('确定删除分类【${category.categoryName}】吗？')">
                            删除
                        </a>
                    </td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
    </div>

    <!-- 新增分类模态框 -->
    <div class="modal fade" id="addCategoryModal" tabindex="-1" role="dialog" aria-labelledby="addModalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <form action="admin_category_add.html" method="post">
                    <div class="modal-header">
                        <h5 class="modal-title" id="addModalLabel">新增图书分类</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <div class="form-group">
                            <label for="categoryName">分类名称</label>
                            <input class="form-control" id="categoryName" name="categoryName" placeholder="输入分类名" required>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="submit" class="btn btn-primary">提交</button>
                        <button type="button" class="btn btn-secondary" data-dismiss="modal">关闭</button>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <!-- 编辑分类模态框 -->
    <div class="modal fade" id="editCategoryModal" tabindex="-1" role="dialog" aria-labelledby="editModalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <form action="admin_category_edit.html" method="post">
                    <div class="modal-header">
                        <h5 class="modal-title" id="editModalLabel">编辑分类</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <input type="hidden" name="categoryId" id="editCategoryId">
                        <div class="form-group">
                            <label for="editCategoryName">分类名称</label>
                            <input class="form-control" name="categoryName" id="editCategoryName" required>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="submit" class="btn btn-primary">保存</button>
                        <button type="button" class="btn btn-secondary" data-dismiss="modal">取消</button>
                    </div>
                </form>
            </div>
        </div>
    </div>

<script>

    // Loading 状态控制
    function showLoading() {
        $('.loading').css('display', 'flex');
    }

    function hideLoading() {
        $('.loading').css('display', 'none');
    }


    // 打开编辑模态框并填充数据
function openEditModal(categoryId, categoryName) {
    // 填充数据
    $('#editCategoryId').val(categoryId);
    $('#editCategoryName').val(categoryName);
    // 显示模态框
    $('#editCategoryModal').modal('show');
}

// 页面加载完成后执行
$(document).ready(function() {
    // 防止表单重复提交
    $('form').submit(function() {
        $(this).find('button[type="submit"]').prop('disabled', true);
    });
});
</script>

</body>
</html>
