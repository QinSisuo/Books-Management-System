<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <title>热门标签</title>
    <link rel="stylesheet" href="css/bootstrap.min.css">
    <script src="js/jquery-3.2.1.js"></script>
    <script src="js/bootstrap.min.js"></script>
    <style>
        .tag-cloud {
            padding: 20px;
            display: flex;
            flex-wrap: wrap;
            justify-content: center;
            gap: 15px;
        }
        .tag-item {
            padding: 10px 20px;
            background: #f8f9fa;
            border-radius: 20px;
            cursor: pointer;
            transition: all 0.3s ease;
            text-align: center;
        }
        .tag-item:hover {
            background: #e9ecef;
            transform: scale(1.05);
        }
        .tag-size-1 { font-size: 14px; }
        .tag-size-2 { font-size: 16px; }
        .tag-size-3 { font-size: 18px; }
        .tag-size-4 { font-size: 20px; }
        .tag-size-5 { font-size: 24px; }
    </style>
</head>
<body>
    <%@ include file="common/header.jsp" %>
    <%@ include file="common/navbar.jsp" %>

    <div class="container">
        <div class="panel panel-default">
            <div class="panel-heading">
                <h3 class="panel-title">热门标签</h3>
            </div>
            <div class="panel-body">
                <div class="tag-cloud">
                    <c:forEach items="${hotTags}" var="tag" varStatus="status">
                        <div class="tag-item tag-size-${status.index % 5 + 1}" 
                             onclick="searchByTag('${tag.name}')" 
                             title="使用次数：${tag.useCount}&#13;搜索次数：${tag.searchCount}&#13;借阅次数：${tag.borrowCount}">
                            ${tag.name}
                            <span class="badge">${tag.hotScore}</span>
                        </div>
                    </c:forEach>
                </div>
            </div>
        </div>
    </div>

    <script>
    function searchByTag(tagName) {
        window.location.href = 'reader_querybook.html?searchWord=' + encodeURIComponent(tagName);
    }
    </script>
</body>
</html> 