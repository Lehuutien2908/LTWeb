<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Giỏ hàng - Flagship Store</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.0/font/bootstrap-icons.css">

    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css">

    <style>
        body { background-color: #f4f4f4; }
        .cart-img { width: 80px; height: 80px; object-fit: cover; border: 1px solid #ddd; border-radius: 4px; }
        /* Nút màu đỏ chuẩn */
        .btn-accent { background-color: #e31e24; color: white; border: none; font-weight: bold; }
        .btn-accent:hover { background-color: #b0181d; color: white; }
    </style>
</head>
<body>

<jsp:include page="../common/header.jsp"/>


<div class="container my-5" style="min-height: 50vh;">
    <h3 class="text-uppercase fw-bold mb-4" style="border-left: 5px solid #e31e24; padding-left: 10px;">
        Giỏ hàng của bạn
    </h3>

    <c:if test="${empty sessionScope.cart or sessionScope.cart.totalQuantity == 0}">
        <div class="bg-white p-5 text-center shadow-sm rounded">
            <i class="bi bi-cart-x display-1 text-secondary"></i>
            <h4 class="mt-3 text-muted">Giỏ hàng của bạn đang trống</h4>
            <p class="text-muted">Hãy chọn thêm sản phẩm để mua sắm nhé!</p>
            <a href="${pageContext.request.contextPath}/home" class="btn btn-accent px-4 py-2 mt-2">
                QUAY LẠI CỬA HÀNG
            </a>
        </div>
    </c:if>

    <c:if test="${not empty sessionScope.cart and sessionScope.cart.totalQuantity > 0}">
        <div class="row">
            <div class="col-lg-8">
                <div class="bg-white p-3 shadow-sm rounded mb-3">
                    <table class="table align-middle mb-0">
                        <thead class="table-light">
                        <tr>
                            <th>Sản phẩm</th>
                            <th class="text-center">Giá</th>
                            <th class="text-center">SL</th>
                            <th class="text-end">Thành tiền</th>
                            <th></th>
                        </tr>
                        </thead>
                        <tbody>
                        <c:forEach items="${sessionScope.cart.items.values()}" var="item">
                            <tr>
                                <td>
                                    <div class="d-flex align-items-center">
                                        <img src="${pageContext.request.contextPath}/assets/images/${item.product.image}" class="cart-img me-3">
                                        <div class="fw-bold text-dark">${item.product.name}</div>
                                    </div>
                                </td>
                                <td class="text-center"><fmt:formatNumber value="${item.product.price}" type="currency" currencySymbol="₫"/></td>
                                <td class="text-center">
                                    <input type="number" value="${item.quantity}" min="1" class="form-control text-center d-inline-block" style="width: 60px;">
                                </td>
                                <td class="text-end fw-bold text-danger">
                                    <fmt:formatNumber value="${item.totalPrice}" type="currency" currencySymbol="₫"/>
                                </td>
                                <td class="text-center">
                                    <a href="#" class="text-secondary"><i class="fas fa-trash-alt"></i></a>
                                </td>
                            </tr>
                        </c:forEach>
                        </tbody>
                    </table>
                </div>
            </div>

            <div class="col-lg-4">
                <div class="bg-white p-4 shadow-sm rounded">
                    <h5 class="fw-bold border-bottom pb-2 mb-3">Cộng giỏ hàng</h5>
                    <div class="d-flex justify-content-between mb-4">
                        <span class="fs-5 fw-bold">Tổng cộng:</span>
                        <span class="fs-4 fw-bold text-danger">
                            <fmt:formatNumber value="${sessionScope.cart.totalMoney}" type="currency" currencySymbol="₫"/>
                        </span>
                    </div>
                    <a href="#" class="btn btn-accent w-100 py-2 text-uppercase">Tiến hành thanh toán</a>
                </div>
            </div>
        </div>
    </c:if>
</div>

<jsp:include page="../common/footer.jsp"/>
</body>
</html>