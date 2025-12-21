<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Trang chủ - Flagship Global</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css">

    <style>
        .product-img { height: 180px; object-fit: contain; padding: 10px; transition: transform 0.3s ease; }
        .product-card { transition: 0.3s; height: 100%; border-radius: 8px; overflow: hidden; }
        .product-card:hover { border-color: #dc3545 !important; }

        /* Hiệu ứng hover cho ảnh */
        .product-card a:hover img { transform: scale(1.05); }

        /* Định dạng giá tiền và nút */
        .product-price { color: #dc3545; font-weight: bold; font-size: 1.1rem; }
        .btn-buy {
            background-color: #dc3545;
            color: white;
            font-weight: bold;
            border: none;
            transition: 0.2s;
        }
        .btn-buy:hover { background-color: #b02a37; color: white; }

        /* Cấu trúc Slider 2 hàng */
        .slider-viewport { overflow: hidden; width: 100%; position: relative; cursor: grab; user-select: none; }
        .slider-wrapper {
            display: grid;
            grid-template-rows: repeat(2, auto);
            grid-auto-flow: column;
            grid-auto-columns: 25%;
            gap: 15px 0;
            transition: transform 0.5s ease-out;
            will-change: transform;
        }
        .slider-item { padding: 0 8px; }

        @media (max-width: 992px) { .slider-wrapper { grid-auto-columns: 50%; } }
        @media (max-width: 576px) { .slider-wrapper { grid-auto-columns: 100%; } }

        .section-title h2 { font-size: 1.5rem; font-weight: bold; border-left: 4px solid #dc3545; padding-left: 10px; }
    </style>
</head>
<body>
    <jsp:include page="../common/header.jsp" />

    <main class="container mt-4">
        <div class="row">
            <div class="col-md-3">
                <jsp:include page="../common/sidebar.jsp" />
            </div>

            <div class="col-md-9">

                <div class="section-title d-flex justify-content-between align-items-end mb-3">
                    <h2 class="m-0 text-uppercase">Sản phẩm mới</h2>
                    <div class="nav-arrows">
                        <button class="btn btn-sm btn-outline-secondary btn-prev" data-target="newWrapper"><i class="bi bi-chevron-left"></i></button>
                        <button class="btn btn-sm btn-outline-secondary btn-next" data-target="newWrapper"><i class="bi bi-chevron-right"></i></button>
                    </div>
                </div>
                <div class="slider-viewport mb-5">
                    <div id="newWrapper" class="slider-wrapper">
                        <c:forEach var="p" items="${newProducts}">
                            <div class="slider-item">
                                <div class="product-card text-center d-flex flex-column p-2 border bg-white shadow-sm">
                                    <a href="detail?id=${p.id}">
                                        <img src="${pageContext.request.contextPath}/assets/images/${p.image}" class="product-img w-100" alt="${p.name}">
                                    </a>

                                    <div class="flex-grow-1 mt-2">
                                        <h6 class="text-dark text-truncate px-2 fw-bold mb-1">${p.name}</h6>
                                        <div class="product-price mb-2">
                                            <fmt:formatNumber value="${p.price}" pattern="#,###"/>₫
                                        </div>
                                    </div>

                                    <a href="detail?id=${p.id}" class="btn btn-buy w-100 py-2 text-decoration-none">MUA HÀNG</a>
                                </div>
                            </div>
                        </c:forEach>
                    </div>
                </div>

                <div class="section-title d-flex justify-content-between align-items-end mb-3">
                    <h2 class="m-0 text-uppercase">Bán chạy</h2>
                    <div class="nav-arrows">
                        <button class="btn btn-sm btn-outline-secondary btn-prev" data-target="hotWrapper"><i class="bi bi-chevron-left"></i></button>
                        <button class="btn btn-sm btn-outline-secondary btn-next" data-target="hotWrapper"><i class="bi bi-chevron-right"></i></button>
                    </div>
                </div>
                <div class="slider-viewport mb-5">
                    <div id="hotWrapper" class="slider-wrapper">
                        <%-- ĐÃ FIX: Sử dụng đúng danh sách hotProducts --%>
                        <c:forEach var="p" items="${hotProducts}">
                            <div class="slider-item">
                                <div class="product-card text-center d-flex flex-column p-2 border bg-white shadow-sm">

                                    <a href="detail?id=${p.id}">
                                        <img src="${pageContext.request.contextPath}/assets/images/${p.image}" class="product-img w-100" alt="${p.name}">
                                    </a>

                                    <div class="flex-grow-1 mt-2">
                                        <h6 class="text-dark text-truncate px-2 fw-bold mb-1">${p.name}</h6>
                                        <div class="product-price mb-2">
                                            <fmt:formatNumber value="${p.price}" pattern="#,###"/>₫
                                        </div>
                                    </div>

                                    <a href="detail?id=${p.id}" class="btn btn-buy w-100 py-2 text-decoration-none">MUA HÀNG</a>

                                </div>
                            </div>
                        </c:forEach>
                    </div>
                </div>
            </div>
        </div>
    </main>

    <jsp:include page="../common/footer.jsp" />

    <script>
    document.addEventListener('DOMContentLoaded', function() {
        function setupSliderLogic(wrapperId) {
            const wrapper = document.getElementById(wrapperId);
            if (!wrapper) return;

            const viewport = wrapper.parentElement;
            const nextBtns = document.querySelectorAll(`.btn-next[data-target="${wrapperId}"]`);
            const prevBtns = document.querySelectorAll(`.btn-prev[data-target="${wrapperId}"]`);

            let currentPos = 0;
            const columnsVisible = 4;
            const totalItems = wrapper.children.length;
            const totalCols = Math.ceil(totalItems / 2);
            const maxPos = totalCols - columnsVisible;

            function update() {
                wrapper.style.transform = `translateX(-${currentPos * 25}%)`;
            }

            nextBtns.forEach(btn => btn.onclick = () => {
                currentPos = (currentPos < maxPos) ? currentPos + 1 : 0;
                update();
            });

            prevBtns.forEach(btn => btn.onclick = () => {
                currentPos = (currentPos > 0) ? currentPos - 1 : maxPos;
                update();
            });

            // Hỗ trợ kéo chuột
            let isDown = false, startX, scrollPos;
            viewport.onmousedown = (e) => {
                isDown = true;
                startX = e.pageX;
                scrollPos = currentPos;
                wrapper.style.transition = 'none';
                viewport.style.cursor = 'grabbing';
            };
            window.onmouseup = () => {
                isDown = false;
                wrapper.style.transition = 'transform 0.5s ease-out';
                viewport.style.cursor = 'grab';
            };
            viewport.onmousemove = (e) => {
                if (!isDown) return;
                const walk = (e.pageX - startX) * 0.05;
                let temp = scrollPos - walk;
                currentPos = Math.max(0, Math.min(maxPos, Math.round(temp)));
                wrapper.style.transform = `translateX(-${temp * 25}%)`;
            };
        }
        setupSliderLogic('newWrapper');
        setupSliderLogic('hotWrapper');
    });
    </script>
</body>
</html>