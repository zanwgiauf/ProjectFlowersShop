<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="Models.Product" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.List" %>
<!DOCTYPE html>
<html>
    <head>
        <title>Product Details</title>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="Website Icon" href="<%= request.getContextPath()%>/images/LogoF.png" type="png" />
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.2/font/bootstrap-icons.min.css" />
        <link rel="stylesheet" href="<%= request.getContextPath()%>/lib/bootstrap/bootstrap_css/bootstrap.min.css" />
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/mdbootstrap/4.19.1/css/mdb.min.css" />
        <link rel="stylesheet" type="text/css" href="https://cdn.jsdelivr.net/npm/toastify-js/src/toastify.min.css">
        <script type="text/javascript" src="https://cdn.jsdelivr.net/npm/toastify-js"></script>
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.10.2/dist/umd/popper.min.js"
                integrity="sha384-7+zCNj/IqJ95wo16oMtfsKbZ9ccEh31eOz1HGyDuCQ6wgnyJNSYdrPa03rtR1zdB" crossorigin="anonymous"
        defer></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.min.js"
                integrity="sha384-QJHtvGhmr9XOIpI6YVutG+2QOK9T+ZnN4kzFN1RtK3zEFEIsxhlmWl5/YESvpZ13" crossorigin="anonymous"
        defer></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/mdbootstrap/4.19.1/js/mdb.min.js"></script>
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
            .feedback-card {
                border: 1px solid #dee2e6;
                border-radius: 5px;
                padding: 10px;
                margin-bottom: 15px;
                background-color: #ffffff;
            }
            .feedback-card-header {
                font-weight: bold;
            }
            .feedback-card-footer {
                font-size: 0.85rem;
                color: #6c757d;
            }
            .edit-feedback {
                float: right;
                cursor: pointer;
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
                            <form action="cart" method="post" class="mt-3">
                                <div class="mb-3">
                                    <label for="quantity" class="form-label">Quantity:</label>
                                    <input type="number" id="quantity" name="quantity" value="1" min="1" max="${product.quantity}" class="form-control">
                                </div>
                                <input type="hidden" name="productID" value="${product.productID}">
                                <input type="hidden" name="action" value="add">
                                <button type="submit" class="btn btn-primary">Add to Cart</button>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
             <div class="mt-5">
                <h3>Feedback</h3>
                <c:forEach items="${feedback}" var="f">
                    <div class="feedback-card">
                        <div class="feedback-card-header">
                            ${f.customer.fullName} 
                            <i class="bi bi-pencil-square btn btn-warning btn-sm edit-feedback"
                               data-feedback-id="${f.feedbackID}"
                               data-feedback-content="${f.content}"
                               data-bs-toggle="modal"
                               data-bs-target="#editFeedbackModal${f.feedbackID}">
                            </i>
                        </div>
                        <div class="feedback-card-body">
                            <span>${f.content}</span>
                        </div>
                        <div class="feedback-card-footer">
                            Created on: ${f.createdDate}
                        </div>
                    </div>

                    <div class="modal fade" id="editFeedbackModal${f.feedbackID}" tabindex="-1" aria-labelledby="editFeedbackModalLabel" aria-hidden="true">
                        <div class="modal-dialog">
                            <div class="modal-content">
                                <div class="modal-header">
                                    <h5 class="modal-title" id="editFeedbackModalLabel">Edit Feedback</h5>
                                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                </div>
                                <form id="editFeedbackForm${f.feedbackID}" action="${pageContext.request.contextPath}/customer-feedback" method="post">
                                    <div class="modal-body">
                                        <input type="hidden" name="id" value="${f.feedbackID}">
                                        <input type="hidden" name="pid" value="${product.productID}">
                                        <input type="hidden" name="action" value="update">
                                        <div class="mb-3">
                                            <label for="editFeedbackContent${f.feedbackID}" class="form-label">Feedback:</label>
                                            <textarea id="editFeedbackContent${f.feedbackID}" name="content" rows="3" class="form-control">${f.content}</textarea>
                                            <div id="editFeedbackError${f.feedbackID}" class="text-danger"></div>
                                        </div>
                                    </div>
                                    <div class="modal-footer">
                                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                                        <button type="submit" class="btn btn-primary">Save changes</button>
                                    </div>
                                </form>
                            </div>
                        </div>
                    </div>
                </c:forEach>

                <br>
                <c:if test="${customerInfor != null}" >
                    <form id="feedbackForm" action="${pageContext.request.contextPath}/customer-feedback" method="post">
                        <div class="mb-3">
                            <label for="feedbackMessage" class="form-label">Feedback:</label>
                            <input type="hidden" name="pid" value="${product.productID}">
                            <input type="hidden" name="action" value="add">
                            <textarea id="feedbackMessage" name="content" rows="3" class="form-control"></textarea>
                            <div id="feedbackError" class="text-danger"></div>
                        </div>
                        <button type="submit" class="btn btn-primary">Add Feedback</button>
                    </form>
                </c:if>
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

        <script>
            document.addEventListener("DOMContentLoaded", function () {
                // Validate feedback form before submission
                document.getElementById('feedbackForm').addEventListener('submit', function (event) {
                    let feedbackMessage = document.getElementById('feedbackMessage').value.trim();

                    if (feedbackMessage === '') {
                        event.preventDefault(); // Prevent form submission
                        document.getElementById('feedbackError').textContent = 'Feedback cannot be empty.';
                        document.getElementById('feedbackMessage').classList.add('is-invalid');
                    } else {
                        document.getElementById('feedbackError').textContent = '';
                        document.getElementById('feedbackMessage').classList.remove('is-invalid');
                    }
                });

                // Validate edit feedback form before submission
                document.querySelectorAll('[id^="editFeedbackForm"]').forEach(function (form) {
                    form.addEventListener('submit', function (event) {
                        let feedbackID = this.querySelector('input[name="id"]').value;
                        let editFeedbackContent = document.getElementById('editFeedbackContent' + feedbackID).value.trim();

                        if (editFeedbackContent === '') {
                            event.preventDefault(); // Prevent form submission
                            document.getElementById('editFeedbackError' + feedbackID).textContent = 'Feedback cannot be empty.';
                            document.getElementById('editFeedbackContent' + feedbackID).classList.add('is-invalid');
                        } else {
                            document.getElementById('editFeedbackError' + feedbackID).textContent = '';
                            document.getElementById('editFeedbackContent' + feedbackID).classList.remove('is-invalid');
                        }
                    });
                });

                // Show Toastify messages if any
                var msg = '<c:out value="${sessionScope.msg}" />';
                var err = '<c:out value="${sessionScope.err}" />';
                if (msg) {
                    Toastify({
                        text: msg,
                        duration: 3000,
                        gravity: "top",
                        position: "right",
                        backgroundColor: "green",
                    }).showToast();
            <c:remove var="msg" scope="session"/>
                }

                if (err) {
                    Toastify({
                        text: err,
                        duration: 3000,
                        gravity: "top",
                        position: "right",
                        backgroundColor: "red",
                    }).showToast();
            <c:remove var="err" scope="session"/>
                }
            });
        </script>
    </body>
</html>
