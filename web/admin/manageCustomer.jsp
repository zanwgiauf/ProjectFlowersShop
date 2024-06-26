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
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.2/font/bootstrap-icons.min.css" />
        <link rel="stylesheet" href="<%= request.getContextPath()%>/lib/bootstrap/bootstrap_css/bootstrap.min.css" />

        <!-- datepicker styles -->
        <link rel="stylesheet"
              href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.9.0/css/bootstrap-datepicker3.min.css">

        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css"
              integrity="sha384-xOolHFLEh07PJGoPkLv1IbcEPTNtaed2xpHsD9ESMhqIYd0nLMwNLD69Npy4HI+N" crossorigin="anonymous">
        <link href=”https://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap.min.css” rel=”stylesheet”
              type=”text/css” />

        <link href="https://cdn.datatables.net/1.13.1/css/dataTables.bootstrap5.min.css" rel="stylesheet">
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
    </head>
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
        <div class="container">
            <div class="row">
                <nav id="sidebar" class="col-md-2 d-none d-md-flex sidebar" style="width: 300px; background-color: #7b88a8;">
                    <div class="container sidebar-sticky text-decoration-none text-white">
                        <a href="<%=request.getContextPath()%>/admin" class="fs-4 fw-bold d-flex justify-content-center align-items-center text-white">
                            <i class="bi bi-person-circle mx-2 "></i>
                            <span>Admin</span>

                        </a>
                        <div class="container d-flex justify-content-center"> <h5><%= ad.decodeString(fullName) %></h5></div>
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
                                    <a href="<%=request.getContextPath()%>/admin/ManageAccountCustomer" class="dropdown-item">Manage Customer Accounts</a>
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
                        <form action="logout" method="post" class="mt-4 me-2" >
                            <button class="btn btn-outline-dark" style="border-radius: 16px" name="btnLogout">Logout</button>
                        </form>
                    </div>
                </nav>

                <div class="col-md-8">
                    <h1 class="m-5 text-info text-center">Manage Customer Account</h1>
                    <table id="CusForm" class="table text-center table-bordered table-striped" style="width:100%">
                        <thead>
                            <tr>
                                <th>STT</th>
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
                                    <td>${c.fullName}</td>
                                    <td>${c.email}</td>
                                    <td>${c.phone}</td>
                                    <td>
                                        <c:if test="${c.status == 0}">InActive</c:if>
                                        <c:if test="${c.status == 1}">Active</c:if>
                                        </td>
                                        <td>
                                            <button type="button" class="btn btn-info btn-lg" data-toggle="modal" data-target="#viewAllCustomerModal${c.customerID}">Open Modal</button>
                                        <a data-toggle="modal" data-target="#viewAllCustomerModal${c.customerID}">
                                            <i id="viewCustomerBtn${c.customerID}" class="fa fa-info-circle" title="View more info"></i>
                                        </a>
                                    </td>
                                    <td>
                                        <c:if test="${c.status == 0}">
                                            <a data-toggle="modal" data-target="#unblockCustomerModal${c.customerID}">
                                                <i id="unblockCustomerBtn${c.customerID}" class="fa fa-refresh col-3" title="UnBlock"></i>
                                            </a>
                                        </c:if>
                                        <c:if test="${c.status != 0}">
                                            <a data-toggle="modal" data-target="#deleteCustomerModal${c.customerID}">
                                                <i id="deleteCustomerBtn${c.customerID}" class="fa fa-trash col-3" title="Delete"></i>
                                            </a>
                                        </c:if>
                                    </td>
                                </tr>

                            </c:forEach>
                        </tbody>
                    </table>
                    <!-- Trigger the modal with a button -->
  <button type="button" class="btn btn-info btn-lg" data-toggle="modal" data-target="#myModal">Open Modal</button>

  <!-- Modal -->
  <div class="modal fade" id="myModal" role="dialog">
    <div class="modal-dialog">
    
      <!-- Modal content-->
      <div class="modal-content">
        <div class="modal-header">
          <button type="button" class="close" data-dismiss="modal">&times;</button>
          <h4 class="modal-title">Modal Header</h4>
        </div>
        <div class="modal-body">
          <p>Some text in the modal.</p>
        </div>
        <div class="modal-footer">
          <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
        </div>
      </div>
      
    </div>
  </div>
  
</div>
                    
                    <c:forEach items="${listCustomer}" var="c" varStatus="i">


                        <!-- Modal Delete Customer-->
                        <div class="modal fade" id="deleteCustomerModal${c.customerID}" tabindex="-1" role="dialog"
                             aria-labelledby="deleteCustomerModalLabel" aria-hidden="true">
                            <div class="modal-dialog" role="document">
                                <div class="modal-content">
                                    <div class="modal-header">
                                        <h5 class="modal-title" id="deleteCustomerModalLabel">Delete Customer Account </h5>
                                    </div>
                                    <div class="modal-body">
                                        <form id="deleteCustomerForm${i.index+1}" action="ManegerUser" method="post">
                                            <div class="form-group">
                                                <label>Are you sure you want to delete this customer's account?</label>
                                                <input name="cus_id" value="${c.customerID}" style="display: none" />
                                            </div>
                                        </form>
                                    </div>
                                    <div class="modal-footer">
                                        <input type="button" class="btn btn-secondary" data-dismiss="modal" value="Cancel">
                                        <input id="deleteCustomerForm${c.customerID}btn" class="btn btn-primary" type="submit" form="deleteCustomerForm${i.index+1}" name="delete-btn" value="DELETE">
                                    </div>
                                </div>
                            </div>
                        </div>

                        <!-- Modal UnBlock Customer-->
                        <div class="modal fade" id="unblockCustomerModal${c.cus_id}" tabindex="-1" role="dialog"
                             aria-labelledby="unblockCustomerModalLabel" aria-hidden="true">
                            <div class="modal-dialog" role="document">
                                <div class="modal-content">
                                    <div class="modal-header">
                                        <h5 class="modal-title" id="unblockCustomerModalLabel">UnBlock Customer Account </h5>
                                    </div>
                                    <div class="modal-body">
                                        <form id="unblockCustomerForm${i.index+1}" action="ManegerUser" method="post">
                                            <div class="form-group">
                                                <label>Are you sure you want to unblock for this customer's account?</label>
                                                <input name="cus_id" value="${c.customerID}" style="display: none" />
                                            </div>
                                        </form>
                                    </div>
                                    <div class="modal-footer">
                                        <input type="button" class="btn btn-secondary" data-dismiss="modal" value="Cancel">
                                        <input id="unblockCustomerForm${c.customerID}btn" class="btn btn-primary" type="submit" form="unblockCustomerForm${i.index+1}" name="unblockCustomer-btn" value="UNBLOCK">
                                    </div>
                                </div>
                            </div>
                        </div>

                        <!-- Modal View Detail all info of Customer -->
                        <div class="modal fade" id="viewAllCustomerModal${c.customerID}" tabindex="-1" role="dialog"
                             aria-labelledby="viewAllCustomerModalLabel" aria-hidden="true">
                            <div class="modal-dialog" role="document">
                                <div class="modal-content">
                                    <div class="modal-header">
                                        <h5 class="modal-title" id="viewAllCustomerModalLabel">More Information of Customer</h5>
                                    </div>
                                    <div class="modal-body">
                                        <form id="ViewAllCustomerForm${i.index+1}">
                                            <div class="input-group mb-3">
                                                <div class="input-group-prepend">
                                                    <span class="input-group-text" id="inputGroup-sizing-fullname">Full Name</span>
                                                </div>
                                                <input type="text" class="form-control" aria-label="Sizing viewAllCustomer fullname input"
                                                       aria-describedby="inputGroup-sizing-fullname"
                                                       id="cus_fullname" value="${c.fullName}" readonly>
                                            </div>

                                            <div class="input-group mb-3">
                                                <div class="input-group-prepend">
                                                    <span class="input-group-text" id="inputGroup-sizing-email">Email</span>
                                                </div>
                                                <input type="text" class="form-control" aria-label="Sizing viewAllCustomer email input"
                                                       aria-describedby="inputGroup-sizing-email"
                                                       id="cus_email" value="${c.email}" readonly>
                                            </div>

                                            <div class="input-group mb-3">
                                                <div class="input-group-prepend">
                                                    <span class="input-group-text" id="inputGroup-sizing-phone">Phone</span>
                                                </div>
                                                <input type="text" class="form-control" aria-label="Sizing viewAllCustomer phone input"
                                                       aria-describedby="inputGroup-sizing-phone"
                                                       id="cus_phone" value="${c.phone}" readonly>
                                            </div>

                                            <div class="input-group mb-3">
                                                <div class="input-group-prepend">
                                                    <span class="input-group-text" id="inputGroup-sizing-birthday">Birthday</span>
                                                </div>
                                                <input type="text" class="form-control" aria-label="Sizing viewAllCustomer birthday input"
                                                       aria-describedby="inputGroup-sizing-birthday"
                                                       id="cus_birthday" value="${c.birthday}" readonly>
                                            </div>

                                            <div class="input-group">
                                                <div class="input-group-prepend">
                                                    <span class="input-group-text" id="inputGroup-sizing-address">Address</span>
                                                </div>
                                                <textarea class="form-control" aria-describedby="inputGroup-sizing-address"
                                                          id="cus_address" readonly>${c.address}</textarea>
                                            </div>
                                        </form>
                                    </div>
                                    <div class="modal-footer">
                                        <input type="button" class="btn btn-secondary" data-dismiss="modal" value="Cancel">
                                    </div>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                        

                </div>

            </div>
    </body>
</html>
