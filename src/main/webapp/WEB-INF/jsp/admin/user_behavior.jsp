<!-- 关键指标卡片 -->
<div class="row">
    <div class="col-md-2">
        <div class="metric-card">
            <h4>总用户数</h4>
            <p id="totalUsers">0</p>
        </div>
    </div>
    <div class="col-md-2">
        <div class="metric-card">
            <h4>活跃用户</h4>
            <p id="activeUsers">0</p>
        </div>
    </div>
    <div class="col-md-2">
        <div class="metric-card">
            <h4>总借阅量</h4>
            <p id="totalBorrows">0</p>
        </div>
    </div>
    <div class="col-md-2">
        <div class="metric-card">
            <h4>当前借阅</h4>
            <p id="currentBorrows">0</p>
        </div>
    </div>
    <div class="col-md-2">
        <div class="metric-card">
            <h4>新增用户</h4>
            <p id="newUsers">0</p>
        </div>
    </div>
</div>

<!-- 图表区域 -->
<div class="row mt-4">
    <div class="col-md-6">
        <div class="chart-container">
            <h4>借阅趋势</h4>
            <canvas id="borrowTrendChart"></canvas>
        </div>
    </div>
    <div class="col-md-6">
        <div class="chart-container">
            <h4>图书分类分布</h4>
            <canvas id="categoryDistChart"></canvas>
        </div>
    </div>
</div>

<div class="row mt-4">
    <div class="col-md-6">
        <div class="chart-container">
            <h4>用户角色分布</h4>
            <canvas id="userRoleChart"></canvas>
        </div>
    </div>
</div>

<script>
function loadData() {
    // 加载关键指标
    $.get("${pageContext.request.contextPath}/admin/behavior/metrics", function(data) {
        $("#totalUsers").text(data.totalUsers);
        $("#activeUsers").text(data.activeUsers);
        $("#totalBorrows").text(data.totalBorrows);
        $("#currentBorrows").text(data.currentBorrows);
        $("#newUsers").text(data.newUsers);
    });

    // 加载用户角色分布
    $.get("${pageContext.request.contextPath}/admin/behavior/userRoleDistribution", function(data) {
        const ctx = document.getElementById('userRoleChart').getContext('2d');
        new Chart(ctx, {
            type: 'pie',
            data: {
                labels: data.map(item => item.role),
                datasets: [{
                    data: data.map(item => item.count),
                    backgroundColor: ['#FF6384', '#36A2EB', '#FFCE56']
                }]
            },
            options: {
                responsive: true,
                plugins: {
                    legend: {
                        position: 'bottom'
                    }
                }
            }
        });
    });
    
    // ... existing chart loading code ...
}
</script>

<style>
.metric-card {
    background: #fff;
    padding: 20px;
    border-radius: 8px;
    box-shadow: 0 2px 4px rgba(0,0,0,0.1);
    text-align: center;
}

.metric-card h4 {
    margin: 0;
    font-size: 16px;
    color: #666;
}

.metric-card p {
    margin: 10px 0 0;
    font-size: 24px;
    font-weight: bold;
    color: #333;
}

.chart-container {
    background: #fff;
    padding: 20px;
    border-radius: 8px;
    box-shadow: 0 2px 4px rgba(0,0,0,0.1);
    margin-bottom: 20px;
}

.chart-container h4 {
    margin-bottom: 20px;
    color: #333;
}
</style> 