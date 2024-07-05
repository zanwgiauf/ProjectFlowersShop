<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="Models.Product" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.List" %>

<!DOCTYPE html>
<html>
<head>
    <title>Product Details</title>
    <link rel="icon" href="<%= request.getContextPath()%>/images/LogoF.png" type="image/png">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css">
    <style>
        body {
            background-color: #f8f9fa; /* Màu nền xám nhạt */
        }
        .product-image-wrapper {
            border: 1px solid #dee2e6;
            border-radius: 5px;
            padding: 10px;
        }
        .product-image {
            max-width: 100%;
            height: auto;
            display: block;
            margin: 0 auto;
        }
        .back-to-home {
            position: absolute;
            top: 10px;
            left: 10px;
        }
        .overview-box {
            background-color: #ffffff; /* Màu nền trắng */
            border: 1px solid #dee2e6;
            border-radius: 5px;
            padding: 10px;
            margin-top: 20px;
        }
    </style>
</head>
<body>
<div class="container mt-5">
    <a href="<%= request.getHeader("referer") %>" class="btn btn-secondary back-to-home">Back to Search</a>
    <h1 class="text-center">Product Details</h1>
    <div class="row mt-5">
        <div class="col-md-4">
            <div class="product-image-wrapper">
                <img src="${product.image}" alt="${product.name}" class="img-fluid product-image">
            </div>
        </div>
        <div class="col-md-8">
            <div class="card">
                <div class="card-header">
                    <h3>${product.name}</h3>
                </div>
                <div class="card-body">
                    <p><strong>Price:</strong> ${product.price}</p>
                    <p><strong>Description:</strong> ${product.description}</p>
                    <p><strong>Quantity in Stock:</strong> ${product.quantity}</p>
                    <form action="AddToCartServlet" method="post" class="mt-3">
                        <div class="mb-3">
                            <label for="quantity" class="form-label">Quantity:</label>
                            <input type="number" id="quantity" name="quantity" value="1" min="1" max="${product.quantity}" class="form-control">
                        </div>
                        <input type="hidden" name="productID" value="${product.productID}">
                        <button type="submit" class="btn btn-primary">Add to Cart</button>
                    </form>
                </div>
            </div>
        </div>
    </div>
    <div class="mt-5">
        <h3>Suggested Products</h3>
        <div class="row">
            <c:forEach var="suggestedProduct" items="${suggestedProducts}">
                <div class="col-md-3">
                    <div class="card mb-4">
                        <img src="${suggestedProduct.image}" class="card-img-top" alt="${suggestedProduct.name}">
                        <div class="card-body">
                            <h5 class="card-title">${suggestedProduct.name}</h5>
                            <p class="card-text">${suggestedProduct.price}</p>
                            <a href="ProductDetailsServlet?productID=${suggestedProduct.productID}" class="btn btn-primary">View Details</a>
                        </div>
                    </div>
                </div>
            </c:forEach>
        </div>
    </div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>