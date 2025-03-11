<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>用户管理</title>
    <link rel="stylesheet" href="css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@11.0.19/dist/sweetalert2.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
    <script src="js/jquery-3.2.1.js"></script>
    <script src="js/bootstrap.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11.0.19/dist/sweetalert2.min.js"></script>
    <style>
        body {
            background-color: rgb(240,242,245);
        }
        .search-container {
            max-width: 600px;
            margin: 30px auto;
            padding: 20px;
        }
        .search-box {
            display: flex;
            align-items: center;
            background: #fff;
            border-radius: 24px;
            box-shadow: 0 2px 6px rgba(0,0,0,0.1);
            padding: 5px;
        }
        .search-input {
            flex: 1;
            border: none;
            padding: 10px 15px;
            font-size: 16px;
            outline: none;
            background: transparent;
        }
        .search-btn {
            background: #007bff;
            color: white;
            border: none;
            padding: 10px 20px;
            border-radius: 20px;
            cursor: pointer;
            transition: background-color 0.3s;
            display: flex;
            align-items: center;
            gap: 5px;
        }
        .search-btn:hover {
            background: #0056b3;
        }
        .search-btn i {
            margin-right: 5px;
        }
        .btn-xs {
            padding: 4px 10px;
            font-size: 12px;
            margin: 0 2px;
        }
        .loading {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: rgba(255,255,255,0.8);
            display: none;
            justify-content: center;
            align-items: center;
            z-index: 9999;
        }
        .table-responsive {
            margin-top: 20px;
            background: #fff;
            border-radius: 8px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
            padding: 15px;
        }
        .table {
            margin-bottom: 0;
        }
        .table th {
            border-top: none;
            font-weight: 600;
            color: #333;
            background-color: #f8f9fa;
            padding: 12px 8px;
        }
        .table td {
            padding: 12px 8px;
            vertical-align: middle;
        }
    </style>
</head>
<body>
    <%@ include file="common/header.jsp" %>
    <%@ include file="common/navbar.jsp" %>

    <!-- Loading 指示器 -->
    <div class="loading">
        <div class="spinner-border text-primary" role="status">
            <span class="sr-only">加载中...</span>
        </div>
    </div>

    <!-- 搜索框 -->
    <div class="search-container">
        <form method="post" action="queryuser.html" class="form-inline" id="searchform">
            <div class="search-box">
                <input type="text" placeholder="输入用户名" class="search-input" id="search" name="searchWord">
                <button type="submit" class="search-btn">
                    <i class="fas fa-search"></i>
                    搜索
                </button>
            </div>
        </form>
    </div>

    <!-- 显示成功或错误信息 -->
    <div class="container">
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

    <!-- 用户列表面板 -->
    <div class="container">
        <div class="panel panel-default">
            <div class="panel-heading bg-white">
                <div class="row align-items-center">
                    <div class="col-md-6">
                        <h3 class="panel-title mb-0">用户管理</h3>
                    </div>
                    <div class="col-md-6 text-right">
                        <button class="btn btn-primary" data-toggle="modal" data-target="#addUserModal">
                            <i class="fas fa-plus"></i> 新增用户
                        </button>
                    </div>
                </div>
            </div>
            <div class="panel-body">
                <div class="table-responsive">
                    <table class="table table-hover">
                        <thead>
                        <tr>
                            <th style="width: 10%">用户ID</th>
                            <th style="width: 15%">用户名</th>
                            <th style="width: 10%">角色</th>
                            <th style="width: 15%">邮箱</th>
                            <th style="width: 15%">电话</th>
                            <th style="width: 15%">地址</th>
                            <th style="width: 10%">创建时间</th>
                            <th style="width: 10%">操作</th>
                        </tr>
                        </thead>
                        <tbody>
                        <c:forEach items="${users}" var="user">
                        <tr>
                            <td title="${user.userId}"><c:out value="${user.userId}"></c:out></td>
                            <td title="${user.username}"><c:out value="${user.username}"></c:out></td>
                            <td title="${user.role}">
                                <c:if test="${user.role=='admin'}">管理员</c:if>
                                <c:if test="${user.role=='user'}">普通用户</c:if>
                            </td>
                            <td title="${user.email}"><c:out value="${user.email}"></c:out></td>
                            <td title="${user.phone}"><c:out value="${user.phone}"></c:out></td>
                            <td title="${user.address}"><c:out value="${user.address}"></c:out></td>
                            <td title="${user.createTime}"><c:out value="${user.createTime}"></c:out></td>
                            <td>
                                <button type="button" class="btn btn-info btn-xs" data-toggle="modal" data-target="#editUserModal"
                                        onclick="openEditModal('${user.userId}', '${user.username}', '${user.email}', '${user.phone}', '${user.address}', '${user.role}')">
                                    编辑
                                </button>
                                <a href="/admin/user/delete.html?userId=<c:out value="${user.userId}"></c:out>" 
                                   class="btn btn-danger btn-xs">删除</a>
                            </td>
                        </tr>
                        </c:forEach>
                        </tbody>
                    </table>
                </div>
                
                <!-- 分页 -->
                <nav aria-label="用户列表分页">
                    <ul class="pagination" id="pagination">
                        <!-- 分页内容将由JavaScript动态生成 -->
                    </ul>
                </nav>
            </div>
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
    <div class="modal fade" id="editUserModal" tabindex="-1" role="dialog" aria-labelledby="editUserModalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="editUserModalLabel">编辑用户</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <form id="editUserForm">
                    <div class="modal-body">
                        <div class="form-group">
                            <label for="userId">用户ID</label>
                            <input type="text" class="form-control" id="userId" name="userId" readonly>
                        </div>
                        <div class="form-group">
                            <label for="username">用户名</label>
                            <input type="text" class="form-control" id="username" name="username" required>
                        </div>
                        <div class="form-group">
                            <label for="email">邮箱</label>
                            <input type="email" class="form-control" id="email" name="email">
                        </div>
                        <div class="form-group">
                            <label for="phone">电话</label>
                            <input type="tel" class="form-control" id="phone" name="phone">
                        </div>
                        <div class="form-group">
                            <label for="address">地址</label>
                            <input type="text" class="form-control" id="address" name="address">
                        </div>
                        <div class="form-group">
                            <label for="role">角色</label>
                            <select class="form-control" id="role" name="role">
                                <option value="user">普通用户</option>
                                <option value="admin">管理员</option>
                            </select>
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

    <script>
        // 删除确认
        $(document).on('click', '.btn-danger', function(e) {
            if ($(this).attr('href')) {
                e.preventDefault();
                var userId = $(this).attr('href').split('userId=')[1];
                var username = $(this).closest('tr').find('td:eq(1)').text();
                
                Swal.fire({
                    title: '确认删除',
                    text: `确定要删除用户"${username}"吗？`,
                    icon: 'warning',
                    showCancelButton: true,
                    confirmButtonText: '确定',
                    cancelButtonText: '取消'
                }).then((result) => {
                    if (result.isConfirmed) {
                        showLoading();
                        window.location.href = $(this).attr('href');
                    }
                });
            }
        });

        // 编辑用户功能
        function openEditModal(userId, username, email, phone, address, role) {
            // 清空之前的数据
            $('#editUserForm')[0].reset();
            
            // 填充数据
            $('#userId').val(userId);
            $('#username').val(username);
            $('#email').val(email || '');
            $('#phone').val(phone || '');
            $('#address').val(address || '');
            $('#role').val(role || 'user');

            // 显示模态框
            $('#editUserModal').modal('show');
        }

        // AJAX 表单提交优化
        $('#editUserForm').on('submit', function(e) {
            e.preventDefault();
            showLoading();
            
            $.ajax({
                type: 'POST',
                url: '/admin/user/edit',
                data: $(this).serialize(),
                success: function(response) {
                    hideLoading();
                    Swal.fire({
                        title: '成功',
                        text: '用户信息更新成功！',
                        icon: 'success'
                    }).then(() => {
                        location.reload();
                    });
                },
                error: function(xhr) {
                    hideLoading();
                    Swal.fire({
                        title: '错误',
                        text: xhr.responseText || '更新失败，请重试！',
                        icon: 'error'
                    });
                }
            });
        });

        // Loading 状态控制
        function showLoading() {
            $('.loading').css('display', 'flex');
        }

        function hideLoading() {
            $('.loading').css('display', 'none');
        }

        // 搜索验证
        $('#searchform').on('submit', function(e) {
            var searchValue = $('#search').val().trim();
            if (searchValue === '') {
                e.preventDefault();
                Swal.fire({
                    title: '提示',
                    text: '请输入搜索关键词',
                    icon: 'warning',
                    confirmButtonText: '确定'
                });
                return false;
            }
        });
    </script>
</body>
</html>