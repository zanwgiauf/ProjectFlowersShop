<%-- 
    Document   : promotions
    Created on : 22-Jun-2024, 13:59:28
    Author     : Le Minh Truong - CE171886
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.List" %>
<%@page import="Models.Promotion" %>
<%@page import="DAOs.PromotionDAO" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Promotions</title>
        <link rel="stylesheet" href="lib/bootstrap/bootstrap_css/bootstrap.min.css" />
        <!-- Favicon -->
        <link rel="icon" type="image/x-icon" href="assets/img/logo/LogoF.png">

        <!-- CSS 
        ========================= -->

        <!-- Plugins CSS -->
        <link rel="stylesheet" href="assets/css/plugins.css">

        <!-- Main Style CSS -->
        <link rel="stylesheet" href="assets/css/style.css">
        <style>
            body {
                font-family: 'Roboto', sans-serif;
                background-color: #f8f9fa;
                margin: 0;
                padding: 20px;
            }
            h1 {
                text-align: center;
                color: #007bff;
                margin-bottom: 20px;
            }
            .promotion-container {
                max-width: 1200px;
                margin: 0 auto;
                display: flex;
                flex-wrap: wrap;
                gap: 20px;
                justify-content: center;
            }
            .promotion-card {
                background-color: #fff; /* White background */
                border: 1px solid #ddd; /* Light gray border */
                border-radius: 10px;
                padding: 20px;
                flex: 1 1 calc(33.333% - 20px); /* Adjust based on your layout needs */
                box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
                transition: transform 0.3s;
                cursor: pointer;
                display: flex;
                flex-direction: column;
                justify-content: space-between; /* Ensures button aligns to bottom */
            }

            .promotion-card:hover {
                transform: translateY(-10px);
                box-shadow: 0 8px 16px rgba(0, 0, 0, 0.2);
            }

            .promotion-card h2, .promotion-card p {
                margin: 5px 0;
                color: #333; /* Darker text for better readability */
            }

            .use {
                background-color: #ff4500; /* Orange color for the button */
                color: white;
                border: none;
                padding: 10px 20px;
                border-radius: 5px;
                text-align: center;
                margin-top: 10px; /* Space above the button */
                cursor: pointer;
            }

            .save-button:hover {
                background-color: #e03e00; /* Darker shade on hover */
            }

        </style>
    </head>
    <body>
        <!-- Offcanvas menu area start -->
        <jsp:include page="layout/menu.jsp"/>
        <!-- Breadcrumbs area start -->
        <div class="breadcrumbs_area other_bread">
            <div class="container">   
                <div class="row">
                    <div class="col-12">
                        <div class="breadcrumb_content">
                            <ul>
                                <li><a href="home">Home</a></li>
                                <li>/</li>
                                <li>Promotions</li>
                            </ul>
                        </div>
                    </div>
                </div>
            </div>         
        </div>
        <!-- Breadcrumbs area end -->
        <h1>Current Promotions</h1>
        <div class="promotion-container">
            <%
            List<Promotion> promotionsList = (List<Promotion>) request.getAttribute("promotionsList");
            if (promotionsList != null && !promotionsList.isEmpty()) {
                for (Promotion promotion : promotionsList) {
            %>
            <div class="promotion-card">
                <h2><%= promotion.getPromotionCode() %></h2>
                <p class="promo-description"><strong>Description:</strong> <%= promotion.getDescription() %></p>
                <p class="promo-discount"><strong>Discount:</strong> <%= promotion.getDiscount() %>% off</p>
                <p class="promo-dates"><strong>Valid from:</strong> <%= promotion.getStartDate() %> to <%= promotion.getEndDate() %></p>
                <div class="use">
                    <a class="nav-link text-white" href="<%=request.getContextPath()%>/categories">Use</a> 
                </div>

            </div>
            <% 
                }
            } else { 
            %>
            <p>No promotions available at the moment. Please check back later.</p>
            <% 
            } 
            %>
        </div>

        <!-- Modal for Promotion Details -->
        <div class="modal fade" id="promotionDetailModal" tabindex="-1" aria-labelledby="promotionDetailModalLabel" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="promotionDetailModalLabel">Promotion Details</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        <p id="promoDescription"></p>
                        <p id="promoDiscount"></p>
                        <p id="promoDates"></p>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                    </div>
                </div>
            </div>
        </div>
        <jsp:include page="layout/footer.jsp"/>
        <!-- Bootstrap JS -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
        <script>
            document.addEventListener('DOMContentLoaded', function () {
                const promotionCards = document.querySelectorAll('.promotion-card');
                promotionCards.forEach(card => {
                    card.addEventListener('click', function () {
                        const promoCode = this.querySelector('h2').textContent;
                        const description = this.querySelector('.promo-description').textContent.replace('Description:', '').trim();
                        const discount = this.querySelector('.promo-discount').textContent.replace('Discount:', '').trim();
                        const dates = this.querySelector('.promo-dates').textContent.replace('Valid from:', '').trim();

                        document.getElementById('promotionDetailModalLabel').textContent = 'Promotion - ' + promoCode;
                        document.getElementById('promoDescription').textContent = 'Description: ' + description;
                        document.getElementById('promoDiscount').textContent = 'Discount: ' + discount;
                        document.getElementById('promoDates').textContent = 'Valid dates: ' + dates;

                        const modalElement = document.getElementById('promotionDetailModal');
                        const modalInstance = new bootstrap.Modal(modalElement);
                        modalInstance.show();
                    });
                });
            });
        </script>
    </body>
</html>
