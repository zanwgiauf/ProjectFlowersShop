
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%-- 
    Document   : adminHome
    Created on : Jun 10, 2024, 7:16:15 PM
    Author     : Nguyen Van Giau - CE170449
--%>
<%@page import="DAOs.AccountDAO"%>
<%@page import="Models.Employee"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
      <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Admin Page</title>
        <link rel="Website Icon" href="<%= request.getContextPath()%>/images/LogoF.png" type="png" />
        <link rel="Website Icon" href="<%= request.getContextPath()%>/images/LogoF.png" type="png" />
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.2/font/bootstrap-icons.min.css" />
        <link rel="stylesheet" href="<%= request.getContextPath()%>/lib/bootstrap/bootstrap_css/bootstrap.min.css" />
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/mdbootstrap/4.19.1/css/mdb.min.css" />
        <link rel="stylesheet" type="text/css" href="https://cdn.jsdelivr.net/npm/toastify-js/src/toastify.min.css">
        <script type="text/javascript" src="https://cdn.jsdelivr.net/npm/toastify-js"></script>

        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.10.2/dist/umd/popper.min.js"
                integrity="sha384-7+zCNj/IqJ95wo16oMtfsKbZ9ccEh31eOz1HGyDuCQ6wgnyJNSYdrPa03rtR1zdB" crossorigin="anonymous"
        defer></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.min.js"
                integrity="sha384-QJHtvGhmr9XOIpI6YVutG+2QOK9T+ZnN4kzFN1RtK3zEFEIsxhlmWl5/YESvpZ13" crossorigin="anonymous"
        defer></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/mdbootstrap/4.19.1/js/mdb.min.js"></script>

        <style>
            body {
                font-family: 'Roboto', sans-serif;
            }
            #sidebar {
                height: 100vh;
                background: #7b88a8;
                /*                padding: 10px;*/
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
    </head>
    <body>
        <%
           Cookie cookies[] = request.getCookies();
           
           String fullName = "";
           int employeeID = 0;
           if (cookies != null) {
               for (int i = 0; i < cookies.length; i++) {
                   if (cookies[i].getName().equals("fullNameE")) {
                       fullName = cookies[i].getValue();
                   } else if (cookies[i].getName().equals("employeeIDA")) {
                           employeeID = Integer.parseInt(cookies[i].getValue());
                   }
               }
           }
//                    CartDAO ctDAO = new CartDAO();
           AccountDAO ad = new AccountDAO();
                      
        %>
        
        
        <div class="container-fluid">
    <div class="row">
        <nav id="sidebar" class="col-md-2 d-none d-md-block sidebar" style="background-color: #7b88a8">
            <div class="container sidebar-sticky text-decoration-none">
                <a href="<%=request.getContextPath()%>/employee" class="fs-4 fw-bold d-flex justify-content-center align-items-center text-dark">
                    <i class="bi bi-person-circle"></i>
                    <span>Employee</span>
                </a>
                <div class="container d-flex justify-content-center"> <h5><%= ad.decodeString(fullName) %></h5></div>
                <ul class="nav flex-column mt-3">
                    <li class="nav-item">
                        <a class="nav-link active" href="<%=request.getContextPath()%>/employee">
                            <i class="bi bi-speedometer2"></i>
                            Dashboard
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="<%=request.getContextPath()%>/employee/feedback-management">
                            <i class="bi bi-shop"></i>
                            Manage feedback
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
                            Analytics
                        </a>
                    </li>


                    <li class="nav-item">
                        <a class="nav-link" href="#">
                            <i class="bi bi-clipboard"></i>
                            List Customer Orders
                        </a>
                    </li>


                </ul>
                <form action="logout" method="post" class="mt-5 me-2" style="border-radius: 16px">
                    <button class="btn btn-outline-dark  w-100 " name="btnLogout">Logout</button>
                </form>
            </div>
        </nav>


        <main id="content" class="col-md-9 ml-sm-auto col-lg-10 px-md-4">
            <nav class="navbar navbar-expand-lg navbar-light bg-light">
                <div class="container-fluid">
                    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
                        <span class="navbar-toggler-icon"></span>
                    </button>
                    <div class="collapse navbar-collapse" id="navbarNav">
                        <ul class="navbar-nav">
                            <li class="nav-item">
                                <a class="nav-link active" aria-current="page" href="#">Home</a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" href="#">Features</a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" href="#">Pricing</a>
                            </li>
                        </ul>
                    </div>
                </div>
            </nav>

            <div class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pt-3 pb-2 mb-3 border-bottom">
                <h1 class="h2">Dashboard</h1>
                <div class="btn-toolbar mb-2 mb-md-0">
                    <div class="btn-group me-2">
                        <button type="button" class="btn btn-sm btn-outline-secondary">Share</button>
                        <button type="button" class="btn btn-sm btn-outline-secondary">Export</button>
                    </div>
                    <button type="button" class="btn btn-sm btn-outline-secondary dropdown-toggle">
                        <span data-feather="calendar"></span>
                        This week
                    </button>
                </div>
            </div>

            <h2>Recent Orders</h2>
            <div class="table-responsive">
                <table class="table table-striped table-sm">
                    <thead>
                        <tr>
                            <th>User</th>
                            <th>Date Order</th>
                            <th>Status</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td>User 1</td>
                            <td>01-01-2024</td>
                            <td><span class="badge bg-success">Completed</span></td>
                        </tr>
                        <tr>
                            <td>User 2</td>
                            <td>01-01-2024</td>
                            <td><span class="badge bg-warning">Pending</span></td>
                        </tr>
                        <tr>
                            <td>User 3</td>
                            <td>01-01-2024</td>
                            <td><span class="badge bg-success">Completed</span></td>
                        </tr>
                        <tr>
                            <td>User 4</td>
                            <td>01-01-2024</td>
                            <td><span class="badge bg-info">In Process</span></td>
                        </tr>
                        <tr>
                            <td>User 5</td>
                            <td>01-01-2024</td>
                            <td><span class="badge bg-success">Completed</span></td>
                        </tr>
                    </tbody>
                </table>
            </div>

            <h2>To-Do List</h2>
            <ul class="list-group">
                <li class="list-group-item d-flex justify-content-between align-items-center">
                    Todo Item 1
                    <span class="badge bg-success rounded-pill">Completed</span>
                </li>
                <li class="list-group-item d-flex justify-content-between align-items-center">
                    Todo Item 2
                    <span class="badge bg-warning rounded-pill">Pending</span>
                </li>
                <li class="list-group-item d-flex justify-content-between align-items-center">
                    Todo Item 3
                    <span class="badge bg-success rounded-pill">Completed</span>
                </li>
                <li class="list-group-item d-flex justify-content-between align-items-center">
                    Todo Item 4
                    <span class="badge bg-danger rounded-pill">Not Started</span>
                </li>
            </ul>
        </main>
    </div>
</div>

        <script src="<%= request.getContextPath()%>/lib/bootstrap/bootstrap_js/bootstrap.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.11.0/umd/popper.min.js"
                integrity="sha384-b/U6ypiBEHpOf/4+1nzFpr53nxSS+GLCkfwBdFNTxtclqqenISfwAzpKaMNFNmj4"
        crossorigin="anonymous"></script>
    </body>
</html>
