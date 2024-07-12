<%-- 
    Document   : index.jsp
    Created on : Jun 4, 2024, 9:25:07 PM
    Author     : giaun
--%>
<%@page import="DAOs.AccountDAO"%>
<%@page import="Models.Customer"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <title>Flowers Shop</title>
        <link rel="Website Icon" href="<%= request.getContextPath()%>/images/LogoF.png" type="image/png" />
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
            .wrapper{
                position: relative;
                color: white;
                margin-right: 10px
            }

            .wrapper span{
                position: absolute;
                top: -2px;
                right: -2px;
                color: red
            }
        </style>
    </head>

    <body>
        <%
           Cookie cookies[] = request.getCookies();
           if (cookies != null) {
               for (Cookie c : cookies) {
                   if (c.getName().contains("roleA")) {
                       response.sendRedirect("/AdminController");
                   }
               }
           }
        %>
        <header>
            <nav class="container fixed-top" style="background-color:#7b88a8; border-radius:16px;">
                <div class="row d-flex justify-content-center align-items-center">
                    <div class="col-lg-2 col-4 d-md-flex align-items-center justify-content-center">
                        <a href="<%=request.getContextPath()%>/" class="text-white d-flex align-items-center">
                            <img src="./images/LogoF.png" width="70px" alt="logo" />
                            <span class="ms-2">Flower Shop</span>
                        </a>

                    </div>

                    <div class="col-lg-4  d-none d-lg-flex justify-content-start align-items-center">
                        <ul class="nav d-lg-flex ">
                            <li class="nav-item"><a class="nav-link text-white" href="<%=request.getContextPath()%>/">Home</a></li>
                            <li class="nav-item"><a class="nav-link text-white" href="#">Category</a></li>
                            <li class="nav-item"><a class="nav-link text-white" href="#">Introduce</a></li>
                            <li class="nav-item"><a class="nav-link text-white" href="#">Contact</a></li>
                        </ul>

                    </div>
                    <%
                    String fullName = "";
                    int customerID = 0;
                    if (cookies != null) {
                        for (int i = 0; i < cookies.length; i++) {
                            if (cookies[i].getName().equals("fullNameC")) {
                                fullName = cookies[i].getValue();
                            } else if (cookies[i].getName().equals("idC")) {
                                customerID = Integer.parseInt(cookies[i].getValue());
                            }
                        }
                    }
//                    CartDAO ctDAO = new CartDAO();
                    AccountDAO ad = new AccountDAO();
//                    int count = ctDAO.getCountCartByCusID(cus_id);
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

                    <div class="col-lg-3 col-7 align-items-center">
                        <form action="ProductController" method="post" class="d-flex align-items-center">
                            <input class="w-75 form-control rounded-pill bg-light" type="text" name="search" placeholder="Search" />
                            <button class="btn rounded-pill bg-light py-2" type="submit" name="btn-search">
                                <i class="bi bi-search"></i>
                            </button>

                        </form>
                    </div>
                    <div class="col-lg-3" style="display: <%=noLogin%>" >
                        <div class="d-flex justify-content-end align-items-center me-3">
                            <a href="<%=request.getContextPath()%>/LoginController" class="text-white me-3"><i class="bi bi-cart2"></i></a>
                            <a href="<%=request.getContextPath()%>/LoginController" class="text-white me-3"><i class="bi bi-person-circle"></i></a>
                        </div>
                    </div>

                    <div class="col-lg-3 align-items-center  clickClose" style="display: <%= yeslogin%>;">
                        <a class="wrapper" href="<%=request.getContextPath()%>/cart" class="text-white ms-5 me-3"><i class="bi bi-cart2"> <span> ${cartSize} </span>
                            </i></a>
                        <div class="btn-group">
                            <button type="button" class="btn btn-dark dropdown-toggle" style="border-radius:16px;"
                                    data-bs-toggle="dropdown"><span><%= ad.decodeString(fullName) %></span></button>
                            <div class="dropdown-menu">
                                <a href="#" class="dropdown-item">Profile</a>
                                <a href="#" class="dropdown-item">View purchase history</a>
                                <form class="dropdown-item " action="LogoutController" method="post">
                                    <button class="btn btn-outline-dark" name="btnLogout" >Logout</button>
                                </form>
                            </div>
                        </div>
                    </div>
                    <div class="d-lg-none col-1  d-flex  align-items-start justify-content-center">
                        <i id="nodebar" class="bi bi-list ms-auto"></i>
                    </div>
                </div>
            </nav>
        </header>