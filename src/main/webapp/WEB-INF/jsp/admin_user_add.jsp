<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>添加用户</title>
    <link rel="stylesheet" href="/css/bootstrap.min.css">
</head>
<body>
    <%@ include file="common/header.jsp" %>
    <%@ include file="common/navbar.jsp" %>
<div class="container">
    <h3 class="panel-title text-center mt-4">添加用户</h3>

    <form action="/admin/user/add" method="post" id="userForm">
        <div class="form-group">
            <label for="username">用户名</label>
            <input type="text" class="form-control" id="username" name="username" required>
            <small class="text-danger d-none" id="usernameError">用户名不能为空</small>
        </div>

        <div class="form-group">
            <label for="password">密码</label>
            <input type="password" class="form-control" id="password" name="password" required>
        </div>

        <div class="form-group">
            <label for="role">角色</label>
            <select class="form-control" id="role" name="role" required>
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


        <div class="form-group text-center">
            <button type="submit" class="btn btn-success">保存</button>
            <a href="/admin_all_users.html" class="btn btn-outline-secondary">取消</a>
        </div>
    </form>
</div>

<!-- JavaScript 依赖 -->
<script src="/js/jquery-3.2.1.js"></script>
<script src="/js/bootstrap.min.js"></script>

<script>
    $(document).ready(function() {
        $("#userForm").submit(function(e) {
            e.preventDefault();  // 阻止表单默认提交

            let username = $("#username").val().trim();
            let password = $("#password").val().trim();
            let email = $("#email").val().trim();
            let phone = $("#phone").val().trim();

            if (username === "" || password === "") {
                alert("用户名和密码不能为空！");
                return;
            }
            if (email !== "" && !/^\S+@\S+\.\S+$/.test(email)) {
                alert("请输入有效的邮箱地址！");
                return;
            }
            if (phone !== "" && !/^\d{10,15}$/.test(phone)) {
                alert("请输入有效的电话号码！");
                return;
            }

            $.ajax({
                type: "POST",
                url: "/admin/user/add",
                data: $(this).serialize(),
                success: function(response) {
                    alert("用户添加成功！");
                    window.location.href = "/admin_all_users.html";
                },
                error: function() {
                    alert("添加失败，请检查输入！");
                }
            });
        });
    });
</script>

</body>
</html>