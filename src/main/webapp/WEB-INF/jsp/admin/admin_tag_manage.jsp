<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>标签管理</title>
    <link rel="stylesheet" href="css/bootstrap.min.css">
    <script src="js/jquery-3.2.1.js"></script>
    <script src="js/bootstrap.min.js"></script>
</head>
<body>
<%@include file="admin_header.jsp"%>

<div style="position: relative;padding-top: 100px">
    <div class="panel panel-default">
        <div class="panel-heading">
            <h3 class="panel-title">标签管理</h3>
        </div>
        <div class="panel-body">
            <div class="row">
                <div class="col-xs-12">
                    <div class="row">
                        <div class="col-xs-8">
                            <form method="post" action="admin_tag_manage.html" class="form-inline" id="searchForm">
                                <input type="text" placeholder="输入标签名" class="form-control" id="searchWord" name="searchWord">
                                <button type="submit" class="btn btn-default">搜索</button>
                            </form>
                        </div>
                        <div class="col-xs-4">
                            <button type="button" class="btn btn-primary" data-toggle="modal" data-target="#addTagModal">
                                新增标签
                            </button>
                        </div>
                    </div>
                </div>
            </div>
            <table class="table table-hover">
                <thead>
                <tr>
                    <th>标签名称</th>
                    <th>状态</th>
                    <th>使用次数</th>
                    <th>搜索次数</th>
                    <th>借阅次数</th>
                    <th>热度得分</th>
                    <th>操作</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach items="${tags}" var="tag">
                    <tr>
                        <td>${tag.name}</td>
                        <td>${tag.status == '0' ? '正常' : '停用'}</td>
                        <td>${tag.useCount}</td>
                        <td>${tag.searchCount}</td>
                        <td>${tag.borrowCount}</td>
                        <td>${tag.hotScore}</td>
                        <td>
                            <button type="button" class="btn btn-info btn-xs" onclick="editTag(${tag.id}, '${tag.name}', '${tag.status}')">编辑</button>
                            <button type="button" class="btn btn-danger btn-xs" onclick="deleteTag(${tag.id})">删除</button>
                        </td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
        </div>
    </div>
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
        success: function(response) {
            if(response.success) {
                alert("添加成功！");
                $('#addTagModal').modal('hide');
                // 刷新页面
                window.location.reload();
            } else {
                alert("添加失败，请重试！");
            }
        },
        error: function() {
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