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
    <script>
        function validateAddress() {
            const addressPattern = /^(\d+\s[A-Za-z\s,]+)$/;
            const address = document.getElementById("destinationAddress").value;
            if (!addressPattern.test(address)) {
                alert("Please enter a valid address in the format: '70 Lê Lợi, Cái Khế, Ninh Kiều, Cần Thơ'.");
                return false;
            }
            return true;
        }
    </script>
</head>
<body>
<div class="container mt-5">
    <h1 class="text-center">Product Management</h1>
    
    <div class="d-flex justify-content-center mt-4">
        <form action="SearchProductServlet" method="get" class="d-flex">
            <input class="form-control me-2" type="search" name="txtSearch" placeholder="Search products...">
            <button class="btn btn-primary" type="submit">Search</button>
        </form>
        <button type="button" class="btn btn-secondary ms-3" data-bs-toggle="modal" data-bs-target="#advancedSearchModal">
            <img src="<%= request.getContextPath() %>/images/search.jpg" alt="" width="20">
        </button>
        <a href="<%= request.getContextPath() %>/home" class="btn btn-secondary ms-3">Back To Home</a>
    </div>
    
    <div class="d-flex justify-content-center mt-4">
        <form action="CalculateDistanceServlet" method="post" class="d-flex" onsubmit="return validateAddress()">
            <input class="form-control me-2" type="text" id="destinationAddress" name="destinationAddress" placeholder="Enter destination address...">
            <button class="btn btn-success" type="submit">Calculate Distance</button>
        </form>
    </div>

    <c:if test="${not empty message}">
        <div class="alert alert-info text-center">${message}</div>
    </c:if>

    <c:if test="${not empty searchError}">
        <p style="color: red;" class="text-center mt-3">${searchError}</p>
    </c:if>

    <c:if test="${not empty priceError}">
        <p style="color: red;" class="text-center mt-3">${priceError}</p>
    </c:if>

    <c:if test="${not empty data}">
        <p class="text-center mt-3">There are ${data.size()} matching search results</p>
        <div class="row">
            <c:forEach var="product" items="${data}">
                <div class="col-md-3 mb-4">
                    <div class="card">
                        <img src="${product.image}" class="card-img-top" alt="${product.name}" style="width:100%; height:auto;">
                        <div class="card-body">
                            <h5 class="card-title">${product.name}</h5>
                            <p class="card-text">${product.price}₫</p>
                            <a href="ProductDetailsServlet?productID=${product.productID}" class="btn btn-primary">View Details</a>
                        </div>
                    </div>
                </div>
            </c:forEach>
        </div>
    </c:if>

    <c:if test="${empty data}">
        <p class="text-center mt-3">No products matched.</p>
    </c:if>
</div>

<!-- Advanced Search Modal -->
<div class="modal fade" id="advancedSearchModal" tabindex="-1" aria-labelledby="advancedSearchModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="advancedSearchModalLabel">Advanced Search</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <form action="AdvancedSearchProductServlet" method="get">
                    <div class="mb-3">
                        <label for="minPrice" class="form-label">Min Price:</label>
                        <div class="input-group">
                            <input type="number" class="form-control" id="minPrice" name="minPrice" min="0" step="50000">
                        </div>
                    </div>
                    <div class="mb-3">
                        <label for="maxPrice" class="form-label">Max Price:</label>
                       <input type="number" class="form-control" id="maxPrice" name="maxPrice" min="0" step="50000">
                    </div>
                    <button type="submit" class="btn btn-primary">Apply</button>
                </form>
            </div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
