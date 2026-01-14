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
        .form-control { border-radius: 10px; border: 2px solid #eee; padding: 10px 15px; font-size: 15px; }
        .form-control:focus { border-color: #dc3545; box-shadow: none; }
        .btn-auth { border-radius: 10px; padding: 12px; font-weight: bold; transition: 0.3s; }
        .info-box { background-color: #f8f9fa; border-left: 4px solid #dc3545; border-radius: 8px; }
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

                    <%-- Hiển thị thông báo lỗi từ Servlet --%>
                    <c:if test="${not empty error}">
                        <div class="alert alert-danger py-2 small text-center" style="border-radius: 10px;">
                            <i class="bi bi-exclamation-circle me-1"></i> ${error}
                        </div>
                    </c:if>

                    <form action="${pageContext.request.contextPath}/register" method="POST">
                        <div class="mb-3">
                            <label class="form-label small fw-bold text-uppercase">Họ và tên</label>
                            <input type="text" name="fullname" class="form-control"
                                   placeholder="Nhập họ tên của bạn" value="${oldFullname}" required>
                        </div>

                        <div class="mb-4">
                            <label class="form-label small fw-bold text-uppercase">Địa chỉ Email</label>
                            <input type="email" name="email" class="form-control"
                                   placeholder="name@example.com" value="${oldEmail}" required>
                        </div>

                        <%-- Thông báo cho người dùng biết mật khẩu sẽ được gửi đi --%>
                        <div class="info-box p-3 mb-4">
                            <div class="d-flex">
                                <i class="bi bi-info-circle-fill text-danger me-2"></i>
                                <p class="small mb-0 text-muted">
                                    <strong>Lưu ý:</strong> Hệ thống sẽ tự động tạo mật khẩu 8 số và gửi trực tiếp về email của bạn ngay sau khi nhấn đăng ký thành công.
                                </p>
                            </div>
                        </div>

                        <button type="submit" class="btn btn-danger btn-auth w-100 text-uppercase shadow-sm">
                            <i class="bi bi-envelope-plus me-2"></i>Nhận mật khẩu qua Email
                        </button>
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