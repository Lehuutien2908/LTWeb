<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Đăng nhập - Flagship Global</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css">

    <style>
        /* CSS bổ sung cho các nút mạng xã hội */
        .divider:after, .divider:before { content: ""; flex: 1; height: 1px; background: #eee; }
        .btn-social {
            width: 50px;
            height: 50px;
            display: flex;
            align-items: center;
            justify-content: center;
            border-radius: 10px; /* Bo tròn đồng bộ 10px */
            border: 1px solid #ddd;
            background: #fff;
            transition: 0.3s;
            font-size: 20px;
        }
        .btn-social:hover { transform: translateY(-3px); box-shadow: 0 4px 8px rgba(0,0,0,0.1); }
        .btn-google:hover { color: #DB4437; border-color: #DB4437; }
        .btn-facebook:hover { color: #4267B2; border-color: #4267B2; }
        .btn-apple:hover { color: #000; border-color: #000; }
        .btn-github:hover { color: #333; border-color: #333; }
    </style>
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
                            <div class="alert alert-danger small py-2 text-center">${error}</div>
                        </c:if>

                        <form action="${pageContext.request.contextPath}/login" method="POST">
                            <div class="mb-3">
                                <label class="form-label small fw-bold text-uppercase">Tên đăng nhập / Email</label>
                                <input type="text" name="username" class="form-control form-control-lg border-2" style="border-radius: 10px; font-size: 15px;" required>
                            </div>
                            <div class="mb-3">
                                <div class="d-flex justify-content-between">
                                    <label class="form-label small fw-bold text-uppercase">Mật khẩu</label>
                                    <a href="forgot-password" class="small text-danger text-decoration-none fw-bold">Quên?</a>
                                </div>
                                <input type="password" name="password" class="form-control form-control-lg border-2" style="border-radius: 10px; font-size: 15px;" required>
                            </div>
                            <div class="mb-4 form-check">
                                <input type="checkbox" class="form-check-input" id="rememberMe">
                                <label class="form-check-label small text-muted" for="rememberMe">Ghi nhớ đăng nhập</label>
                            </div>
                            <button type="submit" class="btn btn-danger w-100 fw-bold py-3 text-uppercase shadow-sm mb-3" style="border-radius: 10px;">Đăng nhập ngay</button>

                            <div class="divider d-flex align-items-center my-4">
                                <p class="text-center small fw-bold mx-3 mb-0 text-muted">HOẶC ĐĂNG NHẬP BẰNG</p>
                            </div>

                            <div class="d-flex justify-content-center gap-3">
                                <a href="#" class="btn-social btn-google text-decoration-none" title="Google">
                                    <i class="bi bi-google"></i>
                                </a>
                                <a href="#" class="btn-social btn-facebook text-decoration-none" title="Facebook">
                                    <i class="bi bi-facebook"></i>
                                </a>
                                <a href="#" class="btn-social btn-apple text-decoration-none" title="Apple ID">
                                    <i class="bi bi-apple"></i>
                                </a>
                                <a href="#" class="btn-social btn-github text-decoration-none" title="Github">
                                    <i class="bi bi-github"></i>
                                </a>
                            </div>
                        </form>

                        <div class="text-center mt-4 pt-2">
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