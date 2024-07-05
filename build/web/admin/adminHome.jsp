<%-- 
    Document   : adminHome
    Created on : Jun 10, 2024, 7:16:15 PM
    Author     : Nguyen Van Giau - CE170449
--%>
<%@page import="DAOs.AccountDAO"%>
<%@page import="Models.Admin"%>
<%@page import="Models.Promotion" %>
<%@page import="DAOs.PromotionDAO" %>
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
    </head>
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
                        <a href="<%=request.getContextPath()%>/AdminController" class="fs-4 fw-bold d-flex justify-content-center align-items-center text-white">
                            <i class="bi bi-person-circle mx-2 "></i>
                            <span>Admin</span>

                        </a>
                        <div class="container d-flex justify-content-center"> <h5><%= ad.decodeString(fullName) %></h5></div>
                        <ul class="nav flex-column mt-3">
                            <li class="nav-item">
                                <a class="nav-link active" href="<%=request.getContextPath()%>/AdminController">
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
                                <a class="nav-link" href="<%=request.getContextPath()%>/managestock">
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
                                    <a href="#" class="dropdown-item">Manage Customer Accounts</a>
                                </div>
                            </li>

                            <li class="nav-item">
                                <a class="nav-link" href="#">
                                    <i class="bi bi-clipboard"></i>
                                    List Customer Orders
                                </a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" href="<%=request.getContextPath()%>/managecategories">
                                    <i class="bi bi-tags"></i>
                                    Category
                                </a>
                            </li>

                            <li class="nav-item">
                                <a class="nav-link" href="<%=request.getContextPath()%>/promotions">
                                    <i class="bi bi-piggy-bank-fill"></i>
                                    Promotions
                                </a>
                            </li>
                        </ul>
                        <form action="LogoutController" method="post" class="mt-4 me-2" >
                            <button class="btn btn-outline-dark  w-100" style="border-radius: 16px" name="btnLogout">Logout</button>
                        </form>
                    </div>
                </nav>

                <main id="content" class="col-md-9 ml-sm-auto col-lg-10 px-md-4"style="width: 1020px;">


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
