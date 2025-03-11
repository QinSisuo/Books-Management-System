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