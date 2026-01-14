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
  <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css">
  <style>
    .success-icon { font-size: 60px; color: #28a745; margin-bottom: 20px; }
    .order-info-box { background: #fff; padding: 20px; border-radius: 8px; border: 1px solid #eee; }
    .table img { width: 50px; height: 50px; object-fit: cover; border: 1px solid #ddd; }
  </style>
</head>
<body>

<jsp:include page="../common/header.jsp"></jsp:include>

<main class="container py-5">
  <div class="text-center mb-5">
    <i class="fa-regular fa-circle-check success-icon"></i>
    <h2 class="fw-bold text-uppercase">Đặt hàng thành công!</h2>
    <p class="text-muted">Cảm ơn bạn đã mua hàng tại Flagship Global. Dưới đây là thông tin đơn hàng của bạn.</p>
    <a href="${pageContext.request.contextPath}/home" class="btn btn-outline-dark mt-2">
      <i class="fa-solid fa-house"></i> Về trang chủ
    </a>
  </div>

  <div class="row">
    <div class="col-md-4">
      <div class="sidebar-box p-4 h-100">
        <h5 class="fw-bold text-uppercase mb-3" style="color: var(--main-red);">Thông tin nhận hàng</h5>
        <p><strong>Mã đơn:</strong> #${order.id}</p>
        <p><strong>Người nhận:</strong> ${order.fullName}</p> <p><strong>SĐT:</strong> ${order.phone}</p>
        <p><strong>Địa chỉ:</strong> ${order.address}</p>
        <p><strong>Ghi chú:</strong> ${order.note}</p>
      </div>
    </div>

    <div class="col-md-8">
      <div class="sidebar-box p-4 h-100">
        <h5 class="fw-bold text-uppercase mb-3" style="color: var(--main-red);">Chi tiết đơn hàng</h5>
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
          <c:forEach items="${order.items}" var="item">
            <tr class="border-bottom">
              <td>
                <div class="d-flex align-items-center">
                  <img src="${pageContext.request.contextPath}/assets/images/${item.product.image}" class="me-2 rounded">
                  <span class="fw-bold" style="font-size: 14px;">${item.product.name}</span>
                </div>
              </td>
              <td class="text-center">x${item.quantity}</td>
              <td class="text-end">
                <fmt:formatNumber value="${item.product.price}" type="currency" currencySymbol="₫"/>
              </td>
              <td class="text-end fw-bold" style="color: var(--main-red);">
                <fmt:formatNumber value="${item.totalPrice}" type="currency" currencySymbol="₫"/>
              </td>
            </tr>
          </c:forEach>
          </tbody>
          <tfoot>
          <tr>
            <td colspan="3" class="text-end fw-bold pt-3 fs-5">TỔNG CỘNG:</td>
            <td class="text-end fw-bold pt-3 fs-4" style="color: var(--main-red);">
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