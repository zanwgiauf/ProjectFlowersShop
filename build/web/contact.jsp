<%-- 
    Document   : contact
    Created on : 12-Jun-2024, 21:25:41
    Author     : Le Minh Truong - CE171886
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>Contact Us</title>
        <link rel="stylesheet" href="<%=request.getContextPath()%>/lib/bootstrap/bootstrap_css/bootstrap.min.css" />
        <!-- Favicon -->
        <link rel="icon" type="image/x-icon" href="assets/img/logo/LogoF.png">
        <!-- CSS -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
        <!-- Plugins CSS -->
        <link rel="stylesheet" href="assets/css/plugins.css">

        <!-- Main Style CSS -->
        <link rel="stylesheet" href="assets/css/style.css">
    </head>
    <body>
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
                                <li><a href="index.html">Home</a></li>
                                <li>/</li>
                                <li>Contact</li>
                            </ul>
                        </div>
                    </div>
                </div>
            </div>         
        </div>
        <!--breadcrumbs area end-->


        <!--contact area start-->
        <div class="contact_area">
            <div class="container">   
                <div class="row">
                    <div class="col-lg-6 col-md-12">
                        <div class="contact_message content">
                            <h3>Contact</h3>
                            <ul>
                                <li><i class="bi bi-building"></i>  600, Nguyen Van Cu Street (extended), An Binh Ward, Ninh Kieu District, Can Tho City</li>
                                <li><i class="bi bi-telephone"></i><a href="tel:+(+84)9915733707">(+84) 9915733707</a> </a></li>
                                <li><i class="bi bi-envelope-fill"></i><a href="mailto:truonglmce171886@fpt.edu.vn">truonglmce171886@fpt.edu.vn</a></li>
                            </ul>             
                        </div> 
                    </div>
                    <% if (request.getAttribute("successMessage") != null) { %>
                    <div class="alert alert-success" role="alert">
                        <%= request.getAttribute("successMessage") %>
                    </div>
                    <% } %>
                    <% if (request.getAttribute("errorMessage") != null) { %>
                    <div class="alert alert-danger" role="alert">
                        <%= request.getAttribute("errorMessage") %>
                    </div>
                    <% } %>
                    <div class="col-lg-6 col-md-12">
                        <div class="contact_message form">
                            <h3>Send feedback</h3>   
                            <form id="contact-form" action="<%=request.getContextPath()%>/contact" method="post">
                                <p>       
                                    <label>  Email address</label>
                                    <input name="email" pattern="[^ @]*@[^ @]*" placeholder="Email *" required value="" type="email">
                                </p>   
                                <div class="contact_textarea">
                                    <label>  Information</label>
                                    <textarea placeholder="Message *" name="message" required class="form-control2"></textarea>    
                                </div>
                                <br>
                                <button type="submit"> Send</button>                                
                            </form>
                        </div> 
                    </div>
                </div>
            </div>    
        </div>
        <!--contact area end-->

        <!--contact map start-->
        <div class="contact_map">
            <div class="container-fluid">
                <div class="row">
                    <div class="col-12">
                        <div class="map-area">
                            <iframe id="googleMap" style="border: none;" src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3929.053354223717!2d105.73024291485825!3d10.012451792842588!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x31a0890033b0a4d5%3A0x5360c94ba9e67842!2zNjAwIMSQLiBOZ3V54buFbiBWxINuIEPhu6ssIEFuIELDrG5oLCBOaW5oIEtp4buBdSwgQ-G6p24gVGjGoSA5MDAwMDAsIFZp4buHdCBOYW0!5e0!3m2!1svi!2s!4v1666249809527!5m2!1svi!2s" width="600" height="450" style="border:0;" allowfullscreen="" loading="lazy" referrerpolicy="no-referrer-when-downgrade"></iframe>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!--contact map end-->

        <jsp:include page="layout/footer.jsp"/>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
        <script>
            function myFunction() {
                var f = document.getElementById("contact-form");
                f.submit();
            }
            window.onload = function () {
            <% if (request.getAttribute("successMessage") != null) { %>
                alert("<%= request.getAttribute("successMessage") %>");
            <% } %>
            <% if (request.getAttribute("errorMessage") != null) { %>
                alert("<%= request.getAttribute("errorMessage") %>");
            <% } %>
            }
        </script>
    </body>
</html>
