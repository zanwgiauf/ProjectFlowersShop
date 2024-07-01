<%-- 
    Document   : statistics.jsp
    Created on : Jun 22, 2024, 1:53:38 AM
    Author     : Thang Tai
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="Models.Statistics" %>

<!DOCTYPE html>
<html>
<head>
    <title>Statistics</title>
    <link rel="icon" href="<%= request.getContextPath()%>/images/LogoF.png" type="image/png">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css">
</head>
<body>
<div class="container mt-5">
    <a href="<%= request.getContextPath() %>/home" class="btn btn-secondary back-to-home">Back to Home</a>
    <h1 class="text-center">Product Statistics</h1>
    <div class="card mt-5">
        <div class="card-header">
            <h3>Statistics Summary</h3>
        </div>
        <div class="card-body">
            <div class="row">
                <div class="col-md-4">
                    <div class="card text-white bg-primary mb-3">
                        <div class="card-header">Total Products</div>
                        <div class="card-body">
                            <h5 class="card-title">${statistics.productCount}</h5>
                        </div>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="card text-white bg-success mb-3">
                        <div class="card-header">Total Quantity</div>
                        <div class="card-body">
                            <h5 class="card-title">${statistics.totalQuantity}</h5>
                        </div>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="card text-white bg-info mb-3">
                        <div class="card-header">Average Price</div>
                        <div class="card-body">
                            <h5 class="card-title">${statistics.avgPrice}</h5>
                        </div>
                    </div>
                </div>
            </div>
            <div class="row mt-3">
                <div class="col-md-3">
                    <div class="card text-white bg-warning mb-3">
                        <div class="card-header">Revenue Today</div>
                        <div class="card-body">
                            <h5 class="card-title">${statistics.revenueToday}</h5>
                        </div>
                    </div>
                </div>
                <div class="col-md-3">
                    <div class="card text-white bg-danger mb-3">
                        <div class="card-header">Revenue This Week</div>
                        <div class="card-body">
                            <h5 class="card-title">${statistics.revenueThisWeek}</h5>
                        </div>
                    </div>
                </div>
                <div class="col-md-3">
                    <div class="card text-white bg-secondary mb-3">
                        <div class="card-header">Revenue This Month</div>
                        <div class="card-body">
                            <h5 class="card-title">${statistics.revenueThisMonth}</h5>
                        </div>
                    </div>
                </div>
                <div class="col-md-3">
                    <div class="card text-white bg-dark mb-3">
                        <div class="card-header">Revenue This Year</div>
                        <div class="card-body">
                            <h5 class="card-title">${statistics.revenueThisYear}</h5>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
