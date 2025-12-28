<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Đăng nhập - Flagship Global</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css">
</head>
<body class="bg-light">
    <jsp:include page="/WEB-INF/views/common/header.jsp" />

    <main class="container py-5">
        <div class="row justify-content-center">
            <div class="col-md-5">
                <div class="card border-0 shadow-sm" style="border-radius: 15px;">
                    <div class="card-body p-5">
                        <div class="text-center mb-4">
                            <h3 class="fw-bold text-uppercase">Đăng nhập</h3>
                            <p class="text-muted small">Chào mừng bạn quay trở lại với Flagship Global</p>
                        </div>

                        <c:if test="${not empty error}">
                            <div class="alert alert-danger small py-2">${error}</div>
                        </c:if>

                        <form action="${pageContext.request.contextPath}/login" method="POST">
                            <div class="mb-3">
                                <label class="form-label small fw-bold">Tên đăng nhập / Email</label>
                                <input type="text" name="username" class="form-control form-control-lg border-2" style="border-radius: 10px; font-size: 15px;" required>
                            </div>
                            <div class="mb-3">
                                <div class="d-flex justify-content-between">
                                    <label class="form-label small fw-bold">Mật khẩu</label>
                                    <a href="forgot-password" class="small text-danger text-decoration-none">Quên mật khẩu?</a>
                                </div>
                                <input type="password" name="password" class="form-control form-control-lg border-2" style="border-radius: 10px; font-size: 15px;" required>
                            </div>
                            <div class="mb-4 form-check">
                                <input type="checkbox" class="form-check-input" id="rememberMe">
                                <label class="form-check-label small" for="rememberMe">Ghi nhớ đăng nhập</label>
                            </div>
                            <button type="submit" class="btn btn-danger w-100 fw-bold py-3 text-uppercase shadow-sm" style="border-radius: 10px;">Đăng nhập ngay</button>
                        </form>

                        <div class="text-center mt-4">
                            <span class="small text-muted">Chưa có tài khoản?</span>
                            <a href="register" class="small text-danger fw-bold text-decoration-none ms-1">Đăng ký ngay</a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </main>

    <jsp:include page="/WEB-INF/views/common/footer.jsp" />
</body>
</html>