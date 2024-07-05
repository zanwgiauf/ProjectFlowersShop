<%-- 
    Document   : purchaseHistory
    Created on : Jul 1, 2024, 4:22:30 PM
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
        <title>Purchase History</title>
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
            }
        </style>
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
                   
                   String noLogin = "";
                   String yeslogin = "";
                   if (!fullName.equals("")) {
                       noLogin = "none";
                       yeslogin = "";
                   } else {
                       noLogin = "";
                       yeslogin = "none";
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
                                <a class="nav-link" href="<%= request.getContextPath() %>/pendingOrders">Pending</a>
                            </li>
                            
                            <li class="nav-item">
                                <a class="nav-link active fw-bold" href="<%=request.getContextPath()%>/purchaseHistory?customerID=<%=customerID%>">Completed</a>
                            </li>

                        </ul>
                    </div>
                </div>
            </nav>

            <h2 class="text-center text-info my-5">Purchase History</h2>
            <div class="table-responsive">
                <c:if test="${empty orderDetails}">
                    <div class="alert alert-info text-center" role="alert">
                        No items in purchase history. <a class="text-decoration-none" href="<%= request.getContextPath() %>/shopping">Go shopping</a>
                    </div>
                </c:if>
                <c:if test="${not empty orderDetails}">
                    <table class="table table-striped table-bordered">
                        <thead class="table-dark">
                            <tr>
                                <th scope="col">Image</th>
                                <th scope="col">Name</th>
                                <th scope="col">Quantity</th>
                                <th scope="col">Price</th>
                                <th scope="col">Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="detail" items="${orderDetails}">
                                <tr>
                                    <td><img src="${detail.image}" alt="Product Image" class="table-img"></td>
                                    <td>${detail.name}</td>
                                    <td>${detail.quantity}</td>
                                    <td>${detail.price}</td>
                                    <td>
                                        <a href="<%= request.getContextPath() %>/buyAgain?id=${detail.productID}" class="btn btn-primary btn-sm me-2"><i class="bi bi-arrow-repeat"></i> Buy Again</a>
                                        <a href="<%= request.getContextPath() %>/viewProduct?id=${detail.productID}" class="btn btn-success btn-sm me-2"><i class="bi bi-eye"></i> View Product</a>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </c:if>
            </div>

            <div class="mt-4">
                <a href="<%= request.getContextPath() %>/home" class="btn btn-secondary"><i class="bi bi-house"></i> Back to Home</a>
            </div>
        </div>
    </body>
</html>