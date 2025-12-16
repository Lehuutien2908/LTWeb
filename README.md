Project LT Web
├── .idea/
├── src/
│   └── main/
│       ├── java/
│       │   └── vn.edu.hcmunaf.fit.projectltw/
│       │       ├── controller/             <-- CONTROLLER (Servlet)
│       │       │   // Chứa các file Servlet (VD: HomeServlet.java)
│       │       ├── model/                  <-- MODEL (JavaBeans - Đối tượng dữ liệu)
│       │       │   // Chứa các lớp Entity/Bean (VD: User.java, Product.java)
│       │       ├── dao/                    <-- MODEL (Data Access Object)
│       │       │   // Chứa các lớp tương tác trực tiếp với Database/JDBC (VD: UserDAO.java)
│       │       └── service/                <-- MODEL (Logic nghiệp vụ)
│       │           // Chứa các lớp xử lý nghiệp vụ phức tạp, gọi DAO (VD: UserService.java)
│       └── webapp/                       <-- VIEW (JSP) & Static Assets
│           ├── WEB-INF/
│           │   ├── views/                  <-- Các file JSP phải được forward từ Controller
│           │   │   // Chứa các thư mục con (common/, auth/, product/, order/)
│           │   └── web.xml                 <-- Cấu hình Servlet/Deployment Descriptor
│           ├── assets/                     <-- File tĩnh (CSS, JS, Ảnh)
│           │   ├── css/
│           │   ├── js/
│           │   └── images/
│           └── index.jsp (Chỉ dùng để chuyển hướng đến /home)
├── .gitignore
├── mvnw
├── mvnw.cmd
└── pom.xml