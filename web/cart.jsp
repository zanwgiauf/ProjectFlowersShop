<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="header.jsp"></jsp:include>
    <main class="mt-5 pt-4">
        <div class="container">
            <!--SEARCH-->
            <div class="row mb-12" style="margin-top: 30px; margin-bottom: 20px">
                <div class="col-md-6">
                    <div class="form-group">
                        <form action="cart" method="get">
                            <div class="input-group" style="width: 80%">
                                <input style="width: 80%" type="text" class="form-control" name="search" placeholder="Enter name to search" value="${param.search}">
                            <input type="hidden" name="page" value="${currentPage}">
                        </div>
                    </form>
                </div>
            </div>
        </div>

        <style>
            /* Custom styles for table */
            .table {
                width: 100%;
                margin-bottom: 1rem;
                color: #212529;
            }

            .table-hover tbody tr:hover {
                background-color: #f5f5f5;
            }

            .table-bordered {
                border: 1px solid #dee2e6;
            }

            .table-bordered th,
            .table-bordered td {
                border: 1px solid #dee2e6;
            }

            .thead-dark th {
                color: #fff;
                background-color: #343a40;
                border-color: #454d55;
            }

            .input-group .form-control {
                width: 60px;
                text-align: center;
            }

            .input-group .input-group-append .btn {
                border-radius: 0;
            }

            .pagination {
                justify-content: center;
            }

            .pagination .page-item.active .page-link {
                background-color: #007bff;
                border-color: #007bff;
            }

            .btn-primary {
                background-color: #007bff;
                border-color: #007bff;
            }

            .btn-danger {
                background-color: #dc3545;
                border-color: #dc3545;
            }

        </style>
        <c:choose>
            <c:when test="${empty cart}">
                <div class="alert alert-warning text-center" style="color: red;">
                    <c:choose>
                        <c:when test="${not empty param.search}">
                            This product is not found
                        </c:when>
                        <c:otherwise>
                            Cart is empty
                        </c:otherwise>
                    </c:choose>
                </div>
            </c:when>
            <c:otherwise>
                <table class="table table-striped table-hover table-bordered">
                    <thead class="thead-dark">
                        <tr>
                            <th>No</th>
                            <th>Product</th>
                            <th>Image</th>
                            <th>Price</th>
                            <th>Quantity</th>
                            <th>Total</th>
                            <th>Action</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach items="${cart}" var="c" varStatus="status">
                            <tr>
                                <td>${(currentPage - 1) * 10 + status.index + 1}</td>
                                <td>${c.product.name}</td>
                                <td><img src="${c.product.image}" height="100px" alt="${c.product.name}"/></td>
                                <td>${c.product.price}</td>
                                <td>
                                    <form action="cart" method="POST" onsubmit="return confirmStatusChange()">
                                        <input type="hidden" name="id" value="${c.getCartID()}">
                                        <input type="hidden" name="action" value="update">
                                        <div class="input-group">
                                            <input type="number" name="quantity" value="${c.quantity}" min="1" class="form-control" style="width: 80px;">
                                            <div class="input-group-append">
                                                <button type="submit" class="btn btn-sm btn-primary">
                                                    <i class="bi bi-check"></i>
                                                </button>
                                            </div>
                                        </div>
                                    </form>
                                </td>
                                <td>${c.product.price * c.quantity}</td>
                                <td>
                                    <form action="cart" method="POST" onsubmit="return confirmStatusChange()">
                                        <input type="hidden" name="id" value="${c.getCartID()}">
                                        <input type="hidden" name="action" value="remove">
                                        <button type="submit" class="btn btn-sm btn-danger">
                                            <i class="bi bi-trash"></i>
                                        </button>
                                    </form>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>

                <!-- Pagination -->
                <nav aria-label="Page navigation">
                    <ul class="pagination">
                        <c:if test="${currentPage > 1}">
                            <li class="page-item"><a class="page-link" href="cart?page=${currentPage - 1}&search=${param.search}">Previous</a></li>
                            </c:if>
                            <c:forEach begin="1" end="${totalPages}" step="1" var="i">
                            <li class="page-item <c:if test="${currentPage == i}">active</c:if>">
                                <a class="page-link" href="cart?page=${i}&search=${param.search}">${i}</a>
                            </li>
                        </c:forEach>
                        <c:if test="${currentPage < totalPages}">
                            <li class="page-item"><a class="page-link" href="cart?page=${currentPage + 1}&search=${param.search}">Next</a></li>
                            </c:if>
                    </ul>
                </nav>
            </c:otherwise>
        </c:choose>
    </div>
</main>

<script>
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
    });

    function confirmStatusChange() {
        return confirm('Are you sure you want to change the status of this item?');
    }
</script>
