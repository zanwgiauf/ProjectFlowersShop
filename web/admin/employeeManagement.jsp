<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%-- 
    Document   : adminHome
    Created on : Jun 10, 2024, 7:16:15 PM
    Author     : Nguyen Van Giau - CE170449
--%>
<%@page import="DAOs.AccountDAO"%>
<%@page import="Models.Admin"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Admin Page</title>
        <link rel="Website Icon" href="<%= request.getContextPath()%>/images/LogoF.png" type="png" />
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.2/font/bootstrap-icons.min.css" />
        <link rel="stylesheet" href="<%= request.getContextPath()%>/lib/bootstrap/bootstrap_css/bootstrap.min.css" />
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/mdbootstrap/4.19.1/css/mdb.min.css" />
        <link rel="stylesheet" type="text/css" href="https://cdn.jsdelivr.net/npm/toastify-js/src/toastify.min.css">
        <script type="text/javascript" src="https://cdn.jsdelivr.net/npm/toastify-js"></script>

        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.10.2/dist/umd/popper.min.js"
                integrity="sha384-7+zCNj/IqJ95wo16oMtfsKbZ9ccEh31eOz1HGyDuCQ6wgnyJNSYdrPa03rtR1zdB" crossorigin="anonymous"
        defer></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.min.js"
                integrity="sha384-QJHtvGhmr9XOIpI6YVutG+2QOK9T+ZnN4kzFN1RtK3zEFEIsxhlmWl5/YESvpZ13" crossorigin="anonymous"
        defer></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/mdbootstrap/4.19.1/js/mdb.min.js"></script>
        <style>
            body {
                font-family: 'Roboto', sans-serif;
            }
            #sidebar {
                height: 100vh;
                background: #7b88a8;
                padding: 10px;
                position: sticky;
                top: 0;
            }
            #sidebar a {
                color: #fff;
                display: block;
                padding: 10px;
                text-decoration: none;
            }
            #sidebar a:hover {
                background: #495057;
            }
            #content {
                padding: 20px;
            }
            .table-responsive {
                max-height: 400px;
            }
            .btn-add-right {
                float: right;
                margin-right: 20px;
                /* Thêm khoảng cách phải nếu cần */
            }
            .clearfix::button {
                margin-top: 20px
            }
            table {
                width: 100%;
                border-collapse: collapse;
            }

            th {
                background-color: #000; /* Black background */
                color: #fff; /* White text color */
                font-family: Arial, sans-serif; /* Stylish, modern font */
                font-size: 14px; /* Appropriate text size */
                padding: 8px; /* Space around text */
                border: 1px solid #ccc; /* Light grey border */
                text-align: left; /* Align text to the left */
            }

            /* Styling for rounded corners on the left and right sides of the header row */
            th:first-child {
                border-top-left-radius: 10px; /* Rounded corners on the left side of the first header */
            }

            th:last-child {
                border-top-right-radius: 10px; /* Rounded corners on the right side of the last header */
            }
        </style>
    </head>
    <body>
        <%
            Cookie cookies[] = request.getCookies();

            String fullName = "";
            int adminID = 0;
            if (cookies != null) {
                for (int i = 0; i < cookies.length; i++) {
                    if (cookies[i].getName().equals("fullNameA")) {
                        fullName = cookies[i].getValue();
                    } else if (cookies[i].getName().equals("adminIDA")) {
                    adminID = Integer.parseInt(cookies[i].getValue());
                    }
                }
            }
            AccountDAO ad = new AccountDAO();  
        %>
        <div class="container">
            <div class="row">
                <nav id="sidebar" class="col-md-2 d-none d-md-flex sidebar" style="width: 300px; background-color: #7b88a8;">
                    <div class="container sidebar-sticky text-decoration-none text-white">
                        <a href="<%=request.getContextPath()%>/AdminController" class="fs-4 fw-bold d-flex justify-content-center align-items-center text-white">
                            <i class="bi bi-person-circle mx-2 "></i>
                            <span>Admin</span>

                        </a>
                        <div class="container d-flex justify-content-center"> <h5><%= ad.decodeString(fullName) %></h5></div>
                        <ul class="nav flex-column mt-3">
                            <li class="nav-item">
                                <a class="nav-link active" href="<%=request.getContextPath()%>/AdminController">
                                    <i class="bi bi-speedometer2"></i>
                                    Dashboard
                                </a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" href="#">
                                    <i class="bi bi-shop"></i>
                                    My Store
                                </a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" href="#">
                                    <i class="bi bi-list-check"></i>
                                    Manage Stock
                                </a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" href="#">
                                    <i class="bi bi-graph-up"></i>
                                    Analytic
                                </a>
                            </li>
                            <li class="nav-item">
                                <a class=" dropdown-toggle"  data-bs-toggle="collapse" data-bs-target="#manageUserAccounts" aria-expanded="false" aria-controls="manageUserAccounts">
                                    <i class="bi bi-people"></i>
                                    <span>Manage User Accounts</span>
                                </a>
                                <div class="collapse ms-3" id="manageUserAccounts">
                                    <a href="${pageContext.request.contextPath}/admin/employee-management"class="dropdown-item">Manage Employee Accounts</a>
                                    <a href="#" class="dropdown-item">Manage Customer Accounts</a>
                                </div>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" href="#">
                                    <i class="bi bi-clipboard"></i>
                                    List Customer Orders
                                </a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" href="#">
                                    <i class="bi bi-tags"></i>
                                    Category
                                </a>
                            </li>

                        </ul>
                        <form action="../logout" method="post" class="mt-4 me-2" >
                            <button class="btn btn-outline-dark  w-100" style="border-radius: 16px" name="btnLogout">Logout</button>
                        </form>
                    </div>
                </nav>

                <main id="content" class="col-md-9 ml-sm-auto col-lg-10 px-md-4" style="width: 1020px;">
                    <h2>Employee management</h2>
                    <div class="clearfix">
                        <button type="button" class="btn btn-primary btn-sm btn-add-right" data-bs-toggle="modal" data-bs-target="#add">
                            Add new Employee
                        </button>
                    </div>

                    <div class="...">
                        <!--SEARCH-->
                        <div class="row mb-12" style="margin-bottom: 30px">
                            <div class="col-md-6">
                                <div class="form-group">
                                    <form action="employee-management" method="get">
                                        <div class="input-group" style="width: 80%">
                                            <input style="width: 80%" type="text" class="form-control" name="search" placeholder="Enter name to search" value="${param.search}">
                                            <input type="hidden" name="page" value="${currentPage}">
                                        </div>
                                    </form>
                                </div>
                            </div>
                        </div>
                        <table class="table table-striped table-lg info-table">
                            <thead>
                                <tr>
                                    <th>No</th>
                                    <th>Full name</th>
                                    <th>Phone</th>
                                    <th>Email</th>
                                    <th>Role</th>
                                    <th>Status</th>
                                    <th>Action</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:choose>
                                    <c:when test="${not empty employee}">
                                        <c:forEach items="${employee}" var="e" varStatus="status">
                                            <tr>
                                                <td>${(currentPage - 1) * 5 + status.index + 1}</td>
                                                <td>${e.getFullName()}</td>
                                                <td>${e.getPhone()}</td>
                                                <td>${e.getEmail()}</td>
                                                <td>${e.getRoleName()}</td>
                                                <c:if test="${e.getStatus() == 1}">
                                                    <td><span class="badge bg-success">Active</span></td>
                                                </c:if>
                                                <c:if test="${e.getStatus() == 0}">
                                                    <td><span class="badge bg-danger rounded-pill">Inactive</span></td>
                                                </c:if>
                                                <td style="display: flex; gap: 5px">
                                                    <form action="employee-management" method="POST" onsubmit="return confirmStatusChange()">
                                                        <input type="hidden" name="id" value="${e.getEmployeeID()}">
                                                        <input type="hidden" name="action" value="change-status">
                                                        <input type="hidden" name="status" value="${e.getStatus()}">
                                                        <c:choose>
                                                            <c:when test="${e.getStatus() == 1}">
                                                                <button type="submit" class="btn-sm btn-danger">
                                                                    <i class="bi bi-ban"></i>
                                                                </button>
                                                            </c:when>
                                                            <c:otherwise>
                                                                <button type="submit" class="btn-sm btn-success">
                                                                    <i class="bi bi-arrow-counterclockwise"></i>
                                                                </button>
                                                            </c:otherwise>
                                                        </c:choose>
                                                    </form>
                                                    <button class="btn-sm btn-success" data-bs-toggle="modal" data-bs-target="#edit${e.getEmployeeID()}">
                                                        <i class="bi bi-pencil"></i>
                                                    </button>
                                                </td>
                                            </tr>
                                        </c:forEach>
                                    </c:when>
                                    <c:otherwise>
                                        <tr>
                                            <td colspan="7" class="text-center">Nhân viên không tồn tại!</td>
                                        </tr>
                                    </c:otherwise>
                                </c:choose>
                            </tbody>
                        </table>
                        <!--PAGING-->
                        <nav class="mt-3" aria-label="Page navigation example">
                            <ul class="pagination justify-content-center">
                                <c:if test="${currentPage > 1}">
                                    <li class="page-item">
                                        <a class="page-link" href="?search=${param.search}&amp;page=${currentPage - 1}">Previous</a>
                                    </li>
                                </c:if>
                                <c:forEach var="pageNum" begin="1" end="${totalPages}">
                                    <li class="page-item <c:if test='${pageNum == currentPage}'>active</c:if>">
                                        <a class="page-link" href="?search=${param.search}&amp;page=${pageNum}">${pageNum}</a>
                                    </li>
                                </c:forEach>
                                <c:if test="${currentPage < totalPages}">
                                    <li class="page-item">
                                        <a class="page-link" href="?search=${param.search}&amp;page=${currentPage + 1}">Next</a>
                                    </li>
                                </c:if>
                            </ul>
                        </nav>
                    </div>
                    <!--MODAL ADD-->
                    <div class="modal fade" id="add" tabindex="-1" aria-labelledby="addModalLabel" aria-hidden="true">
                        <div class="modal-dialog">
                            <div class="modal-content">
                                <div class="modal-header">
                                    <h5 class="modal-title" id="addModalLabel">Add new Employee</h5>
                                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                </div>
                                <div class="modal-body">
                                    <form id="employeeForm" action="${pageContext.request.contextPath}/admin/employee-management" method="post">
                                        <label style="margin-bottom: 10px" for="name">Employee name</label><br>
                                        <input class="input-group" type="text" name="name" id="name" placeholder="Enter Employee name">
                                        <div id="nameError" class="text-danger"></div><br>

                                        <label style="margin-bottom: 10px" for="phone">Phone</label><br>
                                        <input class="input-group" type="text" name="phone" id="phone" placeholder="Enter phone number">
                                        <div id="phoneError" class="text-danger"></div><br>

                                        <label style="margin-bottom: 10px" for="email">Email</label><br>
                                        <input class="input-group" type="email" name="email" id="email" placeholder="Enter email">
                                        <div id="emailError" class="text-danger"></div><br>

                                        <label style="margin-bottom: 10px" for="password">Password</label><br>
                                        <input class="input-group" type="password" name="password" id="password" placeholder="Enter password">
                                        <div id="passwordError" class="text-danger"></div><br>

                                        <label style="margin-bottom: 10px" for="re-password">Re-password</label><br>
                                        <input class="input-group" type="password" name="re-password" id="re-password" placeholder="Enter re-password">
                                        <div id="rePasswordError" class="text-danger"></div><br>

                                        <input type="hidden" name="action" value="add"><br>

                                        <button type="submit" class="btn btn-primary">Add</button>
                                    </form>
                                </div>
                            </div>
                        </div>
                    </div>
                </main>
            </div>
        </div>

        <script src="<%= request.getContextPath()%>/lib/bootstrap/bootstrap_js/bootstrap.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.11.0/umd/popper.min.js"
                integrity="sha384-b/U6ypiBEHpOf/4+1nzFpr53nxSS+GLCkfwBdFNTxtclqqenISfwAzpKaMNFNmj4"
        crossorigin="anonymous"></script>

        <script>
            document.getElementById('employeeForm').addEventListener('submit', function (event) {
                var isValid = true;
                var name = document.getElementById('name').value.trim();
                var phone = document.getElementById('phone').value;
                var email = document.getElementById('email').value;
                var password = document.getElementById('password').value;
                var rePassword = document.getElementById('re-password').value;
                var nameRegex = /^[a-zA-Z\s]+$/;
                var phoneRegex = /^0\d{9}$/;
                var emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;

                // Clear previous error messages
                document.getElementById('nameError').textContent = '';
                document.getElementById('phoneError').textContent = '';
                document.getElementById('emailError').textContent = '';
                document.getElementById('passwordError').textContent = '';
                document.getElementById('rePasswordError').textContent = '';

                if (name === "" || !nameRegex.test(name)) {
                    document.getElementById('nameError').textContent = "Please enter a valid full name containing only letters and spaces.";
                    isValid = false;
                }

                if (!phoneRegex.test(phone)) {
                    document.getElementById('phoneError').textContent = "Please enter a valid phone number with 10 digits starting with 0.";
                    isValid = false;
                }

                if (!emailRegex.test(email)) {
                    document.getElementById('emailError').textContent = "Please enter a valid email address.";
                    isValid = false;
                }

                if (password.length < 8) {
                    document.getElementById('passwordError').textContent = "Password must be at least 8 characters long.";
                    isValid = false;
                }

                if (password !== rePassword) {
                    document.getElementById('rePasswordError').textContent = "Password and re-password do not match.";
                    isValid = false;
                }

                if (!isValid) {
                    event.preventDefault();
                }
            });

            function validateEditForm(employeeId) {
                var isValid = true;
                var name = document.getElementById('nameEdit' + employeeId).value.trim();
                var phone = document.getElementById('phoneEdit' + employeeId).value;
                var email = document.getElementById('emailEdit' + employeeId).value;
                var nameRegex = /^[a-zA-Z\s]+$/;
                var phoneRegex = /^0\d{9}$/;
                var emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;

                // Clear previous error messages
                document.getElementById('nameEditError' + employeeId).textContent = '';
                document.getElementById('phoneEditError' + employeeId).textContent = '';
                document.getElementById('emailEditError' + employeeId).textContent = '';

                if (name === "" || !nameRegex.test(name)) {
                    document.getElementById('nameEditError' + employeeId).textContent = "Please enter a valid full name containing only letters and spaces.";
                    isValid = false;
                }

                if (!phoneRegex.test(phone)) {
                    document.getElementById('phoneEditError' + employeeId).textContent = "Please enter a valid phone number with 10 digits starting with 0.";
                    isValid = false;
                }

                if (!emailRegex.test(email)) {
                    document.getElementById('emailEditError' + employeeId).textContent = "Please enter a valid email address.";
                    isValid = false;
                }

                return isValid;
            }

            document.addEventListener("DOMContentLoaded", function () {
                var msg = '<c:out value="${sessionScope.notification}" />';
                var err = '<c:out value="${sessionScope.notificationErr}" />';
                if (msg) {
                    Toastify({
                        text: msg,
                        duration: 3000,
                        gravity: "top",
                        position: "right",
                        backgroundColor: "green",
                    }).showToast();
<c:remove var="notification" scope="session"/>
                }

                if (err) {
                    Toastify({
                        text: err,
                        duration: 3000,
                        gravity: "top",
                        position: "right",
                        backgroundColor: "red",
                    }).showToast();
<c:remove var="notificationErr" scope="session"/>
                }

                var employeeTableBody = document.querySelector(".info-table tbody");
                var noEmployeeRow = document.querySelector(".info-table tbody tr td[colspan='7']");
                
                if (noEmployeeRow) {
                    var headerRow = document.querySelector(".info-table thead tr");
                    headerRow.style.display = 'none';
                }
            });

            function confirmStatusChange() {
                return confirm('Are you sure you want to change the status of this employee?');
            }
        </script>
    </body>
</html>
