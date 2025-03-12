<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <title>借阅统计</title>
    <!-- 统一风格的 CSS 和 JS -->
    <link rel="stylesheet" href="css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@11.0.19/dist/sweetalert2.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
    <script src="js/jquery-3.2.1.js"></script>
    <script src="js/bootstrap.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11.0.19/dist/sweetalert2.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/echarts@5.4.3/dist/echarts.min.js"></script>
    <style>
        .metric-card {
            border-radius: 8px;
            padding: 20px;
            margin-bottom: 20px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
            transition: transform 0.2s;
        }
        .metric-card:hover {
            transform: translateY(-5px);
        }
        .metric-title {
            font-size: 14px;
            color: #666;
            margin-bottom: 10px;
        }
        .metric-value {
            font-size: 24px;
            font-weight: bold;
            color: #333;
        }
        .chart-container {
            background: white;
            border-radius: 8px;
            padding: 15px;
            margin-bottom: 20px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
        }
        .loading {
            display: none;
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: rgba(255, 255, 255, 0.8);
            z-index: 9999;
            justify-content: center;
            align-items: center;
        }
    </style>
</head>

<body>
    <!-- 统一引入头部、导航栏和底部 -->
    <%@ include file="common/header.jsp" %>
    <%@ include file="common/admin_navbar.jsp" %>
    <%@ include file="common/footer.jsp" %>

    <!-- Loading 指示器 -->
    <div class="loading">
        <div class="spinner-border text-primary" role="status">
            <span class="sr-only">加载中...</span>
        </div>
    </div>

    <div class="container">
        <!-- 页面标题 -->
        <div class="panel panel-default">
            <div class="panel-heading bg-white">
                <div class="row align-items-center">
                    <div class="col-md-6">
                        <h3 class="panel-title mb-0">📊 借阅统计</h3>
                    </div>
                </div>
            </div>
        </div>

        <!-- 统计数据卡片 -->
        <div class="row">
            <div class="col-md-3">
                <div class="metric-card bg-primary bg-opacity-10">
                    <div class="metric-title">今日借阅量</div>
                    <div class="metric-value">${stats.todayBorrows}</div>
                </div>
            </div>
            <div class="col-md-3">
                <div class="metric-card bg-success bg-opacity-10">
                    <div class="metric-title">今日归还量</div>
                    <div class="metric-value">${stats.todayReturns}</div>
                </div>
            </div>
            <div class="col-md-3">
                <div class="metric-card bg-info bg-opacity-10">
                    <div class="metric-title">当前借出总量</div>
                    <div class="metric-value">${stats.currentBorrows}</div>
                </div>
            </div>
            <div class="col-md-3">
                <div class="metric-card bg-danger bg-opacity-10">
                    <div class="metric-title">逾期未还数</div>
                    <div class="metric-value">${stats.overdueCount}</div>
                </div>
            </div>
        </div>

        <!-- 图表区域 -->
        <div class="row">
            <div class="col-md-8">
                <div class="chart-container">
                    <h5 class="card-title">📈 借阅趋势</h5>
                    <div id="borrowTrendChart" style="height:300px;"></div>
                </div>
            </div>
            <div class="col-md-4">
                <div class="chart-container">
                    <h5 class="card-title">📚 热门图书</h5>
                    <table class="table table-hover">
                        <thead>
                            <tr>
                                <th>#</th>
                                <th>书名</th>
                                <th>作者</th>
                                <th>借阅次数</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="book" items="${popularBooks}" varStatus="index">
                                <tr>
                                    <td>${index.index + 1}</td>
                                    <td>${book.name}</td>
                                    <td>${book.author}</td>
                                    <td>${book.borrowCount}</td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>

    <script>
        var borrowChart = echarts.init(document.getElementById('borrowTrendChart'));
        var trendData = ${trendDataJson}; // 由后端传递 JSON
        borrowChart.setOption({
            tooltip: { trigger: 'axis' },
            xAxis: { type: 'category', data: trendData.dates },
            yAxis: { type: 'value' },
            series: [
                { name: '借出量', type: 'line', data: trendData.borrows },
                { name: '归还量', type: 'line', data: trendData.returns }
            ]
        });

        // 显示加载动画
        $(document).ready(function() {
            $(".loading").fadeOut();
        });

        // 响应式调整
        window.addEventListener('resize', function() {
            borrowChart.resize();
        });
    </script>
</body>
</html>
