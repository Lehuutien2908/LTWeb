package vn.edu.hcmuaf.fit.projectltw.db;

import java.sql.Connection;
import java.sql.DriverManager;

public class DBContext {
    private static final String HOST = "gateway01.ap-southeast-1.prod.aws.tidbcloud.com";
    private static final String PORT = "4000";
    private static final String DB_NAME = "project_ltw";

    // Sử dụng Username mới bạn vừa cung cấp
    private static final String USER = "3isZuxziPep68Fa.root";

    // Mật khẩu 16 ký tự bạn đã tạo
    private static final String PASS = "1GzC4epPIU9MUnSw";

    public static Connection getConnection() throws Exception {
        Class.forName("com.mysql.cj.jdbc.Driver");

        // URL bắt buộc phải có useSSL=true để TiDB Cloud chấp nhận kết nối
        String url = "jdbc:mysql://" + HOST + ":" + PORT + "/" + DB_NAME
                + "?useUnicode=true&characterEncoding=UTF-8&useSSL=true&serverTimezone=UTC";

        return DriverManager.getConnection(url, USER, PASS);
    }
}