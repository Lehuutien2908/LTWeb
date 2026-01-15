<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="vi">
<head>
  <meta charset="UTF-8">
  <title>Đặt hàng thành công - Flagship Global</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
  <style>
    .success-icon { font-size: 60px; color: #28a745; margin-bottom: 20px; }
    .sidebar-box { background: #fff; border: 1px solid #eee; border-radius: 8px; }
    .table img { width: 50px; height: 50px; object-fit: cover; border: 1px solid #ddd; }
  </style>
</head>
<body>

<jsp:include page="../common/header.jsp"></jsp:include>

<main class="container py-5">
  <div class="text-center mb-5">
    <i class="fa-regular fa-circle-check success-icon"></i>
    <h2 class="fw-bold text-uppercase">Đặt hàng thành công!</h2>
    <p class="text-muted">Cảm ơn bạn đã mua hàng tại Flagship Global.</p>
    <a href="${pageContext.request.contextPath}/home" class="btn btn-outline-dark mt-2">
      <i class="fa-solid fa-house"></i> Về trang chủ
    </a>
  </div>

  <div class="row">
    <div class="col-md-4">
      <div class="sidebar-box p-4 h-100">
        <h5 class="fw-bold text-uppercase mb-3" style="color: #d9534f;">Thông tin nhận hàng</h5>
        <p><strong>Mã đơn:</strong> #${order.id}</p>
        <p><strong>Người nhận:</strong> ${order.fullName}</p>
        <p><strong>SĐT:</strong> ${order.phone}</p>
        <p><strong>Địa chỉ:</strong> ${order.address}</p>
      </div>
    </div>

    <div class="col-md-8">
      <div class="sidebar-box p-4 h-100">
        <h5 class="fw-bold text-uppercase mb-3" style="color: #d9534f;">Chi tiết đơn hàng</h5>
        <table class="table table-borderless align-middle">
          <thead class="border-bottom">
          <tr>
            <th>Sản phẩm</th>
            <th class="text-center">Số lượng</th>
            <th class="text-end">Đơn giá</th>
            <th class="text-end">Thành tiền</th>
          </tr>
          </thead>
          <tbody>

          <%-- SỬA: Dùng biến orderItems được gửi từ Controller --%>
          <c:forEach items="${orderItems}" var="item">
            <tr class="border-bottom">
              <td>
                <div class="d-flex align-items-center">
                    <%-- Lưu ý: Kiểm tra lại đường dẫn ảnh của bạn --%>
                  <img src="${item.product.image}" class="me-2 rounded" onerror="this.src='https://placehold.co/50'">
                  <span class="fw-bold" style="font-size: 14px;">${item.product.name}</span>
                </div>
              </td>
              <td class="text-center">x${item.quantity}</td>
              <td class="text-end">
                <fmt:formatNumber value="${item.product.price}" type="currency" currencySymbol="₫"/>
              </td>
              <td class="text-end fw-bold" style="color: #d9534f;">
                  <%-- Dùng hàm getTotalPrice() trong CartItem --%>
                <fmt:formatNumber value="${item.totalPrice}" type="currency" currencySymbol="₫"/>
              </td>
            </tr>
          </c:forEach>

          </tbody>
          <tfoot>
          <tr>
            <td colspan="3" class="text-end fw-bold pt-3 fs-5">TỔNG CỘNG:</td>
            <td class="text-end fw-bold pt-3 fs-4" style="color: #d9534f;">
              <fmt:formatNumber value="${order.totalMoney}" type="currency" currencySymbol="₫"/>
            </td>
          </tr>
          </tfoot>
        </table>
      </div>
    </div>
  </div>
</main>

<jsp:include page="../common/footer.jsp"></jsp:include>

</body>
</html>