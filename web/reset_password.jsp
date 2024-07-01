<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <title>Reset Password</title>
        <link rel="stylesheet" type="text/css" href="style.css">
        <style>
            body {
                display: flex;
                justify-content: center;
                align-items: center;
                height: 100vh;
                background-color: #f8f9fa;
                margin: 0;
                font-family: Arial, sans-serif;
            }
            .container {
                width: 100%;
                max-width: 500px;
                background-color: white;
                padding: 100px;
                box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
                border-radius: 8px;
                text-align: center;
            }
            .logo img {
                width: 150px;
                margin-bottom: 20px;
            }
            .reset-form h2 {
                margin-bottom: 20px;
                font-size: 1.5em;
            }
            .input-group {
                margin-bottom: 20px;
            }
            .input-group input {
                width: 100%;
                padding: 10px;
                border: 1px solid #ced4da;
                border-radius: 4px;
            }
            .container button {
                width: 100%;
                padding: 10px;
                background-color: #dc3545;
                color: white;
                border: none;
                border-radius: 4px;
                cursor: pointer;
                font-size: 1em;
            }
            .container button:hover {
                background-color: #c82333;
            }
        </style>
    </head>
    <body>
        <div class="container">
            <div class="logo">    
                <img src="<%= request.getContextPath() %>/images/LogoF.png" alt="FlowerShop Logo">
            </div>
            <div class="reset-form">
                <h2>Set New Password</h2>
                <form action="resetPassword" method="post">
                    <input type="hidden" name="email" value="<%= request.getParameter("email") %>">
                    <div class="input-group">
                        <input type="password" id="new-password" name="new-password" placeholder="Enter your new password" required>
                    </div>
                    <div class="input-group">
                        <input type="password" id="new-password" name="password" placeholder="Enter your new password" required>
                    </div>
                    <button type="submit">CONFIRM</button>
                </form>
            </div>
        </div>
    </body>
</html>
8