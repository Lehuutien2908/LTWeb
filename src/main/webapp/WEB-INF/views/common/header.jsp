<%-- src/main/webapp/WEB-INF/views/common/header.jsp --%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>LT Web - Trang Chủ</title>

    <link rel="stylesheet" href="${contextPath}/assets/css/main.css">
</head>
<body>

    <header class="site-header">

        <div class="topbar hidden-xs">
            <div class="container">
                <div class="row">
                    <div class="col-lg-6 col-md-6 col-sm-6 col-xs-12">
                        <ul class="list-inline">
                            <li><a href="#"><i class="fa fa-phone"></i> 0987 654 321</a></li>
                            <li><a href="#">Chào mừng bạn đến với LT Web!</a></li>
                        </ul>
                    </div>
                    <div class="col-lg-6 col-md-6 col-sm-6 col-xs-12 checkout text-right">
                        <ul class="list-inline">
                            <li>
                                <a href="${contextPath}/login">Đăng nhập</a> /
                                <a href="${contextPath}/register">Đăng ký</a>
                            </li>
                            </ul>
                    </div>
                </div>
            </div>
        </div>

        <div class="mainbar">
            <div class="container header_main">
                <div class="row header-main">

                    <div class="col-lg-3 col-md-3 col-sm-12 col-xs-12">
                        <a href="${contextPath}/" class="logo">
                            <img src="${contextPath}/assets/images/logo.png" alt="LT Web Logo" style="max-height: 50px;">
                        </a>
                    </div>

                    <div class="col-lg-6 col-md-6 hidden-sm hidden-xs search-header">
                        <div class="header_search">
                            <form action="${contextPath}/search" method="get">
                                <div class="input-group">
                                    <svg viewBox="0 0 512 512" width="14" height="14"><path fill="currentColor" d="M505 442.7L405.3 343c-4.5-4.5-10.6-7-17-7H372c27.6-35.3 44-79.6 44-128C416 93.1 322.9 0 208 0S0 93.1 0 208s93.1 208 208 208c48.4 0 92.7-16.4 128-44v16.3c0 6.4 2.5 12.5 7 17l99.7 99.7c9.4 9.4 24.6 9.4 33.9 0l28.3-28.3c9.4-9.4 9.4-24.6.1-34zM208 384c-97.3 0-176-78.7-176-176S110.7 32 208 32s176 78.7 176 176-78.7 176-176 176z"></path></svg>
                                    <input type="text" name="query" class="input-group-field search-text" placeholder="Tìm kiếm sản phẩm...">
                                    <div class="input-group-btn">
                                        <button class="btn" type="submit">Tìm kiếm</button>
                                    </div>
                                </div>
                            </form>
                        </div>
                    </div>

                    <div class="col-lg-3 col-md-3 hidden-sm hidden-xs text-right">
                        <div class="inline-block account-dr">
                            <a href="${contextPath}/account">
                                <svg width="20" height="20" viewBox="0 0 512 512"><path fill="currentColor" d="M256 0c-14.1 0-25.6 11.5-25.6 25.6v51.2c0 14.1 11.5 25.6 25.6 25.6s25.6-11.5 25.6-25.6V25.6C281.6 11.5 270.1 0 256 0zM128 448c-14.1 0-25.6 11.5-25.6 25.6v38.4c0 14.1 11.5 25.6 25.6 25.6h256c14.1 0 25.6-11.5 25.6-25.6v-38.4c0-14.1-11.5-25.6-25.6-25.6H128zm-64 0c-14.1 0-25.6 11.5-25.6 25.6v38.4c0 14.1 11.5 25.6 25.6 25.6h38.4c14.1 0 25.6-11.5 25.6-25.6v-38.4c0-14.1-11.5-25.6-25.6-25.6H64zm384 0c-14.1 0-25.6 11.5-25.6 25.6v38.4c0 14.1 11.5 25.6 25.6 25.6h38.4c14.1 0 25.6-11.5 25.6-25.6v-38.4c0-14.1-11.5-25.6-25.6-25.6h-38.4zM256 128c-70.6 0-128 57.4-128 128s57.4 128 128 128 128-57.4 128-128-57.4-128-128-128zm0 204.8c-42.3 0-76.8-34.5-76.8-76.8s34.5-76.8 76.8-76.8 76.8 34.5 76.8 76.8-34.5 76.8-76.8 76.8z"></path></svg>
                            </a>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <div class="heade_menunavs hidden-sm hidden-xs">
            <div class="container">
                <nav class="header-nav">
                    <ul class="item_big">
                        <li class="nav-item active"><a href="${contextPath}/home">TRANG CHỦ</a></li>
                        <li class="nav-item"><a href="${contextPath}/collections/all">SẢN PHẨM</a></li>
                        <li class="nav-item"><a href="#">TIN TỨC</a></li>
                        <li class="nav-item"><a href="#">LIÊN HỆ</a></li>
                    </ul>
                </nav>
            </div>
        </div>

    </header>

    <div class="site-nav-mobile hidden-lg hidden-md">
        <div class="container">
            <div class="module-title">
                <a href="${contextPath}/" class="logo">
                     <img src="${contextPath}/assets/images/logo.png" alt="Logo">
                </a>
            </div>

            <button class="menubutton category-action">
                <svg viewBox="0 0 24 24" width="24" height="24" fill="currentColor"><path d="M3 18h18v-2H3v2zm0-5h18v-2H3v2zm0-7v2h18V6H3z"/></svg>
            </button>

            <div class="heade_menunavs">
                <a href="#" class="close-menu">
                    <svg viewBox="0 0 320 512" width="15" height="15"><path fill="currentColor" d="M300.6 8.4l-28-28.4c-9.4-9.4-24.6-9.4-33.9 0L160 167.1 77.2 84.4c-9.4-9.4-24.6-9.4-33.9 0l-28 28.4c-9.4 9.4-9.4 24.6 0 33.9l82.8 82.8-82.8 82.8c-9.4 9.4-9.4 24.6 0 33.9l28 28.4c9.4 9.4 24.6 9.4 33.9 0L160 344.9l82.8 82.8c9.4 9.4 24.6 9.4 33.9 0l28-28.4c9.4-9.4 9.4-24.6 0-33.9L193.1 256l82.8-82.8c9.4-9.4 9.4-24.6 0-33.9z"></path></svg>
                </a>
                <div class="bg-header-nav">
                     <ul class="item_big">
                        <li class="nav-item current"><a href="${contextPath}/home">TRANG CHỦ</a></li>
                        <li class="nav-item"><a href="${contextPath}/collections/all">SẢN PHẨM</a></li>
                        <li class="nav-item"><a href="#">TIN TỨC</a></li>
                        <li class="nav-item"><a href="#">LIÊN HỆ</a></li>
                    </ul>
                </div>
            </div>
        </div>
    </div>
    ```

## 2. 🏗️ Hoàn thiện HTML Footer (`footer.jsp`)

Dán khối mã HTML dưới đây vào file **`src/main/webapp/WEB-INF/views/common/footer.jsp`** (đảm bảo các thẻ `<script>` ở cuối).

```jsp
<%-- src/main/webapp/WEB-INF/views/common/footer.jsp --%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>

    <a id="back-to-top" class="backtop" href="#"><i class="fa fa-angle-up"></i></a>

    <footer>
        <div class="footer-inner">
            <div class="container">
                <div class="row">
                    <div class="col-lg-4 col-md-4 col-sm-6 col-xs-12">
                        <div class="footer-widget">
                            <h4>Về chúng tôi</h4>
                            <p>Đơn vị cung cấp các giải pháp công nghệ và thiết bị điện tử hàng đầu.</p>
                            <p>Giờ làm việc: 8h00 - 18h00, T2 - T7.</p>
                        </div>
                    </div>

                    <div class="col-lg-2 col-md-2 col-sm-6 col-xs-12">
                        <div class="footer-widget">
                            <h4>Chính sách</h4>
                            <ul class="list-menu">
                                <li><a href="#">Chính sách bảo mật</a></li>
                                <li><a href="#">Chính sách đổi trả</a></li>
                                <li><a href="#">Quy định thanh toán</a></li>
                                <li><a href="#">Vận chuyển</a></li>
                            </ul>
                        </div>
                    </div>

                    <div class="col-lg-2 col-md-2 col-sm-6 col-xs-12">
                        <div class="footer-widget">
                            <h4>Hỗ trợ khách hàng</h4>
                            <ul class="list-menu">
                                <li>Hotline: 1900 1234</li>
                                <li>Email: support@ltw.vn</li>
                                <li>Địa chỉ: KTX Khu B, TP. HCM</li>
                            </ul>
                        </div>
                    </div>

                    <div class="col-lg-4 col-md-4 col-sm-6 col-xs-12">
                         <div class="footer-widget">
                            <h4>Đăng ký nhận tin</h4>
                            <form class="form-subscribe">
                                <input type="email" placeholder="Nhập email của bạn...">
                                <button type="submit">Gửi</button>
                            </form>

                            <h4 class="margin-top-15">Theo dõi chúng tôi</h4>
                            <ul class="list-unstyled follow_option">
                                <li><a href="#" title="Facebook"><i class="fa fa-facebook-f"></i></a></li>
                                <li><a href="#" title="Twitter"><i class="fa fa-twitter"></i></a></li>
                                <li><a href="#" title="Google Plus"><i class="fa fa-google-plus"></i></a></li>
                            </ul>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <div class="copyright">
            <div class="container">
                <div class="row">
                    <div class="col-lg-6 col-md-6 col-sm-12 col-xs-12 fot_copyright">
                        <span>&copy; 2025 Bản quyền thuộc về <b>LT Web Team</b></span>
                    </div>
                    <div class="col-lg-6 col-md-6 col-sm-12 col-xs-12 text-right">
                        </div>
                </div>
            </div>
        </div>
    </footer>

    <%-- LIÊN KẾT JS ĐÃ THU THẬP --%>
    <script src="${contextPath}/assets/js/libs/jquery.min.js"></script>
    <script src="${contextPath}/assets/js/libs/swiper.min.js"></script>
    <script src="${contextPath}/assets/js/libs/lazyload.min.js"></script>
    <script src="${contextPath}/assets/js/libs/notify.js"></script>
    <script src="${contextPath}/assets/js/libs/js.cookie.js"></script>

    <script src="${contextPath}/assets/js/main.js"></script>

</body>
</html>