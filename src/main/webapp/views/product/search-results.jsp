<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Kết quả cho: ${txtSearch} - Flagship Global</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/product/search.css">
</head>
<body class="bg-light">

<jsp:include page="/views/common/header.jsp"/>

<div class="container py-5">
    <div class="d-flex justify-content-between align-items-center mb-4 pb-2 border-bottom">
        <h4 class="fw-bold text-uppercase m-0">KẾT QUẢ CHO: "${txtSearch}"</h4>
        <span class="text-muted fw-bold">Tìm thấy ${productList.size()} sản phẩm</span>
    </div>

    <div class="row row-cols-1 row-cols-sm-2 row-cols-md-4 g-4">
        <c:forEach items="${productList}" var="p">
            <div class="col">
                <div class="card product-card h-100 shadow-sm border-0">
                    <a href="${pageContext.request.contextPath}/product-detail?id=${p.id}" class="text-decoration-none text-dark">
                        <div class="p-3 text-center bg-white rounded-top" style="height: 200px; display: flex; align-items: center; justify-content: center;">
                            <img src="${pageContext.request.contextPath}/assets/images/${p.image}"
                                 class="img-fluid" style="max-height: 100%; object-fit: contain;">

                            <c:if test="${p.isNewMap}">
                                <span class="badge bg-danger position-absolute top-0 start-0 m-2">Mới</span>
                            </c:if>
                        </div>
                        <div class="card-body text-center bg-white rounded-bottom">
                            <h6 class="card-title fw-bold text-truncate mb-2">${p.name}</h6>
                            <p class="card-text text-danger fw-bold fs-5 mb-0">
                                <fmt:formatNumber value="${p.price}" type="currency" currencySymbol="₫"/>
                            </p>
                        </div>
                    </a>
                </div>
            </div>
        </c:forEach>
    </div>

    <c:if test="${empty productList}">
        <div class="text-center py-5">
            <p class="text-muted fs-5">Không tìm thấy sản phẩm nào khớp với từ khóa "${txtSearch}".</p>
            <a href="${pageContext.request.contextPath}/home" class="btn btn-dark mt-3 px-4">QUAY LẠI TRANG CHỦ</a>
        </div>
    </c:if>
</div>
<jsp:include page="/views/common/footer.jsp"/>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>