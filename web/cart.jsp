<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="header.jsp"></jsp:include>
    <main class="mt-5 pt-4">
        <div class="container">
            <div class="table-responsive">
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
            <table class="table table-striped table-sm">
                <thead>
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
                            <td>${status.index + 1}</td>
                            <td>${c.product.name}</td>
                            <td><img src="${c.product.image}" height="100px" alt="${c.product.name}"/></td>
                            <td>${c.product.price}</td>
                            <td>${c.quantity} <i class="bi bi-pencil" data-bs-toggle="modal" data-bs-target="#edit${c.getCartID()}"></i></td>
                            <td>${c.product.price * c.quantity}</td>
                            <td>
                                <form action="cart" method="POST" onsubmit="return confirmStatusChange()">
                                    <input type="hidden" name="id" value="${c.getCartID()}">
                                    <input type="hidden" name="action" value="remove">
                                    <button type="submit" class="btn-sm btn-danger">
                                        <i class="bi bi-trash"></i>
                                    </button>
                                </form>
                            </td>
                        </tr>
                        <!-- Modal for Editing Quantity -->
                    <div class="modal fade" id="edit${c.getCartID()}" tabindex="-1" aria-labelledby="addModalLabel" aria-hidden="true">
                        <div class="modal-dialog">
                            <div class="modal-content">
                                <div class="modal-header">
                                 <h5 class="modal-title" id="addModalLabel">Update quantity</h5>
                                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                </div>
                                <div class="modal-body">
                                    <form id="cartForm${c.getCartID()}" action="${pageContext.request.contextPath}/cart" method="post">
                                        <label style="margin-bottom: 10px" for="quantity${c.getCartID()}">Quantity for <strong>${c.product.name}</strong></label><br>
                                        <input class="input-group" id="quantity${c.getCartID()}" type="number" step="1" name="quantity" value="${c.quantity}" placeholder="Enter quantity">
                                        <div id="quantityErr${c.getCartID()}" class="text-danger"></div><br>
                                        <input type="hidden" name="action" value="update"><br>
                                        <input type="hidden" name="id" value="${c.getCartID()}"><br>
                                        <button type="submit" class="btn btn-success">Save</button>
                                    </form>
                                </div>
                            </div>
                        </div>
                    </div>
                </c:forEach>
                </tbody>
            </table>
            <!-- PAGING -->
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
    </div>
<!--    <form id="cartForm${c.getCartID()}" action="${pageContext.request.contextPath}/cart" method="post">
         
         
        <input type="text" name="productID" value="1"><br>
        <input type="text" name="action" value="add"><br>
         
        <button type="submit" class="btn btn-success">Save</button>
    </form>-->
</main>
<jsp:include page="footer.jsp"></jsp:include>

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

            // Attach validation to each form

        });

        function confirmStatusChange() {
            return confirm('Are you sure you want to change the status of this item?');
        }
</script>