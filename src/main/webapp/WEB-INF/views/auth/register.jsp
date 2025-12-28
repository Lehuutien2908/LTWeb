<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Đăng ký tài khoản - Flagship Global</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css">
</head>
<body class="bg-light">
    <jsp:include page="/WEB-INF/views/common/header.jsp" />

    <main class="container py-5">
        <div class="row justify-content-center">
            <div class="col-md-6">
                <div class="card border-0 shadow-sm" style="border-radius: 15px;">
                    <div class="card-body p-5">
                        <h3 class="fw-bold text-center text-uppercase mb-4">Tạo tài khoản mới</h3>

                        <form action="${pageContext.request.contextPath}/register" method="POST">
                            <div class="row">
                                <div class="col-md-6 mb-3">
                                    <label class="form-label small fw-bold">Họ và tên</label>
                                    <input type="text" name="fullname" class="form-control border-2" style="border-radius: 10px;" required>
                                </div>
                                <div class="col-md-6 mb-3">
                                    <label class="form-label small fw-bold">Số điện thoại</label>
                                    <input type="tel" name="phone" class="form-control border-2" style="border-radius: 10px;" required>
                                </div>
                            </div>
                            <div class="mb-3">
                                <label class="form-label small fw-bold">Email</label>
                                <input type="email" name="email" class="form-control border-2" style="border-radius: 10px;" required>
                            </div>
                            <div class="mb-3">
                                <label class="form-label small fw-bold">Mật khẩu</label>
                                <input type="password" name="password" class="form-control border-2" style="border-radius: 10px;" required>
                            </div>
                            <div class="mb-4">
                                <label class="form-label small fw-bold">Xác nhận mật khẩu</label>
                                <input type="password" name="confirmPassword" class="form-control border-2" style="border-radius: 10px;" required>
                            </div>
                            <div class="mb-4 form-check">
                                <input type="checkbox" class="form-check-input" id="terms" required>
                                <label class="form-check-label small" for="terms">Tôi đồng ý với các điều khoản của Flagship Global</label>
                            </div>
                            <button type="submit" class="btn btn-danger w-100 fw-bold py-3 text-uppercase shadow-sm" style="border-radius: 10px;">Hoàn tất đăng ký</button>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </main>

    <jsp:include page="/WEB-INF/views/common/footer.jsp" />
</body>
</html>