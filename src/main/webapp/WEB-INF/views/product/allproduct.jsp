<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Tất cả sản phẩm - Flagship Global</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css">
    <style>
        /* Tinh chỉnh riêng để đồng bộ với Home và Detail */
        .product-card { transition: 0.3s; border-radius: 8px; overflow: hidden; }
        .product-card:hover { border-color: #dc3545 !important; box-shadow: 0 8px 20px rgba(0,0,0,0.1); transform: translateY(-3px); }
        .product-img { height: 160px; object-fit: contain; padding: 10px; transition: transform 0.4s; }
        .product-card:hover .product-img { transform: scale(1.08); }

        .btn-buy { background-color: #dc3545; color: white; font-weight: bold; border: none; transition: 0.2s; }
        .btn-buy:hover { background-color: #b02a37; color: white; }

        .filter-btn { border-radius: 20px; font-size: 13px; font-weight: 600; padding: 5px 20px; transition: 0.3s; }
        .filter-btn:hover, .filter-btn.active { background-color: #dc3545; color: white; border-color: #dc3545; }

        .page-link { color: #333; border: none; margin: 0 5px; border-radius: 5px; }
        .page-item.active .page-link { background-color: #dc3545; border-color: #dc3545; }
    </style>
</head>
<body class="bg-light">

    <jsp:include page="/WEB-INF/views/common/header.jsp" />

    <div class="bg-white border-bottom py-2 mb-4">
        <div class="container d-flex justify-content-between align-items-center">
            <div class="d-flex align-items-center">
                <a href="javascript:history.back()" class="text-dark text-decoration-none d-flex align-items-center py-1">
                                    <i class="bi bi-chevron-left fs-5"></i>
                                    <span class="ms-2 small fw-bold text-uppercase">Quay lại</span>
                                </a>
                <div class="vr mx-3 opacity-25"></div>
                <span class="small text-muted text-uppercase fw-semibold">Tất Cả Sản phẩm (${products.size()})</span>
            </div>

            <div class="d-flex align-items-center">
                <span class="small text-muted me-2">Sắp xếp:</span>
                <select class="form-select form-select-sm border-0 bg-light fw-bold" style="width: 160px; cursor: pointer;">
                    <option selected>Mới nhất</option>
                    <option>Giá thấp đến cao</option>
                    <option>Giá cao đến thấp</option>
                    <option>Bán chạy nhất</option>
                </select>
            </div>
        </div>
    </div>

    <main class="container mb-5">
        <div class="d-flex flex-wrap gap-2 mb-4 justify-content-center">
            <button class="btn btn-outline-secondary filter-btn active">Tất cả</button>
            <button class="btn btn-outline-secondary filter-btn">Xiaomi</button>
            <button class="btn btn-outline-secondary filter-btn">OPPO</button>
            <button class="btn btn-outline-secondary filter-btn">Vivo</button>
            <button class="btn btn-outline-secondary filter-btn">Huawei</button>
            <button class="btn btn-outline-secondary filter-btn">Khác</button>
        </div>

        <div class="row row-cols-2 row-cols-md-3 row-cols-lg-5 g-3">
            <c:forEach var="p" items="${products}">
                <div class="col">
                    <div class="product-card text-center d-flex flex-column p-2 border bg-white shadow-sm h-100">
                        <a href="detail?id=${p.id}" class="position-relative overflow-hidden d-block">
                            <c:if test="${p.hot}">
                                <span class="badge bg-danger position-absolute top-0 start-0 m-2 shadow-sm" style="z-index: 1; font-size: 0.7rem;">HOT</span>
                            </c:if>
                            <img src="${pageContext.request.contextPath}/assets/images/${p.image}"
                                 class="product-img w-100" alt="${p.name}">
                        </a>

                        <div class="flex-grow-1 mt-2">
                            <h6 class="text-dark text-truncate px-2 fw-bold mb-1" title="${p.name}">${p.name}</h6>
                            <div class="product-price mb-2 fw-bold" style="color: #dc3545;">
                                <fmt:formatNumber value="${p.price}" pattern="#,###"/>₫
                            </div>
                        </div>

                        <div class="px-1 pb-1">
                            <a href="detail?id=${p.id}" class="btn btn-buy w-100 py-2 text-decoration-none small text-uppercase">Mua hàng</a>
                        </div>
                    </div>
                </div>
            </c:forEach>
        </div>

        <nav class="mt-5">
            <ul class="pagination justify-content-center shadow-sm d-inline-flex bg-white p-2 rounded-pill mx-auto d-flex" style="width: fit-content;">
                <li class="page-item disabled">
                    <a class="page-link" href="#"><i class="bi bi-chevron-left"></i></a>
                </li>
                <li class="page-item active"><a class="page-link" href="#">1</a></li>
                <li class="page-item"><a class="page-link" href="#">2</a></li>
                <li class="page-item"><a class="page-link" href="#">3</a></li>
                <li class="page-item">
                    <a class="page-link" href="#"><i class="bi bi-chevron-right"></i></a>
                </li>
            </ul>
        </nav>
    </main>

    <jsp:include page="/WEB-INF/views/common/footer.jsp" />

</body>
</html>