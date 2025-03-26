<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <title>《${book.name}》</title>
    <!-- 引入外部 CSS 和 JS -->
    <link rel="stylesheet" href="css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@11.0.19/dist/sweetalert2.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
    <script src="js/jquery-3.2.1.js"></script>
    <script src="js/bootstrap.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11.0.19/dist/sweetalert2.min.js"></script>
    <style>
        .panel {
            border-radius: 8px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        }

        .table th {
            background-color: #f8f9fa;
            width: 150px;
            white-space: nowrap;
        }

        .table td {
            background-color: #fff;
        }

        .rating {
            display: flex;
            flex-direction: row-reverse;
            justify-content: flex-end;
        }

        .rating input {
            display: none;
        }

        .rating label {
            font-size: 30px;
            color: #ddd;
            cursor: pointer;
            padding: 5px;
        }

        .rating input:checked ~ label,
        .rating label:hover,
        .rating label:hover ~ label {
            color: #ffd700;
        }

        .review-item {
            border-bottom: 1px solid #eee;
            padding: 15px 0;
        }

        .review-item:last-child {
            border-bottom: none;
        }

        .review-header {
            display: flex;
            justify-content: space-between;
            margin-bottom: 10px;
        }

        .review-user {
            font-weight: bold;
        }

        .review-time {
            color: #999;
            font-size: 0.9em;
        }

        .review-rating {
            color: #ffd700;
            margin-bottom: 10px;
        }

        .review-content {
            color: #666;
        }
    </style>

</head>

<body>
<!-- 公共头部区域 -->
<%@ include file="../common/header.jsp" %>
<%@ include file="../common/reader_navbar.jsp" %>
<%@ include file="../common/footer.jsp" %>
<!-- 统一面板 -->
<div class="container">
<!-- 主体内容 -->

    <div class="panel panel-default shadow-sm">
        <div class="panel-heading bg-white">
            <h3 class="panel-title">
                <i class="fas fa-book-open"></i> 图书详情：《${book.name}》
            </h3>
        </div>
        <div class="panel-body">
            <table class="table table-bordered">
                <tbody>
                <tr>
                    <th><i class="fas fa-book"></i> 书名</th>
                    <td>${book.name}</td>
                </tr>
                <tr>
                    <th><i class="fas fa-user-edit"></i> 作者</th>
                    <td>${book.author}</td>
                </tr>
                <tr>
                    <th><i class="fas fa-building"></i> 出版社</th>
                    <td>${book.publish}</td>
                </tr>
                <tr>
                    <th><i class="fas fa-barcode"></i> ISBN</th>
                    <td>${book.isbn}</td>
                </tr>
                <tr>
                    <th><i class="fas fa-align-left"></i> 简介</th>
                    <td style="line-height: 1.6;">${book.introduction}</td>
                </tr>
                <tr>
                    <th><i class="fas fa-language"></i> 语言</th>
                    <td>${book.language}</td>
                </tr>
                <tr>
                    <th><i class="fas fa-yen-sign"></i> 价格</th>
                    <td>${book.price}</td>
                </tr>
                <tr>
                    <th><i class="fas fa-calendar-alt"></i> 出版日期</th>
                    <td>${book.pubdate}</td>
                </tr>
                <tr>
                    <th><i class="fas fa-th-large"></i> 分类号</th>
                    <td>${book.categoryId}</td>
                </tr>
                <tr>
                    <th><i class="fas fa-layer-group"></i> 书架号</th>
                    <td>${book.pressmark}</td>
                </tr>
                <tr>
                    <th><i class="fas fa-info-circle"></i> 状态</th>
                    <td>
                        <c:if test="${book.state == 1}">
                            <span class="label label-success">在馆</span>
                        </c:if>
                        <c:if test="${book.state == 0}">
                            <span class="label label-warning">借出</span>
                        </c:if>
                    </td>
                </tr>
                <tr>
                    <th><i class="fas fa-tags"></i> 图书分类</th>
                    <td>${categoryName}</td>
                </tr>
                <tr>
                    <th><i class="fas fa-bookmark"></i> 图书标签</th>
                    <td>
                        <div class="tag-group">
                            <c:forEach items="${tags}" var="tag">
                                <span class="tag">${tag.name}</span>
                            </c:forEach>
                        </div>
                    </td>
                </tr>
                </tbody>
            </table>
        </div>
    </div>

    <!-- 在图书详情下方添加书评和评分部分 -->
    <div class="container mt-4">
        <h3>书评与评分</h3>
        
        <!-- 评分统计 -->
        <div class="card mb-4">
            <div class="card-body">
                <h5 class="card-title">评分统计</h5>
                <div class="d-flex align-items-center">
                    <div class="display-4 mr-3" id="avgRating">0.0</div>
                    <div class="text-muted">共 <span id="totalReviews">0</span> 条评价</div>
                </div>
            </div>
        </div>
        
        <!-- 评分和评论表单 -->
        <div class="card mb-4" id="reviewForm">
            <div class="card-body">
                <h5 class="card-title">发表评价</h5>
                <form id="addReviewForm">
                    <div class="form-group">
                        <label>评分</label>
                        <div class="rating">
                            <input type="radio" name="rating" value="5" id="star5"><label for="star5">★</label>
                            <input type="radio" name="rating" value="4" id="star4"><label for="star4">★</label>
                            <input type="radio" name="rating" value="3" id="star3"><label for="star3">★</label>
                            <input type="radio" name="rating" value="2" id="star2"><label for="star2">★</label>
                            <input type="radio" name="rating" value="1" id="star1"><label for="star1">★</label>
                        </div>
                    </div>
                    <div class="form-group">
                        <label>评论内容</label>
                        <textarea class="form-control" name="content" rows="3" required></textarea>
                    </div>
                    <button type="submit" class="btn btn-primary">提交评价</button>
                </form>
            </div>
        </div>
        
        <!-- 评论列表 -->
        <div class="card">
            <div class="card-body">
                <h5 class="card-title">全部评价</h5>
                <div id="reviewList">
                    <!-- 评论列表将通过JavaScript动态加载 -->
                </div>
            </div>
        </div>
    </div>
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

<!-- 添加JavaScript代码 -->
<script>
$(document).ready(function() {
    const bookId = ${book.bookId};
    
    // 加载评分统计
    function loadRatingStats() {
        $.get('${pageContext.request.contextPath}/review/stats/' + bookId, function(data) {
            $('#avgRating').text(data.avgRating ? data.avgRating.toFixed(1) : '0.0');
            $('#totalReviews').text(data.totalReviews || 0);
        });
    }
    
    // 加载评论列表
    function loadReviews() {
        $.get('${pageContext.request.contextPath}/review/list/' + bookId, function(reviews) {
            const reviewList = $('#reviewList');
            reviewList.empty();
            
            reviews.forEach(function(review) {
                const stars = '★'.repeat(review.rating) + '☆'.repeat(5 - review.rating);
                const reviewHtml = `
                    <div class="review-item">
                        <div class="review-header">
                            <span class="review-user">${'${review.userName}'}</span>
                            <span class="review-time">${'${new Date(review.createTime).toLocaleString()}'}</span>
                        </div>
                        <div class="review-rating">${'${stars}'}</div>
                        <div class="review-content">${'${review.content}'}</div>
                    </div>
                `;
                reviewList.append(reviewHtml);
            });
        });
    }
    
    // 提交评论
    $('#addReviewForm').submit(function(e) {
        e.preventDefault();
        
        const rating = $('input[name="rating"]:checked').val();
        const content = $('textarea[name="content"]').val();
        
        if (!rating) {
            alert('请选择评分');
            return;
        }
        
        $.ajax({
            url: '${pageContext.request.contextPath}/review/add',
            type: 'POST',
            contentType: 'application/json',
            data: JSON.stringify({
                bookId: bookId,
                rating: parseInt(rating),
                content: content
            }),
            success: function(response) {
                if (response.success) {
                    alert(response.message);
                    $('textarea[name="content"]').val('');
                    loadRatingStats();
                    loadReviews();
                } else {
                    alert(response.message);
                }
            },
            error: function(xhr, status, error) {
                console.error('提交评论失败:', status, error);
                console.error('响应:', xhr.responseText);
                Swal.fire({
                    icon: 'error',
                    title: '提交失败',
                    text: '请稍后重试'
                });
            }
        });
    });
    
    // 初始加载
    loadRatingStats();
    loadReviews();
});
</script>

</body>
</html>
