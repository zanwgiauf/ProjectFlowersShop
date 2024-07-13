<%-- 
    Document   : editInfoOrder
    Created on : Jul 10, 2024, 8:04:05 AM
    Author     : Nguyen Van Giau - CE170449
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page import="DAOs.AccountDAO"%>
<%@page import="Models.Customer"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Edit Information Order</title>
        <link rel="icon" href="<%= request.getContextPath()%>/images/LogoF.png" type="image/png" />
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css" integrity="sha384-4LISF5TTJX/fLmGSxO53rV4miRxdg84mZsxmO8Rx5jGtp/LbrixFETvWa5a6sESd" crossorigin="anonymous">


    </head>
    <body>
        <%
            String fullName = "";
            int customerID = 0;
            Cookie cookies[] = request.getCookies();
            if (cookies != null) {
                for (Cookie cookie : cookies) {
                        if (cookie.getName().equals("fullNameC")) {
                            fullName = cookie.getValue();
                        } else if (cookie.getName().equals("idC")) {
                            customerID = Integer.parseInt(cookie.getValue());
                        }
                    }
            }
            AccountDAO ad = new AccountDAO();
        %>
        <div class="mt-5">
            <h1 class="text-center text-info">Edit Information Order</h1>
            <div class="container mb-5 mt-5">
                <form action="<%= request.getContextPath() %>/order" method="post" onsubmit="return validateForm()">
                    <c:forEach var="o" items="${infoOrder}" varStatus="loop">
                        <div class="mb-3 row">
                            <label for="orderID" class="col-sm-2 col-form-label">Order ID:</label>
                            <div class="col-sm-10">
                                <input type="text" class="form-control" id="orderID" name="orderID" value="${o.orderID}" readonly="">
                            </div>
                        </div>

                        <div class="mb-3 row">
                            <label for="orderFullname" class="col-sm-2 col-form-label">Fullname:</label>
                            <div class="col-sm-10">
                                <input type="text" class="form-control" id="orderFullname" readonly value="<%= ad.decodeString(fullName) %>">
                            </div>
                        </div>

                        <div class="mb-3 row">
                            <label for="orderPhone" class="col-sm-2 col-form-label">Phone:</label>
                            <div class="col-sm-10">
                                <input type="text" class="form-control" id="orderPhone" name="ePhone" value="${o.phone}">
                                <span id="phone-error" class="text-danger"></span>
                            </div>
                        </div>

                        <div class="mb-3 row">
                            <label for="orderNote" class="col-sm-2 col-form-label">Note:</label>
                            <div class="col-sm-10">
                                <input type="text" class="form-control" id="orderNote" name="eNote" value="${o.note}">
                            </div>
                        </div>

                        <div class="d-flex justify-content-center align-content-center">
                            <button type="submit" class="btn-edit btn btn-primary" name="btnEdit">Save</button>
                           <a href="<%= request.getContextPath() %>/order/pendingOrder" class="nav-link btn btn-link bg-primary ms-2 px-2 text-white d-flex align-items-center justify-content-center">Cancel</a>
                        </div>
                    </c:forEach>
                </form>
            </div>
        </div>
        <script>
            function displayErrorMessage(id, message) {
                document.getElementById(id).innerText = message;
            }

            function validateForm() {
                var hasError = false;

                var fullName = document.getElementById('orderFullname').value;
                var phone = document.getElementById('orderPhone').value;

                
                // Validate phone number
                if (phone === '') {
                    displayErrorMessage('phone-error', 'Please enter your phone number.');
                    hasError = true;
                } else {
                    var phonePattern = /^(03[2-9]|05[6|8|9]|07[0|6-9]|08[1-6|8-9]|09[0-9])[0-9]{7}$/;
                    if (/[@#%&*!-]/.test(phone)) {
                        displayErrorMessage('phone-error', 'Phone number must not contain special characters.');
                        hasError = true;
                    } else if (/[@#%&*!-]/.test(phone) && /[a-zA-Z]/.test(phone)) {
                        displayErrorMessage('phone-error', 'Phone number must not contain special characters and letters.');
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

                return !hasError;
            }

            function cancelEdit() {
                // Logic để hủy bỏ việc chỉnh sửa, nếu có
            }
        </script>
    </body>
</html>
