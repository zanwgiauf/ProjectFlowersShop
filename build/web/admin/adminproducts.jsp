<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>Admin Product Management</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/lib/bootstrap/bootstrap_css/bootstrap.min.css" />
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.2/font/bootstrap-icons.min.css" />
    <style>
        body {
            font-family: 'Roboto', sans-serif;
        }
        #sidebar {
            height: 100vh;
            background: #7b88a8;
            padding: 10px;
            position: sticky;
            top: 0;
        }
        #sidebar a {
            color: #fff;
            display: block;
            padding: 10px;
            text-decoration: none;
        }
        #sidebar a:hover {
            background: #495057;
        }
        #content {
            padding: 20px;
        }
        .table-responsive {
            max-height: 400px;
        }
        .alert {
            margin-top: 20px;
        }
    </style>
</head>
<body>
<div class="container">
    <div class="row">
        <nav id="sidebar" class="col-md-2 d-none d-md-flex sidebar">
            <div class="sidebar-sticky">
                <ul class="nav flex-column">
                    <li class="nav-item">
                        <a class="nav-link active" href="${pageContext.request.contextPath}/admin/adminproducts">
                            <i class="bi bi-box"></i>
                            Manage Products
                        </a>
                    </li>
                </ul>
            </div>
        </nav>
        <div id="content" class="col-md-10">
            <h1>Product Management</h1>
            <c:if test="${not empty sessionScope.message}">
                <div class="alert alert-success">
                    ${sessionScope.message}
                    <c:remove var="message" scope="session"/>
                </div>
            </c:if>
            <h2>Add Product</h2>
            <form action="${pageContext.request.contextPath}/admin/adminproducts" method="post" enctype="multipart/form-data">
                <input type="hidden" name="action" value="add">
                Name: <input type="text" name="name" class="form-control" required><br>
                Description: <input type="text" name="description" class="form-control" required><br>
                Price: <input type="number" name="price" class="form-control" required><br>
                Reduced Price: <input type="number" name="reducedPrice" class="form-control" required><br>
                Quantity: <input type="number" name="quantity" class="form-control" required><br>
                Image: <input type="file" name="image" class="form-control" required><br>
                Category ID: <input type="number" name="categoryID" class="form-control" required><br>
                <button type="submit" class="btn btn-primary">Add Product</button>
            </form>

            <!-- Edit Product Modal -->
            <div class="modal fade" id="editProductModal" tabindex="-1" aria-labelledby="editProductModalLabel" aria-hidden="true">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title" id="editProductModalLabel">Edit Product</h5>
                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                        </div>
                        <div class="modal-body">
                            <form id="editProductForm" action="${pageContext.request.contextPath}/admin/adminproducts" method="post" enctype="multipart/form-data">
                                <input type="hidden" name="action" value="update">
                                <input type="hidden" name="productId" id="editProductId">
                                Name: <input type="text" name="name" class="form-control" id="editProductName" required><br>
                                Description: <input type="text" name="description" class="form-control" id="editProductDescription" required><br>
                                Price: <input type="number" name="price" class="form-control" id="editProductPrice" required><br>
                                Reduced Price: <input type="number" name="reducedPrice" class="form-control" id="editProductReducedPrice" required><br>
                                Quantity: <input type="number" name="quantity" class="form-control" id="editProductQuantity" required><br>
                                Existing Image: <img id="editProductImage" src="" alt="" width="50"><br>
                                <input type="hidden" name="existingImage" id="editProductExistingImage">
                                New Image: <input type="file" name="image" class="form-control"><br>
                                Category ID: <input type="number" name="categoryID" class="form-control" id="editProductCategoryID" required><br>
                                <button type="submit" class="btn btn-primary">Update Product</button>
                            </form>
                        </div>
                    </div>
                </div>
            </div>

            <h2>Product List</h2>
            <div class="table-responsive">
                <table class="table">
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>Name</th>
                            <th>Description</th>
                            <th>Price</th>
                            <th>Reduced Price</th>
                            <th>Quantity</th>
                            <th>Image</th>
                            <th>Category ID</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="product" items="${products}">
                            <tr>
                                <td>${product.productID}</td>
                                <td>${product.name}</td>
                                <td>${product.description}</td>
                                <td>${product.price}</td>
                                <td>${product.reducedPrice}</td>
                                <td>${product.quantity}</td>
                                <td><img src="${pageContext.request.contextPath}/${product.image}" alt="${product.name}" width="50"></td>
                                <td>${product.categoryID}</td>
                                <td>
                                    <button class="btn btn-secondary" onclick="editProduct(${product.productID}, '${product.name}', '${product.description}', ${product.price}, ${product.reducedPrice}, ${product.quantity}, '${product.image}', ${product.categoryID})">Edit</button>
                                    <form action="${pageContext.request.contextPath}/admin/adminproducts" method="post" style="display:inline;">
                                        <input type="hidden" name="action" value="delete">
                                        <input type="hidden" name="productId" value="${product.productID}">
                                        <button type="submit" class="btn btn-danger">Delete</button>
                                    </form>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
<script>
    function editProduct(id, name, description, price, reducedPrice, quantity, image, categoryID) {
        document.getElementById('editProductId').value = id;
        document.getElementById('editProductName').value = name;
        document.getElementById('editProductDescription').value = description;
        document.getElementById('editProductPrice').value = price;
        document.getElementById('editProductReducedPrice').value = reducedPrice;
        document.getElementById('editProductQuantity').value = quantity;
        document.getElementById('editProductImage').src = '${pageContext.request.contextPath}/' + image;
        document.getElementById('editProductExistingImage').value = image;
        document.getElementById('editProductCategoryID').value = categoryID;

        var myModal = new bootstrap.Modal(document.getElementById('editProductModal'));
        myModal.show();
    }
</script>
</body>
</html>
