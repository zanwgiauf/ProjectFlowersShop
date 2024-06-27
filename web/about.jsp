<%-- 
    Document   : about
    Created on : 12-Jun-2024, 21:26:29
    Author     : Le Minh Truong - CE171886
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>About Us</title>
        <link rel="stylesheet" href="lib/bootstrap/bootstrap_css/bootstrap.min.css" />
        <!-- Favicon -->
        <link rel="icon" type="image/x-icon" href="assets/img/logo/LogoF.png">

        <!-- CSS 
        ========================= -->

        <!-- Plugins CSS -->
        <link rel="stylesheet" href="assets/css/plugins.css">

        <!-- Main Style CSS -->
        <link rel="stylesheet" href="assets/css/style.css">
    </head>
    <body>
        <!-- Main Wrapper Start -->
        <!--Offcanvas menu area start-->
        <div class="off_canvars_overlay"></div>
        <jsp:include page="layout/menu.jsp"/>
        <!--breadcrumbs area start-->
        <div class="breadcrumbs_area other_bread">
            <div class="container">   
                <div class="row">
                    <div class="col-12">
                        <div class="breadcrumb_content">
                            <ul>
                                <li><a href="home">Home</a></li>
                                <li>/</li>
                                <li>Introduce</li>
                            </ul>
                        </div>
                    </div>
                </div>
            </div>         
        </div>
        <!--breadcrumbs area end-->

        <!--about section area -->
        <div class="about_section">
            <div class="container">  
                <div class="row">
                    <div class="col-lg-6 col-md-12">
                        <div class="about_content">
                            <h1>Welcome to ZFlowers!</h1>
                            <p> Welcome to ZFlowers, the premier online flower shop in Can Tho! At ZFlowers, we specialize in providing high-quality fresh flowers, elegant bouquets, and luxurious flower baskets for all your special occasions. Our dedicated team is passionate about delivering the finest flowers, from simple blooms to meticulously crafted floral arrangements.</p>
                            <p>We pride ourselves on our fast and convenient flower delivery service. With just a few clicks on our website, you can easily select and send beautiful fresh flowers to your loved ones anywhere in the Can Tho area. Our team ensures that each bouquet delivered is a perfect gift, filled with love and care.  </p>
                            <p>Explore our unique flower collections and experience our attentive customer service. ZFlowers is honored to be your companion in conveying love and affection through the beauty of fresh flowers!</p>
                     
                        </div>
                    </div>
                    <div class="col-lg-6 col-md-12">
                        <div class="about_thumb">
                            <img src="assets/img/about/images.jpg" alt="">
                        </div>
                    </div>
                </div>
            </div>     
        </div>
        <!--about section end-->

        <jsp:include page="layout/footer.jsp"/>

        <!-- JS
        ============================================ -->

        <!-- Plugins JS -->
        <script src="assets/js/plugins.js"></script>

        <!-- Main JS -->
        <script src="assets/js/main.js"></script>
    </body>
</html>
