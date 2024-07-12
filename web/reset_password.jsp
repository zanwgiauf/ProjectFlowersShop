<%-- 
    Document   : reset_password
    Created on : 26/06/2024, 2:58:55 pm
    Author     : AN515-57
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Reset Password</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/lib/bootstrap/bootstrap_css/bootstrap.min.css">
</head>
<body>
<div class="container">
    <h2>Reset Password</h2>
    <form action="${pageContext.request.contextPath}/reset_password" method="post">
        <input type="hidden" name="token" value="${param.token}">
        <div class="form-group">
            <label for="new_password">Enter new password:</label>
            <input type="password" class="form-control" id="new_password" name="new_password" required>
        </div>
        <button type="submit" class="btn btn-primary">Reset Password</button>
    </form>
</div>
<script src="${pageContext.request.contextPath}/lib/bootstrap/bootstrap_js/bootstrap.bundle.min.js"></script>
</body>
</html>
