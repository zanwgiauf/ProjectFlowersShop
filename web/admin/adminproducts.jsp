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
<div class="container-fluid">
    <div class="row">
        <!-- Sidebar -->
        <nav id="sidebar" class="col-md-2 d-none d-md-flex sidebar">
            <div class="container sidebar-sticky text-decoration-none text-white">
                <a href="<%=request.getContextPath()%>/admin" class="fs-4 fw-bold d-flex justify-content-center align-items-center text-white">
                    <i class="bi bi-person-circle mx-2 "></i>
                    <span>Admin</span>
                </a>

                <ul class="nav flex-column mt-3">
                    <li class="nav-item">
                        <a class="nav-link active" href="<%=request.getContextPath()%>/admin">
                            <i class="bi bi-speedometer2"></i>
                            Dashboard
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="#">
                            <i class="bi bi-shop"></i>
                            My Store
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="#">
                            <i class="bi bi-list-check"></i>
                            Manage Stock
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="#">
                            <i class="bi bi-graph-up"></i>
                            Analytic
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class=" dropdown-toggle"  data-bs-toggle="collapse" data-bs-target="#manageUserAccounts" aria-expanded="false" aria-controls="manageUserAccounts">
                            <i class="bi bi-people"></i>
                            <span>Manage User Accounts</span>
                        </a>
                        <div class="collapse ms-3" id="manageUserAccounts">
                            <a href="#" class="dropdown-item">Manage Employee Accounts</a>
                            <a href="#" class="dropdown-item">Manage Customer Accounts</a>
                        </div>
                    </li>

                    <li class="nav-item">
                        <a class="nav-link" href="#">
                            <i class="bi bi-clipboard"></i>
                            List Customer Orders
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="#">
                            <i class="bi bi-tags"></i>
                            Category
                        </a>
                    </li>
                    <li class="nav-item">
                        <a href="<%= request.getContextPath() %>/admin/adminproducts" class="nav-link text-white">Manage Product <i class="bi bi-box"></i></a> 
                    </li>
                </ul>
                <form action="http://localhost:8080/FlowerShopWebsite/logout" method="post" class="mt-4 me-2" >
                    <button class="btn btn-outline-dark  w-100" style="border-radius: 16px" name="btnLogout">Logout</button>
                </form>
            </div>
        </nav>

        <!-- Content -->
        <div id="content" class="col-md-10">
            <h1>Product Management</h1>

            <!-- Success Message -->
            <c:if test="${not empty sessionScope.message}">
                <div class="alert alert-success">
                    ${sessionScope.message}
                    <c:remove var="message" scope="session"/>
                </div>
            </c:if>

            <!-- Add New Product Button -->
            <button class="btn btn-primary mb-3" onclick="showAddProductForm()">Add New Product</button>

            <!-- Modal thêm sản phẩm -->
            <div class="modal fade" id="addProductModal" tabindex="-1" aria-labelledby="addProductModalLabel" aria-hidden="true">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title" id="addProductModalLabel">Add New Product</h5>
                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                        </div>
                        <div class="modal-body">
                            <form id="addProductForm" action="${pageContext.request.contextPath}/admin/adminproducts" method="post" enctype="multipart/form-data">
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
                        </div>
                    </div>
                </div>
            </div>

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

            <!-- Product List -->
            <h2>Product List</h2>

         <!-- Search Form -->
<form class="d-flex mb-4" action="${pageContext.request.contextPath}/admin/adminproducts" method="get" onsubmit="return validateSearch()">
    <input type="hidden" name="action" value="search">
    <input id="searchInput" class="form-control me-2" type="search" name="keyword" placeholder="Search products" aria-label="Search">
    <button class="btn btn-outline-success" type="submit">Search</button>
</form>
<a href="${pageContext.request.contextPath}/admin/adminproducts" class="btn btn-outline-secondary ms-2">Back to List</a>

<!-- Khối thông báo khi không có kết quả -->
<div id="noResultMessage" class="alert alert-warning" style="display: ${empty noResultMessage ? 'none' : 'block'};">
    ${noResultMessage}
</div>

<!-- Product Table -->
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
<!-- Bootstrap JS Bundle -->
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

    function showAddProductForm() {
        var myModal = new bootstrap.Modal(document.getElementById('addProductModal'));
        myModal.show();
    }
    // JavaScript để kiểm tra và hiển thị khối thông báo khi không có kết quả
    document.addEventListener("DOMContentLoaded", function() {
        var noResultMessage = "${noResultMessage}";
        if (noResultMessage.trim() !== "") {
            document.getElementById('noResultMessage').style.display = 'block';
        } else {
            document.getElementById('noResultMessage').style.display = 'none';
        }
    });

    function validateSearch() {
        var keyword = document.getElementById('searchInput').value.trim(); // Lấy giá trị từ khoá tìm kiếm và loại bỏ các khoảng trắng thừa
        if (keyword === "") {
            alert("Please enter a search keyword."); // Thông báo nếu trường tìm kiếm trống
            return false; // Ngăn form submit
        }
        return true; // Cho phép form submit nếu đã nhập từ khoá
    }
</script>

</body>
</html>