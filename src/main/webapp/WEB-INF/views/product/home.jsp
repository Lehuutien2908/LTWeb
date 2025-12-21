<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Trang chủ - Accent Technology</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">

    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css">

    <style>
        .product-img { height: 200px; object-fit: contain; padding: 15px; }
        .btn-buy { border: 1px solid #ddd; background: #fff; font-size: 13px; font-weight: bold; }
        .btn-buy:hover { background: #e31e24; color: white; border-color: #e31e24; }
        .product-price { color: #e31e24; font-weight: bold; font-size: 1.1rem; }
    </style>
</head>
<body>

    <jsp:include page="../common/header.jsp" />

    <main class="container mt-4">
        <div class="row mb-4 g-2">
            <div class="col-md-8">
                <div id="heroCarousel" class="carousel slide shadow-sm" data-bs-ride="carousel">
                    <div class="carousel-indicators">
                        <button type="button" data-bs-target="#heroCarousel" data-bs-slide-to="0" class="active"></button>
                        <button type="button" data-bs-target="#heroCarousel" data-bs-slide-to="1"></button>
                    </div>
                    <div class="carousel-inner rounded">
                        <div class="carousel-item active" data-bs-interval="4000">
                            <img src="${pageContext.request.contextPath}/assets/images/vivo x200 pro.jpg"
                                 class="banner-main" alt="Vivo X200 Pro">
                        </div>
                        <div class="carousel-item" data-bs-interval="4000">
                            <img src="${pageContext.request.contextPath}/assets/images/OPPO Find X8.jpg"
                                 class="banner-main" alt="Oppo Find X8">
                        </div>
                    </div>
                    <button class="carousel-control-prev" type="button" data-bs-target="#heroCarousel" data-bs-slide="prev">
                        <span class="carousel-control-prev-icon"></span>
                    </button>
                    <button class="carousel-control-next" type="button" data-bs-target="#heroCarousel" data-bs-slide="next">
                        <span class="carousel-control-next-icon"></span>
                    </button>
                </div>
            </div>

            <div class="col-md-4 d-flex flex-column justify-content-between">
                <div class="overflow-hidden rounded shadow-sm">
                    <img src="${pageContext.request.contextPath}/assets/images/oppo x7 ulta.jpg"
                         class="banner-sub" alt="Oppo X7 Ultra">
                </div>
                <div class="overflow-hidden rounded shadow-sm">
                    <img src="${pageContext.request.contextPath}/assets/images/oppo x6 pro.jpg"
                         class="banner-sub" alt="Oppo X6 Pro">
                </div>
            </div>
        </div>

        <div class="row">
            <div class="col-md-3">
                <jsp:include page="../common/sidebar.jsp" />
            </div>

            <div class="col-md-9">
                <div class="section-title d-flex justify-content-between align-items-end mb-3">
                    <h2 class="m-0">Sản phẩm mới</h2>
                    <div class="nav-arrows">
                        <button class="btn btn-sm btn-outline-secondary"><i class="bi bi-chevron-left"></i></button>
                        <button class="btn btn-sm btn-outline-secondary"><i class="bi bi-chevron-right"></i></button>
                    </div>
                </div>

                <div class="row row-cols-1 row-cols-sm-2 row-cols-md-4 g-3 mb-5">
                    <c:forEach var="p" items="${newProducts}">
                        <div class="col">
                            <div class="product-card text-center d-flex flex-column h-100 p-2">
                                <a href="detail?id=${p.id}" class="text-decoration-none">
                                    <img src="${pageContext.request.contextPath}/assets/images/${p.image}"
                                         class="product-img w-100" alt="${p.name}"
                                         onerror="this.src='https://via.placeholder.com/200'">
                                </a>
                                <div class="flex-grow-1 mt-2">
                                    <h6 class="text-dark text-truncate px-2" title="${p.name}">${p.name}</h6>
                                    <div class="product-price mb-2">
                                        <fmt:formatNumber value="${p.price}" pattern="#,###"/>₫
                                    </div>
                                </div>
                                <div class="p-2 pt-0">
                                    <button class="btn btn-buy w-100 py-2">
                                        <i class="bi bi-cart3"></i> MUA HÀNG
                                    </button>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </div>

                <div class="section-title d-flex justify-content-between align-items-end mb-3">
                    <h2 class="m-0">Bán Chạy</h2>
                    <div class="nav-arrows">
                        <button class="btn btn-sm btn-outline-secondary"><i class="bi bi-chevron-left"></i></button>
                        <button class="btn btn-sm btn-outline-secondary"><i class="bi bi-chevron-right"></i></button>
                    </div>
                </div>

                <div class="row row-cols-1 row-cols-sm-2 row-cols-md-4 g-3">
                    <c:forEach var="p" items="${hotProducts}">
                        <div class="col">
                            <div class="product-card text-center d-flex flex-column h-100 p-2">
                                <a href="detail?id=${p.id}" class="text-decoration-none">
                                    <img src="${pageContext.request.contextPath}/assets/images/${p.image}"
                                         class="product-img w-100" alt="${p.name}"
                                         onerror="this.src='https://via.placeholder.com/200'">
                                </a>
                                <div class="flex-grow-1 mt-2">
                                    <h6 class="text-dark text-truncate px-2" title="${p.name}">${p.name}</h6>
                                    <div class="product-price mb-2">
                                        <fmt:formatNumber value="${p.price}" pattern="#,###"/>₫
                                    </div>
                                </div>
                                <div class="p-2 pt-0">
                                    <button class="btn btn-buy w-100 py-2">
                                        <i class="bi bi-plus-circle"></i> TÙY CHỌN
                                    </button>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </div>
        </div>
    </main>

    <footer class="bg-dark text-white mt-5 py-4 border-top border-danger border-4">
        <div class="container text-center">
            <p class="mb-0">&copy; 2025 Accent Technology - Đồ án Lập trình Web</p>
        </div>
    </footer>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>