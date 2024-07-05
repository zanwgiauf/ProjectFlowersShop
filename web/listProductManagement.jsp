<%-- 
    Document   : listProductManagement.jsp
    Created on : Jun 15, 2024, 1:57:00 PM
    Author     : Thang Tai
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="java.util.List" %>
<%@ page import="Models.Product" %>

<!DOCTYPE html>
<html>
<head>
    <title>Product Management</title>
    <link rel="icon" href="<%= request.getContextPath()%>/images/LogoF.png" type="image/png">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css">
</head>
<body>
<div class="container mt-5">
    <h1 class="text-center">Product Management</h1>
    <div class="d-flex justify-content-center mt-4">
        <form action="SearchProductServlet" method="get" class="d-flex">
            <input class="form-control me-2" type="search" name="txtSearch" placeholder="Search products...">
            <button class="btn btn-primary" type="submit">Search</button>
        </form>
        <a href="<%= request.getContextPath() %>/home" class="btn btn-secondary ms-3">Back To Home</a>
    </div>

    <c:if test="${not empty searchError}">
        <p style="color: red;" class="text-center mt-3">${searchError}</p>
    </c:if>

    <div class="d-flex justify-content-end mt-4">
        <a href="StatisticsServlet" class="btn btn-success">View Statistics</a>
    </div>

    <table class="table table-bordered mt-5">
        <thead>
        <tr>
            <th>ID</th>
            <th>Name</th>
            <th>Price</th>
            <th>Reduced Price</th>
            <th>Quantity</th>
            <th>Description</th>
            <th>Image</th>
            <th>Category ID</th>
            
        </tr>
        </thead>
        <tbody>
        <c:forEach var="product" items="${data}">
            <tr>
                <td>${product.productID}</td>
                <td>${product.name}</td>
                <td>${product.price}</td>
                <td>${product.reducedPrice}</td>
                <td>${product.quantity}</td>
                <td>${product.description}</td>
                <td><img src="${product.image}" alt="${product.name}" width="100"></td>
                <td>${product.categoryID}</td>
                <td>
                    <a href="ProductDetailsServlet?productID=${product.productID}" class="btn btn-info">View Details</a>
                </td>
            </tr>
        </c:forEach>
        </tbody>
    </table>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.min.js"></script>
</body>
</html>
