<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Đăng ký - Flagship Global</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css">
    <style>
        .auth-card { border-radius: 15px; border: none; box-shadow: 0 4px 15px rgba(0,0,0,0.1); }
        /* Để áp dụng bo tròn 10px cho các ô nhập liệu */
        .form-control { border-radius: 10px; border: 2px solid #eee; padding: 10px 15px; font-size: 15px; }
        .form-control:focus { border-color: #dc3545; box-shadow: none; }
        .btn-auth { border-radius: 10px; padding: 12px; font-weight: bold; transition: 0.3s; }
    </style>
</head>
<body class="bg-light">
    <jsp:include page="/WEB-INF/views/common/header.jsp" />

    <main class="container py-5">
        <div class="row justify-content-center">
            <div class="col-md-6 col-lg-5">
                <div class="card auth-card p-4">
                    <div class="text-center mb-4">
                        <h2 class="fw-bold text-uppercase">Đăng ký thành viên</h2>
                        <p class="text-muted small">Khám phá công nghệ cùng Flagship Global</p>
                    </div>

                    <%-- Để hiển thị lỗi từ Servlet --%>
                    <c:if test="${not empty error}">
                        <div class="alert alert-danger py-2 small text-center" style="border-radius: 10px;">
                            <i class="bi bi-exclamation-circle me-1"></i> ${error}
                        </div>
                    </c:if>

                    <form action="${pageContext.request.contextPath}/register" method="POST">
                        <div class="mb-3">
                            <label class="form-label small fw-bold text-uppercase">Họ và tên</label>
                            <input type="text" name="fullname" class="form-control"
                                   placeholder="" value="${oldFullname}" required>
                        </div>
                        <div class="mb-3">
                            <label class="form-label small fw-bold text-uppercase">Địa chỉ Email</label>
                            <input type="email" name="email" class="form-control"
                                   placeholder="" value="${oldEmail}" required>
                        </div>

                        <div class="row">
                            <div class="col-md-6 mb-3">
                                <label class="form-label small fw-bold text-uppercase">Mật khẩu</label>
                                <input type="password" name="password" class="form-control" placeholder="" required>
                            </div>
                            <div class="col-md-6 mb-3">
                                <label class="form-label small fw-bold text-uppercase">Xác nhận</label>
                                <input type="password" name="confirmPassword" class="form-control" placeholder="" required>
                            </div>
                        </div>

                        <button type="submit" class="btn btn-danger btn-auth w-100 text-uppercase shadow-sm">Đăng ký ngay</button>
                    </form>

                    <div class="text-center mt-4">
                        <span class="small text-muted">Đã có tài khoản?</span>
                        <a href="${pageContext.request.contextPath}/login" class="small text-danger fw-bold text-decoration-none ms-1">Đăng nhập ngay</a>
                    </div>
                </div>
            </div>
        </div>
    </main>

    <jsp:include page="/WEB-INF/views/common/footer.jsp" />
</body>
</html>