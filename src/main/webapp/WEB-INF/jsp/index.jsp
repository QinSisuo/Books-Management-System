<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>图书馆登录</title>
    <link rel="stylesheet" href="/static/css/bootstrap.min.css">
    <script src="/static/js/jquery-3.2.1.js"></script>
    <script src="/static/js/bootstrap.min.js"></script>
    <script src="/static/js/js.cookie.js"></script>
    <style>
        #login {
            width: 350px;
            margin: 100px auto;
            padding: 20px;
            border: 1px solid #ddd;
            border-radius: 5px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }
        #info {
            color: red;
            text-align: center;
        }
    </style>
</head>
<body>
<div id="login">
    <h3 style="text-align: center;">图书馆登录</h3>
    <div class="form-group">
        <label for="username">用户名</label>
        <input type="text" class="form-control" id="username" placeholder="请输入用户名">
    </div>
    <div class="form-group">
        <label for="password">密码</label>
        <input type="password" class="form-control" id="password" placeholder="请输入密码">
    </div>
    <div class="form-group">
        <div class="checkbox">
            <label>
                <input type="checkbox" id="remember"> 记住我
            </label>
        </div>
    </div>
    <p id="info"></p>
    <button id="loginButton" class="btn btn-primary btn-block">登录</button>
</div>

<script>
    $(document).ready(function () {
        // 从 Cookie 设置登录状态
        function setLoginStatus() {
            var loginStatusText = Cookies.get('loginStatus');
            if (loginStatusText) {
                try {
                    var loginStatus = JSON.parse(loginStatusText);
                    $('#username').val(loginStatus.username);
                    $('#password').val(loginStatus.password);
                    $('#remember').prop('checked', true);
                } catch (e) {
                    console.error("读取登录状态失败: ", e);
                }
            }
        }

        // 点击登录按钮时触发
        $("#loginButton").click(function () {
            var username = $("#username").val().trim();
            var password = $("#password").val().trim();
            var remember = $("#remember").prop("checked");

            // 表单校验
            if (username === "" || password === "") {
                $("#info").text("提示: 用户名或密码不能为空");
                return;
            }

            // 发起 Ajax 请求
            $.ajax({
                type: "POST",
                url: "/api/loginCheck",
                data: { username: username, password: password },
                success: function (data) {
                    if (data.stateCode === "1") {
                        alert("管理员登录成功！");
                        if (remember) {
                            Cookies.set("loginStatus", JSON.stringify({ username: username, password: password }), { expires: 30 });
                        } else {
                            Cookies.remove("loginStatus");
                        }
                        window.location.href = "/admin_main.html"; // 管理员页面
                    } else if (data.stateCode === "2") {
                        alert("读者登录成功！");
                        if (remember) {
                            Cookies.set("loginStatus", JSON.stringify({ username: username, password: password }), { expires: 30 });
                        } else {
                            Cookies.remove("loginStatus");
                        }
                        window.location.href = "/reader_main.html"; // 读者页面
                    } else {
                        $("#info").text(data.msg);
                    }
                },
                error: function () {
                    alert("登录失败，请稍后重试！");
                }
            });
        });

        // 初始化登录状态
        setLoginStatus();
    });
</script>
</body>
</html>
