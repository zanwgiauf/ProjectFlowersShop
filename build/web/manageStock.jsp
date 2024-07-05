<%-- 
    Document   : manageStock.jsp
    Created on : 16-Jun-2024, 22:55:02
    Author     : Le Minh Truong - CE171886
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@page import="DAOs.ProductDAO"%>
<%@page import="Models.Product"%>
<%@page import="java.util.List"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Manage Stock</title>
        <link rel="stylesheet" href="<%= request.getContextPath() %>/lib/bootstrap/bootstrap_css/bootstrap.min.css">
        <!-- Favicon -->
        <link rel="icon" type="image/x-icon" href="assets/img/logo/LogoF.png">
        <style>
            .table-responsive {
                max-height: 400px;
            }
        </style>
    </head>
    <body>
        <div class="container mt-5">
            <h1>Manage Stock</h1>
            <!-- Nút quay lại trang Admin Home -->
            <a href="AdminController" class="btn btn-secondary mb-4">Back to Management Home</a>
            <form method="get" action="managestock">
                <div class="input-group mb-3">
                    <input type="text" name="search" class="form-control" placeholder="Search by product name">
                    <button class="btn btn-outline-secondary" type="submit">Search</button>
                </div>
            </form>
            <c:if test="${not empty searchPerformed and products.isEmpty()}">
                <div class="alert alert-info">No products were found with the name you entered.</div>
            </c:if>
            <c:if test="${not empty products}">
                <div class="table">

                    <table class="table table-striped">
                        <thead>
                            <tr>
                                <th>Product ID</th>
                                <th>Name</th>
                                <th>Price</th>
                                <th>Reduced Price</th>
                                <th>Quantity</th>
                                <th>Import</th>
                                <th>Export</th>
                                <th>Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <%
                                ProductDAO productDAO = new ProductDAO();
                                List<Product> products;
                                String search = request.getParameter("search");
                                if (search != null && !search.isEmpty()) {
                                    products = productDAO.searchProductsByName(search);
                                } else {
                                    products = productDAO.getAllProducts();
                                }

                                for (Product product : products) {
                            %>
                            <tr>
                                <td><%= product.getProductID() %></td>
                                <td><%= product.getName() %></td>
                                <td><%= product.getPrice() %></td>
                                <td><%= product.getReducedPrice() %></td>
                                <td><%= product.getQuantity() %></td>
                                <td><input type="number" value= "0" min="0" class="form-control" id="import<%= product.getProductID() %>"></td>
                                <td><input type="number" value= "0" min="0" class="form-control" id="export<%= product.getProductID() %>"></td>
                                <td>
                                    <button class="btn btn-primary" onclick="updateStock(<%= product.getProductID() %>)">Update</button>
                                </td>
                            </tr>
                            <% } %>
                        </tbody>
                    </table>

                </div>
            </c:if>
        </div>

        <script>
            function updateStock(productId) {
                var importQty = document.getElementById('import' + productId).value;
                var exportQty = document.getElementById('export' + productId).value;
                var xhr = new XMLHttpRequest();
                xhr.open("POST", "managestock", true);
                xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
                xhr.onreadystatechange = function () {
                    if (xhr.readyState == 4 && xhr.status == 200) {
                        alert("Stock updated successfully!");
                        window.location.reload();
                    }
                };
                xhr.send("productId=" + productId + "&importQty=" + importQty + "&exportQty=" + exportQty);
            }
        </script>
        <script src="<%= request.getContextPath()%>/lib/bootstrap/bootstrap_js/bootstrap.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.11.0/umd/popper.min.js"
                integrity="sha384-b/U6ypiBEHpOf/4+1nzFpr53nxSS+GLCkfwBdFNTxtclqqenISfwAzpKaMNFNmj4"
        crossorigin="anonymous"></script>
    </body>
</html>

