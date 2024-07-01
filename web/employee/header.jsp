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