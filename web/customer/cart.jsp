<%-- 
    Document   : cart
    Created on : Jul 3, 2024, 12:47:11 AM
    Author     : Nguyen Van Giau - CE170449
--%>
<%@page import="Models.Cart"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="DAOs.CartDAO"%>
<%@page import="DAOs.AccountDAO"%>
<%@page import="Models.Customer"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Cart Page</title>
        <link rel="icon" href="<%= request.getContextPath()%>/images/LogoF.png" type="image/png" />
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css" crossorigin="anonymous">
        <style>
            .toast-container {
                position: fixed;
                top: 20px;
                right: 20px;
                z-index: 1050;
            }
        </style>
    </head>
    <body>
        <div class="toast-container bg-success">
            <div id="orderSuccessToast" class="toast" role="alert" aria-live="assertive" aria-atomic="true">
                <div class="toast-header">
                    <strong class="me-auto">Order Success</strong>
                    <button type="button" class="btn-close" data-bs-dismiss="toast" aria-label="Close"></button>
                </div>
                <div class="toast-body">
                    <%= session.getAttribute("orderSuccess") != null ? session.getAttribute("orderSuccess") : "" %>
                </div>
            </div>
        </div>
        <form class="mt-3" action="./order" method="post" onsubmit="return validateCheckBox()">
            <div class="container">
                <div class="row">
                    <div class="col-md-8">
                        <p>You currently have <strong>${cart_list.size()}</strong> products in your cart.</p>
                        <c:if test="${cart_list.size() == 0}">
                            <h4 style="text-align: center">Your cart is empty.</h4>
                        </c:if>
                        <div class="row pro-cart-list">
                            <c:forEach items="${cart_list}" var="c">
                                <div class="cart-item row">
                                    <div class="col-md-1 mt-5">
                                        <input type="checkbox" name="checkbox" class="checkBuy" value="${c.cartID}" onchange="calculateTotalPrice()">
                                    </div>
                                    <div class="col-md-2 mt-2 mb-2">
                                        <img src="${c.image}" height="100%" alt="${c.name}" class="img-fluid">
                                    </div>
                                    <div class="col-md-5 mt-3">
                                        <p>${c.name}</p>
                                        <strong class="cart-price">${c.price}<span>VND</span></strong>
                                    </div>
                                    <div class="col-md-4 mt-3 text-end">
                                        <div class="quantity-product text-end col-md-12">
                                            <div class="row text-center">
                                                <a class="btn btn-dark col-md-2 mx-3 btn-decre" href="../cart/decesquan/${c.productID}">-</a>
                                                <input type="text" class="form-control mx-1 cart-quantity" name="quantity" value="${c.quantity}" onchange="calculateTotalPrice()">
                                                <a class="btn col-md-2 btn-sm btn-incre btn-dark mx-2" href="../cart/increquan/${c.productID}">+</a>
                                                <a style="width: fit-content;padding: 5px 65px" class="btn btn-danger btn-sm mt-2" onclick="return confirm('Do you want to remove ${c.name} from your cart?')" href="../cart/delete/${c.cartID}">Remove</a>
                                            </div>

                                        </div>
                                    </div>
                                </div>
                            </c:forEach>
                        </div>
                    </div>
                    <div class="col-md-4">
                        <div class="inf-pay">
                            <h3>Information Order</h3>
                            <h4 class="row">                                   
                                <p class="col-md-4 text-start">Total: </p>                                    
                                <p class="col-md-6" style="color: red"><strong id="total-price" class="col-md-6 text-start" style="color: red;">--</strong> </p>

                            </h4>
                            <p>
                            <ul>
                                <li><p>Shipping fees will be calculated at the checkout page.</p></li>
                                <li><p>You can also enter a discount code at the checkout page.</p></li>
                            </ul>
                            </p>
                        </div>

                        <c:if test="${cart_list.size()!=0}">
                            <input class="pay form-control" value="Check out" name="btnCheckout" type="submit"> 
                        </c:if>
                    </div>
                    <div class="mt-5">
                        <a href="<%= request.getContextPath() %>/" class="btn btn-secondary"><i class="bi bi-house"></i> Back to Home</a>
                    </div>
                </div>
            </div>

        </form>

        <script>
            function validateCheckBox() {
                var checkboxes = document.querySelectorAll(".checkBuy");
                let atLeastOneChecked = false;
                for (var i = 0; i < checkboxes.length; i++) {
                    if (checkboxes[i].checked) {
                        atLeastOneChecked = true;
                        break;
                    }
                }

                if (!atLeastOneChecked) {
                    alert("You must select at least one checkbox.");
                    atLeastOneChecked = false;
                }

                return atLeastOneChecked;
            }

            function changeImage(image) {
                var largeImage = document.getElementById("largeImage");
                largeImage.src = image.src;
            }

            function calculateTotalPrice() {
                var total = 0;
                var checkboxes = document.querySelectorAll(".checkBuy");
                let atLeastOneChecked = false;

                for (var i = 0; i < checkboxes.length; i++) {
                    if (checkboxes[i].checked) {
                        var cartItem = checkboxes[i].closest('.cart-item');
                        var priceElement = cartItem.querySelector('.cart-price');
                        var quantityElement = cartItem.querySelector('.cart-quantity');
                        var price = parseInt(priceElement.textContent); // Get price from HTML element
                        var quantity = parseInt(quantityElement.value); // Get quantity from HTML element
                        total += price * quantity; // Calculate subtotal for this item
                        atLeastOneChecked = true;
                    }
                }

                if (atLeastOneChecked) {
                    document.getElementById('total-price').textContent = total + ' VND'; // Set total price in HTML element
                } else {
                    document.getElementById('total-price').textContent = "--"; // Set placeholder when no items are checked
                }
            }
            // Show the toast if the order was successful
            window.addEventListener('DOMContentLoaded', (event) => {
                const orderSuccess = '<%= session.getAttribute("orderSuccess") != null ? "true" : "false" %>';
                if (orderSuccess === "true") {
                    const orderSuccessToast = new bootstrap.Toast(document.getElementById('orderSuccessToast'));
                    orderSuccessToast.show();
            <% session.removeAttribute("orderSuccess"); %>
                }
            });
        </script>
    </body>
</html>
