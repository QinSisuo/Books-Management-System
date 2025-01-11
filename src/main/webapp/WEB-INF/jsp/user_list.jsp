<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>用户管理</title>
    <link rel="stylesheet" href="/css/bootstrap.min.css">
</head>
<body>
<div class="container">
    <h1>用户管理</h1>

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
            <th>操作</th>
        </tr>
        </thead>
        <tbody>
        <c:if test="${empty users}">
                <tr>
                    <td colspan="7" class="text-center">暂无用户数据</td>
                </tr>
        </c:if>
        <!-- 使用 JSTL 循环显示用户 -->
        <c:forEach var="user" items="${users}">
            <tr>
                <td>${user.userId}</td>
                <td>${user.username}</td>
                <td>${user.role}</td>
                <td>${user.email}</td>
                <td>${user.phone}</td>
                <td>${user.address}</td>
                <td>
                    <!-- 删除按钮 -->
                    <a href="/admin/user/delete?userId=${user.userId}" class="btn btn-danger btn-sm">删除</a>
                </td>
            </tr>
        </c:forEach>
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
                            <option value="ADMIN">管理员</option>
                            <option value="READER">读者</option>
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

<script src="/js/jquery-3.2.1.js"></script>
<script src="/js/bootstrap.min.js"></script>
</body>
</html>
