<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="vi">
<head>
  <meta charset="UTF-8">
  <title>Thanh Toán - Flagship Global</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
  <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css">

  <style>
    /* CSS bổ sung riêng cho trang checkout để đẹp hơn */
    .checkout-container {
      padding: 40px 0;
    }
    .form-control:focus {
      border-color: var(--main-red);
      box-shadow: 0 0 0 0.2rem rgba(227, 30, 36, 0.25);
    }
    .order-summary-row {
      border-bottom: 1px solid #eee;
      padding: 10px 0;
      display: flex;
      justify-content: space-between;
      align-items: center;
    }
    .order-summary-row:last-child {
      border-bottom: none;
    }
    .total-price {
      color: var(--main-red);
      font-size: 20px;
      font-weight: bold;
    }
    .btn-checkout {
      background: #E31E24 !important;
      color: white !important;
      font-weight: bold;
      text-transform: uppercase;
      padding: 12px;
      transition: 0.3s;
    }
    .btn-checkout:hover {
      background: var(--main-red-dark);
      color: white;
      transform: translateY(-2px);
      box-shadow: 0 4px 10px rgba(227, 30, 36, 0.3);
    }
    .product-mini-img {
      width: 50px;
      height: 50px;
      object-fit: cover;
      border: 1px solid #ddd;
      border-radius: 4px;
      margin-right: 10px;
    }
  </style>
</head>
<body>

<jsp:include page="../common/header.jsp"></jsp:include>

<main class="checkout-container">
  <div class="container">
    <div class="section-title mb-4">
      <h2><i class="fa-solid fa-money-check-dollar me-2"></i> Xác nhận thanh toán</h2>
    </div>

    <form action="checkout" method="POST">
      <div class="row">
        <div class="col-md-7">
          <div class="sidebar-box p-4 h-100">
            <h4 class="mb-4 text-uppercase fw-bold" style="color: #333; border-left: 4px solid var(--main-red); padding-left: 10px;">
              Thông tin giao hàng
            </h4>

            <div class="mb-3">
              <label for="fullname" class="form-label fw-bold">Họ và tên người nhận</label>
              <input type="text" class="form-control" id="name" name="fullname" placeholder="Ví dụ: Nguyễn Văn A" required>
            </div>

            <div class="mb-3">
              <label for="phone" class="form-label fw-bold">Số điện thoại</label>
              <input type="tel" class="form-control" id="phone" name="phone" placeholder="Ví dụ: 0987..." required>
            </div>

            <div class="mb-3">
              <label for="address" class="form-label fw-bold">Địa chỉ giao hàng</label>
              <textarea class="form-control" id="address" name="address" rows="2" placeholder="Số nhà, đường, phường/xã..." required></textarea>
            </div>

            <div class="mb-3">
              <label for="note" class="form-label fw-bold">Ghi chú (Tùy chọn)</label>
              <textarea class="form-control" id="note" name="note" rows="2" placeholder="Ví dụ: Giao giờ hành chính"></textarea>
            </div>
          </div>
        </div>

        <div class="col-md-5">
          <div class="sidebar-box p-4">
            <h4 class="mb-4 text-uppercase fw-bold" style="color: #333; border-left: 4px solid var(--main-red); padding-left: 10px;">
              Đơn hàng của bạn
            </h4>

            <div class="order-list mb-3" style="max-height: 300px; overflow-y: auto;">
              <c:if test="${sessionScope.cart != null}">
                <c:forEach items="${sessionScope.cart.items.values()}" var="item">
                  <div class="order-summary-row">
                    <div class="d-flex align-items-center">
                      <img src="${pageContext.request.contextPath}/assets/images/${item.product.image}"
                           class="product-mini-img" alt="Product">
                      <div>
                        <div class="fw-bold" style="font-size: 14px;">${item.product.name}</div>
                        <div class="text-muted" style="font-size: 12px;">x ${item.quantity}</div>
                      </div>
                    </div>
                    <div class="fw-bold">
                      <fmt:formatNumber value="${item.totalPrice}" type="currency" currencySymbol="₫"/>
                    </div>
                  </div>
                </c:forEach>
              </c:if>
            </div>

            <div class="order-summary-row mt-3 pt-3 border-top border-2">
              <span class="fw-bold">Tạm tính:</span>
              <span>
                                <fmt:formatNumber value="${sessionScope.cart.totalMoney}" type="currency" currencySymbol="₫"/>
                            </span>
            </div>
            <div class="order-summary-row">
              <span class="fw-bold">Phí vận chuyển:</span>
              <span class="text-success">Miễn phí</span>
            </div>
            <div class="order-summary-row mt-2">
              <span class="fw-bold" style="font-size: 18px;">TỔNG CỘNG:</span>
              <span class="total-price">
                                <fmt:formatNumber value="${sessionScope.cart.totalMoney}" type="currency" currencySymbol="₫"/>
                            </span>
            </div>

            <button type="submit" class="btn btn-checkout w-100 mt-4">
              XÁC NHẬN ĐẶT HÀNG
            </button>

            <div class="text-center mt-3">
              <a href="cart" class="text-muted" style="font-size: 13px; text-decoration: underline;">
                <i class="fa-solid fa-arrow-left"></i> Quay lại giỏ hàng
              </a>
            </div>
          </div>
        </div>
      </div>
    </form>
  </div>
</main>

<jsp:include page="../common/footer.jsp"></jsp:include>

</body>
</html>