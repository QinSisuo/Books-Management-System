<nav class="navbar navbar-default" role="navigation">
    <div class="container">
        <div class="navbar-header">
            <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#admin-navbar">
                <span class="sr-only">切换导航</span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
            </button>
            <a class="navbar-brand" href="admin_main.html">管理后台</a>
        </div>

        <div class="collapse navbar-collapse" id="admin-navbar">
            <ul class="nav navbar-nav">
                <li>
                    <a href="admin_books.html">
                        <span class="glyphicon glyphicon-book"></span> 图书管理
                    </a>
                </li>
                <li>
                    <a href="admin_readers.html">
                        <span class="glyphicon glyphicon-user"></span> 读者管理
                    </a>
                </li>
                <li>
                    <a href="admin_borrowings.html">
                        <span class="glyphicon glyphicon-transfer"></span> 借阅管理
                    </a>
                </li>
                <li>
                    <a href="admin_statistics.html">
                        <span class="glyphicon glyphicon-stats"></span> 统计分析
                    </a>
                </li>
                <li>
                    <a href="admin_settings.html">
                        <span class="glyphicon glyphicon-cog"></span> 系统设置
                    </a>
                </li>
            </ul>
            <ul class="nav navbar-nav navbar-right">
                <li>
                    <a href="admin_profile.html">
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