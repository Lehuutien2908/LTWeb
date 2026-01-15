<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<%-- Logic thông báo Alert giữ nguyên --%>
<%
    String msg = (String) session.getAttribute("message");
    if (msg != null) {
%>
<div id="success-alert" class="alert alert-success alert-dismissible fade show" role="alert"
     style="position: fixed; top: 80px; right: 20px; z-index: 9999; box-shadow: 0 4px 6px rgba(0,0,0,0.1); min-width: 300px;">
    <i class="bi bi-check-circle-fill me-2"></i>
    <strong>Thành công!</strong> <%= msg %>
    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
</div>
<script>
    setTimeout(function() {
        var alertElement = document.getElementById('success-alert');
        if (alertElement) {
             var bsAlert = new bootstrap.Alert(alertElement);
             bsAlert.close();
        }
    }, 3000);
</script>
<% session.removeAttribute("message"); } %>

<header class="shadow-sm">
    <div class="header-main py-3" style="background-color: #1a1a1a;">
        <div class="container">
            <div class="row align-items-center">
                <div class="col-md-3">
                    <a href="${pageContext.request.contextPath}/home" class="text-decoration-none">
                        <h1 class="text-white fw-bold mb-0 text-uppercase h3">Flagship Global</h1>
                    </a>
                </div>

                <div class="col-md-5">
                    <form action="${pageContext.request.contextPath}/search" method="GET" class="input-group">
                        <input type="text" name="query" class="form-control border-0 px-3 py-2"
                               placeholder="Tìm kiếm sản phẩm..."
                               style="border-radius: 4px 0 0 4px;"
                               value="${param.query}">
                        <button class="btn btn-danger text-uppercase px-4 fw-bold" type="submit"
                                style="border-radius: 0 4px 4px 0; background-color: #dc3545; border: none;">
                            TÌM KIẾM
                        </button>
                    </form>
                </div>

                <div class="col-md-4 d-flex justify-content-end align-items-center">
                    <div class="text-white me-4">
                        <c:choose>
                            <c:when test="${empty sessionScope.user}">
                                <a href="${pageContext.request.contextPath}/login" class="text-white text-decoration-none small fw-bold">Đăng nhập</a>
                                <span class="mx-1 text-white-50">/</span>
                                <a href="${pageContext.request.contextPath}/register" class="text-white text-decoration-none small fw-bold">Đăng ký</a>
                            </c:when>
                            <c:otherwise>
                                <span class="small text-white-50">Chào,</span>
                                <a href="${pageContext.request.contextPath}/profile" class="text-white text-decoration-none fw-bold ms-1">${sessionScope.user.fullName}</a>
                                <a href="${pageContext.request.contextPath}/logout" class="ms-2 text-white-50 small text-decoration-none border-start ps-2">Thoát</a>
                            </c:otherwise>
                        </c:choose>
                    </div>

                    <a href="${pageContext.request.contextPath}/cart" class="btn btn-danger fw-bold d-flex align-items-center gap-2 px-3 py-2" style="background-color: #dc3545; border: none;">
                        <i class="bi bi-cart3 fs-5"></i>
                        <span>THANH TOÁN</span>
                    </a>
                </div>
            </div>
        </div>
    </div>

    <div class="sub-nav-bar bg-white border-bottom mb-0 py-2">
        <div class="container">
            <ul class="nav flex-row gap-4 w-100 small fw-bold text-uppercase mb-0 align-items-center">
                <li><a class="nav-link p-0 text-dark" href="${pageContext.request.contextPath}/home">Trang chủ</a></li>
                <li><a class="nav-link p-0 text-dark" href="${pageContext.request.contextPath}/products">Danh Mục Sản phẩm</a></li>
                <li><a class="nav-link p-0 text-dark" href="#footer-section">Liên hệ</a></li>
                <c:if test="${not empty sessionScope.user && sessionScope.user.role == 1}">
                    <li class="ms-auto">
                        <a class="nav-link p-0 text-danger fw-bold" href="${pageContext.request.contextPath}/admin/dashboard">
                            <i class="bi bi-speedometer2 me-1"></i> QUẢN TRỊ ADMIN
                        </a>
                    </li>
                </c:if>
            </ul>
        </div>
    </div>
</header>