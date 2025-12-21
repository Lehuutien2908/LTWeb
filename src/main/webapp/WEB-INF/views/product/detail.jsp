<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>${product.name} - Accent Technology</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css">
    <style>
        .specs-table th { width: 30%; background-color: #f8f9fa; }
        .product-main-img { transition: transform 0.3s ease; }
        .product-main-img:hover { transform: scale(1.05); }
        .btn-buy-now { background-color: #ee4d2d; border: none; }
        .btn-buy-now:hover { background-color: #d73211; }
    </style>
</head>
<body class="bg-light">

    <jsp:include page="../common/header.jsp" />

    <main class="container py-5">
        <nav aria-label="breadcrumb" class="mb-4">
            <ol class="breadcrumb p-2 bg-white rounded shadow-sm">
                <li class="breadcrumb-item"><a href="home" class="text-decoration-none">Trang chủ</a></li>
                <li class="breadcrumb-item text-capitalize">${product.category}</li>
                <li class="breadcrumb-item active" aria-current="page">${product.name}</li>
            </ol>
        </nav>

        <div class="row bg-white rounded shadow-sm overflow-hidden m-0">
            <div class="col-md-5 p-4 d-flex align-items-center justify-content-center border-end">
                <div class="position-relative">
                    <c:if test="${product.hot}">
                        <span class="position-absolute top-0 start-0 badge rounded-pill bg-danger" style="z-index: 1;">HOT</span>
                    </c:if>
                    <img src="${pageContext.request.contextPath}/assets/images/${product.image}"
                         class="img-fluid product-main-img"
                         style="max-height: 450px; object-fit: contain;"
                         alt="${product.name}">
                </div>
            </div>

            <div class="col-md-7 p-4 ps-md-5">
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

                <div class="p-3 mb-4 rounded" style="background-color: #fafafa;">
                    <div class="d-flex align-items-center">
                        <h2 class="text-danger fw-bold me-3 mb-0">
                            <fmt:formatNumber value="${product.price}" pattern="#,###"/>₫
                        </h2>
                        <span class="text-muted text-decoration-line-through small">
                            <fmt:formatNumber value="${product.price * 1.12}" pattern="#,###"/>₫
                        </span>
                        <span class="badge bg-danger ms-2">-12%</span>
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

                    <div class="bg-light p-3 rounded mb-4">
                        <div class="small text-secondary mb-2"><i class="bi bi-truck me-2"></i> Miễn phí vận chuyển cho đơn hàng từ 500k</div>
                        <div class="small text-secondary"><i class="bi bi-shield-check me-2"></i> Bảo hành chính hãng 12 tháng</div>
                    </div>

                    <div class="d-grid gap-2 d-md-flex mt-4">
                        <button type="submit" formaction="buy-now" class="btn btn-buy-now btn-lg px-5 fw-bold py-3 text-white">MUA NGAY</button>
                        <button type="submit" class="btn btn-outline-danger btn-lg px-4 py-3 border-2">
                            <i class="bi bi-cart-plus fs-4"></i>
                        </button>
                    </div>
                </form>
            </div>
        </div>

        <div class="row mt-4 m-0">
            <div class="col-md-8 p-0 pe-md-3">
                <div class="bg-white p-4 rounded shadow-sm h-100">
                    <h4 class="fw-bold mb-4">Đặc điểm nổi bật</h4>
                    <p>Sản phẩm <strong>${product.name}</strong> mang đến trải nghiệm đột phá với công nghệ màn hình tiên tiến và hiệu năng mạnh mẽ. Đây là lựa chọn hàng đầu trong phân khúc ${product.category} hiện nay.</p>
                    <ul>
                        <li>Thiết kế sang trọng, tinh tế.</li>
                        <li>Camera sắc nét, hỗ trợ AI.</li>
                        <li>Pin dung lượng lớn, sạc nhanh cấp tốc.</li>
                    </ul>
                </div>
            </div>
            <div class="col-md-4 p-0 mt-3 mt-md-0">
                <div class="bg-white p-4 rounded shadow-sm">
                    <h4 class="fw-bold mb-4">Thông số kỹ thuật</h4>
                    <table class="table table-bordered specs-table small">
                        <tr><th>Màn hình</th><td>6.7 inch, AMOLED</td></tr>
                        <tr><th>Chipset</th><td>Snapdragon 8 Gen 3</td></tr>
                        <tr><th>RAM</th><td>12 GB</td></tr>
                        <tr><th>Bộ nhớ</th><td>256 GB</td></tr>
                        <tr><th>Pin</th><td>5000 mAh</td></tr>
                    </table>
                </div>
            </div>
        </div>

        <section class="mt-5">
            <div class="d-flex justify-content-between align-items-center mb-4">
                <h4 class="fw-bold m-0 border-start border-danger border-4 ps-3">Sản phẩm tương tự</h4>
                <a href="home" class="text-decoration-none small text-danger">Xem tất cả <i class="bi bi-arrow-right"></i></a>
            </div>
            <div class="row row-cols-2 row-cols-md-4 g-3">
                <c:forEach var="rp" items="${relatedProducts}">
                    <div class="col">
                        <div class="card h-100 border-0 shadow-sm text-center p-2 position-relative">
                            <a href="detail?id=${rp.id}">
                                <img src="${pageContext.request.contextPath}/assets/images/${rp.image}"
                                     class="card-img-top p-3" style="height: 160px; object-fit: contain;" alt="${rp.name}">
                            </a>
                            <div class="card-body p-1">
                                <h6 class="small fw-bold text-truncate px-2">${rp.name}</h6>
                                <p class="text-danger fw-bold small mb-2">
                                    <fmt:formatNumber value="${rp.price}" pattern="#,###"/>₫
                                </p>
                                <a href="detail?id=${rp.id}" class="btn btn-sm btn-outline-danger w-100 py-1">Chi tiết</a>
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </div>
        </section>
    </main>

    <jsp:include page="../common/footer.jsp" />

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