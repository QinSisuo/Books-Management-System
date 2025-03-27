<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <title>图书标签管理</title>
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

        <!-- 统一搜索框 -->
        <div class="container" style="margin-top: 20px; margin-bottom: 20px; max-width: 600px; margin-left: -15px;">
            <form action="admin_tag_manage.html" method="post" class="form-inline">
                <div class="form-group">
                    <input type="text" class="form-control" name="searchWord"
                           placeholder="输入标签名" value="${searchWord}" style="width: 300px;" />
                </div>
                &nbsp;
                <button type="submit" class="btn btn-primary">搜索</button>
            </form>
        </div>

        <!-- 标题和新增按钮 -->
        <div class="panel panel-default">
            <div class="panel-heading bg-white">
                <div class="row align-items-center">
                    <div class="col-md-6">
                        <h3 class="panel-title mb-0">标签管理</h3>
                    </div>
                    <div class="col-md-6 text-right">
                        <button class="btn btn-primary" data-toggle="modal" data-target="#addTagModal">
                            <i class="fas fa-plus"></i> 新增标签
                        </button>
                    </div>
                </div>
            </div>
        </div>

        <!-- 显示列表 -->
        <table class="table table-hover">
            <thead>
            <tr>
                <th style="width: 30%">标签ID</th>
                <th style="width: 60%">标签名称</th>
                <th style="width: 10%">操作</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach items="${tags}" var="tag">
                <tr>
                    <td>${tag.id}</td>
                    <td>${tag.name}</td>
                    <td>
                        <button type="button" class="btn btn-info btn-xs"
                                onclick="editTag(${tag.id}, '${tag.name}', '${tag.status}')">
                            编辑
                        </button>
                        <button type="button" class="btn btn-danger btn-xs"
                                onclick="deleteTag(${tag.id})">
                            删除
                        </button>
                    </td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
    </div>


<!-- 新增标签模态框 -->
<div class="modal fade" id="addTagModal" tabindex="-1" role="dialog">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h4 class="modal-title">新增标签</h4>
            </div>
            <div class="modal-body">
                <form id="addTagForm" method="post">
                    <div class="form-group">
                        <label>标签名称</label>
                        <input type="text" class="form-control" name="name" required>
                    </div>
                    <div class="form-group">
                        <label>状态</label>
                        <select class="form-control" name="status">
                            <option value="0">正常</option>
                            <option value="1">停用</option>
                        </select>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button type="button" class="btn btn-primary" onclick="submitAddTag()">保存</button>
            </div>
        </div>
    </div>
</div>

<!-- 编辑标签模态框 -->
<div class="modal fade" id="editTagModal" tabindex="-1" role="dialog">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h4 class="modal-title">编辑标签</h4>
            </div>
            <div class="modal-body">
                <form id="editTagForm" method="post">
                    <input type="hidden" name="id" id="editTagId">
                    <div class="form-group">
                        <label>标签名称</label>
                        <input type="text" class="form-control" name="name" id="editTagName" required>
                    </div>
                    <div class="form-group">
                        <label>状态</label>
                        <select class="form-control" name="status" id="editTagStatus">
                            <option value="0">正常</option>
                            <option value="1">停用</option>
                        </select>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button type="button" class="btn btn-primary" onclick="submitEditTag()">保存</button>
            </div>
        </div>
    </div>
</div>

<script>
function submitAddTag() {
    var formData = $("#addTagForm").serialize();
    
    $.ajax({
        url: "admin_tag_add.html",
        type: "POST",
        data: formData,
        dataType: "json",
        success: function(response) {
            if(response.success) {
                alert("添加成功！");
                $('#addTagModal').modal('hide');
                location.href = 'admin_tag_manage.html';
            } else {
                // 显示具体的错误信息
                alert(response.message || "添加失败，请重试！");
            }
        },
        error: function(xhr, status, error) {
            alert("系统错误，请重试！");
        }
    });
}

function editTag(id, name, status) {
    $('#editTagId').val(id);
    $('#editTagName').val(name);
    $('#editTagStatus').val(status);
    $('#editTagModal').modal('show');
}

function submitEditTag() {
    var formData = $("#editTagForm").serialize();
    window.location.href = 'admin_tag_edit.html?' + formData;
}

function deleteTag(id) {
    if(confirm('确定要删除这个标签吗？')) {
        window.location.href = 'admin_tag_delete.html?id=' + id;
    }
}

// 添加模态框关闭后清空表单
$('#addTagModal').on('hidden.bs.modal', function () {
    $('#addTagForm')[0].reset();
});

// 编辑模态框关闭后清空表单
$('#editTagModal').on('hidden.bs.modal', function () {
    $('#editTagForm')[0].reset();
});
</script>
</body>
</html>