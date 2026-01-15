<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<% request.setCharacterEncoding("UTF-8"); %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Quên mật khẩu - Flagship Global</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/common/style.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/auth/auth.css">
</head>
<body class="bg-light">
    <jsp:include page="/views/common/header.jsp" />

    <main class="container py-5">
        <div class="row justify-content-center">
            <div class="col-md-5 col-lg-4">
                <div class="card border-0 shadow-sm auth-card">
                    <div class="card-body p-4 p-md-5">
                        <div class="text-center mb-4 text-danger">
                            <i class="bi bi-shield-lock auth-icon"></i>
                        </div>
                        <h4 class="fw-bold text-uppercase text-center mb-3">Khôi phục mật khẩu</h4>
                        <p class="text-muted small text-center mb-4">Nhập email của bạn để nhận hướng dẫn lấy lại mật khẩu.</p>

                        <c:if test="${not empty message}">
                            <div class="alert alert-success small py-2 text-center auth-alert">
                                <i class="bi bi-check-circle me-1"></i> ${message}
                            </div>
                        </c:if>
                        <c:if test="${not empty error}">
                            <div class="alert alert-danger small py-2 text-center auth-alert">
                                <i class="bi bi-exclamation-triangle me-1"></i> ${error}
                            </div>
                        </c:if>

                        <form action="${pageContext.request.contextPath}/forgot-password" method="POST">
                            <div class="mb-4">
                                <label class="form-label small fw-bold text-uppercase">Email đăng ký</label>
                                <input type="email" name="email" class="form-control border-2 auth-input"
                                       placeholder="" required>
                            </div>
                            <button type="submit" class="btn btn-danger w-100 fw-bold py-3 text-uppercase shadow-sm auth-btn">
                                Gửi yêu cầu
                            </button>
                        </form>

                        <div class="text-center mt-4">
                            <a href="${pageContext.request.contextPath}/login" class="small text-muted text-decoration-none fw-bold">
                                <i class="bi bi-arrow-left"></i> Quay lại đăng nhập
                            </a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </main>

    <jsp:include page="/views/common/footer.jsp" />
</body>
</html>