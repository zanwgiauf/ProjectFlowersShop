<%-- 
    Document   : forgot_password
    Created on : 26/06/2024, 2:55:40 pm
    Author     : AN515-57
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Forgot Password</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/lib/bootstrap/bootstrap_css/bootstrap.min.css">
</head>
<body>
<div class="container">
    <h2>Forgot Password</h2>
    <form action="${pageContext.request.contextPath}/forgot_password" method="post">
        <div class="form-group">
            <label for="email">Enter your email:</label>
            <input type="email" class="form-control" id="email" name="email" required>
        </div>
        
        
        <button type="submit" class="btn btn-primary">Send Reset Link</button>
    </form>
</div>
<script src="${pageContext.request.contextPath}/lib/bootstrap/bootstrap_js/bootstrap.bundle.min.js"></script>
</body>
</html>

