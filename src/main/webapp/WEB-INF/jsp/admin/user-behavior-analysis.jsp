<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
    <title>用户行为分析</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/jquery@3.6.0/dist/jquery.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
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
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
        }
    </style>
</head>
<body class="bg-light">
    <div class="container-fluid p-4">
        <!-- 关键指标卡片 -->
        <div class="row">
            <div class="col-md-3">
                <div class="metric-card bg-primary bg-opacity-10">
                    <div class="metric-title">总用户数</div>
                    <div class="metric-value">${metrics.totalUsers}</div>
                </div>
            </div>
            <div class="col-md-3">
                <div class="metric-card bg-success bg-opacity-10">
                    <div class="metric-title">活跃用户数</div>
                    <div class="metric-value">${metrics.activeUsers}</div>
                </div>
            </div>
            <div class="col-md-3">
                <div class="metric-card bg-info bg-opacity-10">
                    <div class="metric-title">总借阅量</div>
                    <div class="metric-value">${metrics.totalBorrows}</div>
                </div>
            </div>
            <div class="col-md-3">
                <div class="metric-card bg-warning bg-opacity-10">
                    <div class="metric-title">当前借阅量</div>
                    <div class="metric-value">${metrics.currentBorrows}</div>
                </div>
            </div>
        </div>

        <!-- 图表区域 -->
        <div class="row mb-4">
            <div class="col-md-8">
                <div class="chart-container">
                    <h5 class="card-title">借阅趋势（近7天）</h5>
                    <div id="borrowTrendChart" style="height:300px;"></div>
                </div>
            </div>
            <div class="col-md-4">
                <div class="chart-container">
                    <h5 class="card-title">图书分类借阅分布</h5>
                    <div id="categoryPieChart" style="height:300px;"></div>
                </div>
            </div>
        </div>

        <!-- 用户行为表格 -->
        <div class="chart-container">
            <div class="d-flex justify-content-between align-items-center mb-3">
                <h5 class="card-title mb-0">用户行为详情</h5>
                <input type="text" class="form-control w-25" id="userSearch" placeholder="搜索用户...">
            </div>
            <div class="table-responsive">
                <table class="table table-striped table-hover">
                    <thead>
                        <tr>
                            <th>用户名</th>
                            <th>借阅次数</th>
                            <th>最近借阅</th>
                            <th>常借类型</th>
                            <th>逾期记录</th>
                            <th>活跃度</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach items="${userBehaviors}" var="user">
                            <tr>
                                <td>${user.userName}</td>
                                <td>${user.borrowCount}</td>
                                <td><fmt:formatDate value="${user.lastBorrowTime}" pattern="yyyy-MM-dd"/></td>
                                <td>${user.preferredCategory}</td>
                                <td>
                                    <span class="badge ${user.hasOverdue ? 'bg-danger' : 'bg-success'}">
                                        ${user.hasOverdue ? '是' : '否'}
                                    </span>
                                </td>
                                <td>
                                    <span class="badge bg-primary">${user.activityLevel}</span>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>
    </div>

    <script>
        // 初始化借阅趋势图表
        var borrowTrendChart = echarts.init(document.getElementById('borrowTrendChart'));
        borrowTrendChart.setOption({
            tooltip: {
                trigger: 'axis'
            },
            xAxis: {
                type: 'category',
                data: ${borrowTrend.dates},
                axisLabel: {
                    formatter: function(value) {
                        return value.substring(5); // 只显示月-日
                    }
                }
            },
            yAxis: {
                type: 'value',
                name: '借阅数量'
            },
            series: [{
                data: ${borrowTrend.counts},
                type: 'line',
                smooth: true,
                areaStyle: {
                    opacity: 0.3
                },
                itemStyle: {
                    color: '#409EFF'
                }
            }]
        });

        // 初始化分类分布图表
        var categoryPieChart = echarts.init(document.getElementById('categoryPieChart'));
        categoryPieChart.setOption({
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
                data: ${categoryDistribution}
            }]
        });

        // 用户搜索功能
        $('#userSearch').on('input', function() {
            var value = $(this).val().toLowerCase();
            $('tbody tr').filter(function() {
                $(this).toggle($(this).text().toLowerCase().indexOf(value) > -1)
            });
        });

        // 响应式调整图表大小
        window.addEventListener('resize', function() {
            borrowTrendChart.resize();
            categoryPieChart.resize();
        });
    </script>
</body>
</html>