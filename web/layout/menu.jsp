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
                <div class="col-lg-9 col-md-12">
                    <div class="welcome_text">
                        <ul>
                            <li><span>Free shipping: </span>Take advantage of our time to save the event </li>
                            <li><span>Free returns: </span> Satisfaction guaranteed</li>
                        </ul>
                    </div>
                </div>
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
                    AccountDAO ad = new AccountDAO();
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
                
                <div class="col-lg-3 " style="display: <%=noLogin%>" >
                    <div class="d-flex justify-content-end align-items-center">
                        <a href="<%=request.getContextPath()%>/login" class="text-bg-info me-3"><i class="bi bi-cart2"></i></a>
                        <a href="<%=request.getContextPath()%>/login" class="text-bg-info me-3"><i class="bi bi-person-circle"></i></a>
                    </div>
                </div>
                <div class="col-lg-3 align-items-center" style="display: <%= yeslogin%>;">
                    <a href="<%=request.getContextPath()%>/cart" class="text-white ms-5 me-3"><i class="bi bi-cart2"></i></a>
                    <div class="btn-group">
                        <button type="button" class="btn btn-outline-info dropdown-toggle" style="border-radius:16px;"
                                data-bs-toggle="dropdown"><span><%= ad.decodeString(fullName) %></span></button>
                        <div class="dropdown-menu text-center bg-info">
                            <a href="#" class="dropdown-item">Profile</a>
                            <a href="<%= request.getContextPath() %>/order/purchasehistory" class="nav-link btn btn-link">My purchases</a>
                            <form action="logout" method="post" class="dropdown-item m-0 p-0">
                                <button type="submit" name="btnLogout" class="btn btn-link dropdown-item">Logout</button>
                            </form>
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
