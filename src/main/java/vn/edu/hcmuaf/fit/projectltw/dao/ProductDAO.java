package vn.edu.hcmuaf.fit.projectltw.dao;

import vn.edu.hcmuaf.fit.projectltw.db.DBContext;
import vn.edu.hcmuaf.fit.projectltw.model.Product;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ProductDAO {

    private Product mapProduct(ResultSet rs) throws SQLException {
        return new Product(
                rs.getInt("id"),
                rs.getString("name"),
                rs.getDouble("price"),
                rs.getString("image"),
                rs.getString("category"),
                rs.getBoolean("is_new"),
                rs.getBoolean("is_hot"),
                rs.getInt("stock"));
    }

    // Lấy toàn bộ sản phẩm trong Database
    public List<Product> getAllProducts() {
        List<Product> list = new ArrayList<>();
        String sql = "SELECT * FROM products";
        try (Connection conn = DBContext.getConnection();
                PreparedStatement ps = conn.prepareStatement(sql)) {
            ResultSet rs = ps.executeQuery();
            while (rs.next())
                list.add(mapProduct(rs));
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    // Tìm kiếm sản phẩm theo tên (Dùng cho thanh Search ở Header)
    public List<Product> searchProducts(String query) {
        List<Product> list = new ArrayList<>();
        String sql = "SELECT * FROM products WHERE name LIKE ?";
        try (Connection conn = DBContext.getConnection();
                PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, "%" + query + "%"); // Tìm kiếm gần đúng
            ResultSet rs = ps.executeQuery();
            while (rs.next())
                list.add(mapProduct(rs));
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public List<Product> getNewProducts() {
        List<Product> list = new ArrayList<>();
        String sql = "SELECT * FROM products WHERE is_new = 1 LIMIT 12";
        try (Connection conn = DBContext.getConnection();
                PreparedStatement ps = conn.prepareStatement(sql)) {
            ResultSet rs = ps.executeQuery();
            while (rs.next())
                list.add(mapProduct(rs));
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public List<Product> getSaleProducts() {
        List<Product> list = new ArrayList<>();
        String sql = "SELECT * FROM products ORDER BY price ASC LIMIT 5";
        try (Connection conn = DBContext.getConnection();
                PreparedStatement ps = conn.prepareStatement(sql)) {
            ResultSet rs = ps.executeQuery();
            while (rs.next())
                list.add(mapProduct(rs));
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public List<Product> getHotProducts() {
        List<Product> list = new ArrayList<>();
        String sql = "SELECT * FROM products WHERE is_hot = 1 LIMIT 12";
        try (Connection conn = DBContext.getConnection();
                PreparedStatement ps = conn.prepareStatement(sql)) {
            ResultSet rs = ps.executeQuery();
            while (rs.next())
                list.add(mapProduct(rs));
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public Product getProductById(int id) {
        String sql = "SELECT * FROM products WHERE id = ?";
        try (Connection conn = DBContext.getConnection();
                PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next())
                return mapProduct(rs);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    public List<Product> getProductsByCategory(String category) {
        List<Product> list = new ArrayList<>();
        String sql = "SELECT * FROM products WHERE category = ?";
        try (Connection conn = DBContext.getConnection();
                PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, category);
            ResultSet rs = ps.executeQuery();
            while (rs.next())
                list.add(mapProduct(rs));
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public int countLowStockProducts() {
        String sql = "SELECT COUNT(*) FROM products WHERE stock < 10";

        try (Connection conn = DBContext.getConnection();
                PreparedStatement ps = conn.prepareStatement(sql)) {
            ResultSet rs = ps.executeQuery();
            if (rs.next())
                return rs.getInt(1);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return 0;
    }

    public boolean insertProduct(Product p) {
        String sql = "INSERT INTO products (name, price, image, category, is_new, is_hot, stock) VALUES (?, ?, ?, ?, ?, ?, ?)";
        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, p.getName());
            ps.setDouble(2, p.getPrice());
            ps.setString(3, p.getImage());
            ps.setString(4, p.getCategory());
            ps.setBoolean(5, p.isNew());
            ps.setBoolean(6, p.isHot());
            ps.setInt(7, p.getStock());

            int result = ps.executeUpdate();
            return result > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean updateProduct(Product p) {
        String sql = "UPDATE products SET name=?, price=?, image=?, category=?, is_new=?, is_hot=?, stock=? WHERE id=?";
        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, p.getName());
            ps.setDouble(2, p.getPrice());
            ps.setString(3, p.getImage());
            ps.setString(4, p.getCategory());
            ps.setBoolean(5, p.isNew());
            ps.setBoolean(6, p.isHot());
            ps.setInt(7, p.getStock());
            ps.setInt(8, p.getId());

            int result = ps.executeUpdate();
            return result > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean deleteProduct(int id) {
        String sql = "DELETE FROM products WHERE id=?";
        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);

            int result = ps.executeUpdate();
            return result > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }
}