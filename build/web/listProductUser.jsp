<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="Controller.ProductController" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Product List</title>
</head>
<body>
    <h1>Product List</h1>
    
    <form action="searchPU" method="get">
        <input type="text" name="txtSearchU" placeholder="Search products...">
        <input type="submit" value="Search">
    </form>

    <c:if test="${not empty searchError}">
        <p style="color: red;">${searchError}</p>
    </c:if>

    <table border="1">
        <thead>
            <tr>
                <th>ID</th>
                <th>Name</th>
                <th>Price</th>
                <th>Quantity</th>
                <th>Description</th>
                <th>Image</th>
                <th>Category ID</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach var="product" items="${li}">
                <tr>
                    <td>${product.productID}</td>
                    <td>${product.name}</td>
                    <td>${product.price}</td>
                    <td>${product.quantity}</td>
                    <td>${product.description}</td>
                    <td><img src="${product.image}" alt="${product.name}" width="100"></td>
                    <td>${product.categoriesID}</td>
                </tr>
            </c:forEach>
        </tbody>
    </table>
</body>
</html>
