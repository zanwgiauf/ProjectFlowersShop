<%-- 
    Document   : resetPassword
    Created on : 25/06/2024, 10:09:11 pm
    Author     : AN515-57
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Reset Password</title>
    <link rel="stylesheet" type="text/css" href="styles.css">
</head>
<body>
    <div class="container">
        <h2>Reset Password</h2>
        <form action="ResetPasswordController" method="post">
            <input type="hidden" name="email" value="${email}">
            <input type="hidden" name="token" value="${token}">
            <div class="form-group">
                <label for="newPassword">New Password:</label>
                <input type="password" id="newPassword" name="newPassword" class="form-control" required>
            </div>
            <button type="submit" class="btn btn-primary">Reset Password</button>
        </form>
    </div>
</body>
</html>
