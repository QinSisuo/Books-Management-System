<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>图书排行榜</title>
    <link rel="stylesheet" href="css/bootstrap.min.css">
    <script src="js/jquery-3.2.1.js"></script>
    <script src="js/bootstrap.min.js"></script>
    <style>
        .rank-container {
            padding: 20px;
        }
        .rank-list {
            margin-bottom: 30px;
        }
        .rank-item {
            padding: 10px;
            border-bottom: 1px solid #eee;
            display: flex;
            align-items: center;
        }
        .rank-number {
            width: 30px;
            height: 30px;
            background: #f8f9fa;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            margin-right: 15px;
            font-weight: bold;
        }
        .rank-number.top3 {
            color: white;
        }
        .rank-number.rank-1 { background: #FFD700; }
        .rank-number.rank-2 { background: #C0C0C0; }
        .rank-number.rank-3 { background: #CD7F32; }
        .book-info {
            flex-grow: 1;
        }
        .book-title {
            font-weight: bold;
            margin-bottom: 5px;
        }
        .book-author {
            color: #666;
            font-size: 0.9em;
        }
        .rank-value {
            margin-left: 15px;
            font-weight: bold;
            color: #007bff;
        }
    </style>
</head>
<body>
<div class="rank-container">
    <h2>图书排行榜</h2>
    
    <div class="rank-list">
        <h3>借阅排行榜</h3>
        <div id="borrowRankList"></div>
    </div>

    <div class="rank-list">
        <h3>评分排行榜</h3>
        <div id="ratingRankList"></div>
    </div>
</div>

<script>
$(document).ready(function() {
    // 加载排行榜数据
    $.get("${pageContext.request.contextPath}/rank/list", function(data) {
        // 渲染借阅排行榜
        let borrowHtml = '';
        data.borrowRank.forEach((book, index) => {
            borrowHtml += `
                <div class="rank-item">
                    <div class="rank-number \${index < 3 ? 'top3 rank-' + (index + 1) : ''}">${index + 1}</div>
                    <div class="book-info">
                        <div class="book-title">${book.name}</div>
                        <div class="book-author">作者：${book.author}</div>
                    </div>
                    <div class="rank-value">借阅次数：${book.borrow_count}</div>
                </div>
            `;
        });
        $('#borrowRankList').html(borrowHtml);

        // 渲染评分排行榜
        let ratingHtml = '';
        data.ratingRank.forEach((book, index) => {
            ratingHtml += `
                <div class="rank-item">
                    <div class="rank-number \${index < 3 ? 'top3 rank-' + (index + 1) : ''}">${index + 1}</div>
                    <div class="book-info">
                        <div class="book-title">${book.name}</div>
                        <div class="book-author">作者：${book.author}</div>
                    </div>
                    <div class="rank-value">平均评分：${book.avg_rating.toFixed(1)}</div>
                </div>
            `;
        });
        $('#ratingRankList').html(ratingHtml);
    });
});
</script>
</body>
</html> 