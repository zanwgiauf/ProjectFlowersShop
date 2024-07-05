<%-- 
    Document   : menu
    Created on : 16-Jun-2024, 20:35:33
    Author     : Le Minh Truong - CE171886
--%>

<%@page import="DAOs.AccountDAO"%>
<%@page import="Models.Customer"%>
<%@page import="java.net.URLDecoder"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib uri = "http://java.sun.com/jsp/jstl/functions" prefix="fn"%>

<!--header area start-->
<header class="header_area header_three">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.2/font/bootstrap-icons.min.css" />
    <link rel="stylesheet" href="<%= request.getContextPath()%>/lib/bootstrap/bootstrap_css/bootstrap.min.css" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/mdbootstrap/4.19.1/css/mdb.min.css" />
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
    <!--header top start-->
    <div class="header_top">
        <div class="container-fluid">
            <div class="row align-items-center">
                <div class="col-lg-7 col-md-12">
                    <div class="welcome_text">
                        <ul>
                            <li><span>Free shipping: </span>Take advantage of our time to save the event </li>
                            <li><span>Free returns: </span> Satisfaction guaranteed</li>
                        </ul>
                    </div>
                </div>
                <%
                                String fullName = (String) session.getAttribute("fullName"); // Get name from session
                                if (fullName == null) {
                                    // Check for cookie if session does not have the name
                                    Cookie[] cookies = request.getCookies();
                                    if (cookies != null) {
                                    AccountDAO d = new AccountDAO();
                                        for (Cookie cookie : cookies) {
                                            if ("fullNameC".equals(cookie.getName())) {
                                                fullName = d.decodeString(cookie.getValue());
                                                break;
                                            }
                                        }
                                    }
                                }
                                String noLogin = (fullName == null) ? "" : "none"; // Initialize noLogin based on fullName
                                
                %>
                <div class="col-md-2" style="display: <%=noLogin%>;">
                    <div class="d-flex justify-content-end align-items-center me-3">
                        
                        <a href="<%=request.getContextPath()%>/LoginController" class="text-white me-3">Account</a>
                    </div>
                </div>
                <div class="col-md-3" style="display: <%= fullName != null ? "" : "none" %>;">
                    <div class="d-flex align-items-center justify-content-end">
                        <div class="btn-group ">
                            <button type="button" class="bg-warning text-white dropdown-toggle" style="border-radius:16px;"
                                    data-bs-toggle="dropdown"><span><%= fullName %></span></button>
                            <div class="dropdown-menu">
                                <a href="#" class="dropdown-item">Profile</a>
                                <a href="#" class="dropdown-item">View purchase history</a>
                                <form class="dropdown-item " action="LogoutController" method="post">
                                    <button class="btn btn-outline-dark" name="btnLogout" >Logout</button>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!--header top start-->

    <!--header middel start-->
    <div class="header_middel">
        <div class="container-fluid">
            <div class="middel_inner">
                <div class="row align-items-center">
                    <div class="col-lg-4">
                        <div class="search_bar">
                            <form action="product?action=search" method="POST">
                                <input name="text" placeholder="Search..." type="text">
                                <button type="submit"><i class="bi bi-search"></i></button>
                            </form>
                        </div>
                    </div>
                    <div class="col-lg-4" x>
                        <div class="logo">
                            <a href="home"><img style="border-radius: 60px; margin-bottom: 0px; margin-top: 10px" width="110px" height="110px"src="assets/img/logo/LogoF.png" alt=""></a>
                        </div>
                    </div>
                    <div class="col-lg-4">
                        <div class="cart_area">
                            <div class="cart_link">
                                <a href="cart?action=showcart"><i class="bi bi-cart-plus"></i>${sessionScope.size} Shopping Cart</a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="horizontal_menu">
                <div class="left_menu">
                    <div class="main_menu">
                        <nav>
                            <ul>
                                <li><a href="home">Home<i class="fa"></i></a>
                                </li>
                                <li class="mega_items"><a href="product">Category</a>
                                </li>
                            </ul>
                        </nav>
                    </div>
                </div>
                <div class="right_menu">
                    <div class="main_menu">
                        <nav>
                            <ul>
                                <li><a href="about">Introduce</a></li>
                                <li><a href="contact">Contact</a></li>
                            </ul>
                        </nav>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!--header middel end-->

    <!--header bottom satrt-->
    <div class="header_bottom sticky-header">
        <div class="container">
            <div class="row align-items-center">
                <div class="col-12">
                    <div class="main_menu_inner">
                        <div class="main_menu">
                            <nav>
                                <ul>
                                    <li class="active"><a href="home">Home</a></li>
                                    <li><a href="categories">Category</a></li>
                                    <li><a href="about">Introduce</a></li>
                                    <li><a href="contact">Contact</a></li>
                                    <li><a href="promotionsview">Promotion</a></li>
                                </ul>
                            </nav>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!--header bottom end-->
</header>
