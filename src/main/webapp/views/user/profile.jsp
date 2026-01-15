<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Hồ sơ của tôi - Flagship Global</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/product/search.css">
</head>
<body class="bg-light">

<jsp:include page="/views/common/header.jsp"/>

<div class="container py-5">
    <div class="row">
        <div class="col-md-3">
            <div class="card border-0 shadow-sm mb-4">
                <div class="card-body text-center py-4">
                    <div class="mb-3">
                        <i class="bi bi-person-circle display-1 text-secondary"></i>
                    </div>
                    <h5 class="fw-bold">${user.fullName}</h5>
                    <p class="text-muted small mb-0">Thành viên Flagship</p>
                </div>
            </div>

            <div class="list-group shadow-sm border-0 rounded-3 overflow-hidden">
                <a href="${pageContext.request.contextPath}/profile"
                   class="list-group-item list-group-item-action active bg-danger border-danger">
                    <i class="bi bi-person-vcard me-2"></i> Hồ sơ & Đơn hàng
                </a>
                <a href="${pageContext.request.contextPath}/logout"
                   class="list-group-item list-group-item-action text-danger">
                    <i class="bi bi-box-arrow-right me-2"></i> Đăng xuất
                </a>
            </div>
        </div>

        <div class="col-md-9">

            <c:if test="${not empty message}">
                <div class="alert alert-success alert-dismissible fade show" role="alert">
                    <i class="bi bi-check-circle-fill me-2"></i>${message}
                    <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                </div>
            </c:if>
            <c:if test="${not empty error}">
                <div class="alert alert-danger alert-dismissible fade show" role="alert">
                    <i class="bi bi-exclamation-triangle-fill me-2"></i>${error}
                    <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                </div>
            </c:if>

            <div class="card border-0 shadow-sm mb-4">
                <div class="card-header bg-white py-3 border-bottom">
                    <h5 class="mb-0 fw-bold text-uppercase"><i class="bi bi-info-circle me-2 text-danger"></i> Hồ sơ cá
                        nhân</h5>
                    <span class="text-muted small">Quản lý thông tin hồ sơ để bảo mật tài khoản</span>
                </div>
                <div class="card-body p-4">
                    <form action="profile" method="post">

                        <div class="row mb-3 align-items-center">
                            <label class="col-md-3 col-form-label text-end fw-bold">Họ và tên</label>
                            <div class="col-md-9">
                                <input type="text" class="form-control bg-light" value="${user.fullName}" readonly>
                            </div>
                        </div>

                        <div class="row mb-3 align-items-center">
                            <label class="col-md-3 col-form-label text-end fw-bold">Email</label>
                            <div class="col-md-9">
                                <input type="email" class="form-control bg-light" value="${user.email}" readonly>
                            </div>
                        </div>

                        <div class="row mb-3 align-items-center">
                            <label class="col-md-3 col-form-label text-end fw-bold">Số điện thoại</label>
                            <div class="col-md-9">
                                <input type="text" name="phone" class="form-control" value="${user.phone}"
                                       placeholder="Cập nhật số điện thoại">
                            </div>
                        </div>

                        <div class="row mb-3 align-items-center">
                            <label class="col-md-3 col-form-label text-end fw-bold">Địa chỉ</label>
                            <div class="col-md-9">
                                <input type="text" name="address" class="form-control" value="${user.address}"
                                       placeholder="Cập nhật địa chỉ giao hàng">
                            </div>
                        </div>

                        <div class="row mb-3">
                            <div class="col-md-9 offset-md-3">
                                <button type="submit" class="btn btn-danger px-4">Lưu thay đổi</button>
                            </div>
                        </div>

                    </form>
                </div>
            </div>

            <div class="card border-0 shadow-sm">
                <div class="card-header bg-white py-3 border-bottom">
                    <h5 class="mb-0 fw-bold text-uppercase"><i class="bi bi-clock-history me-2 text-danger"></i> Lịch sử
                        mua hàng</h5>
                </div>
                <div class="card-body p-0">
                    <div class="table-responsive">
                        <table class="table table-hover mb-0 align-middle">
                            <thead class="table-light">
                            <tr>
                                <th class="py-3 ps-4">Mã đơn</th>
                                <th class="py-3">Sản phẩm</th>
                                <th class="py-3">Ngày đặt</th>
                                <th class="py-3">Tổng tiền</th>
                                <th class="py-3">Trạng thái</th>
                            </tr>
                            </thead>
                            <tbody>
                            <c:choose>
                                <c:when test="${empty orderHistory}">
                                    <tr>
                                        <td colspan="5" class="text-center py-4 text-muted">Bạn chưa có đơn hàng nào.
                                        </td>
                                    </tr>
                                </c:when>
                                <c:otherwise>
                                    <c:forEach var="o" items="${orderHistory}">
                                        <tr>
                                            <td class="ps-4 fw-bold text-primary"><a
                                                    href="${pageContext.request.contextPath}/order-detail?id=${o.id}"
                                                    class="text-decoration-none fw-bold text-primary">
                                                #${o.id}
                                            </a></td>
                                            <td>
                                                    <span class="d-inline-block text-truncate" style="max-width: 200px;"
                                                          title="${o.listProductNames}">
                                                            ${o.listProductNames}
                                                    </span>
                                            </td>
                                            <td><fmt:formatDate value="${o.date}" pattern="dd/MM/yyyy HH:mm"/></td>
                                            <td class="fw-bold text-danger">
                                                <fmt:formatNumber value="${o.totalMoney}" type="currency"
                                                                  currencySymbol="₫"/>
                                            </td>
                                            <td>
                                                <c:choose>
                                                    <c:when test="${o.status == 0}">
                                                        <span class="badge bg-warning text-dark">Chờ xử lý</span>
                                                    </c:when>
                                                    <c:when test="${o.status == 1}">
                                                        <span class="badge bg-info">Đang giao</span>
                                                    </c:when>
                                                    <c:when test="${o.status == 3}">
                                                        <span class="badge bg-success">Hoàn thành</span>
                                                    </c:when>
                                                    <c:when test="${o.status == 4}"> <span class="badge bg-danger">Đã hủy</span>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <span class="badge bg-secondary">Khác</span>
                                                    </c:otherwise>
                                                </c:choose>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </c:otherwise>
                            </c:choose>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>

        </div>
    </div>
</div>

<jsp:include page="/views/common/footer.jsp"/>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>