<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Enter OTP Code</title>
        <link rel="stylesheet" type="text/css" href="<%= request.getContextPath() %>/style.css">
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
            .container img {
                width: 150px;
                margin-bottom: 20px;
            }
            .container h2 {
                margin-bottom: 20px;
                font-size: 1.5em;
            }
            .container form {
                display: flex;
                flex-direction: column;
                align-items: center;
            }
            .container label {
                margin-bottom: 10px;
                font-size: 1em;
            }
            .container input[type="text"] {
                width: 100%;
                padding: 10px;
                margin-bottom: 20px;
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
            .container p {
                margin-top: 20px;
            }
            .error-message{
                color: red;
            }
        </style>
    </head>
    <body>
        <div class="container">
            <img src="./images/LogoF.png" alt="FlowerShop Logo">   
            <h2>Enter OTP Code</h2>
            <form action="verifyOTP" method="post">
                <input type="hidden" name="email" value="<%= request.getParameter("email") %>">
                <p>Email: <%= request.getParameter("email") %></p>
                <label for="otp">OTP Code:</label>
                <input type="text" id="otp" name="otp" required>
                <button type="submit">Confirm</button>
            </form>
                  <% String error = (String) request.getAttribute("error");
           if (error != null) { %>
               <p class="error-message"><%= error %></p>
        <% } %>
        </div>
    </body>
</html>
