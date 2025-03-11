<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>读者主页</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/bootstrap.min.css">
    <style>
        body {
            background-color: rgb(240,242,245);
            margin-bottom: 70px;
        }
        .container { 
            margin-top: 50px; 
        }
        .navbar-nav .nav-item { 
            margin-right: 20px; 
        }
        .navbar-brand { 
            font-weight: bold; 
            font-size: 24px; 
        }
        .navbar-nav .nav-link { 
            font-size: 18px; 
        }
        .navbar .btn-outline-danger { 
            font-size: 16px; 
            padding: 5px 15px; 
        }
    </style>
</head>

<body>
    <%@ include file="common/header.jsp" %>

    <nav class="navbar navbar-default" role="navigation">
        <div class="container">
            <div class="navbar-header">
                <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#reader-navbar">
                    <span class="sr-only">切换导航</span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                </button>
                <a class="navbar-brand" href="reader_main.html">我的图书馆</a>
            </div>

            <div class="collapse navbar-collapse" id="reader-navbar">
                <ul class="nav navbar-nav">
                    <li class="active">
                        <a href="reader_querybook.html">
                            <span class="glyphicon glyphicon-search"></span> 图书查询
                        </a>
                    </li>
                    <li>
                        <a href="reader_info.html">
                            <span class="glyphicon glyphicon-user"></span> 个人信息
                        </a>
                    </li>
                    <li>
                        <a href="mylend.html">
                            <span class="glyphicon glyphicon-book"></span> 我的借还
                        </a>
                    </li>
                    <li>
                        <a href="reader_repasswd.html">
                            <span class="glyphicon glyphicon-lock"></span> 密码修改
                        </a>
                    </li>
                </ul>
                <ul class="nav navbar-nav navbar-right">
                    <li>
                        <a href="reader_info.html">
                            <span class="glyphicon glyphicon-user"></span> ${user.username}，已登录
                        </a>
                    </li>
                    <li>
                        <a href="logout">
                            <span class="glyphicon glyphicon-log-out"></span> 退出
                        </a>
                    </li>
                </ul>
            </div>
        </div>
    </nav>

    <div class="container">
        <div class="jumbotron">
            <h2>欢迎来到智悦书屋</h2>
            <p>在这里，您可以：</p>
            <ul>
                <li>查询和借阅图书</li>
                <li>管理个人借阅记录</li>
                <li>更新个人信息</li>
                <li>修改账户密码</li>
            </ul>
        </div>
    </div>

    <div class="container">
        <div class="row">
            <div class="col-md-4">
                <div class="panel panel-primary">
                    <div class="panel-heading">
                        <h3 class="panel-title">图书查询</h3>
                    </div>
                    <div class="panel-body">
                        快速查找您感兴趣的图书，了解图书详情和借阅状态。
                    </div>
                </div>
            </div>
            <div class="col-md-4">
                <div class="panel panel-success">
                    <div class="panel-heading">
                        <h3 class="panel-title">借阅管理</h3>
                    </div>
                    <div class="panel-body">
                        查看您的借阅历史，管理当前借阅的图书。
                    </div>
                </div>
            </div>
            <div class="col-md-4">
                <div class="panel panel-info">
                    <div class="panel-heading">
                        <h3 class="panel-title">个人中心</h3>
                    </div>
                    <div class="panel-body">
                        更新个人信息，修改账户密码，确保账户安全。
                    </div>
                </div>
            </div>
        </div>
    </div>

    <%@ include file="common/footer.jsp" %>

    <script src="${pageContext.request.contextPath}/js/jquery-3.2.1.js"></script>
    <script src="${pageContext.request.contextPath}/js/bootstrap.min.js"></script>
</body>
</html>
