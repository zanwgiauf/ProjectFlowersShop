<%-- 
    Document   : menu
    Created on : 16-Jun-2024, 20:35:33
    Author     : Le Minh Truong - CE171886
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib uri = "http://java.sun.com/jsp/jstl/functions" prefix="fn"%>

<!--header area start-->
<header class="header_area header_three">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.2/font/bootstrap-icons.min.css" />
    <link rel="stylesheet" href="<%= request.getContextPath()%>/lib/bootstrap/bootstrap_css/bootstrap.min.css" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/mdbootstrap/4.19.1/css/mdb.min.css" />
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
                <div class="col-lg-5 col-md-12">
                    <div class="top_right text-right">
                        <ul>

                            <c:if test="${sessionScope.user != null}">
                                <li class="top_links"><a href="#">Hello, ${sessionScope.user.user_name}<i class="bi bi-chevron-down"></i></i></a>
                                </c:if>
                                <c:if test="${sessionScope.user == null}">
                                <li class="top_links"><a href="#">Account<i class="ion-chevron-down"></i></a>
                                    </c:if>
                                <ul class="dropdown_links">
                                    <c:if test="${sessionScope.user != null}">
                                        <li><a href="user?action=myaccount">My account</a></li>
                                        </c:if>

                                    <c:if test="${fn: toUpperCase(sessionScope.user.isAdmin == 'TRUE')}">
                                        <li><a href="dashboard">Manage</a></li>
                                        </c:if>

                                    <c:if test="${sessionScope.user == null}">
                                        <li><a href="<%=request.getContextPath()%>/LoginController">Login</a></li>
                                        <li><a href="user?action=sigup">Register</a></li>
                                        </c:if>

                                    <c:if test="${sessionScope.user != null}">
                                        <li><a href="user?action=logout">Logout</a></li>
                                        </c:if>
                                </ul>
                            </li>
                        </ul>
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
                                <a href="cart?action=showcart"><i class="bi bi-cart-plus"></i>${sessionScope.size} Product</a>
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
                                    <li><a href="product">Category</a></li>
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
