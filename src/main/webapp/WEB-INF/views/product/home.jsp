<%-- src/main/webapp/WEB-INF/views/product/home.jsp --%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>

<%-- BƯỚC 1: GỌI HEADER (Chứa CSS và Menu trên) --%>
<jsp:include page="../common/header.jsp" />

<%-- BƯỚC 2: NỘI DUNG CHÍNH CỦA TRANG CHỦ --%>
<main class="main-content">
    <div class="container">

        <div class="row">
            <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">

                <section class="section_slider home-slider margin-bottom-40">
                    <div class="swiper-container swiper_slider">
                        <div class="swiper-wrapper">

                            <%-- SLIDE 1 --%>
                            <div class="swiper-slide" data-swiper-slide-index="0">
                                <a href="#" title="Banner 1">
                                    <%-- Sử dụng LazyLoad: data-src thay vì src --%>
                                    <img class="lazyload" data-src="${contextPath}/assets/images/banner/slide-01.jpg" alt="Slide 1">
                                </a>
                            </div>

                            <%-- SLIDE 2 --%>
                            <div class="swiper-slide" data-swiper-slide-index="1">
                                <a href="#" title="Banner 2">
                                    <img class="lazyload" data-src="${contextPath}/assets/images/banner/slide-02.jpg" alt="Slide 2">
                                </a>
                            </div>

                        </div>

                        <div class="swiper-button-prev"></div>
                        <div class="swiper-button-next"></div>

                        <div class="swiper-pagination"></div>
                    </div>
                </section>

            </div>
        </div>

        <div class="row">
            <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
                <section class="section_policy hidden-xs">
                    <div class="row">

                        <div class="col-lg-3 col-md-3 col-sm-6 col-xs-12">
                            <div class="policy">
                                <span class="policy-icon">
                                    <svg viewBox="0 0 576 512"><path fill="currentColor" d="M565.4 397.4l-31-155c-2.2-11-12.8-18.4-23.7-18.4h-54.8c-1.4-9.2-8.5-16.5-18.4-16.5H192c-9.9 0-17 7.3-18.4 16.5h-54.8c-11 0-21.6 7.4-23.7 18.4l-31 155c-1.8 9.2 1.3 18.7 8.1 24.5 6.8 5.8 16 7.2 24.8 3.6l.4-.2c17.5-7.3 36.4-11.4 56.4-11.4 20.1 0 39 4.1 56.5 11.4l.4.2c8.8 3.6 18 2.2 24.8-3.6 6.8-5.8 9.9-15.3 8.1-24.5zM480 320c-11.7 0-21.3-9.6-21.3-21.3 0-11.7 9.6-21.3 21.3-21.3s21.3 9.6 21.3 21.3c0 11.8-9.6 21.3-21.3 21.3zm0 64c-11.7 0-21.3-9.6-21.3-21.3 0-11.7 9.6-21.3 21.3-21.3s21.3 9.6 21.3 21.3c0 11.8-9.6 21.3-21.3 21.3zm-64-64c-11.7 0-21.3-9.6-21.3-21.3 0-11.7 9.6-21.3 21.3-21.3s21.3 9.6 21.3 21.3c0 11.8-9.6 21.3-21.3 21.3zm0 64c-11.7 0-21.3-9.6-21.3-21.3 0-11.7 9.6-21.3 21.3-21.3s21.3 9.6 21.3 21.3c0 11.8-9.6 21.3-21.3 21.3z" class=""></path></svg>
                                </span>
                                <div class="policy-text">
                                    <h4>MIỄN PHÍ VẬN CHUYỂN</h4>
                                    <span>Cho đơn hàng trên 500k</span>
                                </div>
                            </div>
                        </div>

                        <div class="col-lg-3 col-md-3 col-sm-6 col-xs-12">
                            <div class="policy">
                                <span class="policy-icon">
                                    <svg viewBox="0 0 512 512"><path fill="currentColor" d="M352 144c-19.1 0-38.3 4.2-55.8 12.8-17.5 8.6-32.9 21.5-44.2 37.8-11.3 16.3-19.1 35.8-22.3 56.8-3.2 21 1.7 42.6 13.5 61.5 11.8 19 28.5 35.3 47.5 47.1 19 11.7 41.2 16.7 63.8 14.8 22.6-1.9 44.8-10.4 62.2-24.8 17.4-14.4 30.8-33.8 39.4-55.8 8.6-22-3.1-46.7-27.1-57.8C424 192 352 192 352 144zm0 64c12.2 0 24.3 2.1 35.5 6.4 11.2 4.3 21.2 10.6 29.8 19.3 8.6 8.6 15 18.7 19.3 30.1 4.3 11.4 6.4 23.5 6.4 35.7s-2.1 24.3-6.4 35.7c-4.3 11.4-10.7 21.4-19.3 30.1-8.6 8.6-18.7 15-30.1 19.3-11.4 4.3-23.5 6.4-35.7 6.4s-24.3-2.1-35.7-6.4c-11.4-4.3-21.4-10.7-30.1-19.3-8.6-8.6-15-18.7-19.3-30.1-4.3-11.4-6.4-23.5-6.4-35.7s2.1-24.3 6.4-35.7c4.3-11.4 10.7-21.4 19.3-30.1 8.6-8.6 18.7-15 30.1-19.3C327.7 206.1 339.8 204 352 204z" class=""></path></svg>
                                </span>
                                <div class="policy-text">
                                    <h4>THANH TOÁN AN TOÀN</h4>
                                    <span>100% bảo mật SSL</span>
                                </div>
                            </div>
                        </div>

                        <div class="col-lg-3 col-md-3 col-sm-6 col-xs-12">
                            <div class="policy">
                                <span class="policy-icon">
                                    <svg viewBox="0 0 512 512"><path fill="currentColor" d="M496 448H16c-8.8 0-16 7.2-16 16v32c0 8.8 7.2 16 16 16h480c8.8 0 16-7.2 16-16v-32c0-8.8-7.2-16-16-16zM32 288v96h448v-96H32zM480 96H32c-17.7 0-32 14.3-32 32v32c0 17.7 14.3 32 32 32h448c17.7 0 32-14.3 32-32v-32c0-17.7-14.3-32-32-32zM32 32v32h448V32H32z" class=""></path></svg>
                                </span>
                                <div class="policy-text">
                                    <h4>ĐỔI TRẢ TRONG 7 NGÀY</h4>
                                    <span>Nếu có lỗi từ nhà sản xuất</span>
                                </div>
                            </div>
                        </div>

                        <div class="col-lg-3 col-md-3 col-sm-6 col-xs-12">
                            <div class="policy">
                                <span class="policy-icon">
                                    <svg viewBox="0 0 512 512"><path fill="currentColor" d="M504 256c0 136.9-111.1 248-248 248S8 392.9 8 256 119.1 8 256 8s248 111.1 248 248zm-151.7 17.7l-96-96c-4.7-4.7-12.3-4.7-17 0l-96 96c-4.7 4.7-4.7 12.3 0 17l16 16c4.7 4.7 12.3 4.7 17 0L256 211.3l80.3 80.4c4.7 4.7 12.3 4.7 17 0l16-16c4.7-4.7 4.7-12.3 0-17zM256 96c-13.3 0-24 10.7-24 24v192c0 13.3 10.7 24 24 24s24-10.7 24-24V120c0-13.3-10.7-24-24-24z" class=""></path></svg>
                                </span>
                                <div class="policy-text">
                                    <h4>HỖ TRỢ KHÁCH HÀNG</h4>
                                    <span>Hotline: 1900 1234</span>
                                </div>
                            </div>
                        </div>

                    </div>
                </section>
            </div>
        </div>

        <section class="section_main_product margin-bottom-40">

            <%-- Tiêu đề Module (Style 1: Màu đỏ nền) --%>
            <div class="module-header">
                 <h2 class="module-title title-style-1"><span>SẢN PHẨM BÁN CHẠY</span></h2>
                 <a href="#" class="view-more">Xem tất cả <i class="fa fa-angle-right"></i></a>
            </div>

            <%-- Nội dung Module (Lưới sản phẩm) --%>
            <div class="module-content">
                <div class="row row-noGutter">

                    <%-- Ví dụ Sản phẩm (Sản phẩm thực tế sẽ được thêm bằng JSTL) --%>
                    <c:forEach begin="1" end="8" var="i">
                        <div class="col-lg-3 col-md-4 col-sm-6 col-xs-6">
                            <div class="product-box">
                                <form action="#" method="post" class="variants">
                                    <div class="product-thumbnail">
                                        <a href="${contextPath}/product-detail/${i}" class="image_thumb" title="Sản phẩm mẫu ${i}">
                                            <%-- Image place holder (Dùng cho Lazy Load) --%>
                                            <img data-src="https://via.placeholder.com/300x300?text=Product+${i}" class="lazyload" alt="Sản phẩm mẫu ${i}">
                                        </a>
                                        <span class="sale-flash">-15%</span>

                                        <%-- Action Buttons (Chỉ hiển thị khi hover) --%>
                                        <div class="product-action">
                                            <div class="action-info">Chọn hoạt động</div>
                                            <button type="submit" class="btn-circle btn_view" data-title="Thêm vào giỏ" title="Thêm vào giỏ">
                                                <svg viewBox="0 0 512 512" width="11" height="11"><path fill="currentColor" d="M496 128H144L128 32h-16L128 64H16c-8.8 0-16 7.2-16 16v32c0 8.8 7.2 16 16 16h48l48 240c0 8.8 7.2 16 16 16h320c8.8 0 16-7.2 16-16V144c0-8.8-7.2-16-16-16z"/></svg>
                                            </button>
                                        </div>
                                    </div>

                                    <h3 class="product-name">
                                        <a href="${contextPath}/product-detail/${i}" title="Sản phẩm mẫu ${i}">Sản phẩm mẫu ${i}</a>
                                    </h3>

                                    <div class="product-info">
                                        <div class="price-box">
                                            <span class="special-price"><fmt:formatNumber value="${2500000 - i*100000}" type="currency" currencyCode="VND" maxFractionDigits="0"/></span>
                                            <span class="compare-price"><fmt:formatNumber value="2500000" type="currency" currencyCode="VND" maxFractionDigits="0"/></span>
                                        </div>
                                    </div>
                                </form>
                            </div>
                        </div>
                    </c:forEach>

                </div>
            </div>
        </section>

        <%-- KẾT THÚC NỘI DUNG CHÍNH --%>

    </div>
</main>

<%-- BƯỚC 3: GỌI FOOTER (Chứa HTML Footer và Liên kết JS) --%>
<jsp:include page="../common/footer.jsp" />