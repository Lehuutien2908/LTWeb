<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<header>

    <div class="header-main">
        <div class="container">
            <div class="row align-items-center">
                <div class="col-md-3">
                    <h1 class="text-white fw-bold">Flagship Global</h1>
                </div>
                <div class="col-md-6">
                    <div class="input-group">
                        <input type="text" class="form-control" placeholder="Tìm kiếm...">
                        <button class="btn search-btn text-uppercase px-4">Tìm kiếm</button>
                    </div>
                </div>
                <div class="col-md-3 d-flex justify-content-end align-items-center">
                    <div class="text-white me-3 auth-wrapper">
                        <a href="login" class="text-white text-decoration-none auth-link">Đăng nhập</a>
                        <span class="mx-1 text-white-50">/</span>
                        <a href="register" class="text-white text-decoration-none auth-link">Đăng ký</a>
                    </div>
                    <div class="cart-box">

                        <span><i class="bi bi-cart"></i> Thanh toán</span>
                    </div>

                </div>
            </div>
        </div>
    </div>

    <div class="sub-nav-bar bg-white border-bottom mb-4 py-2">
                <div class="bg-white border-bottom mb-0">
                    <div class="container d-flex align-items-center py-2"> <ul class="navbar-nav flex-row gap-4 w-100 small fw-bold text-uppercase mb-0"> <li class="nav-item"><a class="nav-link p-0 text-dark active" href="home">Trang chủ</a></li>
                            <li class="nav-item">
                                <a class="nav-link p-0 text-dark" href="${pageContext.request.contextPath}/products">Tất Cả Sản phẩm</a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link p-0 text-dark" href="#footer-section">Liên hệ</a>
                            </li>
                        </ul>
                    </div>
                </div>
</header>