<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>${product.name} - Flagship Global</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css">
    <style>
        /* Tinh chỉnh riêng cho trang chi tiết */
        .specs-table th { width: 35%; background-color: #f8f9fa; font-weight: 600; }
        .product-main-img { transition: transform 0.4s cubic-bezier(0.165, 0.84, 0.44, 1); }
        .product-main-img:hover { transform: scale(1.08); }

        .btn-buy-now { background-color: #dc3545; border: none; transition: 0.3s; }
        .btn-buy-now:hover { background-color: #b02a37; transform: translateY(-2px); }

        .quantity-input { width: 60px !important; font-weight: bold; border-left: none; border-right: none; }
        .badge-hot { font-size: 0.7rem; padding: 0.5em 1em; }

        /* Hiệu ứng cho Related Products */
        .related-card { transition: 0.3s; }
        .related-card:hover { border-color: #dc3545 !important; box-shadow: 0 5px 15px rgba(0,0,0,0.1) !important; }
    </style>
</head>
<body class="bg-light">
    <jsp:include page="/WEB-INF/views/common/header.jsp" />

    <main class="container py-3">
        <%-- Thanh điều hướng tối giản: Gần Header hơn nhờ mb-0 trên header --%>
        <div class="bg-white border-bottom mt-0 pt-1 pb-2 mb-4">
            <div class="container d-flex align-items-center">
                <a href="javascript:history.back()" class="text-dark text-decoration-none d-flex align-items-center py-1">
                    <i class="bi bi-chevron-left fs-5"></i>
                    <span class="ms-2 small fw-bold text-uppercase">Quay lại</span>
                </a>
                <div class="vr mx-3 text-secondary opacity-25"></div>
                <span class="small text-muted text-truncate">${product.name}</span>
            </div>
        </div>

        <div class="row bg-white rounded shadow-sm overflow-hidden m-0 border">
            <div class="col-md-5 p-4 d-flex align-items-center justify-content-center border-end bg-white">
                <div class="position-relative">
                    <c:if test="${product.hot}">
                        <span class="position-absolute top-0 start-0 badge rounded-pill bg-danger badge-hot" style="z-index: 1;">HOT</span>
                    </c:if>
                    <img src="${pageContext.request.contextPath}/assets/images/${product.image}"
                         class="img-fluid product-main-img"
                         style="max-height: 400px; object-fit: contain;"
                         alt="${product.name}">
                </div>
            </div>

            <div class="col-md-7 p-4 ps-md-5">
                <nav aria-label="breadcrumb" class="mb-2">
                    <ol class="breadcrumb small mb-0">
                        <li class="breadcrumb-item"><a href="home" class="text-decoration-none text-muted">Trang chủ</a></li>
                        <li class="breadcrumb-item active text-danger fw-bold">${product.category}</li>
                    </ol>
                </nav>

                <h1 class="h2 fw-bold text-dark mb-2">${product.name}</h1>
                <div class="d-flex align-items-center mb-3">
                    <div class="text-warning me-2">
                        <i class="bi bi-star-fill"></i>
                        <i class="bi bi-star-fill"></i>
                        <i class="bi bi-star-fill"></i>
                        <i class="bi bi-star-fill"></i>
                        <i class="bi bi-star-half"></i>
                    </div>
                    <span class="small text-muted border-start ps-2">Đã bán 128</span>
                </div>

                <div class="p-3 mb-4 rounded" style="background-color: #fff5f5; border: 1px dashed #feb2b2;">
                    <div class="d-flex align-items-baseline">
                        <h2 class="text-danger fw-bold me-3 mb-0">
                            <fmt:formatNumber value="${product.price}" pattern="#,###"/>₫
                        </h2>
                        <span class="text-muted text-decoration-line-through small">
                            <fmt:formatNumber value="${product.price * 1.12}" pattern="#,###"/>₫
                        </span>
                        <span class="badge bg-danger ms-2 px-2">-12%</span>
                    </div>
                </div>

                <form action="cart-add" method="POST">
                    <input type="hidden" name="productId" value="${product.id}">

                    <div class="mb-4 d-flex align-items-center">
                                            <label class="me-3 fw-bold">Số lượng:</label>
                                            <div class="input-group" style="width: 130px;">
                                                <button class="btn btn-outline-secondary" type="button" onclick="changeQty(-1)">-</button>
                                                <input type="number" name="quantity" id="quantity" class="form-control text-center" value="1" min="1">
                                                <button class="btn btn-outline-secondary" type="button" onclick="changeQty(1)">+</button>
                                            </div>
                                        </div>

                    <div class="bg-light p-3 rounded mb-4 border">
                        <div class="small text-dark mb-2"><i class="bi bi-truck text-danger me-2"></i> Miễn phí vận chuyển cho đơn hàng từ 500k</div>
                        <div class="small text-dark"><i class="bi bi-shield-check text-danger me-2"></i> Bảo hành chính hãng 12 tháng tại <strong>Flagship Global</strong></div>
                    </div>

                    <div class="d-grid gap-2 d-md-flex mt-4">
                        <button type="submit" formaction="buy-now" class="btn btn-buy-now btn-lg px-5 fw-bold py-3 text-white text-uppercase">MUA NGAY</button>
                        <button type="submit" class="btn btn-outline-danger btn-lg px-4 py-3 border-2 shadow-sm">
                            <i class="bi bi-cart-plus fs-4"></i>
                        </button>
                    </div>
                </form>
            </div>
        </div>

        <div class="row mt-4 m-0 g-3">
            <div class="col-md-8">
                <div class="bg-white p-4 rounded shadow-sm border h-100">
                    <h4 class="fw-bold mb-4 border-start border-danger border-4 ps-3 text-uppercase" style="font-size: 1.1rem;">Đặc điểm nổi bật</h4>
                    <p class="text-secondary">Sản phẩm <strong>${product.name}</strong> mang đến trải nghiệm đột phá với công nghệ màn hình tiên tiến và hiệu năng mạnh mẽ nhất năm 2025.</p>
                    <ul class="text-secondary">
                        <li class="mb-2">Thiết kế sang trọng với khung viền kim loại cao cấp.</li>
                        <li class="mb-2">Camera sắc nét hỗ trợ AI thế hệ mới, quay video 8K.</li>
                        <li class="mb-2">Pin dung lượng 5000mAh hỗ trợ sạc nhanh cấp tốc 120W.</li>
                    </ul>
                </div>
            </div>
            <div class="col-md-4">
                <div class="bg-white p-4 rounded shadow-sm border h-100">
                    <h4 class="fw-bold mb-4 border-start border-danger border-4 ps-3 text-uppercase" style="font-size: 1.1rem;">Thông số kỹ thuật</h4>
                    <table class="table table-bordered specs-table small mb-0">
                        <tr><th>Màn hình</th><td class="text-muted">6.7 inch, AMOLED</td></tr>
                        <tr><th>Chipset</th><td class="text-muted">Snapdragon 8 Gen 3</td></tr>
                        <tr><th>RAM</th><td class="text-muted">12 GB LPDDR5X</td></tr>
                        <tr><th>Bộ nhớ</th><td class="text-muted">256 GB UFS 4.0</td></tr>
                        <tr><th>Pin</th><td class="text-muted">5000 mAh</td></tr>
                    </table>
                </div>
            </div>
        </div>

        <section class="mt-5 mb-5">
            <div class="d-flex justify-content-between align-items-center mb-4">
                <h4 class="fw-bold m-0 border-start border-danger border-4 ps-3 text-uppercase" style="font-size: 1.1rem;">Sản phẩm tương tự</h4>
            </div>
            <div class="row row-cols-2 row-cols-md-4 g-3">
                <c:forEach var="rp" items="${relatedProducts}">
                    <div class="col">
                        <div class="card h-100 border bg-white related-card text-center p-2 position-relative shadow-sm">
                            <a href="detail?id=${rp.id}">
                                <img src="${pageContext.request.contextPath}/assets/images/${rp.image}"
                                     class="card-img-top p-3" style="height: 160px; object-fit: contain;" alt="${rp.name}">
                            </a>
                            <div class="card-body p-2">
                                <h6 class="small fw-bold text-dark text-truncate px-2 mb-1">${rp.name}</h6>
                                <p class="text-danger fw-bold small mb-2">
                                    <fmt:formatNumber value="${rp.price}" pattern="#,###"/>₫
                                </p>
                                <a href="detail?id=${rp.id}" class="btn btn-sm btn-outline-danger w-100 py-1 fw-bold">CHI TIẾT</a>
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </div>
        </section>
    </main>

    <jsp:include page="/WEB-INF/views/common/footer.jsp" />

    <script>
        function changeQty(amount) {
            let qtyInput = document.getElementById('quantity');
            let currentQty = parseInt(qtyInput.value);
            if (currentQty + amount >= 1) {
                qtyInput.value = currentQty + amount;
            }
        }
    </script>
</body>
</html>