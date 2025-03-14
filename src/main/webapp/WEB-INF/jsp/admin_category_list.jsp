<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html lang="zh-CN">
<head>
    <title>图书分类管理</title>
    <meta charset="UTF-8">
    <!-- 引入外部 CSS -->
    <link rel="stylesheet" href="css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@11.0.19/dist/sweetalert2.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
    <script src="js/jquery-3.2.1.js"></script>
    <script src="js/bootstrap.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11.0.19/dist/sweetalert2.min.js"></script>
</head>

<body>
<!-- 引入公共头部导航栏 -->
<%@ include file="common/header.jsp" %>
<%@ include file="common/admin_navbar.jsp" %>

<div class="container" style="margin-top: 30px;">
    <h3>📚 图书分类管理</h3>

    <!-- 添加错误消息显示 -->
    <c:if test="${not empty error}">
        <div class="alert alert-danger alert-dismissible fade show" role="alert">
            ${error}
            <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                <span aria-hidden="true">&times;</span>
            </button>
        </div>
    </c:if>
    <c:if test="${not empty succ}">
        <div class="alert alert-success alert-dismissible fade show" role="alert">
            ${succ}
            <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                <span aria-hidden="true">&times;</span>
            </button>
        </div>
    </c:if>

    <button class="btn btn-primary" data-toggle="modal" data-target="#addCategoryModal">新增分类</button>

    <table class="table table-bordered table-hover" style="margin-top:20px;">
        <thead>
            <tr>
                <th>分类ID</th>
                <th>分类名称</th>
                <th>操作</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach var="category" items="${categories}">
                <tr>
                    <td>${category.categoryId}</td>
                    <td>${category.categoryName}</td>
                    <td style="white-space: nowrap;">
                        <button type="button" class="btn btn-warning btn-sm" 
                                onclick="openEditModal('${category.categoryId}', '${category.categoryName}')">
                            编辑
                        </button>
                        <a href="<c:url value='/admin_category_delete.html?categoryId=${category.categoryId}'/>"
                           class="btn btn-danger btn-sm"
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
            <form action="<c:url value='/admin_category_add.html'/>" method="post">
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
            <form action="<c:url value='/admin_category_edit.html'/>" method="post">
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
