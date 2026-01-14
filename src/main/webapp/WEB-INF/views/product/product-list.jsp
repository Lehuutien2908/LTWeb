<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Danh sách sản phẩm</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css">

    <style>
        /* Style riêng cho danh mục bên trái */
        .sidebar-menu { background: #fff; border: 1px solid #eee; border-radius: 8px; overflow: hidden; }
        .sidebar-menu a {
            display: block;
            padding: 12px 20px;
            color: #333;
            border-bottom: 1px solid #f0f0f0;
            transition: 0.3s;
            font-weight: 500;
        }
        .sidebar-menu a:last-child { border-bottom: none; }
        .sidebar-menu a:hover {
            color: var(--main-red);
            background: #f9f9f9;
            padding-left: 25px;
        }
        /* Link đang được chọn sẽ màu đỏ */
        .sidebar-menu a.active {
            color: white;
            background: var(--main-red);
        }

        /* Card sản phẩm */
        .product-card {
            border: 1px solid #eee;
            transition: 0.3s;
            height: 100%;
            background: #fff;
            border-radius: 8px;
        }
        .product-card:hover {
            box-shadow: 0 5px 15px rgba(0,0,0,0.1);
            border-color: var(--main-red);
            transform: translateY(-3px);
        }
        .card-img-top { padding: 15px; height: 200px; object-fit: contain; }
    </style>
</head>
<body>

<jsp:include page="../common/header.jsp"></jsp:include>

<div class="container py-5">
    <div class="row">
        <div class="col-md-3">
            <h5 class="fw-bold text-uppercase mb-3 ps-2" style="border-left: 4px solid var(--main-red);">
                Thương hiệu
            </h5>
            <div class="sidebar-menu mb-4">
                <a href="products?category=all" class="${empty activeCategory || activeCategory == 'all' ? 'active' : ''}">
                    <i class="fa-solid fa-border-all me-2"></i> Tất cả
                </a>
                <a href="products?category=Huawei" class="${activeCategory == 'Huawei' ? 'active' : ''}">
                    <i class="fa-brands fa-huawei me-2"></i> Huawei
                </a>
                <a href="products?category=Honor" class="${activeCategory == 'Honor' ? 'active' : ''}">
                    <i class="fa-brands fa-honor me-2"></i> Honor
                </a>
                <a href="products?category=Xiaomi" class="${activeCategory == 'Xiaomi' ? 'active' : ''}">
                    <i class="fa-solid fa-mobile-screen me-2"></i> Xiaomi
                </a>
                <a href="products?category=Oppo" class="${activeCategory == 'Oppo' ? 'active' : ''}">
                    <i class="fa-solid fa-camera me-2"></i> Oppo
                </a>
            </div>

            <img src="https://via.placeholder.com/300x400?text=ADS+BANNER" class="w-100 rounded">
        </div>

        <div class="col-md-9">
            <div class="d-flex justify-content-between align-items-center mb-4 pb-2 border-bottom">
                <h4 class="fw-bold text-uppercase m-0">${currentCategory}</h4>
                <span class="text-muted">Tìm thấy ${productList.size()} sản phẩm</span>
            </div>

            <div class="row row-cols-1 row-cols-md-3 g-4">
                <c:forEach items="${productList}" var="p">
                    <div class="col">
                        <div class="card product-card h-100">
                            <a href="detail?id=${p.id}" class="text-decoration-none">
                                <div class="position-relative">
                                    <img src="${pageContext.request.contextPath}/assets/images/${p.image}" class="card-img-top" alt="${p.name}">
                                    <c:if test="${p.isNewMap}"><span class="badge bg-danger position-absolute top-0 start-0 m-2">Mới</span></c:if>
                                </div>
                                <div class="card-body text-center">
                                    <h6 class="card-title fw-bold text-dark text-truncate">${p.name}</h6>
                                    <p class="card-text text-danger fw-bold fs-5">
                                        <fmt:formatNumber value="${p.price}" type="currency" currencySymbol="₫"/>
                                    </p>
                                </div>
                            </a>
                        </div>
                    </div>
                </c:forEach>

                <c:if test="${productList.size() == 0}">
                    <div class="col-12 text-center py-5">
                        <i class="fa-solid fa-box-open fs-1 text-muted mb-3"></i>
                        <p class="text-muted">Không tìm thấy sản phẩm nào thuộc hãng này.</p>
                        <a href="products" class="btn btn-dark">Xem tất cả</a>
                    </div>
                </c:if>
            </div>
        </div>
    </div>
</div>

<jsp:include page="../common/footer.jsp"></jsp:include>

</body>
</html>