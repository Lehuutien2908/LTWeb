<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

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
                    <h5 class="fw-bold">${sessionScope.user.fullName}</h5>
                    <p class="text-muted small mb-0">Thành viên Flagship</p>
                </div>
            </div>

            <div class="list-group shadow-sm border-0 rounded-3 overflow-hidden">
                <a href="${pageContext.request.contextPath}/profile" class="list-group-item list-group-item-action active bg-danger border-danger">
                    <i class="bi bi-person-vcard me-2"></i> Tài khoản của bạn
                </a>


                <a href="${pageContext.request.contextPath}/logout" class="list-group-item list-group-item-action text-danger">
                    <i class="bi bi-box-arrow-right me-2"></i> Đăng xuất
                </a>
            </div>
        </div>

        <div class="col-md-9">
            <div class="card border-0 shadow-sm">
                <div class="card-header bg-white py-3 border-bottom">
                    <h5 class="mb-0 fw-bold text-uppercase"><i class="bi bi-info-circle me-2 text-danger"></i> Hồ sơ của tôi</h5>
                    <span class="text-muted small">Quản lý thông tin hồ sơ để bảo mật tài khoản</span>
                </div>
                <div class="card-body p-4">
                    <form>

                        <div class="row mb-3 align-items-center">
                            <label class="col-md-3 col-form-label text-end fw-bold">Họ và tên</label>
                            <div class="col-md-9">
                                <input type="text" class="form-control" value="${sessionScope.user.fullName}" readonly style="background-color: #e9ecef;">
                            </div>
                        </div>

                        <div class="row mb-3 align-items-center">
                            <label class="col-md-3 col-form-label text-end fw-bold">Email</label>
                            <div class="col-md-9">
                                <input type="email" class="form-control" value="${sessionScope.user.email}" readonly style="background-color: #e9ecef;">
                            </div>
                        </div>

                    </form>
                </div>
            </div>
        </div>
    </div>
</div>

<jsp:include page="/views/common/footer.jsp"/>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>