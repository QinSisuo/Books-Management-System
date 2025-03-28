<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <title>reader图书查询</title>
    <!-- 引入外部 CSS -->
    <link rel="stylesheet" href="css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@11.0.19/dist/sweetalert2.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
    <script src="js/jquery-3.2.1.js"></script>
    <script src="js/bootstrap.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11.0.19/dist/sweetalert2.min.js"></script>
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
        .tag-cloud a {
            text-decoration: none; /* 默认无下划线 */
        }

        .tag-cloud a:hover {
            text-decoration: none; /* 悬停时也无下划线 */
        }
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
    </style>
</head>

<body>
    <!-- 引入公共头部: 包含CSS/JS等 -->
    <%@ include file="../common/header.jsp" %>
    <%@ include file="../common/reader_navbar.jsp" %>
    <%@ include file="../common/footer.jsp" %>

    <!-- 统一面板 -->
    <div class="container">

        <!-- 统一搜索框 -->
        <div class="container" style="margin-top: 20px; margin-bottom: 20px; max-width: 600px; margin-left: -15px;">
            <form action="reader_book_catalog.html" method="get" class="form-inline">
                <div class="form-group">
                    <input type="text" class="form-control" name="searchWord"
                           placeholder="输入搜索关键词" value="${searchWord}" style="width: 300px;" />
                </div>
                &nbsp;
                <button type="submit" class="btn btn-primary">搜索</button>
            </form>
        </div>

        <!-- 热门标签区域 -->
        <div class="panel panel-default">
            <div class="panel-heading">
                <h3 class="panel-title">热门标签</h3>
            </div>
            <div class="panel-body">
                <div class="tag-cloud">
                    <c:forEach items="${hotTags}" var="tag" varStatus="status">
                        <a href="reader_book_catalog.html?tagId=${tag.id}"
                           class="tag-item tag-size-${status.index % 5 + 1}"
                           style="margin: 5px; font-size: ${12 + tag.hotScore/2}px;">
                            ${tag.name} <span class="badge badge-light">${tag.hotScore}</span>
                        </a>
                    </c:forEach>
                </div>
            </div>
        </div>

        <!-- 热门图书推荐 -->
        <div class="hot-books">
            <h3>热门推荐</h3>
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

        <!-- 标题和新增按钮 -->
        <div class="panel panel-default">
            <div class="panel-heading bg-white">
                <div class="row align-items-center">
                    <div class="col-md-6">
                        <h3 class="panel-title mb-0">查询结果</h3>
                    </div>
                </div>
            </div>
        </div>

        <table class="table table-hover">
            <thead>
                <tr>
                    <th>书名</th>
                    <th>作者</th>
                    <th>出版社</th>
                    <th>ISBN</th>
                    <th>价格</th>
                    <th>可借数量</th>
                    <th>操作</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="bk" items="${books}">
                    <tr>
                        <td>${bk.name}</td>
                        <td>${bk.author}</td>
                        <td>${bk.publish}</td>
                        <td>${bk.isbn}</td>
                        <td>${bk.price}</td>
                        <td>${(bk.totalCount == null ? 0 : bk.totalCount) - (bk.lentCount == null ? 0 : bk.lentCount)}</td>

                        <!-- 操作列: 根据可借数量显示借阅按钮 -->
                        <td>
                            <!-- 详情按钮 -->
                            <form action="reader/book/detail" method="get" style="display:inline;">
                                <input type="hidden" name="id" value="${bk.bookId}" />
                                <button type="submit" class="btn btn-info btn-sm">
                                    <i class="fas fa-info-circle"></i> 详情
                                </button>
                            </form>
                            &nbsp;
                            <c:choose>
                                <c:when test="${(bk.totalCount == null ? 0 : bk.totalCount) - (bk.lentCount == null ? 0 : bk.lentCount) > 0}">
                                    <!-- 有可借数量 => 显示绿色借阅按钮 -->
                                    <form action="reader_book_borrow.html" method="post" style="display:inline;">
                                        <input type="hidden" name="bookId" value="${bk.bookId}" />
                                        <button type="submit" class="btn btn-success btn-sm">
                                            <i class="fas fa-book"></i> 借阅
                                        </button>
                                    </form>
                                </c:when>
                                <c:otherwise>
                                    <!-- 无可借数量 => 显示预约按钮 -->
                                    <form action="reader_book_reserve.html" method="post" style="display:inline;">
                                        <input type="hidden" name="bookId" value="${bk.bookId}" />
                                        <button type="submit" class="btn btn-warning btn-sm">
                                            <i class="fas fa-clock"></i> 预约
                                        </button>
                                    </form>
                                </c:otherwise>
                            </c:choose>
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </div>

    <!-- SweetAlert 提示信息 -->
    <c:if test="${not empty succ}">
        <script>
            Swal.fire({
                icon: 'success',
                title: '${succ}',
                showConfirmButton: false,
                timer: 2000
            });
        </script>
    </c:if>

    <c:if test="${not empty error}">
        <script>
            Swal.fire({
                icon: 'error',
                title: '${error}',
                showConfirmButton: true
            });
        </script>
    </c:if>

    <script>
        $(document).ready(function() {
            const baseUrl = '${pageContext.request.contextPath}';
            console.log('Base URL:', baseUrl);
            
            // 加载热门图书
            $.ajax({
                url: baseUrl + '/recommend/hot',
                method: 'GET',
                dataType: 'json',
                success: function(books) {
                    console.log('获取到的热门图书数据:', books);
                    const hotBooksContainer = $('#hotBooks');
                    if (!books || books.length === 0) {
                        hotBooksContainer.html('<div class="col-12 text-center">暂无热门图书数据</div>');
                        return;
                    }
                    books.forEach(function(book) {
                        console.log('处理图书:', book);
                        const rating = parseFloat(book.avgRating) || 0;
                        const stars = '★'.repeat(Math.round(rating)) +
                                     '☆'.repeat(5 - Math.round(rating));
                        const bookHtml = `
                            <div class="col-md-3">
                                <div class="hot-book-item">
                                    <h4><a href="${'${baseUrl}'}/reader/book/detail?id=${'${book.bookId}'}">${'${book.name}'}</a></h4>
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
                },
                error: function(xhr, status, error) {
                    console.error('获取热门图书数据失败:', {
                        status: status,
                        error: error,
                        response: xhr.responseText
                    });
                    $('#hotBooks').html('<div class="col-12 text-center text-danger">获取热门图书数据失败</div>');
                }
            });

            // 加载排行榜数据
            $.ajax({
                url: baseUrl + '/rank/list',
                method: 'GET',
                dataType: 'json',
                success: function(data) {
                    console.log('获取到的排行榜数据:', data);
                    
                    // 渲染借阅排行榜
                    let borrowHtml = '';
                    if (data.borrowRank && data.borrowRank.length > 0) {
                        data.borrowRank.forEach((book, index) => {
                            borrowHtml += `
                                <div class="rank-item">
                                    <div class="rank-number \${index < 3 ? 'top3 rank-' + (index + 1) : ''}">${'${index + 1}'}</div>
                                    <div class="book-info">
                                        <div class="book-title">${'${book.name}'}</div>
                                        <div class="book-author">作者：${'${book.author}'} | 出版社：${'${book.publish}'}</div>
                                    </div>
                                    <div class="rank-value">借阅次数：${'${book.borrowCount || 0}'}</div>
                                </div>
                            `;
                        });
                    } else {
                        borrowHtml = '<div class="text-center">暂无借阅排行数据</div>';
                    }
                    $('#borrowRankList').html(borrowHtml);

                    // 渲染评分排行榜
                    let ratingHtml = '';
                    if (data.ratingRank && data.ratingRank.length > 0) {
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
                    } else {
                        ratingHtml = '<div class="text-center">暂无评分排行数据</div>';
                    }
                    $('#ratingRankList').html(ratingHtml);
                },
                error: function(xhr, status, error) {
                    console.error('获取排行榜数据失败:', {
                        status: status,
                        error: error,
                        response: xhr.responseText
                    });
                    $('#borrowRankList').html('<div class="text-center text-danger">获取借阅排行榜数据失败</div>');
                    $('#ratingRankList').html('<div class="text-center text-danger">获取评分排行榜数据失败</div>');
                }
            });
        });
    </script>

</body>
</html>
