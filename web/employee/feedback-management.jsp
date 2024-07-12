<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="header.jsp"></jsp:include>
    <main id="content" class="col-md-9 ml-sm-auto col-lg-10 px-md-4" >
        <h2>Feedback management</h2>
        <div class="">
            <!--SEARCH-->
            <div class="row mb-12" style="margin-bottom: 30px">
                <div class="col-md-6">
                    <div class="form-group">
                        <form action="feedback-management" method="get">
                            <div class="input-group" style="width: 80%">
                                <input style="width: 80%" type="text" class="form-control" name="search" placeholder="Enter name to search" value="${param.search}">
                            <input type="hidden" name="page" value="${currentPage}">
                        </div>
                    </form>
                </div>
            </div>
        </div>
        <table class="table table-striped table-lg">
            <thead>
                <c:if test="${not feedback.isEmpty()}">
                    <tr>
                        <th>No</th>
                        <th>Product</th>
                        <th>Image</th>
                        <th>Customer</th>
                        <th>Content</th>
                        <th>Action</th>
                    </tr>
                </c:if>
            </thead>

            <tbody>
                <c:forEach items="${feedback}" var="f" varStatus="status">
                    <tr>
                        <td>${(currentPage - 1) * 5 + status.index + 1}</td>
                        <td>${f.product.name}</td>
                        <td><img src="../${f.product.image}" width="40" alt="alt"/></td>
                        <td>${f.customer.fullName}</td>
                        <td>${f.content}</td>
                        <td>
                            <form action="feedback-management" method="POST" onsubmit="return confirm('Do you want to delete this feedback?')">
                                <input type="hidden" name="id" value="${f.feedbackID}">
                                <button type="submit" class="btn btn-danger btn-sm"><i class="bi bi-trash"></i></button>
                            </form>
                        </td>
                    </tr>
                </c:forEach>
                <c:if test="${feedback.isEmpty()}">
                    <c:choose>
                        <c:when test="${not empty param.search}">
                            <tr>
                                <td colspan="6" class="text-center">This type of flower was not found</td>
                            </tr>
                        </c:when>
                        <c:otherwise>
                            <!-- ?? tr?ng, không hi?n th? thông báo gì trong tình hu?ng này vì s? x? lý ? d??i -->
                        </c:otherwise>
                    </c:choose>
                </c:if>
            </tbody>
        </table>
        <c:if test="${feedback.isEmpty() and empty param.search}">
            <div class="alert alert-warning" role="alert" style="text-align: center; width: 100%; margin-top: 20px; margin-bottom: 20px;">
                There are no comments at all.
            </div>
        </c:if>



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
        });

        function confirmStatusChange() {
            return confirm('Are you sure you want to change the status of this feedback?');
        }
</script>
