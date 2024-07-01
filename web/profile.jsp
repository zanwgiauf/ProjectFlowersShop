<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="Models.Customer" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Profile Page</title>
    <link rel="Website Icon" href="<%= request.getContextPath()%>/images/LogoF.png" type="png" />
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.2/font/bootstrap-icons.min.css" />
    <link rel="stylesheet" href="<%= request.getContextPath()%>/lib/bootstrap/bootstrap_css/bootstrap.min.css" />
    <link rel="stylesheet" href="<%= request.getContextPath()%>/css/style.css" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/mdbootstrap/4.19.1/css/mdb.min.css" />
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.10.2/dist/umd/popper.min.js" integrity="sha384-7+zCNj/IqJ95wo16oMtfsKbZ9ccEh31eOz1HGyDuCQ6wgnyJNSYdrPa03rtR1zdB" crossorigin="anonymous" defer></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.min.js" integrity="sha384-QJHtvGhmr9XOIpI6YVutG+2QOK9T+ZnN4kzFN1RtK3zEFEIsxhlmWl5/YESvpZ13" crossorigin="anonymous" defer></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/mdbootstrap/4.19.1/js/mdb.min.js"></script>
    <style>
        .button-group {
            display: flex;
            justify-content: center;
            gap: 10px; /* Adjust the gap between buttons as needed */
        }
        .back-home-btn {
            position: absolute;
            top: 10px;
            left: 10px;
        }
    </style>
</head>
<body>
    <form method="get" action="<%= request.getContextPath() %>/" class="back-home-btn">
        <button type="submit" class="btn btn-danger">
            <i class="bi bi-arrow-left"></i>
        </button>                           
    </form>
    <main class="my-5 pt-5 close-main">
        <div class="row d-flex justify-content-center align-items-center">
            <div class="col-12 col-md-9 col-lg-7 col-xl-6">
                <div class="card" style="border-radius: 15px;">
                    <div class="card-body p-5">
                        <h2 class="text-uppercase text-center mb-5"><%= request.getAttribute("customer") != null ? ((Customer)request.getAttribute("customer")).getFullName() : "" %> Profile</h2>
                        <form method="post" action="<%= request.getContextPath() %>/ProfileController" onsubmit="return validateForm();">
                            <div class="form-outline mb-4">
                                <label class="form-label" for="fullName">Full Name</label>
                                <input type="text" id="fullName" name="fullName" class="form-control form-control-lg" value="<%= request.getAttribute("customer") != null ? ((Customer)request.getAttribute("customer")).getFullName() : "" %>" required>
                            </div>
                            <div class="form-outline mb-4">
                                <label class="form-label" for="birthday">Birthday</label>
                                <input type="date" id="birthday" name="birthday" class="form-control form-control-lg" value="<%= request.getAttribute("customer") != null ? ((Customer)request.getAttribute("customer")).getBirthday() : "" %>" required>
                            </div>
                            <div class="form-outline mb-4">
                                <label class="form-label" for="phone">Phone</label>
                                <input type="text" id="phone" name="phone" class="form-control form-control-lg" value="<%= request.getAttribute("customer") != null ? ((Customer)request.getAttribute("customer")).getPhone() : "" %>" required>
                            </div>
                            <div class="form-outline mb-4">
                                <label class="form-label" for="email">Email</label>
                                <input type="email" id="email" name="email" class="form-control form-control-lg" value="<%= request.getAttribute("customer") != null ? ((Customer)request.getAttribute("customer")).getEmail() : "" %>" required>
                            </div>
                            <div class="form-outline mb-4">
                                <label class="form-label" for="address">Address</label>
                                <input type="text" id="address" name="address" class="form-control form-control-lg" value="<%= request.getAttribute("customer") != null ? ((Customer)request.getAttribute("customer")).getAddress() : "" %>" required>
                            </div>
                            <div class="d-flex justify-content-center mb-3">
                                <button type="submit" class="btn btn-primary btn-block btn-lg">Update</button>
                            </div>
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
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.11.0/umd/popper.min.js" integrity="sha384-b/U6ypiBEHpOf/4+1nzFpr53nxSS+GLCkfwBdFNTxtclqqenISfwAzpKaMNFNmj4" crossorigin="anonymous"></script>
</body>
</html>
