<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Chi tiết đơn hàng #${order.id}</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">
</head>
<body class="bg-light">

<jsp:include page="/views/common/header.jsp"/>

<div class="container py-5">
    <div class="mb-4">
        <a href="${pageContext.request.contextPath}/profile" class="text-decoration-none text-muted">
            <i class="bi bi-arrow-left"></i> Quay lại hồ sơ
        </a>
    </div>

    <div class="row">
        <div class="col-lg-4 mb-4">
            <div class="card border-0 shadow-sm h-100">
                <div class="card-header bg-white py-3">
                    <h5 class="mb-0 fw-bold">Thông tin nhận hàng</h5>
                </div>
                <div class="card-body">
                    <p class="mb-1 text-muted small">Mã đơn hàng</p>
                    <p class="fw-bold">#${order.id}</p>

                    <p class="mb-1 text-muted small">Ngày đặt</p>
                    <p class="fw-bold"><fmt:formatDate value="${order.date}" pattern="dd/MM/yyyy HH:mm"/></p>

                    <p class="mb-1 text-muted small">Người nhận</p>
                    <p class="fw-bold">${order.fullName}</p>

                    <p class="mb-1 text-muted small">Số điện thoại</p>
                    <p class="fw-bold">${order.phone}</p>

                    <p class="mb-1 text-muted small">Địa chỉ</p>
                    <p class="fw-bold">${order.address}</p>

                    <hr>
                    <p class="mb-1 text-muted small">Trạng thái đơn hàng</p>
                    <c:choose>
                        <c:when test="${order.status == 0}"><span
                                class="badge bg-warning text-dark">Chờ xử lý</span></c:when>
                        <c:when test="${order.status == 1}"><span class="badge bg-info">Đang giao</span></c:when>
                        <c:when test="${order.status == 3}"><span class="badge bg-success">Hoàn thành</span></c:when>
                        <c:when test="${order.status == 4}"><span class="badge bg-danger">Đã hủy</span></c:when>
                    </c:choose>
                </div>
            </div>
        </div>

        <div class="col-lg-8">
            <div class="card border-0 shadow-sm">
                <div class="card-header bg-white py-3">
                    <h5 class="mb-0 fw-bold">Sản phẩm đã mua</h5>
                </div>
                <div class="card-body p-0">
                    <div class="table-responsive">
                        <table class="table align-middle mb-0">
                            <thead class="table-light">
                            <tr>
                                <th class="ps-4">Sản phẩm</th>
                                <th class="text-center">Giá</th>
                                <th class="text-center">Số lượng</th>
                                <th class="text-end pe-4">Tạm tính</th>
                            </tr>
                            </thead>
                            <tbody>
                            <c:forEach var="item" items="${details}">
                                <tr>
                                    <td class="ps-4">
                                        <div class="d-flex align-items-center">
                                            <div style="width: 50px; height: 50px; background: #eee;"
                                                 class="rounded me-3 d-flex align-items-center justify-content-center">
                                                <i class="bi bi-image text-muted"></i>
                                            </div>
                                            <span class="fw-bold">${item.productName}</span>
                                        </div>
                                    </td>
                                    <td class="text-center">
                                        <fmt:formatNumber value="${item.price}" type="currency" currencySymbol="₫"/>
                                    </td>
                                    <td class="text-center">x${item.quantity}</td>
                                    <td class="text-end pe-4 fw-bold">
                                        <fmt:formatNumber value="${item.price * item.quantity}" type="currency"
                                                          currencySymbol="₫"/>
                                    </td>
                                </tr>
                            </c:forEach>
                            </tbody>
                            <tfoot class="bg-light">
                            <tr>
                                <td colspan="3" class="text-end fw-bold pt-3">Tổng tiền thanh toán:</td>
                                <td class="text-end pe-4 fw-bold text-danger fs-5 pt-3">
                                    <fmt:formatNumber value="${order.totalMoney}" type="currency" currencySymbol="₫"/>
                                </td>
                            </tr>
                            </tfoot>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<jsp:include page="/views/common/footer.jsp"/>
</body>
</html>