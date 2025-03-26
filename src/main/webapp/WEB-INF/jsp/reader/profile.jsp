<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>个人信息管理</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
    <style>
        .profile-container {
            max-width: 800px;
            margin: 30px auto;
            padding: 20px;
            background: #fff;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
        }
        .profile-header {
            text-align: center;
            margin-bottom: 30px;
        }
        .profile-avatar {
            width: 150px;
            height: 150px;
            border-radius: 50%;
            margin-bottom: 15px;
        }
        .form-group {
            margin-bottom: 20px;
        }
        .btn-save {
            width: 100%;
            padding: 10px;
            font-size: 16px;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="profile-container">
            <div class="profile-header">
                <img src="https://via.placeholder.com/150" alt="用户头像" class="profile-avatar">
                <h3>个人信息管理</h3>
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

    <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.4/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
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