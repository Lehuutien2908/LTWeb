<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>404 - Không tìm thấy trang</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">
    <style>
        .error-container { min-height: 80vh; display: flex; align-items: center; justify-content: center; }
        .error-card { border-radius: 10px; border: none; box-shadow: 0 10px 30px rgba(0,0,0,0.1); }
        .btn-home { border-radius: 10px; background-color: #dc3545; color: white; transition: 0.3s; padding: 12px 30px; }
        .btn-home:hover { background-color: #b02a37; transform: translateY(-3px); color: white; }
    </style>
</head>
<body class="bg-light">
    <jsp:include page="/WEB-INF/views/common/header.jsp" />

    <div class="container error-container">
        <div class="col-md-6 text-center">
            <div class="card error-card p-5">
                <h1 class="display-1 fw-bold text-danger">404</h1>
                <h3 class="fw-bold text-dark">Úi! Trang này không tồn tại</h3>
                <p class="text-muted mb-4">Có vẻ như đường dẫn bạn truy cập đã bị lỗi hoặc không còn tồn tại trên hệ thống Flagship Global.</p>
                <div class="d-flex justify-content-center">
                    <a href="${pageContext.request.contextPath}/home" class="btn btn-home fw-bold text-uppercase">
                        <i class="bi bi-house-door me-2"></i> Quay về trang chủ
                    </a>
                </div>
            </div>
        </div>
    </div>

    <jsp:include page="/WEB-INF/views/common/footer.jsp" />
</body>
</html>