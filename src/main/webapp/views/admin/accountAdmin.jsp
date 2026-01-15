<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Hồ Sơ Của Tôi</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link rel="stylesheet" href="/assets/css/admin/profileAD.css">
</head>
<body class="bg-light">

<jsp:include page="headerAD.jsp"/>

<div class="container-fluid">
    <div class="row">
        <jsp:include page="sidebarAD.jsp">
            <jsp:param name="activePage" value="accountAD"/>
        </jsp:include>

        <main class="col-md-9 ms-sm-auto col-lg-10 px-md-4 py-4">
            <h4 class="mb-4 text-gray-800 border-start border-primary border-3 ps-3">Hồ Sơ Của Tôi</h4>

            <c:if test="${not empty message}">
                <div class="alert alert-success alert-dismissible fade show">
                    <i class="fas fa-check-circle me-2"></i> ${message}
                    <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                </div>
            </c:if>
            <c:if test="${not empty error}">
                <div class="alert alert-danger alert-dismissible fade show">
                    <i class="fas fa-exclamation-circle me-2"></i> ${error}
                    <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                </div>
            </c:if>

            <div class="row">
                <div class="col-md-4 mb-4">
                    <div class="card shadow-sm border-0 text-center">
                        <div class="profile-card-header rounded-top"></div>
                        <div class="card-body">
                            <div class="profile-avatar rounded-circle shadow-sm mx-auto d-flex align-items-center justify-content-center">
                                <i class="fas fa-user-tie"></i>
                            </div>
                            <h5 class="card-title mt-3 fw-bold">${sessionScope.user.fullName}</h5>
                            <p class="text-muted mb-1">Quản Trị Viên Hệ Thống</p>
                            <span class="badge bg-success mb-3">Active</span>

                            <hr>
                            <div class="text-start px-3">
                                <p class="small mb-1"><i
                                        class="fas fa-envelope me-2 text-primary"></i> ${sessionScope.user.email}</p>
                                <p class="small mb-1"><i
                                        class="fas fa-phone me-2 text-primary"></i> ${sessionScope.user.phone}</p>
                                <p class="small mb-0"><i
                                        class="fas fa-map-marker-alt me-2 text-primary"></i> ${sessionScope.user.address}
                                </p>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="col-md-8">
                    <div class="card shadow-sm border-0">
                        <div class="card-header bg-white border-bottom-0 pt-3">
                            <ul class="nav nav-tabs card-header-tabs" id="profileTab" role="tablist">
                                <li class="nav-item">
                                    <button class="nav-link active fw-bold" id="info-tab" data-bs-toggle="tab"
                                            data-bs-target="#info" type="button">
                                        <i class="fas fa-user-edit me-1"></i> Thông tin chung
                                    </button>
                                </li>
                                <li class="nav-item">
                                    <button class="nav-link fw-bold text-danger" id="password-tab" data-bs-toggle="tab"
                                            data-bs-target="#password" type="button">
                                        <i class="fas fa-key me-1"></i> Đổi mật khẩu
                                    </button>
                                </li>
                            </ul>
                        </div>

                        <div class="card-body">
                            <div class="tab-content" id="profileTabContent">
                                <div class="tab-pane fade show active" id="info">
                                    <form action="accountAD" method="post">
                                        <input type="hidden" name="action" value="updateInfo">

                                        <div class="mb-3">
                                            <label class="form-label text-muted small">Email (Không thể thay
                                                đổi)</label>
                                            <input type="text" class="form-control bg-light"
                                                   value="${sessionScope.user.email}" readonly>
                                        </div>

                                        <div class="mb-3">
                                            <label class="form-label fw-bold">Họ và tên</label>
                                            <input type="text" class="form-control" name="fullName"
                                                   value="${sessionScope.user.fullName}" required>
                                        </div>

                                        <div class="mb-3">
                                            <label class="form-label fw-bold">Số điện thoại</label>
                                            <input type="text" class="form-control" name="phone"
                                                   value="${sessionScope.user.phone}">
                                        </div>

                                        <div class="mb-3">
                                            <label class="form-label fw-bold">Địa chỉ</label>
                                            <input type="text" class="form-control" name="address"
                                                   value="${sessionScope.user.address}">
                                        </div>

                                        <div class="text-end">
                                            <button type="submit" class="btn btn-primary"><i
                                                    class="fas fa-save me-1"></i> Lưu thay đổi
                                            </button>
                                        </div>
                                    </form>
                                </div>

                                <div class="tab-pane fade" id="password">
                                    <form action="accountAD" method="post">
                                        <input type="hidden" name="action" value="changePassword">
                                        <div class="mb-3">
                                            <label class="form-label fw-bold">Mật khẩu hiện tại</label>
                                            <input type="password" class="form-control" name="currentPass" required>
                                        </div>
                                        <div class="mb-3">
                                            <label class="form-label fw-bold">Mật khẩu mới</label>
                                            <input type="password" class="form-control" name="newPass" required>
                                        </div>
                                        <div class="mb-3">
                                            <label class="form-label fw-bold">Xác nhận mật khẩu mới</label>
                                            <input type="password" class="form-control" name="confirmPass" required>
                                        </div>
                                        <div class="alert alert-warning small">
                                            <i class="fas fa-shield-alt me-1"></i> Mật khẩu nên có ít nhất 6 ký tự.
                                        </div>
                                        <div class="text-end">
                                            <button type="submit" class="btn btn-danger"><i
                                                    class="fas fa-check me-1"></i> Xác nhận đổi
                                            </button>
                                        </div>
                                    </form>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </main>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>