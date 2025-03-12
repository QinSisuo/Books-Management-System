<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <title>借阅统计</title>
    <!-- 引入外部 CSS -->
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
        .metric-trend {
            font-size: 12px;
            margin-top: 5px;
        }
        .trend-up {
            color: #ff4d4f;
        }
        .trend-down {
            color: #52c41a;
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
        .status-badge {
            padding: 5px 10px;
            border-radius: 12px;
            font-weight: 500;
            font-size: 12px;
            color: white;
        }
        .book-status-high {
            background-color: #ff4d4f;
        }
        .book-status-medium {
            background-color: #faad14;
        }
        .book-status-low {
            background-color: #52c41a;
        }
    </style>
</head>

<body>
    <!-- 引入公共头部: 包含CSS/JS等 -->
    <%@ include file="../common/header.jsp" %>
    <%@ include file="../common/admin_navbar.jsp" %>
    <%@ include file="../common/footer.jsp" %>

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
                        <h3 class="panel-title mb-0">借阅统计</h3>
                    </div>
                    <div class="col-md-6 text-right">
                        <div class="btn-group">
                            <button class="btn btn-outline-primary" onclick="updateStats('day')">日</button>
                            <button class="btn btn-outline-primary" onclick="updateStats('week')">周</button>
                            <button class="btn btn-outline-primary" onclick="updateStats('month')">月</button>
                            <button class="btn btn-outline-primary" onclick="updateStats('year')">年</button>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- 关键指标卡片 -->
        <div class="row">
            <div class="col-md-3">
                <div class="metric-card bg-primary bg-opacity-10">
                    <div class="metric-title">今日借阅量</div>
                    <div class="metric-value">${stats.todayBorrows}</div>
                    <div class="metric-trend ${stats.borrowTrend > 0 ? 'trend-up' : 'trend-down'}">
                        <i class="fas fa-arrow-${stats.borrowTrend > 0 ? 'up' : 'down'}"></i>
                        ${Math.abs(stats.borrowTrend)}% 较昨日
                    </div>
                </div>
            </div>
            <div class="col-md-3">
                <div class="metric-card bg-success bg-opacity-10">
                    <div class="metric-title">今日归还量</div>
                    <div class="metric-value">${stats.todayReturns}</div>
                    <div class="metric-trend ${stats.returnTrend > 0 ? 'trend-up' : 'trend-down'}">
                        <i class="fas fa-arrow-${stats.returnTrend > 0 ? 'up' : 'down'}"></i>
                        ${Math.abs(stats.returnTrend)}% 较昨日
                    </div>
                </div>
            </div>
            <div class="col-md-3">
                <div class="metric-card bg-info bg-opacity-10">
                    <div class="metric-title">当前借出总量</div>
                    <div class="metric-value">${stats.currentBorrows}</div>
                    <div class="metric-trend">
                        <i class="fas fa-book"></i>
                        占总藏书 ${stats.borrowPercentage}%
                    </div>
                </div>
            </div>
            <div class="col-md-3">
                <div class="metric-card bg-warning bg-opacity-10">
                    <div class="metric-title">逾期未还数</div>
                    <div class="metric-value">${stats.overdueCount}</div>
                    <div class="metric-trend trend-up">
                        <i class="fas fa-exclamation-triangle"></i>
                        需要关注
                    </div>
                </div>
            </div>
        </div>

        <!-- 图表区域 -->
        <div class="row">
            <div class="col-md-8">
                <div class="chart-container">
                    <h5 class="card-title">借阅趋势分析</h5>
                    <div id="borrowTrendChart" style="height:300px;"></div>
                </div>
            </div>
            <div class="col-md-4">
                <div class="chart-container">
                    <h5 class="card-title">热门图书分类</h5>
                    <div id="categoryPieChart" style="height:300px;"></div>
                </div>
            </div>
        </div>

        <!-- 热门图书列表 -->
        <div class="panel panel-default">
            <div class="panel-heading bg-white">
                <div class="row align-items-center">
                    <div class="col-md-6">
                        <h5 class="panel-title mb-0">热门图书排行</h5>
                    </div>
                </div>
            </div>
            <div class="panel-body">
                <div class="table-responsive">
                    <table class="table table-hover">
                        <thead>
                            <tr>
                                <th>排名</th>
                                <th>书名</th>
                                <th>作者</th>
                                <th>分类</th>
                                <th>借阅次数</th>
                                <th>借阅热度</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach items="${popularBooks}" var="book" varStatus="status">
                                <tr>
                                    <td>${status.index + 1}</td>
                                    <td>${book.name}</td>
                                    <td>${book.author}</td>
                                    <td>${book.category}</td>
                                    <td>${book.borrowCount}</td>
                                    <td>
                                        <span class="status-badge 
                                            ${book.popularity >= 80 ? 'book-status-high' : 
                                              book.popularity >= 50 ? 'book-status-medium' : 
                                              'book-status-low'}">
                                            ${book.popularity}%
                                        </span>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>

    <script>
        // 借阅趋势图表配置
        var borrowTrendChart = echarts.init(document.getElementById('borrowTrendChart'));
        var trendOption = {
            tooltip: {
                trigger: 'axis',
                axisPointer: {
                    type: 'shadow'
                }
            },
            legend: {
                data: ['借出量', '归还量']
            },
            grid: {
                left: '3%',
                right: '4%',
                bottom: '3%',
                containLabel: true
            },
            xAxis: {
                type: 'category',
                data: ${trendDates}
            },
            yAxis: {
                type: 'value'
            },
            series: [
                {
                    name: '借出量',
                    type: 'bar',
                    data: ${borrowData},
                    itemStyle: {
                        color: '#409EFF'
                    }
                },
                {
                    name: '归还量',
                    type: 'bar',
                    data: ${returnData},
                    itemStyle: {
                        color: '#67C23A'
                    }
                }
            ]
        };
        borrowTrendChart.setOption(trendOption);

        // 分类饼图配置
        var categoryPieChart = echarts.init(document.getElementById('categoryPieChart'));
        var pieOption = {
            tooltip: {
                trigger: 'item',
                formatter: '{b}: {c} ({d}%)'
            },
            legend: {
                orient: 'vertical',
                right: 10,
                top: 'center',
                type: 'scroll'
            },
            series: [{
                type: 'pie',
                radius: ['40%', '70%'],
                avoidLabelOverlap: false,
                itemStyle: {
                    borderRadius: 10,
                    borderColor: '#fff',
                    borderWidth: 2
                },
                label: {
                    show: false
                },
                emphasis: {
                    label: {
                        show: true,
                        fontSize: '20',
                        fontWeight: 'bold'
                    }
                },
                labelLine: {
                    show: false
                },
                data: ${categoryData}
            }]
        };
        categoryPieChart.setOption(pieOption);

        // 时间范围切换函数
        function updateStats(range) {
            showLoading();
            $.ajax({
                url: '/admin/borrow-statistics',
                data: { timeRange: range },
                success: function(response) {
                    // 更新统计数据和图表
                    // ...
                    hideLoading();
                },
                error: function() {
                    hideLoading();
                    Swal.fire({
                        title: '错误',
                        text: '获取数据失败',
                        icon: 'error'
                    });
                }
            });
        }

        // Loading 控制
        function showLoading() {
            $('.loading').css('display', 'flex');
        }

        function hideLoading() {
            $('.loading').css('display', 'none');
        }

        // 响应式调整
        window.addEventListener('resize', function() {
            borrowTrendChart.resize();
            categoryPieChart.resize();
        });
    </script>
</body>
</html> 