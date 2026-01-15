<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="vi">

<head>
    <meta charset="UTF-8">
    <title>Admin Dashboard</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
</head>

<body>
<fmt:setLocale value="vi_VN"/>
<jsp:include page="headerAD.jsp"/>
<div class="container-fluid">
    <div class="row">
        <jsp:include page="sidebarAD.jsp"/>

        <main class="col-md-10 ms-sm-auto px-md-4 py-4 bg-light">
            <h2 class="mb-4">Tổng quan hệ thống</h2>

            <div class="row g-4">
                <div class="col-md-3">
                    <div class="card text-white bg-primary mb-3 h-100">
                        <div class="card-header">Doanh thu</div>
                        <div class="card-body">
                            <h3 class="card-title">
                                <fmt:formatNumber value="${stats.totalRevenue}" type="number" maxFractionDigits="0"/>
                                VNĐ
                            </h3>
                            <p class="card-text">Tổng doanh thu tháng này</p>
                        </div>
                    </div>
                </div>

                <div class="col-md-3">
                    <div class="card text-white bg-success mb-3 h-100">
                        <div class="card-header">Đơn hàng mới</div>
                        <div class="card-body">
                            <h3 class="card-title">${stats.newOrders}</h3>
                            <p class="card-text">Đơn chưa xử lý</p>
                        </div>
                    </div>
                </div>

                <div class="col-md-3">
                    <div class="card text-dark bg-warning mb-3 h-100">
                        <div class="card-header">Khách hàng</div>
                        <div class="card-body">
                            <h3 class="card-title">${stats.totalUsers}</h3>
                            <p class="card-text">Thành viên đăng ký</p>
                        </div>
                    </div>
                </div>
            </div>

            <div class="mt-5">
                <h4>Thông báo mới</h4>
                <div class="alert alert-info">
                    Hệ thống đang hoạt động ổn định. Có <strong>${stats.lowStockProducts}</strong> sản phẩm sắp hết hàng
                    cần nhập thêm.
                </div>
            </div>
        </main>
    </div>
</div>
</body>

</html>