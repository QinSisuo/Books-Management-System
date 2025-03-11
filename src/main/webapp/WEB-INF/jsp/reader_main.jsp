<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>读者主页</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/bootstrap.min.css">
    <style>
        body {
            background-color: rgb(240,242,245);
            margin-bottom: 70px;
        }
        .container { 
            margin-top: 50px; 
        }
        .navbar-nav .nav-item { 
            margin-right: 20px; 
        }
        .navbar-brand { 
            font-weight: bold; 
            font-size: 24px; 
        }
        .navbar-nav .nav-link { 
            font-size: 18px; 
        }
        .navbar .btn-outline-danger { 
            font-size: 16px; 
            padding: 5px 15px; 
        }
    </style>
</head>

<body>
    <%@ include file="common/header.jsp" %>
    <%@ include file="common/reader_navbar.jsp" %>



    <%@ include file="common/footer.jsp" %>

    <script src="${pageContext.request.contextPath}/js/jquery-3.2.1.js"></script>
    <script src="${pageContext.request.contextPath}/js/bootstrap.min.js"></script>
</body>
</html>
