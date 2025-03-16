<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>标签管理</title>
    <link rel="stylesheet" href="css/bootstrap.min.css">
    <script src="js/jquery-3.2.1.js"></script>
    <script src="js/bootstrap.min.js"></script>
</head>
<body>
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
                        <button type="button" class="btn btn-info btn-xs" onclick="editTag(${tag.id})">编辑</button>
                        <button type="button" class="btn btn-danger btn-xs" onclick="deleteTag(${tag.id})">删除</button>
                    </td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
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
                <form id="addTagForm">
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

<script>
function editTag(id) {
    // 实现编辑功能
}

function deleteTag(id) {
    if(confirm('确定要删除这个标签吗？')) {
        window.location.href = 'admin_tag_delete.html?id=' + id;
    }
}

function submitAddTag() {
    var form = $('#addTagForm');
    $.ajax({
        url: 'admin_tag_add.html',
        type: 'POST',
        data: form.serialize(),
        success: function(response) {
            $('#addTagModal').modal('hide');
            location.reload();
        }
    });
}
</script>
</body>
</html> 