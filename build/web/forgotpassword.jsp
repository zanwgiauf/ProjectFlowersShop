<%-- 
    Document   : forgotpassword
    Created on : 25/06/2024, 11:29:10 pm
    Author     : AN515-57
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Forget Password</title>
    <link rel="stylesheet" type="text/css" href="styles.css">
</head>
<body>
    <div class="container">
        <h2>Forget Password</h2>
        <form action="ForgotPasswordController" method="post">
            <div class="form-group">
                <label for="email">Enter your email address:</label>
                <input type="email" id="email" name="email" class="form-control" required>
            </div>
            <button type="submit" class="btn btn-primary">Send Reset Link</button>
        </form>
    </div>
</body>
</html>
