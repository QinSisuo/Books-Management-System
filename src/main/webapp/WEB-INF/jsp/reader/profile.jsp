<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>个人信息管理</title>
    <link rel="stylesheet" href="css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@11.0.19/dist/sweetalert2.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
    <link href="https://cdn.jsdelivr.net/npm/select2@4.1.0-rc.0/dist/css/select2.min.css" rel="stylesheet" />
    <link href="https://cdn.jsdelivr.net/npm/select2-bootstrap-theme@0.1.0-beta.10/dist/select2-bootstrap.min.css" rel="stylesheet" />
    <script src="js/jquery-3.2.1.js"></script>
    <script src="js/bootstrap.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11.0.19/dist/sweetalert2.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/select2@4.1.0-rc.0/dist/js/select2.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.4/dist/umd/popper.min.js"></script>
    <style>
        body {
            background-color: #f8f9fa;
        }
        .main-container {
            padding: 20px 0;
        }
        .profile-container {
            background: #fff;
            border-radius: 8px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
            padding: 20px;
        }
        .profile-header {
            text-align: center;
            margin-bottom: 30px;
            padding-bottom: 20px;
            border-bottom: 1px solid #eee;
        }
        .form-group {
            margin-bottom: 20px;
        }
        .form-group label {
            font-weight: 500;
            color: #495057;
        }
        .form-control {
            border-radius: 4px;
            border: 1px solid #ced4da;
        }
        .form-control:focus {
            border-color: #80bdff;
            box-shadow: 0 0 0 0.2rem rgba(0,123,255,.25);
        }
        .btn-save {
            width: 100%;
            padding: 10px;
            font-size: 16px;
            background-color: #007bff;
            border-color: #007bff;
        }
        .btn-save:hover {
            background-color: #0069d9;
            border-color: #0062cc;
        }
        .page-title {
            color: #333;
            margin-bottom: 20px;
            font-weight: 500;
        }
    </style>
</head>
<body>
    <!-- 引入公共头部: 包含CSS/JS等 -->
    <%@ include file="../common/header.jsp" %>
    <%@ include file="../common/reader_navbar.jsp" %>
    
    <div class="container main-container">
        <div class="row">
            <div class="col-md-8 offset-md-2">
                <div class="profile-container">
                    <div class="profile-header">
                        <h4 class="page-title">个人信息管理</h4>
                    </div>
                    
                    <form id="profileForm" action="/reader/profile/update" method="post">
                        <input type="hidden" name="userId" value="${user.userId}">
                        
                        <div class="form-group">
                            <label for="username">用户名</label>
                            <input type="text" class="form-control" id="username" name="username" value="${user.username}" readonly>
                        </div>
                        
                        <div class="form-group">
                            <label for="email">邮箱</label>
                            <input type="email" class="form-control" id="email" name="email" value="${user.email}">
                        </div>
                        
                        <div class="form-group">
                            <label for="phone">电话</label>
                            <input type="tel" class="form-control" id="phone" name="phone" value="${user.phone}">
                        </div>
                        
                        <div class="form-group">
                            <label for="address">地址</label>
                            <input type="text" class="form-control" id="address" name="address" value="${user.address}">
                        </div>
                        
                        <div class="form-group">
                            <label for="newPassword">新密码（留空则不修改）</label>
                            <input type="password" class="form-control" id="newPassword" name="newPassword">
                        </div>
                        
                        <div class="form-group">
                            <label for="confirmPassword">确认新密码</label>
                            <input type="password" class="form-control" id="confirmPassword" name="confirmPassword">
                        </div>
                        
                        <button type="submit" class="btn btn-primary btn-save">
                            <i class="fas fa-save"></i> 保存修改
                        </button>
                    </form>
                </div>
            </div>
        </div>
    </div>

    <script>
        $(document).ready(function() {
            $('#profileForm').on('submit', function(e) {
                e.preventDefault();
                
                var newPassword = $('#newPassword').val();
                var confirmPassword = $('#confirmPassword').val();
                
                if (newPassword && newPassword !== confirmPassword) {
                    alert('两次输入的密码不一致！');
                    return;
                }
                
                $.ajax({
                    url: '/reader/profile/update',
                    type: 'POST',
                    data: $(this).serialize(),
                    success: function(response) {
                        if (response.success) {
                            alert('个人信息更新成功！');
                            $('#newPassword').val('');
                            $('#confirmPassword').val('');
                        } else {
                            alert('更新失败：' + response.message);
                        }
                    },
                    error: function() {
                        alert('更新失败，请稍后重试！');
                    }
                });
            });
        });
    </script>
</body>
</html> 