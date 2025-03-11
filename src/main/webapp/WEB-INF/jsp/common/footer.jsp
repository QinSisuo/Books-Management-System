<!-- footer.jsp -->
<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<meta charset="UTF-8">
<style>
    .footer {
        position: fixed;
        bottom: 0;
        width: 100%;
        background-color: #343a40;
        color: white;
        text-align: center;
        padding: 1rem 0;
        z-index: 1000;
    }
    
    /* 为了防止页面内容被固定页脚遮挡，给body添加下边距 */
    body {
        margin-bottom: 70px; /* 根据footer高度调整 */
    }
</style>

<footer class="footer">
    <div class="container">
        <p class="mb-0">&copy; 2025 图书管理系统. 版权所有.</p>
    </div>
</footer>
