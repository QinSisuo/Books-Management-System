<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<meta charset="UTF-8">
<html>
<head>

<style>
    /* 基础样式 */
    .navbar-nav .dropdown > a:before {
        content: none !important;
    }

    /* 导航栏容器样式 */
    .navbar-content {
        display: flex;
        align-items: flex-end;
        width: 100%;
        margin-bottom: 0;
        padding-bottom: 0;
    }

    /* 导航菜单样式 */
    .nav-menu {
        flex-grow: 1;
        display: flex;
        justify-content: flex-end;
        margin-bottom: 0;
        padding-bottom: 0;
        margin-left: -15px;  /* 调整整个菜单向左偏移，减少与标题的距离 */
    }

    /* 用户部分样式 */
    .user-section {
        display: flex;
        align-items: flex-end;
        margin-bottom: 0;
        padding-bottom: 0;
    }

    /* 移除所有导航元素的底部边距 */
    .navbar-nav, .navbar-nav .nav-item, .navbar-nav .nav-link, .navbar-brand, .navbar-brand h1 {
        margin-bottom: 0;
        padding-bottom: 0;
    }

    /* 导航栏列表样式 */
    .navbar-nav {
        list-style-type: none;
        display: flex;
        align-items: flex-end;
        margin-left: 0;
    }

    /* 确保所有导航元素在底端对齐 */
    .navbar-nav .nav-item .nav-link, .navbar-brand, .navbar-brand h1 {
        display: flex;
        align-items: flex-end;
        line-height: 1;
    }

    /* 品牌标题样式 */
    .navbar-brand {
        margin-bottom: 0;
        padding-bottom: 0;
        display: flex;
        align-items: flex-end;
    }

    /* 标题样式 - 减小右侧边距 */
    .navbar-brand h1 {
        margin-bottom: 0;
        padding-bottom: 0;
        line-height: 1;
        margin-right: -10px;  /* 减小右侧边距，与用户管理更接近 */
    }

    /* 欢迎文本样式 */
    .welcome-text {
        line-height: 1;
    }

    /* 导航项间距 */
    .navbar-nav .nav-item:first-child {
        margin-left: -5px;  /* 第一个导航项左移，更贴近标题 */
    }

    .navbar-nav .nav-item {
        margin-left: 10px;
    }

    /* 下拉菜单项样式 */
    .dropdown-menu {
        margin-top: 0;
        padding-top: 0;
    }

    .dropdown-menu a {
        padding-top: 5px;
        padding-bottom: 5px;
    }

    /* 覆盖Bootstrap默认样式 */
    .navbar-nav .nav-link {
        padding-top: 0.5rem;
        padding-bottom: 0;
        margin-bottom: 0;
        display: flex;
        align-items: flex-end;
    }

    .btn-outline-danger {
        padding-top: 0.25rem;
        padding-bottom: 0;
        display: flex;
        align-items: flex-end;
        line-height: 1;
    }

    /* 登出按钮样式 */
    .nav-link.btn-outline-danger {
        margin-bottom: 0;
    }

    /* 响应式布局样式 */
    @media (max-width: 992px) {
        .navbar-content {
            flex-direction: column;
            align-items: flex-start;
        }

        .nav-menu, .user-section {
            width: 100%;
            justify-content: flex-start;
            margin-left: 0;
        }

        .navbar-nav .nav-item .nav-link, .navbar-brand, .navbar-brand h1 {
            align-items: flex-start;
            padding-bottom: 0;
        }

        .navbar-brand h1 {
            margin-right: 0;
        }

        .navbar-nav .nav-item {
            margin-left: 0;
        }

        .dropdown-menu {
            margin-top: 0;
            padding-top: 0;
        }
    }
</style>

<nav class="navbar navbar-expand-lg navbar-light bg-light">
    <div class="container">
        <!-- 创建一个新的父容器来包裹所有内容，设置为 flex 布局并在底端对齐 -->
        <div class="navbar-content">
            <!-- 图书管理系统标题 -->
            <a class="navbar-brand" href="admin_main.html">
                <h1>图书管理系统</h1>
            </a>

            <!-- 菜单项 -->
            <div class="nav-menu">
                <ul class="navbar-nav">
                    <li class="nav-item dropdown">
                        <a href="#" class="nav-link dropdown-toggle" data-toggle="dropdown">
                            用户管理
                        </a>
                        <ul class="dropdown-menu">
                            <li><a href="admin_all_users.html">全部用户</a></li>
                            <li class="dropdown-divider"></li>
                            <li><a href="admin_user_add.html">新增用户</a></li>
                        </ul>
                    </li>
                    <li class="nav-item dropdown">
                        <a href="#" class="nav-link dropdown-toggle" data-toggle="dropdown">
                            图书管理
                        </a>
                        <ul class="dropdown-menu">
                            <li><a href="admin_book_all.html">全部图书</a></li>
                            <li class="dropdown-divider"></li>
                            <li><a href="admin_book_add.html">增加图书</a></li>
                        </ul>
                    </li>
                    <li class="nav-item dropdown">
                        <a href="#" class="nav-link dropdown-toggle" data-toggle="dropdown">
                            借阅管理
                        </a>
                        <ul class="dropdown-menu">
                            <li><a href="lendlist.html">借还日志</a></li>
                        </ul>
                    </li>
                    <li class="nav-item dropdown">
                        <a href="#" class="nav-link dropdown-toggle" data-toggle="dropdown">
                            数据分析和统计
                        </a>
                        <ul class="dropdown-menu">
                            <li><a href="lendlist.html">借阅统计</a></li>
                            <li><a href="${pageContext.request.contextPath}/user-behavior-analysis.html">用户行为分析</a></li>
                            <li><a href="system-logs-and-operation-records.html">系统日志和操作记录</a></li>
                        </ul>
                    </li>
                </ul>
            </div>

            <!-- 用户名和退出按钮区域 -->
            <div class="user-section">
                <ul class="navbar-nav">
                    <li class="nav-item">
                        <span class="nav-link welcome-text">admin：${user.username}</span>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link btn btn-outline-danger btn-sm ml-2" href="logout">退出</a>
                    </li>
                </ul>
            </div>
        </div>
    </div>
</nav>

</head>
</html>