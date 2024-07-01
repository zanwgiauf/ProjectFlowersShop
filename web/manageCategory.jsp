<%-- 
    Document   : manageCategory
    Created on : 26-Jun-2024, 01:43:58
    Author     : Le Minh Truong - CE171886
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@page import="DAOs.CategoryDAO"%>
<%@page import="Models.Category"%>
<%@page import="java.util.List"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Manage Category</title>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css">
    </head>
    <body>
        <div class="container mt-5">
            <h1 class="mb-4">Manage Category</h1>
            <c:if test="${not empty message}">
                <div class="alert alert-success alert-dismissible fade show auto-close" role="alert">
                    ${message}
                    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                </div>
            </c:if>
            <!-- Nút quay lại trang Admin Home -->
            <a href="AdminController" class="btn btn-secondary mb-4">Back to Admin Home</a>
            <!-- Form Tìm kiếm Danh mục -->
            <form action="managecategories" method="get" class="mb-4">
                <div class="input-group">
                    <input type="text" name="name" class="form-control" placeholder="Enter the name of the category to search">
                    <button class="btn btn-primary" type="submit" name="action" value="search">Search</button>
                </div>
            </form>
            <c:if test="${empty categories}">
                <div class="alert alert-info">No category was found with the name you entered.</div>
            </c:if>

            <!-- Button để mở modal thêm danh mục -->
            <button class="btn btn-success mb-4" data-bs-toggle="modal" data-bs-target="#addCategoryModal">Add new category</button>

            <!-- Bảng danh mục -->
            <c:if test="${not empty categories}">
                <table class="table table-bordered">
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>Category name</th>
                            <th>Action</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="category" items="${categories}">
                            <tr>
                                <td>${category.categoryID}</td>
                                <td>${category.name}</td>
                                <td>
                                    <!-- Button để mở modal sửa danh mục -->
                                    <button class="btn btn-warning" data-bs-toggle="modal" data-bs-target="#editCategoryModal" onclick="editCategory(${category.categoryID}, '${category.name}')">Edit</button>

                                    <!-- Form xóa danh mục -->
                                    <form id="deleteForm_${category.categoryID}" action="managecategories" method="post" class="d-inline-block">
                                        <input type="hidden" name="categoryID" value="${category.categoryID}">
                                        <input type="hidden" name="action" value="delete">
                                        <button class="btn btn-danger" type="submit" onclick="confirmDelete(${category.categoryID})">Delete</button>
                                    </form>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </c:if>
        </div>

        <!-- Modal thêm danh mục -->
        <div class="modal fade" id="addCategoryModal" tabindex="-1" aria-labelledby="addCategoryModalLabel" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="addCategoryModalLabel">Add New Category</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <form action="managecategories" method="post">
                        <div class="modal-body">
                            <div class="input-group">
                                <input type="text" name="name" class="form-control" placeholder="Enter a new category name">
                            </div>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                            <button type="submit" class="btn btn-success" name="action" value="add">Add</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>

        <!-- Modal sửa danh mục -->
        <div class="modal fade" id="editCategoryModal" tabindex="-1" aria-labelledby="editCategoryModalLabel" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="editCategoryModalLabel">Edit Category</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <form action="managecategories" method="post">
                        <div class="modal-body">
                            <input type="hidden" name="categoryID" id="editCategoryID">
                            <div class="input-group">
                                <input type="text" name="name" class="form-control" id="editCategoryName">
                            </div>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                            <button type="submit" class="btn btn-warning" name="action" value="edit">Save changes</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>

        <script type="text/javascript">
            window.addEventListener('load', () => {
                const autoCloseAlerts = document.querySelectorAll('.auto-close');
                autoCloseAlerts.forEach(alert => {
                    setTimeout(() => {
                        const bsAlert = new bootstrap.Alert(alert);
                        bsAlert.close();
                    }, 5000); // Thời gian hiển thị thông báo là 5 giây
                });
            });

            function confirmDelete(categoryID) {
                var result = confirm("Are you sure you want to delete this category?");
                if (result) {
                    document.getElementById('deleteForm_' + categoryID).submit();
                }
            }

            function editCategory(id, name) {
                // Điền dữ liệu của danh mục hiện tại vào modal
                document.getElementById('editCategoryID').value = id;
                document.getElementById('editCategoryName').value = name;
            }
        </script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>
