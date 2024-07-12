<%-- 
    Document   : checkout
    Created on : Jul 1, 2024, 3:14:23 PM
    Author     : Nguyen Van Giau - CE170449
--%>

<%@page import="Models.Cart"%>
<%@page import="DAOs.AccountDAO"%>
<%@page import="DAOs.CartDAO"%>
<%@page import="Models.Customer"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Checkout Page</title>
        <link rel="icon" href="<%= request.getContextPath()%>/images/LogoF.png" type="image/png" />
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css" crossorigin="anonymous">
        <style>
            body {
                padding: 20px;
                background-color: #f8f9fa;
            }
            .container {
                max-width: 1200px;
            }
            .table-img {
                width: 50px;
                height: 50px;
                object-fit: cover;
            }
            .card-header {
                background-color: #343a40;
                color: #fff;
            }
            .card-body {
                background-color: #ffffff;
            }
            .btn-primary {
                background-color: #007bff;
                border: none;
            }
            .btn-primary:hover {
                background-color: #0056b3;
            }
            .btn-secondary {
                background-color: #6c757d;
                border: none;
            }
            .btn-secondary:hover {
                background-color: #5a6268;
            }
            .error-message {
                color: red;
                display: none;
            }
        </style>
    </head>
    <body>
        <%
            String fullName = "";
            int customerID = 0;
            Cookie cookies[] = request.getCookies();
            if (cookies != null) {
                for (Cookie cookie : cookies) {
                    if (cookie.getName().contains("roleA")) {
                        response.sendRedirect(request.getContextPath() + "/admin");
                    } else if (cookie.getName().contains("roleE")) {
                        response.sendRedirect(request.getContextPath() + "/employee");
                    } else {
                        if (cookie.getName().equals("fullNameC")) {
                            fullName = cookie.getValue();
                        } else if (cookie.getName().equals("idC")) {
                            customerID = Integer.parseInt(cookie.getValue());
                        }
                    }
                }
            }
            AccountDAO ad = new AccountDAO();
        %>
        <div class="container-fluid">
            <h2 class="text-center text-info text-uppercase my-3">Check out</h2>
            <c:if test="${not empty errors}">
                <div class="alert alert-danger">
                    <ul>
                        <c:forEach var="error" items="${errors}">
                            <li>${error}</li>
                            </c:forEach>
                    </ul>
                </div>
            </c:if>
            <div class="row">
                <div class="col-md-6">
                    <h4 class="text-center text-uppercase">Shipping Information</h4>
                    <form id="placeOrder" action="order" method="post" onsubmit="return validatePlaceOrder()">
                        <div class="row mt-2">
                            <div class="mt-2">
                                <input type="text" class="form-control" value="<%= ad.decodeString(fullName) %>" placeholder="Your Name" readonly>
                            </div>
                            <div class="mt-2">
                                <input type="text" class="form-control" name="phone" placeholder="Phone">
                                <div id="phone-error" class="error-message"></div>
                            </div>
                        </div>
                        <div class="mt-2">
                            <select name="address" class="form-control" onchange="calculateShippingFee()">
                                <option value="">Select District</option>
                                <option value="Ninh Kieu">Ninh Kieu</option>
                                <option value="Binh Thuy">Binh Thuy</option>
                                <option value="Cai Rang">Cai Rang</option>
                                <option value="O Mon">O Mon</option>
                                <option value="Thot Not">Thot Not</option>
                                <option value="Phong Dien">Phong Dien</option>
                                <option value="Co Do">Co Do</option>
                                <option value="Thoi Lai">Thoi Lai</option>
                                <option value="Vinh Thanh">Vinh Thanh</option>
                            </select>
                            <div id="delivery-address-error" class="error-message"></div>
                        </div>
                        <div class="mt-2">
                            <textarea name="note" placeholder="Note" class="form-control"></textarea>
                        </div>
                                                
                        <div class="mt-2">
                        <input type="checkbox" name="d" value="0"/> Cash on Delivery
                        <input type="checkbox" name="d" value="1"/> Bank Transfer
                        </div>
                        
                        <button type="submit" class="order-now form-control mt-2" name="btnPlaceOrder"><i class="bi bi-bag-fill"></i>Place Order</button>            
                    </form>
                </div>
                <div class="col-md-6 border-left">
                    <div class="product-table-container">
                        <c:if test="${cart_out.size()!=0}">
                            <h6 style="color: red">This product is not enough quantity!</h6>
                            <table class="table">
                                <thead class="place-title-th">
                                    <tr>
                                        <th></th>
                                        <th>Name</th>
                                        <th>Quantity</th>
                                        <th>Price</th>
                                    </tr>
                                </thead>
                                <c:forEach items="${cart_out}" var="c">
                                    <tbody class="place-title-tb">
                                        <tr>
                                            <td>
                                                <img src="./images/${c.image}" width="100px" class="img-fluid" alt="">
                                            </td>
                                            <td>${c.name}</td>
                                            <td>${c.quantity}</td>
                                            <td>${c.price}</td>
                                        </tr>
                                    </tbody>
                                </c:forEach>
                            </table>
                        </c:if>
                        <c:if test="${cart_buy.size()!=0}">
                            <h6 style="color: green">This product is available for purchase</h6>
                            <table class="table">
                                <thead class="place-title-th">
                                    <tr>
                                        <th></th>
                                        <th>Name</th>
                                        <th>Quantity</th>
                                        <th>Price</th>
                                    </tr>
                                </thead>
                                <c:forEach items="${cart_buy}" var="c">
                                    <tbody class="place-title">
                                        <tr>
                                            <td>
                                                <img src="${c.image}" width="100px" height="100%" class="img-fluid" alt="${c.image}">
                                            </td>
                                            <td>${c.name}</td>
                                            <td>${c.quantity}</td>
                                            <td>${c.price} VND</td>
                                        </tr>
                                    </tbody>
                                </c:forEach>
                            </table>
                        </c:if>
                    </div>
                    <div class="place-tt"></div>
                    <div class="place-total">
                        <h4>Total: <span id="total-price" data-total-price="${totalPrice}">${totalPrice}</span> VND</h4>
                        <h4>Shipping Fee: <span id="shipping-fee">0</span> VND</h4>
                    </div>
                </div>
                <div class="mt-4">
                    <a href="<%= request.getContextPath() %>/cart" class="btn btn-secondary"><i class="bi bi-cart2"></i>Back to Cart</a>
                </div>
            </div>
        </div>
        <script>
            // Get shipping fees from backend (from Map)
            const shippingFees = {
                "Ninh Kieu": 20000,
                "Binh Thuy": 25000,
                "Cai Rang": 30000,
                "O Mon": 35000,
                "Thot Not": 40000,
                "Phong Dien": 45000,
                "Co Do": 50000,
                "Thoi Lai": 55000,
                "Vinh Thanh": 60000
            };
            function calculateShippingFee() {
                let address = document.querySelector('select[name="address"]').value;
                let shippingFee = shippingFees[address] || 0;
                document.getElementById('shipping-fee').innerText = shippingFee;
                let totalPriceElement = document.getElementById('total-price');
                let baseTotalPrice = parseInt(totalPriceElement.getAttribute('data-total-price'));
                let totalPrice = baseTotalPrice + shippingFee;
                totalPriceElement.innerText = totalPrice;
            }

            document.querySelector('select[name="address"]').addEventListener('change', calculateShippingFee);
            function resetErrorMessages() {
                document.querySelectorAll('.error-message').forEach(function (el) {
                    el.style.display = 'none';
                });
            }

            function displayErrorMessage(id, message) {
                let errorElement = document.getElementById(id);
                if (errorElement) {
                    errorElement.textContent = message;
                    errorElement.style.display = 'block';
                }
            }

            function validatePlaceOrder() {
                let phone = document.querySelector('#placeOrder input[name="phone"]').value;
                let deliveryAddress = document.querySelector('#placeOrder select[name="address"]').value;
                // Reset error messages before validation
                resetErrorMessages();
                let hasError = false;

                // Validate phone number
                if (phone === '') {
                    displayErrorMessage('phone-error', 'Please enter your phone number.');
                    hasError = true;
                } else {
                    var phonePattern = /^(03[2-9]|05[6|8|9]|07[0|6-9]|08[1-6|8-9]|09[0-9])[0-9]{7}$/;
                    if (/[@#%&*!-]/.test(phone) && /[a-zA-Z]/.test(phone)) {
                        displayErrorMessage('phone-error', 'Phone number must not contain special characters and letters.');
                        hasError = true;
                    }
                    else if (/[@#%&*!-]/.test(phone)) {
                        displayErrorMessage('phone-error', 'Phone number must not contain special characters.');
                        hasError = true;
                    } else if (/[a-zA-Z]/.test(phone)) {
                        displayErrorMessage('phone-error', 'Phone number must not contain letters.');
                        hasError = true;
                    } else if (phone.trim().length !== 10) {
                        displayErrorMessage('phone-error', 'Phone number must be 10 digits.');
                        hasError = true;
                    } else if (!phonePattern.test(phone.trim())) {
                        displayErrorMessage('phone-error', 'Your phone number is invalid!');
                        hasError = true;
                    }
                }

                // Validate address
                if (deliveryAddress === '') {
                    displayErrorMessage('delivery-address-error', 'Please select a delivery address.');
                    hasError = true;
                }

                // If there is an error, prevent form submission
                if (hasError) {
                    return false;
                }

                // If all is valid, submit the form
                return true;
            }

            document.getElementById('placeOrder').onsubmit = validatePlaceOrder;

        </script>
    </body>
</html>
