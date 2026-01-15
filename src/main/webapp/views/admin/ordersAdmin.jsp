<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quản Lý Đơn Hàng</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <link rel="stylesheet" href="/assets/css/admin/ordersAD.css">
</head>
<body class="bg-light">

<jsp:include page="headerAD.jsp" />

<div class="container-fluid">
    <div class="row">

        <jsp:include page="sidebarAD.jsp">
            <jsp:param name="activePage" value="orders" />
        </jsp:include>

        <main class="col-md-9 ms-sm-auto col-lg-10 px-md-4 py-4">

            <div class="d-flex justify-content-between align-items-center mb-4">
                <h2 class="h4 mb-0 text-gray-800 border-start border-primary border-3 ps-3">
                    Quản Lý Đơn Hàng
                </h2>

                <form class="d-flex" role="search">
                    <input class="form-control me-2" type="search" placeholder="Mã đơn / Tên khách..." aria-label="Search" style="width: 250px;">
                    <button class="btn btn-outline-primary" type="submit"><i class="fas fa-search"></i></button>
                </form>
            </div>

            <c:if test="${not empty message}">
                <div class="alert alert-success alert-dismissible fade show shadow-sm" role="alert">
                    <i class="fas fa-check-circle me-2"></i> ${message}
                    <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                </div>
            </c:if>

            <div class="card card-orders mb-4">
                <div class="card-body p-0">
                    <div class="table-responsive">
                        <table class="table table-orders align-middle mb-0">
                            <thead class="table-head-custom">
                            <tr>
                                <th>Mã Đơn</th>
                                <th>Khách Hàng</th>
                                <th>Ngày Đặt</th>
                                <th>SL SP</th>
                                <th>Tổng Tiền</th>
                                <th class="text-center">Trạng Thái</th>
                                <th class="text-center">Tác Vụ</th>
                            </tr>
                            </thead>
                            <tbody>
                            <c:forEach items="${listOrders}" var="o">
                                <tr>
                                    <td class="order-id">#${o.id}</td>

                                    <td class="fw-bold text-dark">${o.fullName}</td>

                                    <td class="text-secondary small">
                                        <i class="far fa-calendar-alt me-1"></i> ${o.date}
                                    </td>

                                    <td class="text-center fw-bold text-primary">
                                            ${o.totalQuantity}
                                    </td>

                                    <td class="fw-bold text-danger">
                                        <fmt:formatNumber value="${o.totalMoney}" type="currency" currencySymbol="₫"/>
                                    </td>

                                    <td class="text-center">
                                        <c:choose>
                                            <c:when test="${o.status == 0}">
                                                <span class="badge-status status-pending"><i class="fas fa-times-circle"></i> Chờ duyệt</span>
                                            </c:when>
                                            <c:when test="${o.status == 1}">
                                                <span class="badge-status status-shipping"><i class="fas fa-clock"></i> Đang giao</span>
                                            </c:when>
                                            <c:when test="${o.status == 2}">
                                                <span class="badge-status status-success"><i class="fas fa-truck"></i> Đã giao</span>
                                            </c:when>
                                            <c:when test="${o.status == 3}">
                                                <span class="badge-status status-cancel"><i class="fas fa-check-circle"></i> Đã hủy</span>
                                            </c:when>
                                        </c:choose>
                                    </td>

                                    <td class="text-center">
                                        <button class="btn btn-action btn-outline-primary"
                                                title="Xem & Cập nhật"
                                                data-bs-toggle="modal"
                                                data-bs-target="#orderModal"
                                                onclick="viewOrder('${o.id}', '${o.fullName}', '${o.phone}', '${o.address}', ${o.totalMoney}, ${o.status}, '${o.listProductNames}')">
                                            <i class="fas fa-eye"></i>
                                        </button>
                                    </td>
                                </tr>
                            </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>

        </main>
    </div>
</div>

<div class="modal fade" id="orderModal" tabindex="-1" aria-hidden="true">
    <div class="modal-dialog modal-lg"> <div class="modal-content">

        <div class="modal-header bg-primary text-white">
            <h5 class="modal-title fw-bold">Chi Tiết Đơn Hàng <span id="modalOrderId" class="text-warning"></span></h5>
            <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
        </div>

        <form action="orders" method="post">
            <input type="hidden" name="action" value="updateStatus">
            <input type="hidden" name="id" id="formOrderId">

            <div class="modal-body">
                <div class="row">
                    <div class="col-md-6 border-end">
                        <h6 class="text-primary fw-bold mb-3"><i class="fas fa-user mb-1"></i> Thông tin khách hàng</h6>
                        <p class="mb-1"><strong>Tên:</strong> <span id="modalCustomerName"></span></p>
                        <p class="mb-1"><strong>SĐT:</strong> <span id="modalPhone"></span></p>
                        <p class="mb-2"><strong>Địa chỉ:</strong> <span id="modalAddress"></span></p>

                        <div class="p-2 bg-light border rounded mt-3">
                            <h6 class="small fw-bold text-secondary mb-1">Danh sách sản phẩm:</h6>
                            <span id="modalProducts" class="text-dark fw-bold" style="font-size: 0.95rem;"></span>
                        </div>

                        <hr>
                        <h6 class="text-danger fw-bold"><i class="fas fa-money-bill-wave mb-1"></i> Tổng tiền: <span id="modalTotalPrice"></span> ₫</h6>
                    </div>

                    <div class="col-md-6 ps-4">
                        <h6 class="text-primary fw-bold mb-3"><i class="fas fa-edit mb-1"></i> Cập nhật trạng thái</h6>

                        <div class="mb-3">
                            <label class="form-label text-muted">Trạng thái hiện tại:</label>
                            <select class="form-select" name="status" id="modalStatus">
                                <option value="0">Chờ duyệt (Pending)</option>
                                <option value="1">Đang giao hàng (Shipping)</option>
                                <option value="2">Đã giao thành công (Delivered)</option>
                                <option value="3">Hủy đơn hàng (Cancelled)</option>
                            </select>
                        </div>

                        <div class="alert alert-warning small mt-3">
                            <i class="fas fa-exclamation-triangle"></i> Lưu ý: Kiểm tra kỹ trước khi cập nhật trạng thái "Đã hủy" hoặc "Hoàn thành".
                        </div>
                    </div>
                </div>
            </div>

            <div class="modal-footer bg-light">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Đóng</button>
                <button type="submit" class="btn btn-primary fw-bold">Lưu Thay Đổi</button>
            </div>
        </form>
    </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script>
    const formatter = new Intl.NumberFormat('vi-VN', {
        style: 'decimal',
    });

    function viewOrder(id, name, phone, address, total, status, productNames) {
        document.getElementById("modalOrderId").innerText = "#" + id;
        document.getElementById("formOrderId").value = id;

        document.getElementById("modalCustomerName").innerText = name;
        document.getElementById("modalPhone").innerText = phone || "Không có SĐT";
        document.getElementById("modalAddress").innerText = address || "Tại cửa hàng";

        document.getElementById("modalTotalPrice").innerText = formatter.format(total);

        document.getElementById("modalStatus").value = status;

        document.getElementById("modalProducts").innerText = productNames;
    }
</script>

</body>
</html>