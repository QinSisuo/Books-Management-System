<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>图书排行榜</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/bootstrap.min.css">
    <script src="${pageContext.request.contextPath}/js/jquery-3.2.1.js"></script>
    <script src="${pageContext.request.contextPath}/js/bootstrap.min.js"></script>
    <style>
        body {
            background-color: rgb(240,242,245);
        }
        .rank-container {
            margin-top: 20px;
        }
        .rank-list {
            margin-bottom: 30px;
            background: #fff;
            border-radius: 4px;
            box-shadow: 0 1px 3px rgba(0,0,0,0.1);
        }
        .rank-list-header {
            padding: 15px;
            border-bottom: 1px solid #eee;
            background: #f8f9fa;
            border-radius: 4px 4px 0 0;
        }
        .rank-list-header h3 {
            margin: 0;
            font-size: 18px;
            color: #333;
        }
        .rank-item {
            padding: 15px;
            border-bottom: 1px solid #eee;
            display: flex;
            align-items: center;
            transition: background-color 0.2s;
        }
        .rank-item:hover {
            background-color: #f8f9fa;
        }
        .rank-item:last-child {
            border-bottom: none;
            border-radius: 0 0 4px 4px;
        }
        .rank-number {
            width: 28px;
            height: 28px;
            background: #f8f9fa;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            margin-right: 15px;
            font-weight: bold;
            font-size: 14px;
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
            font-weight: 500;
            margin-bottom: 5px;
            color: #333;
        }
        .book-author {
            color: #666;
            font-size: 13px;
        }
        .rank-value {
            margin-left: 15px;
            font-weight: 500;
            color: #007bff;
            font-size: 14px;
            min-width: 100px;
            text-align: right;
        }
    </style>
</head>
<body>
    <!-- 引入公共头部和导航栏 -->
    <%@ include file="../common/header.jsp" %>
    <%@ include file="../common/reader_navbar.jsp" %>

    <div class="container rank-container">
        <!-- 借阅排行榜 -->
        <div class="rank-list">
            <div class="rank-list-header">
                <h3>借阅排行榜</h3>
            </div>
            <div id="borrowRankList"></div>
        </div>

        <!-- 评分排行榜 -->
        <div class="rank-list">
            <div class="rank-list-header">
                <h3>评分排行榜</h3>
            </div>
            <div id="ratingRankList"></div>
        </div>
    </div>

    <!-- 引入公共底部 -->
    <%@ include file="../common/footer.jsp" %>

<script>
$(document).ready(function() {
    // 加载排行榜数据
    $.get("${pageContext.request.contextPath}/rank/list", function(data) {
        // 渲染借阅排行榜
        let borrowHtml = '';
        data.borrowRank.forEach((book, index) => {
            borrowHtml += `
                <div class="rank-item">
                    <div class="rank-number \${index < 3 ? 'top3 rank-' + (index + 1) : ''}">${'${index + 1}'}</div>
                    <div class="book-info">
                        <div class="book-title">${'${book.name}'}</div>
                        <div class="book-author">作者：${'${book.author}'} | 出版社：${'${book.publish}'}</div>
                    </div>
                    <div class="rank-value">借阅次数：${'${book.borrowCount}'}</div>
                </div>
            `;
        });
        $('#borrowRankList').html(borrowHtml);

        // 渲染评分排行榜
        let ratingHtml = '';
        data.ratingRank.forEach((book, index) => {
            const rating = parseFloat(book.avgRating) || 0;
            const stars = '★'.repeat(Math.round(rating)) +
                         '☆'.repeat(5 - Math.round(rating));
            ratingHtml += `
                <div class="rank-item">
                    <div class="rank-number \${index < 3 ? 'top3 rank-' + (index + 1) : ''}">${'${index + 1}'}</div>
                    <div class="book-info">
                        <div class="book-title">${'${book.name}'}</div>
                        <div class="book-author">作者：${'${book.author}'} | 出版社：${'${book.publish}'}</div>
                    </div>
                    <div class="rank-value">
                        <div class="book-rating">${'${stars}'}</div>
                        <div>评分：${'${rating.toFixed(1)}'}</div>
                    </div>
                </div>
            `;
        });
        $('#ratingRankList').html(ratingHtml);
    });
});
</script>
</body>
</html> 