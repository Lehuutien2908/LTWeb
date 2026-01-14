Project LT Web
├── src/
│   └── main/
│       ├── java/
│       │   └── vn/edu/hcmuaf/fit/projectltw/
│       │       ├── controller/               <-- CONTROLLER (Phân gói chuyên nghiệp)
│       │       │   ├── auth/                 <-- Login, Register, ForgotPassword...
│       │       │   ├── cart/                 <-- AddToCart, Checkout, ShowCart...
│       │       │   ├── product/              <-- ProductController, ProductServlet...
│       │       │   └── HomeServlet.java      <-- Cổng vào trang chủ
│       │       ├── dao/                      <-- MODEL (Data Access Object)
│       │       │   └── UserDAO.java          <-- Đã sửa lỗi trùng lặp phương thức
│       │       ├── db/                       <-- KẾT NỐI DATABASE
│       │       │   └── DBContext.java        <-- Kết nối TiDB Cloud (SSL)
│       │       ├── model/                    <-- MODEL (Entities)
│       │       │   └── User.java, Product.java
│       │       └── service/                  <-- MODEL (Business Logic)
│       │           └── EmailService.java     <-- Đã chuyển sang đọc file .properties
│       ├── resources/                        <-- CẤU HÌNH HỆ THỐNG
│       │   └── email.properties              <-- Chứa tài khoản SMTP & App Password
│       └── webapp/                           <-- VIEW & STATIC ASSETS
│           ├── WEB-INF/
│           │   ├── views/                    <-- Thư mục bảo mật cho JSP
│           │   │   ├── auth/                 <-- login.jsp (đã bỏ Social Login), forgot-password.jsp...
│           │   │   ├── cart/                 <-- view-cart.jsp, checkout.jsp...
│           │   │   └── product/              <-- product-detail.jsp...
│           │   └── web.xml                   <-- Cấu hình Servlet Mapping
│           └── assets/                       <-- CSS, JS, Images (Winner X 2026...)
├── .gitignore                                <-- Đã cấu hình để quản lý code sạch
├── pom.xml                                   <-- Quản lý thư viện Maven (Jakarta EE, Jakarta Mail, TiDB Driver)
└── README.md                                 <-- Tài liệu hướng dẫn đồ án