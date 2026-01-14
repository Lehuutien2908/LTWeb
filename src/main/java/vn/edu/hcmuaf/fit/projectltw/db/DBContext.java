package vn.edu.hcmuaf.fit.projectltw.db;

import java.sql.Connection;
import java.sql.DriverManager;

public class DBContext {
    public static Connection getConnection() throws Exception {
        Class.forName("com.mysql.cj.jdbc.Driver");

        String url = "jdbc:mysql://localhost:3306/project_ltw";
        return DriverManager.getConnection(url, "root", "");
    }
}