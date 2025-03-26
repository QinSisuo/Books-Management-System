<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <title>读者主页</title>
    <!-- 引入外部 CSS -->
    <link rel="stylesheet" href="css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@11.0.19/dist/sweetalert2.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
    <script src="js/jquery-3.2.1.js"></script>
    <script src="js/bootstrap.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11.0.19/dist/sweetalert2.min.js"></script>
    <style>
        .hot-books {
            margin-bottom: 30px;
        }
        .hot-book-item {
            padding: 15px;
            border: 1px solid #eee;
            margin-bottom: 15px;
            transition: all 0.3s;
        }
        .hot-book-item:hover {
            box-shadow: 0 2px 12px rgba(0,0,0,0.1);
        }
        .book-rating {
            color: #ffd700;
            margin-bottom: 10px;
        }
        .book-borrow-count {
            color: #666;
            font-size: 0.9em;
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
    <!-- 引入公共头部: 包含CSS/JS等 -->
    <%@ include file="../common/header.jsp" %>
    <%@ include file="../common/reader_navbar.jsp" %>
    <%@ include file="../common/footer.jsp" %>

    <!-- 统一面板 -->
    <div class="container">

        <!-- 热门图书推荐 -->
        <div class="hot-books">
            <div>
                <h3>热门推荐</h3>
            </div>
            <div class="row" id="hotBooks">
                <!-- 热门图书将通过Ajax加载 -->
            </div>
        </div>

        <!-- 借阅排行榜 -->
        <div class="rank-list" style="margin-top: 20px;">
            <div class="rank-list-header">
                <h3>借阅排行榜</h3>
            </div>
            <div id="borrowRankList">
                <!-- 借阅排行榜将通过Ajax加载 -->
            </div>
        </div>

        <!-- 评分排行榜 -->
        <div class="rank-list">
            <div class="rank-list-header">
                <h3>评分排行榜</h3>
            </div>
            <div id="ratingRankList">
                <!-- 评分排行榜将通过Ajax加载 -->
            </div>
        </div>
    </div>


    <script>
        $(document).ready(function() {
            // 加载热门图书
            $.get('${pageContext.request.contextPath}/recommend/hot', function(books) {
                const hotBooksContainer = $('#hotBooks');
                books.forEach(function(book) {
                    const stars = '★'.repeat(Math.round(book.avgRating || 0)) +
                        '☆'.repeat(5 - Math.round(book.avgRating || 0));
                    const bookHtml = `
                    <div class="col-md-3">
                        <div class="hot-book-item">
                            <h4><a href="${pageContext.request.contextPath}/reader/book/detail?id=${'${book.bookId}'}">${'${book.name}'}</a></h4>
                            <div class="book-rating">${'${stars}'}</div>
                            <div class="book-info">
                                <div>作者: ${'${book.author}'}</div>
                                <div class="book-borrow-count">借阅次数: ${'${book.borrowCount || 0}'}</div>
                            </div>
                        </div>
                    </div>
                `;
                    hotBooksContainer.append(bookHtml);
                });
            });


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
                        <div class="book-author">作者：${book.author} | 出版社：${book.publisher}</div>
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
                        <div class="book-author">作者：${book.author} | 出版社：${book.publisher}</div>
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