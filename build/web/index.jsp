<%@page import="DAOs.ProductDAO"%>
<%@page import="Models.Product"%>
<%@page import="DAOs.AccountDAO"%>
<%@page import="Models.Customer"%>
<%@page import="java.util.List"%>
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

    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.10.2/dist/umd/popper.min.js"
            integrity="sha384-7+zCNj/IqJ95wo16oMtfsKbZ9ccEh31eOz1HGyDuCQ6wgnyJNSYdrPa03rtR1zdB" crossorigin="anonymous"
    defer></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.min.js"
            integrity="sha384-QJHtvGhmr9XOIpI6YVutG+2QOK9T+ZnN4kzFN1RtK3zEFEIsxhlmWl5/YESvpZ13" crossorigin="anonymous"
    defer></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/mdbootstrap/4.19.1/js/mdb.min.js"></script>
</head>
<style>
    .card-img-top {
        width: 100%;
        height: 200px;
        object-fit: cover;
    }
</style>
<body>
<%
    Cookie cookies[] = request.getCookies();
    if (cookies != null) {
        for (Cookie c : cookies) {
            if (c.getName().contains("roleA")) {
                response.sendRedirect("/FlowerShopWebsite/AdminController");
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
            <div class="col-lg-3 col-7 align-items-center">
                <form action="ProductController" method="post" class="d-flex align-items-center">
                    <input class="w-75 form-control rounded-pill bg-light" type="text" name="search" placeholder="Search" />
                    <button class="btn rounded-pill bg-light py-2" type="submit" name="btn-search">
                        <i class="bi bi-search"></i>
                    </button>
                </form>
            </div>
            <div class="col-lg-3" style="display: <%=noLogin%>">
                <div class="d-flex justify-content-end align-items-center me-3">
                    <a href="<%=request.getContextPath()%>/login" class="text-white me-3"><i class="bi bi-cart2"></i></a>
                    <a href="<%=request.getContextPath()%>/login" class="text-white me-3"><i class="bi bi-person-circle"></i></a>
                </div>
            </div>
            <div class="col-lg-3 align-items-center clickClose" style="display: <%= yeslogin%>;">
                <a href="<%=request.getContextPath()%>/CartController" class="text-white ms-5 me-3"><i class="bi bi-cart2"></i></a>
                <div class="btn-group">
                    <button type="button" class="btn btn-dark dropdown-toggle" style="border-radius:16px;" data-bs-toggle="dropdown">
                        <span><%= ad.decodeString(fullName) %></span>
                    </button>
                    <div class="dropdown-menu">
                        <a href="#" class="dropdown-item">Profile</a>
                        <a href="#" class="dropdown-item">View purchase history</a>
                        <form class="dropdown-item" action="LogoutController" method="post">
                            <button class="btn btn-outline-dark" name="btnLogout">Logout</button>
                        </form>
                    </div>
                </div>
            </div>
            <div class="d-lg-none col-1 d-flex align-items-start justify-content-center">
                <i id="nodebar" class="bi bi-list ms-auto"></i>
            </div>
        </div>
    </nav>
</header>

<main class="mt-5 pt-4">
    <div class="container">
        <div id="myCarousel" class="carousel slide" data-bs-ride="carousel">
            <!-- Carousel indicators -->
            <ol class="carousel-indicators">
                <li data-bs-target="#myCarousel" data-bs-slide-to="0" class="active"></li>
                <li data-bs-target="#myCarousel" data-bs-slide-to="1"></li>
                <li data-bs-target="#myCarousel" data-bs-slide-to="2"></li>
            </ol>
            <!-- Wrapper for carousel items -->
            <div class="carousel-inner">
                <div class="carousel-item active">
                    <img src="https://img.freepik.com/free-psd/flat-design-spring-template_23-2150073645.jpg?t=st=1717526658~exp=1717530258~hmac=096e62ea0d094314e250fe5b6ead38bdbce017f4653aba1d1145170a9f80563f&w=1380" class="d-block w-100" alt="slide 1">
                </div>
                <div class="carousel-item">
                    <img src="https://img.freepik.com/free-photo/tied-up-paper-with-string-pink-flowers-leaves-concrete-background_23-2147942354.jpg?t=st=1717526153~exp=1717529753~hmac=5462b2bca2ce7e5846276d65d7650c3d7513c20acf65b7ac23d62984bbdbba27&w=1380" class="d-block w-100" alt="Slide 2">
                </div>
                <div class="carousel-item">
                    <img src="https://img.freepik.com/free-psd/flat-design-spring-template_23-2150073641.jpg?t=st=1717527002~exp=1717530602~hmac=a1c4d08ad6f20e97fffb9abdc69b00aa66f20175c56050eda1a822b561ea5e31&w=1380" class="d-block w-100" alt="Slide 3">
                </div>
            </div>
            <!-- Carousel controls -->
            <a class="carousel-control-prev" href="#myCarousel" data-bs-slide="prev">
                <span class="carousel-control-prev-icon"></span>
            </a>
            <a class="carousel-control-next" href="#myCarousel" data-bs-slide="next">
                <span class="carousel-control-next-icon"></span>
            </a>
        </div>

        <!-- Hiển thị danh sách sản phẩm cho từng category -->
        <%
            ProductDAO productDAO = new ProductDAO();
            // Lấy danh sách sản phẩm cho từng category
            List<Product> loveFlowersProducts = productDAO.getProductsByCategoryId(1); // Category 1: LOVE FLOWERS
            List<Product> birthdayFlowersProducts = productDAO.getProductsByCategoryId(2); // Category 2: BIRTHDAY FLOWERS
            List<Product> sympathyFlowersProducts = productDAO.getProductsByCategoryId(3); // Category 3: SYMPATHY FLOWERS
            List<Product> newYearFlowersProducts = productDAO.getProductsByCategoryId(4); // Category 4: NEW YEAR FLOWERS
        %>

        <!-- LOVE FLOWERS -->
        <h2 class="text-center mb-4 mt-5">LOVE FLOWERS</h2>
        <div class="row g-4">
            <% for (int i = 0; i < loveFlowersProducts.size() && i < 4; i++) { %>
            <div class="col-md-3">
                <div class="card">
                    <img src="<%= loveFlowersProducts.get(i).getImage() %>" class="card-img-top" alt="...">
                    <div class="card-body text-center">
                        <h5 class="card-title"><%= loveFlowersProducts.get(i).getName() %></h5>
                        <p class="card-text">Price: $<%= loveFlowersProducts.get(i).getPrice() %></p>

                    </div>
                </div>
            </div>
            <% } %>
        </div>
        <div class="text-center">
            <a href="allProducts.jsp?categoryId=1" class="btn btn-primary mt-3">View More</a>
        </div>

        <!-- BIRTHDAY FLOWERS -->
        <h2 class="text-center mb-4 mt-5">BIRTHDAY FLOWERS</h2>
        <div class="row g-4">
            <% for (int i = 0; i < birthdayFlowersProducts.size() && i < 4; i++) { %>
            <div class="col-md-3">
                <div class="card">
                    <img src="<%= birthdayFlowersProducts.get(i).getImage() %>" class="card-img-top" alt="...">
                    <div class="card-body text-center">
                        <h5 class="card-title"><%= birthdayFlowersProducts.get(i).getName() %></h5>
                        <p class="card-text">Price: $<%= birthdayFlowersProducts.get(i).getPrice() %></p>

                    </div>
                </div>
            </div>
            <% } %>
        </div>
        <div class="text-center">
            <a href="allProducts.jsp?categoryId=2" class="btn btn-primary mt-3">View More</a>
        </div>

        <!-- SYMPATHY FLOWERS -->
        <h2 class="text-center mb-4 mt-5">CONGRATULATION FLOWERS</h2>
        <div class="row g-4">
            <% for (int i = 0; i < sympathyFlowersProducts.size() && i < 4; i++) { %>
            <div class="col-md-3">
                <div class="card">
                    <img src="<%= sympathyFlowersProducts.get(i).getImage() %>" class="card-img-top" alt="...">
                    <div class="card-body text-center">
                        <h5 class="card-title"><%= sympathyFlowersProducts.get(i).getName() %></h5>
                        <p class="card-text">Price: $<%= sympathyFlowersProducts.get(i).getPrice() %></p>

                    </div>
                </div>
            </div>
            <% } %>
        </div>
        <div class="text-center">
            <a href="allProducts.jsp?categoryId=3" class="btn btn-primary mt-3">View More</a>
        </div>

        <!-- NEW YEAR FLOWERS -->
        <h2 class="text-center mb-4 mt-5">FUNERAL FLOWERS</h2>
        <div class="row g-4">
            <% for (int i = 0; i < newYearFlowersProducts.size() && i < 4; i++) { %>
            <div class="col-md-3">
                <div class="card">
                    <img src="<%= newYearFlowersProducts.get(i).getImage() %>" class="card-img-top" alt="...">
                    <div class="card-body text-center">
                        <h5 class="card-title"><%= newYearFlowersProducts.get(i).getName() %></h5>
                        <p class="card-text">Price: $<%= newYearFlowersProducts.get(i).getPrice() %></p>

                    </div>
                </div>
            </div>
            <% } %>
        </div>
        <div class="text-center">
            <a href="allProducts.jsp?categoryId=4" class="btn btn-primary mt-3">View More</a>
        </div>

</main>
<footer class="text-white mt-5 pt-4" style="background-color:#7b88a8;">
    <div class="container text-center text-md-start ">
        <div class="row pt-5">
            <div class="col-md-6 col-lg-3 col-xl-3 mb-4">
                <h4 class="text-uppercase fw-bold">About ZFLOWERS</h4>
                <p>ZFlowers is an online flower shop in Can Tho, Vietnam. They specialize in providing elegant and stylish fresh flower bouquets for customers. ZFlowers’ online flower delivery service allows you to send beautiful fresh flowers to your loved ones anywhere in the Can Tho area.</p>
            </div>
            <div class="col-md-6 col-lg-3 col-xl-3 mb-4">
                <h4 class="text-uppercase fw-bold">Address</h4>
                <p>70 Le Loi, Cai Khe Ward, Ninh Kieu, Can Tho</p>
                <div>Phone: 0859022220</div>
                <div>Email: zflowers.vn@gmail.com</div>
            </div>
            <div class="col-md-6 col-lg-3 col-xl-3 mb-4">
                <h4 class="text-uppercase fw-bold">Customer Support</h4>
                <ul class="list-unstyled">
                    <li><a href="#" class="text-white text-decoration-none">Introduce ZFlowers Shop</a></li>
                    <li><a href="#" class="text-white text-decoration-none">Order Guidelines</a></li>
                    <li><a href="#" class="text-white text-decoration-none">Privacy Policy</a></li>
                </ul>
            </div>
            <div class="col-md-6 col-lg-3 col-xl-3 mb-4">
                <h4 class="text-uppercase fw-bold text-lg-center">Follow Us</h4>
                <div class="d-lg-flex justify-content-center align-items-center gap-3">
                    <a href="#" class="text-white"><i class="bi bi-facebook" style="font-size: 1.5rem;"></i></a>
                    <a href="#" class="text-white"><i class="bi bi-instagram" style="font-size: 1.5rem;"></i></a>
                    <a href="#" class="text-white"><i class="bi bi-youtube" style="font-size: 1.5rem;"></i></a>
                    <a href="#" class="text-white"><i class="bi bi-google" style="font-size: 1.5rem;"></i></a>
                </div>
            </div>
        </div>
        <div class="d-flex justify-content-center mt-4 pb-4">
            <span>&copy; 2024, Designed by Nguyen Van Giau</span>
        </div>
    </div>
</footer>

<script src="<%= request.getContextPath()%>/lib/bootstrap/bootstrap_js/bootstrap.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.11.0/umd/popper.min.js"
        integrity="sha384-b/U6ypiBEHpOf/4+1nzFpr53nxSS+GLCkfwBdFNTxtclqqenISfwAzpKaMNFNmj4"
crossorigin="anonymous"></script>

</body>
</html>
