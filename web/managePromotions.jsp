<%-- 
    Document   : managePromotions
    Created on : 22-Jun-2024, 13:59:56
    Author     : Le Minh Truong - CE171886
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@page import="java.util.List" %>
<%@page import="Models.Promotion" %>
<%@page import="DAOs.PromotionDAO" %>
<%@page import="DAOs.ProductDAO"%>
<%@page import="Models.Product"%>
<%@page import="java.util.List"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Admin - Manage Promotions</title>
        <!-- Favicon -->
        <link rel="icon" type="image/x-icon" href="assets/img/logo/LogoF.png">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
        <style>
            /* Your existing styles */
            #promotionsTable {
                margin-top: 20px;
                width: 100%;
                border-collapse: collapse;
            }
            #promotionsTable th, #promotionsTable td {
                border: 1px solid #ccc;
                padding: 10px;
                text-align: left;
            }
            .action-buttons {
                display: flex;
                gap: 5px;
            }
        </style>
    </head>
    <body>
        <div class="container mt-5">
            <h1>Manage Promotions</h1>
            <c:if test="${not empty error}">
                <div class="alert alert-danger alert-dismissible fade show" role="alert">
                    ${error}
                    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                </div>
            </c:if>
            <c:if test="${not empty message}">
                <div class="alert alert-success alert-dismissible fade show" role="alert">
                    ${message}
                    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                </div>
            </c:if>
            <!-- Nút quay lại trang Admin Home -->
            <a href="AdminController" class="btn btn-secondary mb-4">Back to Admin Home</a>
            <!-- Search form -->
            <form method="get" action="promotions">
                <div class="input-group mb-3">
                    <input type="text" name="searchCode" id="searchCode" class="form-control" placeholder="Search by promotion code">
                    <button class="btn btn-primary" type="submit">Search</button>
                </div>
            </form>
            <c:if test="${empty promotions and empty error}">
                <div class="alert alert-info">No offers were found that match the code you found.</div>
            </c:if>
            <button class="btn btn-success" id="addPromotionBtn" data-bs-toggle="modal" data-bs-target="#addPromotionModal">Add New Promotion</button>
            <c:if test="${not empty promotions}">
                <table id="promotionsTable">
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>Code</th>
                            <th>Description</th>
                            <th>Discount</th>
                            <th>Start Date</th>
                            <th>End Date</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="promo" items="${promotions}">
                            <tr>
                                <td>${promo.promotionID}</td>
                                <td>${promo.promotionCode}</td>
                                <td>${promo.description}</td>
                                <td>${promo.discount}%</td>
                                <td>${promo.startDate}</td>
                                <td>${promo.endDate}</td>
                                <td class="action-buttons">
                                    <!-- Button trigger modal -->
                                    <button type="button" class="btn btn-warning" data-bs-toggle="modal" data-bs-target="#editModal${promo.promotionID}">Edit</button>

                                    <button class="btn btn-danger" onclick="deletePromotion(${promo.promotionID})">Delete</button>
                                </td>
                            </tr>
                        </c:forEach>
                        <c:forEach var="promo" items="${promotions}">
                            <!-- Modal for editing promotion -->
                        <div class="modal fade" id="editModal${promo.promotionID}" tabindex="-1" role="dialog" aria-labelledby="editModalLabel" aria-hidden="true">
                            <div class="modal-dialog" role="document">
                                <div class="modal-content">
                                    <form action="promotions" method="POST">
                                        <div class="modal-header">
                                            <h5 class="modal-title" id="editModalLabel">Edit Promotion</h5>
                                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                        </div>
                                        <div class="modal-body">
                                            <input type="hidden" name="promotionID" value="${promo.promotionID}">
                                            <input type="hidden" name="action" value="edit">
                                            <div class="form-group">
                                                <label for="promotionCode${promo.promotionID}">Promotion Code</label>
                                                <input type="text" class="form-control" name="promotionCode" id="promotionCode${promo.promotionID}" value="${promo.promotionCode}" required>
                                            </div>
                                            <div class="form-group">
                                                <label for="description${promo.promotionID}">Description</label>
                                                <input type="text" class="form-control" name="description" id="description${promo.promotionID}" value="${promo.description}" required>
                                            </div>
                                            <div class="form-group">
                                                <label for="discount${promo.promotionID}">Discount</label>
                                                <div class="input-group">
                                                    <input type="number" class="form-control" name="discount" id="discount${promo.promotionID}" value="${promo.discount}" min="0" required>
                                                    <span class="input-group-text">%</span>
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <label for="startDate${promo.promotionID}">Start Date</label>
                                                <input type="date" class="form-control" name="startDate" id="startDate${promo.promotionID}" value="${promo.startDate}" required>
                                            </div>
                                            <div class="form-group">
                                                <label for="endDate${promo.promotionID}">End Date</label>
                                                <input type="date" class="form-control" name="endDate" id="endDate${promo.promotionID}" value="${promo.endDate}" required>
                                            </div>
                                        </div>
                                        <div class="modal-footer">
                                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                                            <button type="submit" class="btn btn-warning">Save changes</button>
                                        </div>
                                    </form>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                    </tbody>
                </table>
            </c:if>

            <!-- Modal for adding new promotion -->
            <div class="modal fade" id="addPromotionModal" tabindex="-1" aria-labelledby="addPromotionModalLabel" aria-hidden="true">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <form action="promotions" method="post" id="addPromotionForm" onsubmit="return validatePromotionForm()">
                            <div class="modal-header">
                                <h5 class="modal-title" id="addPromotionModalLabel">Add New Promotion</h5>
                                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                            </div>
                            <div class="modal-body">
                                <input type="hidden" name="action" value="add">
                                <div class="form-group">
                                    <label for="promotionCode">Promotion Code</label>
                                    <input type="text" class="form-control" name="promotionCode" id="promotionCode" >
                                    <div id="promotionCodeError" class="text-danger"></div>
                                </div>
                                <div class="form-group">
                                    <label for="description">Description</label>
                                    <input type="text" class="form-control" name="description" id="description" >
                                    <div id="descriptionError" class="text-danger"></div>
                                </div>
                                <div class="form-group">
                                    <label for="discount">Discount</label>
                                    <div class="input-group">
                                        <input type="number" class="form-control" name="discount" id="discount">                        
                                        <span class="input-group-text">%</span>                                       
                                    </div>
                                    <div id="discountError" class="text-danger"></div>
                                </div>
                                <div class="form-group">
                                    <label for="startDate">Start Date</label>
                                    <input type="date" class="form-control" name="startDate" id="startDate" >
                                    <div id="startDateError" class="text-danger"></div>
                                </div>
                                <div class="form-group">
                                    <label for="endDate">End Date</label>
                                    <input type="date" class="form-control" name="endDate" id="endDate" >
                                    <div id="endDateError" class="text-danger"></div>
                                </div>
                            </div>
                            <div class="modal-footer">
                                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                                <button type="submit" class="btn btn-primary">Add Promotion</button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>

        </div>
        <script>
            window.addEventListener('load', () => {
                const autoCloseAlerts = document.querySelectorAll('.auto-close');
                autoCloseAlerts.forEach(alert => {
                    setTimeout(() => {
                        const bsAlert = new bootstrap.Alert(alert);
                        bsAlert.close();
                    }, 5000); // Thời gian hiển thị thông báo là 5 giây
                });
            });
            // Reset form and show modal when clicking add promotion button
            document.getElementById('addPromotionBtn').addEventListener('click', function () {
                document.getElementById('addPromotionForm').reset();
            });

            // Delete promotion function
            function deletePromotion(promotionID) {
                if (confirm('Are you sure you want to delete this promotion?')) {
                    var form = document.createElement('form');
                    form.method = 'POST';
                    form.action = 'promotions';
                    var inputAction = document.createElement('input');
                    inputAction.type = 'hidden';
                    inputAction.name = 'action';
                    inputAction.value = 'delete';
                    form.appendChild(inputAction);
                    var inputID = document.createElement('input');
                    inputID.type = 'hidden';
                    inputID.name = 'promotionID';
                    inputID.value = promotionID;
                    form.appendChild(inputID);
                    document.body.appendChild(form);
                    form.submit();
                }
            }

            function validatePromotionForm() {
                let isValid = true;
                const promotionCode = document.getElementById('promotionCode');
                const description = document.getElementById('description');
                const discount = document.getElementById('discount');
                const startDate = document.getElementById('startDate');
                const endDate = document.getElementById('endDate');

                // Reset error messages
                document.getElementById('promotionCodeError').innerText = '';
                document.getElementById('descriptionError').innerText = '';
                document.getElementById('discountError').innerText = '';
                document.getElementById('startDateError').innerText = '';
                document.getElementById('endDateError').innerText = '';

                // Check for empty fields and set error messages
                if (promotionCode.value.trim() === '') {
                    document.getElementById('promotionCodeError').innerText = 'Promotion code cannot be empty.';
                    isValid = false;
                } else if (!/^[a-zA-Z0-9_\-]+$/.test(promotionCode.value)) {
                    document.getElementById('promotionCodeError').innerText = 'Promotion code must not contain special characters.';
                    isValid = false;
                }

                if (description.value.trim() === '') {
                    document.getElementById('descriptionError').innerText = 'Description cannot be empty.';
                    isValid = false;
                } else if (!/^[a-zA-Z0-9_\-\s]+$/.test(description.value)) {
                    document.getElementById('descriptionError').innerText = 'Description must not contain special characters.';
                    isValid = false;
                }

                if (discount.value.trim() === '') {
                    document.getElementById('discountError').innerText = 'Discount cannot be empty.';
                    isValid = false;
                } else if (discount.value < 0) {
                    document.getElementById('discountError').innerText = 'Discount cannot be negative.';
                    isValid = false;
                }

                if (startDate.value.trim() === '') {
                    document.getElementById('startDateError').innerText = 'Start date cannot be empty.';
                    isValid = false;
                }

                if (endDate.value.trim() === '') {
                    document.getElementById('endDateError').innerText = 'End date cannot be empty.';
                    isValid = false;
                } else if (new Date(endDate.value) <= new Date(startDate.value)) {
                    document.getElementById('endDateError').innerText = 'End date must be after start date.';
                    isValid = false;
                }

                return isValid;
            }

        </script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
    </body>
</html>