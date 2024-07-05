<%-- 
    Document   : manageCustomer
    Created on : Jun 26, 2024, 2:12:42 PM
    Author     : Nguyen Van Giau - CE170449
--%>
<%@page import="DAOs.AccountDAO"%>
<%@page import="Models.Admin"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Manage Customer Account Page</title>
        <link rel="Website Icon" href="<%= request.getContextPath()%>/images/LogoF.png" type="png" />
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
        <link href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css" rel="stylesheet">

    </head>
    <style>
        body {
            font-family: 'Roboto', sans-serif;
        }
        #sidebar {
            height: 100vh;
            background: #7b88a8;
            padding: 10px;
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
        #sidehover a:hover{
            background: #495057;
        }
        #content {
            padding: 20px;
        }
        .table-responsive {
            max-height: 500px;
        }
        .sidebar-toggle-btn {
            position: fixed;
            top: 10px;
            left: 10px;
            z-index: 1050;
        }
    </style>
    <body>
        <%
           Cookie cookies[] = request.getCookies();
           String fullName = "";
           int adminID = 0;
           if (cookies != null) {
               for (int i = 0; i < cookies.length; i++) {
                   if (cookies[i].getName().equals("fullNameA")) {
                       fullName = cookies[i].getValue();
                   } else if (cookies[i].getName().equals("adminIDA")) {
                           adminID = Integer.parseInt(cookies[i].getValue());
                   }
               }
           }
           AccountDAO ad = new AccountDAO();  
        %>
        <div class="container-fluid">
            <div class="row">
                <!-- Sidebar Toggle Button for Small Screens -->
                <button class="btn btn-outline-info d-lg-none" type="button" data-bs-toggle="offcanvas" data-bs-target="#offcanvasSidebar" aria-controls="offcanvasSidebar">
                    <i class="bi bi-list"></i>
                </button>
                <!-- Offcanvas Sidebar for small screens -->
                <div class="offcanvas offcanvas-start d-lg-none" tabindex="-1" id="offcanvasSidebar" aria-labelledby="offcanvasSidebarLabel" style="width: 300px; background-color: #7b88a8;">
                    <div class="offcanvas-header">
                        <button type="button" class="btn-close text-reset" data-bs-dismiss="offcanvas" aria-label="Close"></button>
                    </div>
                    <div class="offcanvas-body">
                        <div id="sidehover"  class="container sidebar-sticky text-decoration-none text-white">
                            <a href="<%=request.getContextPath()%>/admin" class="fs-4 fw-bold d-flex justify-content-center align-items-center text-white text-decoration-none">
                                <i class="bi bi-person-circle mx-2"></i>
                                <span>Admin</span>
                            </a>
                            <div class="container d-flex justify-content-center"> 
                                <h5><%= ad.decodeString(fullName) %></h5>
                            </div>
                            <ul class="nav flex-column mt-3">
                                <li class="nav-item">
                                    <a class="nav-link text-white active" href="<%=request.getContextPath()%>/admin">
                                        <i class="bi bi-speedometer2"></i>
                                        Dashboard
                                    </a>
                                </li>
                                <li class="nav-item">
                                    <a class="nav-link text-white" href="#">
                                        <i class="bi bi-shop"></i>
                                        My Store
                                    </a>
                                </li>
                                <li class="nav-item">
                                    <a class="nav-link text-white" href="#">
                                        <i class="bi bi-list-check"></i>
                                        Manage Stock
                                    </a>
                                </li>
                                <li class="nav-item">
                                    <a class="nav-link text-white" href="#">
                                        <i class="bi bi-graph-up"></i>
                                        Analytic
                                    </a>
                                </li>
                                <li class="nav-item">
                                    <a class="dropdown-toggle text-white text-decoration-none my-3 py-2" data-bs-toggle="collapse" data-bs-target="#manageUserAccounts" aria-expanded="false" aria-controls="manageUserAccounts">
                                        <i class="ms-3 bi bi-people"></i>
                                        <span>Manage User Accounts</span>
                                    </a>
                                    <div class="collapse" id="manageUserAccounts">
                                        <a href="#" class="dropdown-item ms-4 my-2 py-2">Manage Employee Accounts</a>
                                        <a href="#"  class="dropdown-item ms-4 my-2 py-2">Manage Customer Accounts</a>
                                    </div>
                                </li>
                                <li class="nav-item">
                                    <a class="nav-link text-white" href="#">
                                        <i class="bi bi-clipboard"></i>
                                        List Customer Orders
                                    </a>
                                </li>
                                <li class="nav-item">
                                    <a class="nav-link text-white" href="#">
                                        <i class="bi bi-tags"></i>
                                        Category
                                    </a>
                                </li>
                            </ul>
                            <form action="logout" method="post" class="mt-4 d-flex justify-content-center align-items-center">
                                <button class="btn btn-outline-dark px-5" style="border-radius: 16px" name="btnLogout">Logout</button>
                            </form>
                        </div>
                    </div>
                </div>
                <!-- Sidebar for larger screens -->
                <nav id="sidebar" class="col-2 d-none d-lg-flex sidebar" style="width: 300px; background-color: #7b88a8;">
                    <div class="container sidebar-sticky text-decoration-none text-white">
                        <a href="<%=request.getContextPath()%>/admin" class="fs-4 fw-bold d-flex justify-content-center align-items-center text-white">
                            <i class="bi bi-person-circle mx-2 "></i>
                            <span>Admin</span>
                        </a>
                        <div class="container d-flex justify-content-center"> 
                            <h5><%= ad.decodeString(fullName) %></h5>
                        </div>
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
                                <a class="dropdown-toggle" data-bs-toggle="collapse" data-bs-target="#manageUserAccounts" aria-expanded="false" aria-controls="manageUserAccounts">
                                    <i class="bi bi-people"></i>
                                    <span>Manage User Accounts</span>
                                </a>
                                <div class="collapse ms-3" id="manageUserAccounts">
                                    <a href="#" class="dropdown-item">Manage Employee Accounts</a>
                                    <a href="#" class="dropdown-item active" >Manage Customer Accounts</a>
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
                        </ul>
                        <form action="logout" method="post" class="mt-4 d-flex justify-content-center align-items-center">
                            <button class="btn btn-outline-dark px-5" style="border-radius: 16px" name="btnLogout">Logout</button>
                        </form>
                    </div>
                </nav>

                <div class="col-lg-8 col-10 mx-auto">
                    <h1 class="m-5 text-info text-center">Manage Customer Account</h1>
                    <!-- Search Form -->
                    <form class="mb-4" method="get" action="<%= request.getContextPath() %>/manageUserAccount">
                        <div class="input-group">
                            <input type="text" name="search" class="form-control" placeholder="Search by name, phone or email" 
                                   value="<c:out value='${param.search != null ? param.search : ""}'/>">
                            <button class="btn btn-outline-info" type="submit">Search</button>
                        </div>
                    </form>

                    <c:choose>
                        <c:when test="${empty listCustomer}">
                            <h4 class="text-center text-danger">No customer accounts found with that keyword!</h4>
                        </c:when>
                        <c:otherwise>
                            <div class="table-responsive">
                                <table id="CusForm" class="table text-center table-bordered" style="width:100%">
                                    <thead class="table-primary">
                                        <tr>
                                            <th>No.</th>
                                            <th>Full Name</th>
                                            <th>Email</th>
                                            <th>Phone</th>
                                            <th>Status</th>
                                            <th>Detail</th>
                                            <th>Tools</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach items="${listCustomer}" var="c" varStatus="i">
                                            <tr>
                                                <td>${i.index + 1}</td>
                                                <td class="text-start">${c.fullName}</td>
                                                <td class="text-start">${c.email}</td>
                                                <td>${c.phone}</td>
                                                <td style="width: 100px">
                                                    <c:if test="${c.status == 0}">InActive</c:if>
                                                    <c:if test="${c.status == 1}">Active</c:if>
                                                    </td>
                                                    <td>
                                                        <a data-bs-toggle="modal" data-bs-target="#viewAllCustomerModal${c.customerID}">
                                                        <i id="viewCustomerBtn${c.customerID}" class="fa fa-info-circle" title="View more info"></i>
                                                    </a>
                                                </td>
                                                <td>
                                                    <c:if test="${c.status == 0}">
                                                        <a data-bs-toggle="modal" data-bs-target="#unblockCustomerModal${c.customerID}">
                                                            <i id="unblockCustomerBtn${c.customerID}" class="fa fa-refresh col-3" title="UnBlock"></i>
                                                        </a>
                                                    </c:if>
                                                    <c:if test="${c.status != 0}">
                                                        <a data-bs-toggle="modal" data-bs-target="#blockCustomerModal${c.customerID}">
                                                            <i id="blockCustomerBtn${c.customerID}" class="fa fa-trash col-3" title="Block"></i>
                                                        </a>
                                                    </c:if>
                                                </td>
                                            </tr>
                                        </c:forEach>
                                    </tbody>
                                </table>
                            </div>
                        </c:otherwise>
                    </c:choose>

                    <c:forEach items="${listCustomer}" var="c" varStatus="i">
                        <!-- Modal for Viewing Detailed Customer Information -->
                        <div class="modal fade" id="viewAllCustomerModal${c.customerID}" tabindex="-1" aria-labelledby="viewAllCustomerModalLabel${c.customerID}" aria-hidden="true">
                            <div class="modal-dialog" role="document">
                                <div class="modal-content">
                                    <div class="modal-header">
                                        <h5 class="modal-title" id="viewAllCustomerModalLabel${c.customerID}">More Information of Customer</h5>
                                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                    </div>
                                    <div class="modal-body">
                                        <form id="ViewAllCustomerForm${i.index+1}">
                                            <!-- Full Name -->
                                            <div class="mb-3">
                                                <label for="cus_fullname${i.index+1}" class="form-label">Full Name</label>
                                                <input type="text" class="form-control" id="cus_fullname${i.index+1}" value="${c.fullName}" readonly>
                                            </div>

                                            <!-- Email -->
                                            <div class="mb-3">
                                                <label for="cus_email${i.index+1}" class="form-label">Email</label>
                                                <input type="text" class="form-control" id="cus_email${i.index+1}" value="${c.email}" readonly>
                                            </div>

                                            <!-- Phone -->
                                            <div class="mb-3">
                                                <label for="cus_phone${i.index+1}" class="form-label">Phone</label>
                                                <input type="text" class="form-control" id="cus_phone${i.index+1}" value="${c.phone}" readonly>
                                            </div>

                                            <!-- Birthday -->
                                            <div class="mb-3">
                                                <label for="cus_birthday${i.index+1}" class="form-label">Birthday</label>
                                                <input type="text" class="form-control" id="cus_birthday${i.index+1}" value="${c.birthday}" readonly>
                                            </div>

                                            <!-- Address -->
                                            <div class="mb-3">
                                                <label for="cus_address${i.index+1}" class="form-label">Address</label>
                                                <textarea class="form-control" id="cus_address${i.index+1}" rows="3" readonly>${c.address}</textarea>
                                            </div>
                                        </form>
                                    </div>
                                    <div class="modal-footer">
                                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </c:forEach>

                    <c:forEach items="${listCustomer}" var="c" varStatus="i">
                        <!-- Modal Block Customer-->
                        <div class="modal fade" id="blockCustomerModal${c.customerID}" tabindex="-1" role="dialog"
                             aria-labelledby="blockCustomerModalLabel" aria-hidden="true">
                            <div class="modal-dialog" role="document">
                                <div class="modal-content">
                                    <div class="modal-header">
                                        <h5 class="modal-title" id="blockCustomerModalLabel">Block Customer Account </h5>
                                    </div>
                                    <form action="manageUserAccount" method="post">
                                        <div class="modal-body">
                                            <div class="form-group">
                                                <label>Are you sure you want to block this customer's account?</label>
                                                <input name="customerID" value="${c.customerID}" type="hidden" />
                                                <input name="action" value="block" type="hidden" />
                                            </div>
                                        </div>
                                        <div class="modal-footer">
                                            <input type="button" class="btn btn-secondary" data-bs-dismiss="modal" value="Cancel">
                                            <input class="btn btn-primary" type="submit" value="BLOCK">
                                        </div>
                                    </form>
                                </div>
                            </div>
                        </div>
                    </c:forEach>

                    <c:forEach items="${listCustomer}" var="c" varStatus="i">
                        <!-- Modal UnBlock Customer-->
                        <div class="modal fade" id="unblockCustomerModal${c.customerID}" tabindex="-1" role="dialog"
                             aria-labelledby="unblockCustomerModalLabel" aria-hidden="true">
                            <div class="modal-dialog" role="document">
                                <div class="modal-content">
                                    <div class="modal-header">
                                        <h5 class="modal-title" id="unblockCustomerModalLabel">UnBlock Customer Account </h5>
                                    </div>
                                    <form action="manageUserAccount" method="post">
                                        <div class="modal-body">
                                            <div class="form-group">
                                                <label>Are you sure you want to unblock this customer's account?</label>
                                                <input name="customerID" value="${c.customerID}" type="hidden" />
                                                <input name="action" value="unblock" type="hidden" />
                                            </div>
                                        </div>
                                        <div class="modal-footer">
                                            <input type="button" class="btn btn-secondary" data-bs-dismiss="modal" value="Cancel">
                                            <input class="btn btn-primary" type="submit" value="UNBLOCK">
                                        </div>
                                    </form>
                                </div>
                            </div>
                        </div>
                    </c:forEach>

                </div>
            </div>
        </div>
    </body>
</html>
