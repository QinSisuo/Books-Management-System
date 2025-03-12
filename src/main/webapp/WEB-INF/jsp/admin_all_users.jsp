<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <title>用户管理</title>
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
    <%@ include file="common/header.jsp" %>
    <%@ include file="common/admin_navbar.jsp" %>
    <%@ include file="common/footer.jsp" %>

<!-- 搜索表单：与 admin_book_list.jsp 保持一致 -->
<div class="container" style="margin-top: 20px; max-width: 600px;">
    <form action="queryuser.html" method="get" class="form-inline">
        <div class="form-group">
            <input type="text" class="form-control" name="searchWord"
                   placeholder="输入用户名" value="${searchWord}" style="width: 300px;" />
        </div>
        &nbsp;
        <button type="submit" class="btn btn-primary">搜索</button>
    </form>
</div>


    <!-- 显示成功或错误信息 -->
    <div style="position: relative;top: 10%">
        <c:if test="${not empty succ}">
            <div class="alert alert-success alert-dismissable">
                <button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button>
                ${succ}
            </div>
        </c:if>
        <c:if test="${not empty error}">
            <div class="alert alert-danger alert-dismissable">
                <button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button>
                ${error}
            </div>
        </c:if>
    </div>

    <!-- 用户列表面板 -->
    <div class="panel panel-default" style="width: 90%;margin-left: 5%">
        <div class="panel-heading" style="background-color: #fff">
            <div class="row">
                <div class="col-md-6">
                    <h3 class="panel-title">用户管理</h3>
                </div>
                <div class="col-md-6 text-right">
                    <button class="btn btn-primary btn-sm" data-toggle="modal" data-target="#addUserModal">新增用户</button>
                </div>
            </div>
        </div>
        <div class="panel-body">
            <table class="table table-hover">
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
                                    <button type="button" class="btn btn-info btn-xs"
                                            onclick="openEditModal('${user.userId}', '${user.username}', '${user.role}', '${user.email}', '${user.phone}', '${user.address}')">
                                        编辑
                                    </button>
                                    <a href="/admin/user/delete?userId=${user.userId}"
                                       onclick="return confirm('确定删除用户 ${user.username} 吗？')"
                                       class="btn btn-danger btn-xs">删除</a>
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
        </div>
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
</body>
</html>