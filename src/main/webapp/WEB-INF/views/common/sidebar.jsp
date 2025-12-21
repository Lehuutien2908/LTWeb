<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<aside>
    <div class="sidebar-box shadow-sm mb-4">
        <div class="sidebar-title">Hỗ trợ trực tuyến</div>
        <div class="p-3">
            <div class="support-item d-flex align-items-center mb-3">
                <div class="me-3">
                    <i class="bi bi-headset text-danger fs-3"></i>
                </div>
                <div>
                    <div class="small text-muted">Tư vấn bán hàng</div>
                    <div class="fw-bold text-danger">1900 6750</div>
                </div>
            </div>

            <div class="support-item d-flex align-items-center">
                <div class="me-3">
                    <i class="bi bi-envelope-at text-danger fs-3"></i>
                </div>
                <div>
                    <div class="small text-muted">Email liên hệ</div>
                    <div class="fw-bold" style="font-size: 13px;">support@projectltw.vn</div>
                </div>
            </div>
        </div>
    </div>

    <div class="sidebar-box shadow-sm">
        <div class="sidebar-title">Siêu giảm giá</div>
        <div class="p-2">
            <%-- Đổi từ saleList thành saleProducts để khớp với HomeServlet --%>
            <c:forEach var="p" items="${saleProducts}" varStatus="status">
                <div class="d-flex mb-3 ${not status.last ? 'border-bottom pb-2' : ''} align-items-center">
                    <img src="${pageContext.request.contextPath}/assets/images/${p.image}"
                         style="width: 70px; height: 70px; object-fit: contain;"
                         class="me-2 rounded border" alt="${p.name}">
                    <div>
                        <a href="${pageContext.request.contextPath}/product-detail?id=${p.id}" class="text-decoration-none">
                            <div class="small fw-bold text-dark text-truncate-2"
                                 style="display: -webkit-box; -webkit-line-clamp: 2; -webkit-box-orient: vertical; overflow: hidden; line-height: 1.2;">
                                ${p.name}
                            </div>
                        </a>

                        <%-- Giá hiện tại --%>
                        <div class="text-danger fw-bold small">
                            <fmt:formatNumber value="${p.price}" type="currency" currencySymbol="" maxFractionDigits="0"/>₫
                        </div>

                        <%-- Giá gốc ảo (Giá hiện tại + 10%) --%>
                        <div class="text-muted small text-decoration-line-through" style="font-size: 11px;">
                            <fmt:formatNumber value="${p.price * 1.1}" type="currency" currencySymbol="" maxFractionDigits="0"/>₫
                        </div>
                    </div>
                </div>
            </c:forEach>

            <%-- Trường hợp danh sách trống --%>
            <c:if test="${empty saleProducts}">
                <div class="p-3 text-center text-muted small">Đang cập nhật khuyến mãi...</div>
            </c:if>
        </div>
    </div>
</aside>