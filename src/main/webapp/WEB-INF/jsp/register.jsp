<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>用户注册</title>
    <link rel="stylesheet" href="/static/css/bootstrap.min.css">
    <script src="/static/js/jquery-3.2.1.js"></script>
    <script src="/static/js/bootstrap.min.js"></script>
    <style>
        #register {
            width: 350px;
            margin: 100px auto;
            padding: 20px;
            border: 1px solid #ddd;
            border-radius: 5px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            background-color: #fff;
        }
        #info {
            color: red;
            text-align: center;
        }
        .form-group {
            margin-bottom: 15px;
        }
        .btn-block {
            margin-top: 10px;
        }
    </style>
</head>
<body>
<div id="register">
    <h3 style="text-align: center;">用户注册</h3>
    <form id="registerForm">
        <div class="form-group">
            <label for="username">用户名</label>
            <input type="text" class="form-control" id="username" name="username" placeholder="请输入用户名" required>
        </div>
        <div class="form-group">
            <label for="password">密码</label>
            <input type="password" class="form-control" id="password" name="password" placeholder="请输入密码" required>
        </div>
        <div class="form-group">
            <label for="confirmPassword">确认密码</label>
            <input type="password" class="form-control" id="confirmPassword" name="confirmPassword" placeholder="请再次输入密码" required>
        </div>
        <div class="form-group">
            <label for="email">邮箱</label>
            <input type="email" class="form-control" id="email" name="email" placeholder="请输入邮箱(可选)">
        </div>
        <div class="form-group">
            <label for="phone">手机号</label>
            <input type="tel" class="form-control" id="phone" name="phone" placeholder="请输入手机号(可选)">
        </div>
        <p id="info"></p>
        <button type="submit" class="btn btn-primary btn-block">注册</button>
        <div class="text-center mt-3">
            <p>已有账号？ <a href="/login.html" class="btn btn-link">返回登录</a></p>
        </div>
    </form>
</div>

<script>
$(document).ready(function() {
    $("#registerForm").submit(function(e) {
        e.preventDefault();
        
        var username = $("#username").val().trim();
        var password = $("#password").val().trim();
        var confirmPassword = $("#confirmPassword").val().trim();
        var email = $("#email").val().trim();
        var phone = $("#phone").val().trim();
        
        // 表单验证
        if (username === "" || password === "" || confirmPassword === "") {
            $("#info").text("提示：用户名和密码不能为空");
            return;
        }
        
        if (password !== confirmPassword) {
            $("#info").text("提示：两次输入的密码不一致");
            return;
        }
        
        // 发送注册请求
        $.ajax({
            type: "POST",
            url: "/api/register",
            data: {
                username: username,
                password: password,
                email: email,
                phone: phone
            },
            success: function(response) {
                if (response.success) {
                    $("#info").text("注册成功！正在跳转到登录页面...");
                    setTimeout(function() {
                        window.location.href = "/login.html";
                    }, 1500);
                } else {
                    $("#info").text(response.message || "注册失败，请重试");
                }
            },
            error: function() {
                $("#info").text("注册失败，请稍后重试");
            }
        });
    });
});
</script>
</body>
</html> 