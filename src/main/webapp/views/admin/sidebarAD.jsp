<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<nav id="sidebarMenu" class="col-md-3 col-lg-2 d-md-block bg-light sidebar collapse">
    <div class="position-sticky pt-3 sidebar-sticky">
        <ul class="nav flex-column">
            <li class="nav-item">
                <a class="nav-link" href="${pageContext.request.contextPath}/admin/dashboard">
                    <i class="fas fa-home"></i> Tổng quan
                </a>
            </li>

            <li class="nav-item">
                <a class="nav-link ${param.activePage == 'products' ? 'active' : ''}"
                   href="${pageContext.request.contextPath}/admin/products">
                    <i class="fas fa-mobile-alt"></i> Sản phẩm
                </a>
            </li>

            <li class="nav-item">
                <a class="nav-link ${param.activePage == 'orders' ? 'active' : ''}"
                   href="${pageContext.request.contextPath}/admin/orders">
                    <i class="fas fa-shopping-cart"></i> Đơn hàng
                </a>
            </li>

            <li class="nav-item">
                <a class="nav-link ${param.activePage == 'users' ? 'active' : ''}"
                   href="${pageContext.request.contextPath}/admin/users">
                    <i class="fas fa-users"></i> Khách hàng
                </a>
            </li>
        </ul>

        <h6 class="sidebar-heading d-flex justify-content-between align-items-center px-3 mt-4 mb-1 text-muted text-uppercase">
            <span>Cài đặt</span>
        </h6>
        <ul class="nav flex-column mb-2">
            <li class="nav-item">
                <a class="nav-link" href="#">
                    <i class="fas fa-user-cog"></i> Tài khoản Admin
                </a>
            </li>
        </ul>
    </div>
</nav>