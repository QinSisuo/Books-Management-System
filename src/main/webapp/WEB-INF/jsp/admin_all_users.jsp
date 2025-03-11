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
            padding: 2px 8px;
            font-size: 12px;
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
        }
        .pagination {
            margin-top: 20px;
            justify-content: center;
        }
        .modal-header {
            background-color: #f8f9fa;
            border-bottom: 1px solid #dee2e6;
        }
        .modal-footer {
            background-color: #f8f9fa;
            border-top: 1px solid #dee2e6;
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
        <c:if test="${not empty succ}">
            <div class="alert alert-success alert-dismissable fade show">
                <button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button>
                ${succ}
            </div>
        </c:if>
        <c:if test="${not empty error}">
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
                    <table class="table table-hover" id="userTable">
                        <thead>
                        <tr>
                            <th data-sort="userId">用户ID <i class="fas fa-sort"></i></th>
                            <th data-sort="username">用户名 <i class="fas fa-sort"></i></th>
                            <th data-sort="role">角色 <i class="fas fa-sort"></i></th>
                            <th data-sort="email">邮箱 <i class="fas fa-sort"></i></th>
                            <th data-sort="phone">电话 <i class="fas fa-sort"></i></th>
                            <th data-sort="address">地址 <i class="fas fa-sort"></i></th>
                            <th data-sort="createdAt">创建时间 <i class="fas fa-sort"></i></th>
                            <th data-sort="updatedAt">更新时间 <i class="fas fa-sort"></i></th>
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
        // 表格排序功能
        $(document).ready(function() {
            $('th[data-sort]').click(function() {
                var column = $(this).data('sort');
                sortTable(column);
            });
        });

        function sortTable(column) {
            var table = $('#userTable');
            var rows = table.find('tbody tr').toArray();
            var isAscending = table.data('sort-' + column) !== 'asc';
            
            rows.sort(function(a, b) {
                var A = $(a).find('td').eq(getColumnIndex(column)).text();
                var B = $(b).find('td').eq(getColumnIndex(column)).text();
                return isAscending ? A.localeCompare(B) : B.localeCompare(A);
            });
            
            table.data('sort-' + column, isAscending ? 'asc' : 'desc');
            table.find('tbody').empty().append(rows);
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

        // 删除确认
        function confirmDelete(userId, username) {
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
                    window.location.href = `/admin/user/delete?userId=${userId}`;
                }
            });
            return false;
        }

        // Loading 状态控制
        function showLoading() {
            $('.loading').css('display', 'flex');
        }

        function hideLoading() {
            $('.loading').css('display', 'none');
        }

        // AJAX 表单提交优化
        $('#editUserForm').on('submit', function(e) {
            e.preventDefault();
            showLoading();
            $.ajax({
                type: 'POST',
                url: '/admin/user/update',
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
                error: function() {
                    hideLoading();
                    Swal.fire({
                        title: '错误',
                        text: '更新失败，请重试！',
                        icon: 'error'
                    });
                }
            });
        });
    </script>
</body>
</html>