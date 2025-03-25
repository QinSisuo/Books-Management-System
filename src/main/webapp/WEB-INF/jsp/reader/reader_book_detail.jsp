<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>《 ${book.name}》</title>
    <link rel="stylesheet" href="css/bootstrap.min.css">
    <script src="js/jquery-3.2.1.js"></script>
    <script src="js/bootstrap.min.js" ></script>
    <style>
        body{
            background-color: rgb(240,242,245);
        }
        .tag-group {
            display: flex;
            flex-wrap: wrap;
            gap: 8px;
            margin-top: 5px;
        }

        .tag {
            background-color: #e9ecef;
            color: #495057;
            padding: 4px 8px;
            border-radius: 4px;
            font-size: 14px;
            display: inline-block;
        }
    </style>
</head>
<body>
<nav class="navbar navbar-default" role="navigation" style="background-color:#fff">
    <div class="container-fluid">
        <div class="navbar-header" style="margin-left: 8%;margin-right: 1%">
            <a class="navbar-brand " href="reader_main.html"><p class="text-primary">我的图书馆</p></a>
        </div>
        <div class="collapse navbar-collapse" id="example-navbar-collapse">
            <ul class="nav navbar-nav navbar-left">
                <li class="active">
                    <a href="reader_book_catalog.html">
                        图书目录
                    </a>
                </li>
                <li>
                    <a href="reader_info.html" >
                        个人信息
                    </a>
                </li>
                <li >
                    <a href="mylend.html" >
                        我的借还
                    </a>
                </li>
                <li >
                    <a href="reader_repasswd.html" >
                        密码修改
                    </a>
                </li>
            </ul>
            <ul class="nav navbar-nav navbar-right">
                <li><a href="reader_info.html"><span class="glyphicon glyphicon-user"></span>&nbsp;${readercard.name}，已登录</a></li>
                <li><a href="login.html"><span class="glyphicon glyphicon-log-in"></span>&nbsp;退出</a></li>
            </ul>
        </div>
    </div>
</nav>

<div class="col-xs-6 col-md-offset-3" style="position: relative;top: 3%">
    <div class="panel panel-primary">
        <div class="panel-heading">
            <h3 class="panel-title">《 ${book.name}》</h3>
        </div>
        <div class="panel-body">
            <table class="table table-hover">
                <tr>
                    <th width="15%">书名</th>
                    <td>${book.name}</td>
                </tr>
                <tr>
                    <th>作者</th>
                    <td>${book.author}</td>
                </tr>
                <tr>
                    <th>出版社</th>
                    <td>${book.publish}</td>
                </tr>
                <tr>
                    <th>ISBN</th>
                    <td>${book.isbn}</td>
                </tr>
                <tr>
                    <th>简介</th>
                    <td>${book.introduction}</td>
                </tr>
                <tr>
                    <th>语言</th>
                    <td>${book.language}</td>
                </tr>
                <tr>
                    <th>价格</th>
                    <td>${book.price}</td>
                </tr>
                <tr>
                    <th>出版日期</th>
                    <td>${book.pubdate}</td>
                </tr>
                <tr>
                    <th>分类号</th>
                    <td>${book.categoryId}</td>
                </tr>
                <tr>
                    <th>书架号</th>
                    <td>${book.pressmark}</td>
                </tr>
                <tr>
                    <th>状态</th>
                    <c:if test="${book.state==1}">
                        <td>在馆</td>
                    </c:if>
                    <c:if test="${book.state==0}">
                        <td>借出</td>
                    </c:if>
                </tr>
                <tr>
                    <th>图书分类：</th>
                    <td>${categoryName}</td>
                </tr>
                <tr>
                    <th>图书标签：</th>
                    <td>
                        <div class="tag-group">
                            <c:forEach items="${tags}" var="tag">
                                <span class="tag">${tag.name}</span>
                            </c:forEach>
                        </div>
                    </td>
                </tr>
                <tr>
                    <th>图书简介：</th>
                    <td>${book.introduction}</td>
                </tr>
                </tbody>
            </table>
        </div>
    </div>

</div>

</body>
</html>
