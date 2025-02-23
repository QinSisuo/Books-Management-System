<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<%@ include file="common/header.jsp" %>
<%@ include file="common/navbar.jsp" %>
<head>
    <meta charset="UTF-8">
    <title>用户管理</title>
    <link rel="stylesheet" href="/css/bootstrap.min.css">
</head>
<body>
<div class="container">
    <h1>用户管理</h1>

    <!-- 显示成功或错误信息 -->
    <c:if test="${not empty succ}">
        <div class="alert alert-success">${succ}</div>
    </c:if>
    <c:if test="${not empty error}">
        <div class="alert alert-danger">${error}</div>
    </c:if>

    <!-- 显示用户列表 -->
    <table class="table table-bordered">
        <thead>
        <tr>
            <th>用户ID</th>
            <th>用户名</th>
            <th>角色</th>
            <th>邮箱</th>
            <th>电话</th>
            <th>地址</th>
            <th>创建时间</th>
            <th>更新时间</th>
            <th>操作</th>
        </tr>
        </thead>
        <tbody>
        <c:choose>
            <c:when test="${not empty users}">
                <c:forEach var="user" items="${users}">
                    <tr>
                        <td>${user.userId}</td>
                        <td>${user.username}</td>
                        <td>${user.role}</td>
                        <td>${user.email}</td>
                        <td>${user.phone}</td>
                        <td>${user.address}</td>
                        <td>${user.createdAt}</td>
                        <td>${user.updatedAt}</td>
                        <td>
                            <!-- 删除按钮 -->
                            <a href="/admin/user/delete?userId=${user.userId}"
                               onclick="return confirm('确定删除用户 ${user.username} 吗？')"
                               class="btn btn-danger btn-sm">删除</a>

                            <!-- 编辑按钮 -->
                            <button type="button" class="btn btn-warning btn-sm"
                                    onclick="openEditModal('${user.userId}', '${user.username}', '${user.role}', '${user.email}', '${user.phone}', '${user.address}')">
                                编辑
                            </button>
                        </td>
                    </tr>
                </c:forEach>
            </c:when>
            <c:otherwise>
                <tr>
                    <td colspan="9" class="text-center">暂无用户数据</td>
                </tr>
            </c:otherwise>
        </c:choose>
        </tbody>
    </table>

    <!-- 新增用户按钮 -->
    <button class="btn btn-primary" data-toggle="modal" data-target="#addUserModal">新增用户</button>
</div>

<!-- 新增用户弹窗 -->
<div class="modal fade" id="addUserModal" tabindex="-1" role="dialog" aria-labelledby="addUserModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h4 class="modal-title" id="addUserModalLabel">新增用户</h4>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <form action="/admin/user/add" method="post">
                <div class="modal-body">
                    <div class="form-group">
                        <label for="username">用户名</label>
                        <input type="text" class="form-control" id="username" name="username" required>
                    </div>
                    <div class="form-group">
                        <label for="password">密码</label>
                        <input type="password" class="form-control" id="password" name="password" required>
                    </div>
                    <div class="form-group">
                        <label for="role">角色</label>
                        <select class="form-control" id="role" name="role">
                            <option value="admin">管理员</option>
                            <option value="reader">读者</option>
                        </select>
                    </div>
                    <div class="form-group">
                        <label for="email">邮箱</label>
                        <input type="email" class="form-control" id="email" name="email">
                    </div>
                    <div class="form-group">
                        <label for="phone">电话</label>
                        <input type="text" class="form-control" id="phone" name="phone">
                    </div>
                    <div class="form-group">
                        <label for="address">地址</label>
                        <input type="text" class="form-control" id="address" name="address">
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-dismiss="modal">关闭</button>
                    <button type="submit" class="btn btn-primary">保存</button>
                </div>
            </form>
        </div>
    </div>
</div>

<!-- 编辑用户弹窗 -->
<div class="modal fade" id="editUserModal" tabindex="-1" role="dialog" aria-labelledby="editUserModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h4 class="modal-title" id="editUserModalLabel">编辑用户</h4>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <form id="editUserForm" action="/admin/user/update" method="post">
                <div class="modal-body">
                    <input type="hidden" id="editUserId" name="userId">

                    <div class="form-group">
                        <label for="editUsername">用户名</label>
                        <input type="text" class="form-control" id="editUsername" name="username" required>
                    </div>

                    <div class="form-group">
                        <label for="editRole">角色</label>
                        <select class="form-control" id="editRole" name="role">
                            <option value="admin">管理员</option>
                            <option value="reader">读者</option>
                        </select>
                    </div>

                    <div class="form-group">
                        <label for="editEmail">邮箱</label>
                        <input type="email" class="form-control" id="editEmail" name="email">
                    </div>

                    <div class="form-group">
                        <label for="editPhone">电话</label>
                        <input type="text" class="form-control" id="editPhone" name="phone">
                    </div>

                    <div class="form-group">
                        <label for="editAddress">地址</label>
                        <input type="text" class="form-control" id="editAddress" name="address">
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="submit" class="btn btn-primary">保存</button>
                    <button type="button" class="btn btn-secondary" data-dismiss="modal">关闭</button>
                </div>
            </form>
        </div>
    </div>
</div>

<script>
    // 打开编辑模态框并填充用户数据
    function openEditModal(userId, username, role, email, phone, address) {
        // 将数据填充到模态框表单
        document.getElementById("editUserId").value = userId;
        document.getElementById("editUsername").value = username;
        document.getElementById("editRole").value = role;
        document.getElementById("editEmail").value = email;
        document.getElementById("editPhone").value = phone;
        document.getElementById("editAddress").value = address;

        // 显示模态框
        $('#editUserModal').modal('show');
    }

    // 提交表单时的事件处理（可选，如果使用 AJAX）
    $("#editUserForm").submit(function(e) {
        e.preventDefault();  // 阻止表单默认提交行为
        $.ajax({
            type: "POST",
            url: "/admin/user/update",
            data: $(this).serialize(),
            success: function(response) {
                alert("用户信息更新成功！");
                location.reload();  // 刷新页面
            },
            error: function() {
                alert("更新失败，请重试！");
            }
        });
    });
</script>

<script src="/js/jquery-3.2.1.js"></script>
<script src="/js/bootstrap.min.js"></script>
</body>
</html>