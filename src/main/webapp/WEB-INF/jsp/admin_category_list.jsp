<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html lang="zh-CN">
<head>
    <title>图书分类管理</title>
    <!-- 按正确顺序引入CSS和JS文件 -->
    <link rel="stylesheet" href="<c:url value='/css/bootstrap.min.css'/>">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@11.0.19/dist/sweetalert2.min.css">
    
    <!-- 先引入jQuery，再引入Bootstrap JS -->
    <script src="<c:url value='/js/jquery-3.2.1.js'/>"></script>
    <script src="<c:url value='/js/bootstrap.min.js'/>"></script>
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
                        <button type="button" class="btn btn-warning btn-sm edit-category" 
                                data-toggle="modal" 
                                data-target="#editCategoryModal"
                                data-id="${category.categoryId}" 
                                data-name="${category.categoryName}">
                            编辑
                        </button>
                        <a href="<c:url value='/admin_category_delete.html?categoryId=${category.categoryId}'/>"
                           class="btn btn-danger btn-sm"
                           onclick="return confirm('确定删除该分类吗？')">
                           删除
                        </a>
                    </td>
                </tr>
            </c:forEach>
        </tbody>
    </table>
</div>

<!-- 新增分类模态框 -->
<div class="modal fade" id="addCategoryModal" tabindex="-1">
  <div class="modal-dialog">
    <div class="modal-content">
        <form action="<c:url value='/admin_category_add.html'/>" method="post">
            <div class="modal-header">
                <h5 class="modal-title">新增图书分类</h5>
                <button type="button" class="close" data-dismiss="modal">&times;</button>
            </div>
            <div class="modal-body">
                <input class="form-control" name="categoryName" placeholder="输入分类名" required>
            </div>
            <div class="modal-footer">
                <button type="submit" class="btn btn-primary">提交</button>
                <button type="button" class="btn btn-secondary" data-dismiss="modal">关闭</button>
            </div>
        </form>
    </div>
</div>
<div class="modal fade" id="editCategoryModal">
    <div class="modal-dialog">
        <div class="modal-content">
            <form action="<c:url value='/admin_category_edit.html'/>" method="post">
                <div class="modal-header">
                    <h5 class="modal-title">编辑分类</h5>
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                </div>
                <div class="modal-body">
                    <input type="hidden" name="categoryId" id="editCategoryId">
                    <input class="form-control" name="categoryName" id="editCategoryName" required>
                </div>
                <div class="modal-footer">
                    <button type="submit" class="btn btn-primary">保存</button>
                    <button type="button" class="btn btn-secondary" data-dismiss="modal">取消</button>
                </div>
            </form>
        </div>
    </div>
</div>

<!-- 自动填充模态框数据 -->
<script>
    $(document).ready(function() {
        // 使用类选择器绑定点击事件
        $('.edit-category').on('click', function() {
            let categoryId = $(this).data('id');
            let categoryName = $(this).data('name');
            $('#editCategoryId').val(categoryId);
            $('#editCategoryName').val(categoryName);
            $('#editCategoryModal').modal('show');
        });
        
        // 添加调试代码
        console.log('Document ready executed');
        $('.edit-category').each(function() {
            console.log('Found edit button:', $(this).data('id'));
        });
    });
</script>

</body>
</html>
