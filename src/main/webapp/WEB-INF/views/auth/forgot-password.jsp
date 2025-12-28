<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Quên mật khẩu - Flagship Global</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css">
</head>
<body class="bg-light">
    <jsp:include page="/WEB-INF/views/common/header.jsp" />

    <main class="container py-5">
        <div class="row justify-content-center">
            <div class="col-md-5">
                <div class="card border-0 shadow-sm" style="border-radius: 15px;">
                    <div class="card-body p-5 text-center">
                        <div class="mb-4 text-danger">
                            <i class="bi bi-shield-lock fs-1"></i>
                        </div>
                        <h4 class="fw-bold mb-3">Quên mật khẩu?</h4>
                        <p class="text-muted small mb-4">Nhập email của bạn để nhận hướng dẫn đặt lại mật khẩu mới.</p>

                        <form action="reset-request" method="POST">
                            <div class="mb-4">
                                <input type="email" name="email" class="form-control border-2 text-center" placeholder="Email của bạn" style="border-radius: 10px;" required>
                            </div>
                            <button type="submit" class="btn btn-danger w-100 fw-bold py-2 mb-3" style="border-radius: 10px;">Gửi yêu cầu</button>
                            <a href="login" class="small text-muted text-decoration-none"><i class="bi bi-arrow-left"></i> Quay lại đăng nhập</a>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </main>

    <jsp:include page="/WEB-INF/views/common/footer.jsp" />
</body>
</html>