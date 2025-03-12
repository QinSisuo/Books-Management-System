<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <title>用户行为分析</title>
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
        /* 新增样式 */
        .status-badge {
            padding: 5px 10px;
            border-radius: 12px;
            font-weight: 500;
            font-size: 12px;
            color: white;
        }
        .status-overdue-yes {
            background-color: #ff4d4f;
        }
        .status-overdue-no {
            background-color: #52c41a;
        }
        .activity-level-high {
            background-color: #1890ff;
        }
        .activity-level-medium {
            background-color: #faad14;
        }
        .activity-level-low {
            background-color: #d9d9d9;
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

    <!-- 显示成功或错误信息（默认隐藏） -->
    <div id="messageContainer" class="container" style="display: none;">
        <c:if test="${not empty succ}">
            <div class="alert alert-success alert-dismissable">
                <button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button>
                ${succ}
            </div>
        </c:if>
        <c:if test="${not empty error}">
            <div class="alert alert-danger alert-dismissable">
                <button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button>
                ${error}
            </div>
        </c:if>
    </div>

    <div class="container">
        <!-- 页面标题 -->
        <div class="panel panel-default">
            <div class="panel-heading bg-white">
                <div class="row align-items-center">
                    <div class="col-md-6">
                        <h3 class="panel-title mb-0">用户行为分析</h3>
                    </div>
                </div>
            </div>
        </div>

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
        <div class="row">
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
        <div class="panel panel-default">
            <div class="panel-heading bg-white">
                <div class="row align-items-center">
                    <div class="col-md-6">
                        <h5 class="panel-title mb-0">用户行为详情</h5>
                    </div>
                    <div class="col-md-6 text-right">
                        <input type="text" class="form-control w-50 float-end" id="userSearch" placeholder="搜索用户...">
                    </div>
                </div>
            </div>
            <div class="panel-body">
                <div class="table-responsive">
                    <table class="table table-hover">
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
                                        <span class="status-badge ${user.hasOverdue ? 'status-overdue-yes' : 'status-overdue-no'}">
                                            ${user.hasOverdue ? '有逾期' : '无逾期'}
                                        </span>
                                    </td>
                                    <td>
                                        <span class="status-badge 
                                            ${user.activityLevel == 'HIGH' ? 'activity-level-high' : 
                                              user.activityLevel == 'MEDIUM' ? 'activity-level-medium' : 
                                              'activity-level-low'}">
                                            ${user.activityLevel == 'HIGH' ? '高' : 
                                              user.activityLevel == 'MEDIUM' ? '中' : '低'}
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
        // 准备图表数据
        var borrowTrendDates = <c:out value="${borrowTrend.dates}" default="[]"/>;
        var borrowTrendCounts = <c:out value="${borrowTrend.counts}" default="[]"/>;
        var categoryData = <c:out value="${categoryDistribution}" default="[]"/>;

        // 初始化借阅趋势图表
        var borrowTrendChart = echarts.init(document.getElementById('borrowTrendChart'));
        borrowTrendChart.setOption({
            tooltip: {
                trigger: 'axis'
            },
            xAxis: {
                type: 'category',
                data: borrowTrendDates,
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
                data: borrowTrendCounts,
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
                data: categoryData
            }]
        });

        // 消息显示控制
        $(document).ready(function() {
            if ($("#messageContainer").text().trim() !== "") {
                $("#messageContainer").show();
            }
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