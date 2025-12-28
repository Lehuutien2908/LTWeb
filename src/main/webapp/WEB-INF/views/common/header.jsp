<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<header class="shadow-sm">
    <div class="top-bar py-1 bg-black border-bottom border-secondary">
        <div class="container d-flex justify-content-between align-items-center small text-white-50">
            <span>Chào mừng bạn đến với <strong>Flagship Global</strong>!</span>
            <div class="d-flex gap-3">
                <a href="${pageContext.request.contextPath}/home#footer-section" class="text-decoration-none text-white-50 hover-red">Hỗ trợ</a>
                <a href="#" class="text-decoration-none text-white-50 hover-red">Bản đồ</a>
            </div>
        </div>
    </div>

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
                        <input type="text" name="query" class="form-control border-0 px-3" placeholder="Tìm kiếm sản phẩm..." style="border-radius: 10px 0 0 10px;">
                        <button class="btn search-btn text-uppercase px-4 fw-bold" type="submit" style="border-radius: 0 10px 10px 0;">
                            Tìm kiếm
                        </button>
                    </form>
                </div>

                <div class="col-md-4 d-flex justify-content-end align-items-center">
                    <div class="text-white me-4 auth-wrapper">
                        <c:choose>
                            <c:when test="${empty sessionScope.user}">
                                <a href="${pageContext.request.contextPath}/login" class="text-white text-decoration-none auth-link">Đăng nhập</a>
                                <span class="mx-1 text-white-50">/</span>
                                <a href="${pageContext.request.contextPath}/register" class="text-white text-decoration-none auth-link">Đăng ký</a>
                            </c:when>
                            <c:otherwise>
                                <span class="small text-white-50">Xin chào,</span>
                                <a href="${pageContext.request.contextPath}/profile" class="text-white text-decoration-none fw-bold ms-1 hover-red">${sessionScope.user.fullname}</a>
                                <a href="${pageContext.request.contextPath}/logout" class="ms-2 text-white-50 small text-decoration-none border-start ps-2">Thoát</a>
                            </c:otherwise>
                        </c:choose>
                    </div>

                    <a href="${pageContext.request.contextPath}/checkout" class="text-decoration-none">
                        <div class="cart-box d-flex align-items-center justify-content-center">
                            <i class="bi bi-cart3 me-2 fs-5"></i>
                            <span class="fw-bold">THANH TOÁN</span>
                        </div>
                    </a>
                </div>
            </div>
        </div>
    </div>

    <div class="sub-nav-bar bg-white border-bottom mb-0 py-0">
        <div class="container">
            <ul class="navbar-nav flex-row gap-4 w-100 small fw-bold text-uppercase mb-0">
                <li class="nav-item">
                    <a class="nav-link p-0 text-dark active" href="${pageContext.request.contextPath}/home">Trang chủ</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link p-0 text-dark" href="${pageContext.request.contextPath}/products">Danh Mục Sản phẩm</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link p-0 text-dark" href="#footer-section">Liên hệ</a>
                </li>
            </ul>
        </div>
    </div>
</header>