<%-- 
    Document   : login
    Created on : Jun 5, 2024, 2:10:10 PM
    Author     : giaun
--%>
<%@page import="DAOs.AccountDAO"%>
<%@page import="Models.Customer"%>
<%@page import="java.net.URLDecoder"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <title>Flowers Shop</title>
        <link rel="Website Icon" href="<%= request.getContextPath()%>/images/LogoF.png" type="png" />
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css" integrity="sha384-4LISF5TTJX/fLmGSxO53rV4miRxdg84mZsxmO8Rx5jGtp/LbrixFETvWa5a6sESd" crossorigin="anonymous">
        <style>
            .position-fixed {
                z-index: 1050;
            }
            .top-25 {
                top: 10%;
            }
            .start-50 {
                left: 50%;
            }
            .translate-middle {
                transform: translate(-50%, -50%);
            }
            .dropdown-item {
                display: flex;
                justify-content: center;
                align-items: center;
            }

            .dropdown-item button {
                width: 100%;
                text-align: left;
            }

        </style>


    </head>

    <body>
        <header>
            <nav class="container position-relative fixed-top" style="background-color:#7b88a8; border-radius:16px;">
                <div class="row d-flex justify-content-center align-items-center">
                    <div class="col-lg-2 col-4 d-md-flex align-items-center justify-content-center">
                        <a href="<%=request.getContextPath()%>/" class="text-white d-flex align-items-center text-decoration-none">
                            <img src="./images/LogoF.png" width="70px" alt="logo" />
                            <span class="ms-2">Flower Shop</span>
                        </a>
                    </div>
                    <div class="col-lg-3  d-none d-lg-flex justify-content-start align-items-center">
                        <ul class="nav d-lg-flex ">
                            <li class="nav-item"><a class="nav-link text-white" href="<%=request.getContextPath()%>/">Home</a></li>
                            <li class="nav-item"><a class="nav-link text-white" href="<%=request.getContextPath()%>/categories">Category</a></li>
                            <li class="nav-item"><a class="nav-link text-white" href="<%=request.getContextPath()%>/about">Introduce</a></li>
                            <li class="nav-item"><a class="nav-link text-white" href="<%=request.getContextPath()%>/contact">Contact</a></li>               
                            <li class="nav-item"><a class="nav-link text-white" href="<%=request.getContextPath()%>/promotionsview">Promotions</a></li>
                        </ul>
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
                    <div class="col-lg-3 col-7 align-items-center">
                        <form action="ProductController" method="post" class="d-flex align-items-center">
                            <input class="w-75 form-control rounded-pill bg-light" type="text" name="search" placeholder="Search" />
                            <button class="btn rounded-pill bg-light py-2 px-4 ms-2" type="submit" name="btn-search">
                                <i class="bi bi-search"></i>
                            </button>
                        </form>
                    </div>
                    <div class="col-lg-3" style="display: <%=noLogin%>" >
                        <div class="d-flex justify-content-end align-items-center me-3">
                            <a href="<%=request.getContextPath()%>/login" class="text-white me-3"><i class="bi bi-cart2"></i></a>
                            <a href="<%=request.getContextPath()%>/login" class="text-white me-3"><i class="bi bi-person-circle"></i></a>
                        </div>
                    </div>
                    <div class="col-lg-4 align-items-center" style="display: <%= yeslogin%>;">
                        <a href="<%=request.getContextPath()%>/cart" class="text-white ms-5 me-3"><i class="bi bi-cart2"></i></a>
                        <div class="btn-group">
                            <button type="button" class="btn btn-dark dropdown-toggle" style="border-radius:16px;"
                                    data-bs-toggle="dropdown"><span><%= ad.decodeString(fullName) %></span></button>
                            <div class="dropdown-menu text-center">
                                <a href="#" class="dropdown-item">Profile</a>
                                <a href="<%= request.getContextPath() %>/order/purchasehistory" class="nav-link btn btn-link">My purchases</a>
                                <form action="logout" method="post" class="dropdown-item m-0 p-0">
                                    <button type="submit" name="btnLogout" class="btn btn-link dropdown-item">Logout</button>
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


        <%
            String check = "";
            if (session.getAttribute("checkLoginMess") != null) {
                check = (String) session.getAttribute("checkLoginMess");
            }
            session.removeAttribute("checkLoginMess");
        %>
        <main class="mt-5 pt-5 close-main">
            <div id="login-id" class="row d-flex justify-content-center align-items-center login">
                <div class="col-12 col-md-9 col-lg-7 col-xl-6">
                    <div class="card" style="border-radius: 15px;">
                        <div class="card-body px-5">
                            <h2 class="text-uppercase text-center my-3">Login</h2>
                            <form method="post" action="login" onsubmit="return validLogin()">
                                <div data-mdb-input-init class="form-outline mb-4 form-login">
                                    <input name="email" class="form-control" id="email-login" type="text" placeholder="Enter your email">
                                    <br>
                                    <input name="password" class="form-control" id="password-login" type="password" placeholder="Enter your password">
                                    <div style="color: red"><strong><%= check%></strong></div>
                                </div>
                                <div class="d-grid gap-2 col-6 mx-auto">
                                    <div id="error-messages" class="mt-2"></div>
                                    <button data-mdb-button-init data-mdb-ripple-init class="btn btn-primary btn-lg btn-block " name="loginSubmit" type="submit">Login</button>
                                    <div class="text-center mt-3">
                                        <p ><a class="text-muted" <a href="<%=request.getContextPath() %>/ForgotController">Forgot password?</a></p>
                                        <p>Don't have an account? <a href="<%=request.getContextPath()%>/register" class="link-info forgotHover">Register here</a></p>
                                    </div>
                                    <hr>

                                </div>
                            </form>
                            <div class="text-center mt-3">
                                <a href="https://accounts.google.com/o/oauth2/auth?scope=email%20profile&redirect_uri=http://localhost:8080/FlowerShopWebsite/loginwithgoogle&response_type=code&client_id=370764090420-k526pdcm848buf522o6ccouv8koo58j7.apps.googleusercontent.com&approval_prompt=force"
                                   class="btn btn-google-login">Login With Google</a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

        </main>

    </div>


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
                <span>&copy; 2024, Desisgned by Group 4</span>
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
