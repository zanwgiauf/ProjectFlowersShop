<%-- 
    Document   : register
    Created on : Jun 5, 2024, 3:28:21 PM
    Author     : giaun
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <link rel="Website Icon" href="<%= request.getContextPath()%>/images/LogoF.png" type="png" />
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.2/font/bootstrap-icons.min.css" />
        <link rel="stylesheet" href="<%= request.getContextPath()%>/lib/bootstrap/bootstrap_css/bootstrap.min.css" />
        <link rel="stylesheet" href="<%= request.getContextPath()%>/css/style.css" />
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/mdbootstrap/4.19.1/css/mdb.min.css" />

        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.10.2/dist/umd/popper.min.js"
                integrity="sha384-7+zCNj/IqJ95wo16oMtfsKbZ9ccEh31eOz1HGyDuCQ6wgnyJNSYdrPa03rtR1zdB" crossorigin="anonymous"
        defer></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.min.js"
                integrity="sha384-QJHtvGhmr9XOIpI6YVutG+2QOK9T+ZnN4kzFN1RtK3zEFEIsxhlmWl5/YESvpZ13" crossorigin="anonymous"
        defer></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/mdbootstrap/4.19.1/js/mdb.min.js"></script>


    </head>
    <body>
        <header>
            <nav class="container fixed-top" style="background-color:#7b88a8; border-radius:16px;">
                <div class="row align-items-center">
                    <div class="col-lg-2 col-4 d-md-flex align-items-center justify-content-center">
                        <a href="#header" class="text-white d-flex align-items-center">
                            <img src="./images/LogoF.png" width="70px" alt="logo" />
                            <span class="ms-2">Flower Shop</span>
                        </a>
                    </div>
                    <div class="col-lg-4  d-none d-lg-flex justify-content-start align-items-center">
                        <ul class="nav d-lg-flex">
                            <li class="nav-item"><a class="nav-link text-white" href="<%=request.getContextPath()%>/">Home</a></li>
                            <li class="nav-item"><a class="nav-link text-white" href="#">Category</a></li>
                            <li class="nav-item"><a class="nav-link text-white" href="#">Introduce</a></li>
                            <li class="nav-item"><a class="nav-link text-white" href="#">Contact</a></li>
                        </ul>
                    </div>
                    <div class="col-lg-3 col-7 align-items-center">
                        <form action="CategoryController" method="post" class="d-flex align-items-center">
                            <input class="w-75 form-control rounded-pill bg-light" type="text" name="search" placeholder="Search" />
                            <button class="btn rounded-pill bg-light py-2" type="submit" name="btn-search">
                                <i class="bi bi-search"></i>
                            </button>
                        </form>
                    </div>
                    <div class="col-lg-3">
                        <div class="d-flex justify-content-end align-items-center me-3">
                            <a href="<%=request.getContextPath()%>/LoginController" class="text-white me-3"><i class="bi bi-cart2"></i></a>
                            <a href="<%=request.getContextPath()%>/LoginController" class="text-white me-3"><i class="bi bi-person-circle"></i></a>
                        </div>
                    </div>
                    <div class="d-lg-none col-1  d-flex  align-items-start justify-content-center">
                        <i id="nodebar" class="bi bi-list ms-auto"></i>
                    </div>
                </div>
            </nav>
        </header>
        <main class="my-5 pt-5 close-main">
            <div class="row d-flex justify-content-center align-items-center">
                <div class="col-12 col-md-9 col-lg-7 col-xl-6">
                    <div class="card" style="border-radius: 15px;">
                        <div class="card-body p-5">
                            <h2 class="text-uppercase text-center mb-5">Register</h2>
                            <form method="post" method="/SendEmailController">
                                <div class="form-outline mb-4">
                                    <label class="form-label" for="yourName">Your Name</label>
                                    <input type="text" id="yourName" class="form-control form-control-lg" placeholder="Enter your name" required=""/>
                                </div>
                                <div  class="form-outline mb-4">
                                    <label class="form-label" for="yourDate">Your Birthday</label>
                                    <input type="date" id="yourDate" class="form-control form-control-lg" placeholder="Choose your birthday" required=""/>
                                </div>
                                <div  class="form-outline mb-4">
                                    <label class="form-label" for="yourPhone">Your Phone Number</label>
                                    <input type="text" id="yourPhone" class="form-control form-control-lg" placeholder="Enter your phone number" required=""/>
                                </div>
                                <div class="form-outline mb-4">
                                    <label class="form-label" for="yourEmail">Your Email</label>
                                    <input type="email" id="yourEmail" class="form-control form-control-lg"  placeholder="Enter your email" required=""/>
                                </div>
                                <div class="form-outline mb-4">
                                    <label class="form-label" for="yourAddress">Your Address</label>
                                    <input type="password" id="yourAddress" class="form-control form-control-lg"  placeholder="Enter your address" required=""/>
                                </div>
                                <div class="form-outline mb-4">
                                    <label class="form-label" for="yourPassword">Password</label>
                                    <input type="password" id="yourPassword" class="form-control form-control-lg" placeholder="Enter your password"  required=""/>

                                </div>
                                <div class="form-outline mb-4">
                                    <label class="form-label" for="yourRepeatPassword">Repeat your password</label>
                                    <input type="password" id="yourRepeatPassword" class="form-control form-control-lg" placeholder="Re-enter your password"  required=""/>
                                </div>
                                <div class="d-flex justify-content-center">
                                    <button  type="submit" 
                                             class="btn btn-primary btn-block btn-lg">Register</button>
                                </div>
                                <p class="text-center text-muted mt-5 mb-0">Have already an account? <a href="<%=request.getContextPath() %>/LoginController"
                                                                                                        class="text-info"><u>Login here</u></a></p>
                            </form>
                        </div>
                    </div>
                </div>
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
                    <span>&copy; 2024, Designed by Group 4</span>
                </div>
            </div>
        </footer>

        <script src="<%= request.getContextPath()%>/lib/bootstrap/bootstrap_js/bootstrap.min.js"></script>
        <script src="<%= request.getContextPath()%>/sang/js/vendor/jquery-2.2.4.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.11.0/umd/popper.min.js"
                integrity="sha384-b/U6ypiBEHpOf/4+1nzFpr53nxSS+GLCkfwBdFNTxtclqqenISfwAzpKaMNFNmj4"
        crossorigin="anonymous"></script>

    </body>
</html>
