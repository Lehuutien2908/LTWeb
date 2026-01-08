<%-- /WEB-INF/views/auth/forgot-password.jsp --%>
<div class="card border-0 shadow-sm" style="border-radius: 10px;">
    <div class="card-body p-5">
        <h4 class="fw-bold text-uppercase text-center mb-3">Khôi phục mật khẩu</h4>
        <p class="text-muted small text-center mb-4">Nhập email của bạn để nhận hướng dẫn lấy lại mật khẩu.</p>

        <c:if test="${not empty message}">
            <div class="alert alert-success small py-2 text-center" style="border-radius: 10px;">${message}</div>
        </c:if>
        <c:if test="${not empty error}">
            <div class="alert alert-danger small py-2 text-center" style="border-radius: 10px;">${error}</div>
        </c:if>

        <form action="${pageContext.request.contextPath}/forgot-password" method="POST">
            <div class="mb-4">
                <label class="form-label small fw-bold text-uppercase">Email đăng ký</label>
                <input type="email" name="email" class="form-control border-2" style="border-radius: 10px;" placeholder="example@gmail.com" required>
            </div>
            <button type="submit" class="btn btn-danger w-100 fw-bold py-3 text-uppercase" style="border-radius: 10px;">Gửi yêu cầu</button>
        </form>
        <div class="text-center mt-4">
            <a href="login" class="small text-muted text-decoration-none"><i class="bi bi-arrow-left"></i> Quay lại đăng nhập</a>
        </div>
    </div>
</div>