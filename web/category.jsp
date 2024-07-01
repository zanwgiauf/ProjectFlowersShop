<%-- 
    Document   : caterory
    Created on : 21-Jun-2024, 16:47:04
    Author     : Le Minh Truong - CE171886
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <meta name="description" content="">
        <title>Shop Category</title>
        <!-- Favicon -->
        <link rel="icon" type="image/x-icon" href="assets/img/logo/logo.png">

        <!-- CSS 
        ========================= -->

        <!-- Plugins CSS -->
        <link rel="stylesheet" href="assets/css/plugins.css">

        <!-- Main Style CSS -->
        <link rel="stylesheet" href="assets/css/style.css">
    </head>
    <body>
        <!-- Main Wrapper Start -->
        <!-- Offcanvas menu area start -->
        <div class="off_canvars_overlay"></div>
        <jsp:include page="layout/menu.jsp"/>

        <!-- Breadcrumbs area start -->
        <div class="breadcrumbs_area">
            <div class="container">   
                <div class="row">
                    <div class="col-12">
                        <div class="breadcrumb_content">
                            <ul>
                                <li><a href="home">Home</a></li>
                                <li>/</li>
                                <li>Shop</li>
                            </ul>
                        </div>
                    </div>
                </div>
            </div>         
        </div>
        <!-- Breadcrumbs area end -->

        <!-- Shop area start -->
        <div class="shop_area shop_reverse">
            <div class="container">
                <div class="shop_inner_area">
                    <div class="row">
                        <div class="col-lg-3 col-md-12">
                            <!-- Sidebar widget start -->
                            <div class="sidebar_widget">
                                <div class="widget_list widget_categories">
                                    <h2>Categories</h2>
                                    <ul>
                                        <li><a href="categories">ALL</a></li>
                                            <c:forEach items="${CategoryData}" var="c">
                                            <li><a href="categories?action=listByCategory&categoryID=${c.categoryID}">${c.name}</a></li>
                                            </c:forEach>
                                    </ul>
                                </div>
                            </div>
                            <!-- Sidebar widget end -->
                        </div>

                        <div class="col-lg-9 col-md-12">
                            <!-- Shop wrapper start -->
                            <div class="shop_title">
                                <h2>Products</h2>
                            </div>
                            <div class="shop_toolbar_wrapper" style="border:none">
                                <div class="dropdown ">
                                    <button style="color: #000; background-color: #ffffff; border:none; font-family: sans-serif;" class="btn btn-secondary dropdown-toggle" type="button" id="dropdownMenuButton" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                        Filter
                                    </button>
                                    <div class="dropdown-menu" aria-labelledby="dropdownMenuButton">
                                        <a class="dropdown-item" href="categories?action=sort&type=low">Prices from low to high</a>
                                        <a class="dropdown-item" href="categories?action=sort&type=high">Prices from high to low</a>
                                        <a class="dropdown-item" href="categories?action=sort&type=a-z">A-Z</a>
                                    </div>
                                </div>
                            </div>
                            <div class="row shop_wrapper">
                                <c:forEach items="${ProductData}" var="p">
                                    <!-- Hiển thị sản phẩm -->              
                                    <div class="col-lg-4 col-md-4 col-12">
                                        <div class="single_product">
                                            <div class="product_thumb">
                                                <a class="primary_img" href="categories?action=productdetail&ProductID=${p.productID}">
                                                    <img src="${p.image}" alt="${p.name}">
                                                </a>
                                                <div class="quick_button">
                                                    <a href="categories?action=productdetail&ProductID=${p.productID}" title="quick_view">View Product</a>
                                                </div>
                                            </div>
                                            <div class="product_content grid_content">
                                                <h3><a href="categories?action=productdetail&ProductID=${p.productID}">${p.name}</a></h3>
                                                <span class="current_price">${p.price}</span>
                                            </div>
                                        </div>
                                    </div>
                                </c:forEach>
                            </div>

                            <c:set var="page" value="${page}"/>
                            <div class="shop_toolbar t_bottom" style="border: none;">
                                <div class="pagination">
                                    <ul>
                                        <c:forEach begin="${1}" end="${num}" var="i">
                                            <li class="${i == page ? "current" : ""}"><a href="categories?page=${i}&action=${action}&type=${type}&categoryID=${categoryID}&text=${text}">${i}</a></li>
                                            </c:forEach>
                                    </ul>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!-- Shop area end -->

        <!-- Footer area start -->
        <jsp:include page="layout/footer.jsp"/>
        <!-- Footer area end -->

        <!-- Plugins JS -->
        <script src="assets/js/plugins.js"></script>

        <!-- Main JS -->
        <script src="assets/js/main.js"></script>
    </body>
</html>
