<%-- 
    Document   : pendingOrders
    Created on : Jul 1, 2024, 5:49:21 PM
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
        <title>Pending Orders</title>
        <link rel="icon" href="<%= request.getContextPath()%>/images/LogoF.png" type="image/png" />
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css" integrity="sha384-4LISF5TTJX/fLmGSxO53rV4miRxdg84mZsxmO8Rx5jGtp/LbrixFETvWa5a6sESd" crossorigin="anonymous">

        <style>
            body {
                padding: 20px;
            }
            .table-img {
                width: 50px;
                height: 50px;
                object-fit: cover;
            }
            .align-middle {
                vertical-align: middle !important;
            }
        </style>

        <script>
            function confirmCancel(orderID) {
                var myModal = new bootstrap.Modal(document.getElementById('confirmModal'));
                document.getElementById('orderIdInput').value = orderID;
                myModal.show();
            }
        </script>
    </head>
    <body>
        <%
            String fullName = "";
            int customerID = 0;
            Cookie cookies[] = request.getCookies();
            if (cookies != null) {
                for (int i = 0; i < cookies.length; i++) {
                    if(cookies[i].getName().contains("roleA")){
                    response.sendRedirect(request.getContextPath()+ "/admin");
                    }else if(cookies[i].getName().contains("roleE")){
                    response.sendRedirect(request.getContextPath()+ "/employee");
                    }else{
                        if (cookies[i].getName().equals("fullNameC")) {
                        fullName = cookies[i].getValue();
                        } else if (cookies[i].getName().equals("idC")) {
                        customerID = Integer.parseInt(cookies[i].getValue());
                        }
                    }
                }
            }
        %>
        <div class="container">
            <nav class="navbar navbar-expand-lg navbar-light bg-light mb-4">
                <div class="container-fluid">
                    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
                        <span class="navbar-toggler-icon"></span>
                    </button>
                    <div class="collapse navbar-collapse" id="navbarNav">
                         <ul class="navbar-nav">
                            <li class="nav-item">
                                <a href="<%= request.getContextPath() %>/order/pendingOrder" class="nav-link btn btn-link active fw-bold">Pending</a>
                            </li>

                            <li class="nav-item">
                                <a href="<%= request.getContextPath() %>/order/purchasehistory" class="nav-link btn btn-link">Purchase History</a>
                            </li>
                            <li class="nav-item">
                                <a href="<%= request.getContextPath() %>/order/cancelled" class="nav-link btn btn-link">Cancelled</a>
                            </li>
                        </ul>
                    </div>
                </div>
            </nav>
            <h2 class="text-center text-info my-5">Pending Orders</h2>
            <div class="table-responsive">
                <c:if test="${empty pendingOrders}">
                    <div class="alert alert-info text-center" role="alert">
                        No items in pending orders.
                    </div>
                </c:if>
                <c:if test="${not empty pendingOrders}">
                    <table class="table  text-center">
                        <thead class="table-dark">
                            <tr>
                                <th scope="col">Image</th>
                                <th scope="col">Name</th>
                                <th scope="col">Quantity</th>
                                <th scope="col">Price</th>
                                <th scope="col">Total Price</th>
                                <th scope="col">Order Date</th>
                                <th scope="col">Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="orderDetail" items="${pendingOrders}">
                                <tr>
                                    <td class="align-middle"><img src="../${orderDetail.image}"  alt="Product Image" class="table-img"></td>
                                    <td class="align-middle">${orderDetail.name}</td>
                                    <td class="align-middle">${orderDetail.quantity}</td>
                                    <td class="align-middle">${orderDetail.price}</td>
                                    <td class="align-middle">${orderDetail.totalPrice}</td>
                                    <td class="align-middle">${orderDetail.dateCreate}</td>
                                    <td class="align-middle">
                                        <a href="javascript:void(0);" onclick="confirmCancel(${orderDetail.orderID})" class="btn btn-danger btn-sm me-2"><i class="bi bi-x-circle"></i> Cancel Order</a>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </c:if>
            </div>

            <div class="mt-4">
                <a href="<%= request.getContextPath() %>/" class="btn btn-secondary"><i class="bi bi-house"></i> Back to Home</a>
            </div>
        </div>

        <!-- Modal -->
        <div class="modal fade" id="confirmModal" tabindex="-1" aria-labelledby="confirmModalLabel" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="confirmModalLabel">Confirm Cancel</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        Are you sure you want to cancel this order?
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">No</button>
                        <form id="cancelForm" action="<%= request.getContextPath() %>/order/cancelOrder">
                            <input type="hidden" name="orderId" id="orderIdInput">
                            <button type="submit" name="cancel" class="btn btn-danger">Yes, Cancel</button>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </body>
</html>
