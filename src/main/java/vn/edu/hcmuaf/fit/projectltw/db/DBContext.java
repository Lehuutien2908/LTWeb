package vn.edu.hcmuaf.fit.projectltw.db;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBContext {
    // 1. Đặt thông tin kết nối thành các hằng số để dễ quản lý và sửa đổi
    private static final String HOST = "localhost";
    private static final String PORT = "3306";
    private static final String DB_NAME = "project_ltw";
    private static final String USER = "root";
    private static final String PASS = "";

    public static Connection getConnection() throws Exception {
        // 2. Thêm các tham số để đảm bảo không lỗi font tiếng Việt và múi giờ
        String url = "jdbc:mysql://" + HOST + ":" + PORT + "/" + DB_NAME
                + "?useUnicode=true&characterEncoding=UTF-8&useSSL=false&serverTimezone=UTC";

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            return DriverManager.getConnection(url, USER, PASS);
        } catch (ClassNotFoundException | SQLException e) {
            System.err.println("Lỗi kết nối Database: " + e.getMessage());
            throw e;
        }
    }
}