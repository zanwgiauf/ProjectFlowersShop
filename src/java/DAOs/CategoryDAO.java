/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAOs;

import DBConnect.DBConnection;
import Models.Category;
import Models.Product;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author Le Minh Truong - CE171886
 */
public class CategoryDAO {

    private Connection conn;

    public CategoryDAO() {
        conn = DBConnection.connect();
        if (conn != null) {
            System.out.println("Database connection established successfully.");
        } else {
            System.out.println("Failed to establish database connection.");
        }
    }

    public List<Category> getAllCategories() {
        List<Category> categories = new ArrayList<>();
        String query = "SELECT * FROM Categories";
        try ( PreparedStatement ps = conn.prepareStatement(query);  ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                categories.add(new Category(
                        rs.getInt("categoryID"),
                        rs.getString("name")
                ));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return categories;
    }

    public List<Category> searchCategoriesByName(String name) {
        List<Category> categories = new ArrayList<>();
        String query = "SELECT * FROM Categories WHERE name LIKE ?";
        try ( PreparedStatement ps = conn.prepareStatement(query)) {
            ps.setString(1, "%" + name + "%");
            try ( ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    categories.add(new Category(
                            rs.getInt("categoryID"),
                            rs.getString("name")
                    ));
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return categories;
    }

    public Category getCategoryByName(String name) {
        String sql = "SELECT * FROM Categories WHERE name = ?";
        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, name);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return new Category(rs.getInt("categoryID"), rs.getString("name"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public void addCategory(Category category) {
        String query = "INSERT INTO Categories (name) VALUES (?)";
        try ( PreparedStatement ps = conn.prepareStatement(query)) {
            ps.setString(1, category.getName());
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void editCategory(Category category) {
        String query = "UPDATE Categories SET name = ? WHERE categoryID = ?";
        try ( PreparedStatement ps = conn.prepareStatement(query)) {
            ps.setString(1, category.getName());
            ps.setInt(2, category.getCategoryID());
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void deleteCategory(int categoryID) {
        String query = "DELETE FROM Categories WHERE categoryID = ?";
        try ( PreparedStatement ps = conn.prepareStatement(query)) {
            ps.setInt(1, categoryID);
            int rowsAffected = ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    
    public List<Product> getProductsByCategory(int categoryID) {
        List<Product> products = new ArrayList<>();
        String query = "SELECT * FROM Products WHERE categoryID = ?";
        try ( PreparedStatement ps = conn.prepareStatement(query)) {
            ps.setInt(1, categoryID);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                products.add(new Product(
                        rs.getInt("productID"),
                        rs.getString("name"),
                        rs.getInt("price"),
                        rs.getInt("reducedPrice"),
                        rs.getInt("quantity"),
                        rs.getString("description"),
                        rs.getString("image"),
                        rs.getInt("categoryID")
                ));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return products;
    }

    public List<Product> getListByPage(List<Product> list,
            int start, int end) {
        ArrayList<Product> arr = new ArrayList<>();
        for (int i = start; i < end; i++) {
            arr.add(list.get(i));
        }
        return arr;
    }

    public List<Product> getProductByCategory(int category_id) {
        List<Product> list = new ArrayList<>();
        String sql = "SELECT p.categoryID, p.productID, p.name, p.price, p.reducedPrice, p.quantity, p.description, p.image \n"
                + "FROM Products p\n"
                + "INNER JOIN Categories c ON p.categoryID = c.categoryID\n"
                + "WHERE p.categoryID = ?";
        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, category_id);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                //Category category = new Category(category_id, rs.getString("name"));
                Product product = new Product(
                        rs.getInt("productID"),
                        rs.getString("name"),
                        rs.getInt("price"),
                        rs.getInt("reducedPrice"),
                        rs.getInt("quantity"),
                        rs.getString("description"),
                        rs.getString("image"),
                        rs.getInt("categoryID")
                );
                list.add(product);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return list;
    }

    public List<Product> SearchAll(String text) {
        List<Product> list = new ArrayList<>();
        String sql = "SELECT c.name, p.productID, p.name, p.price, p.description, p.quantity, p.image "
                + "FROM Products p "
                + "INNER JOIN Categories c ON p.categoryID = c.categoryID "
                + "WHERE p.name LIKE ? OR c.name LIKE ?";

        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, "%" + text + "%");
            ps.setString(2, "%" + text + "%");
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Category category = new Category(rs.getInt("categoryID"), rs.getString("name"));
                Product product = new Product(
                        rs.getInt("productID"),
                        rs.getString("name"),
                        rs.getInt("price"),
                        rs.getInt("reducedPrice"),
                        rs.getInt("quantity"),
                        rs.getString("description"),
                        rs.getString("image"),
                        rs.getInt("categoryID")
                );
                list.add(product);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return list;
    }

    public List<Product> getProductLow() {
        List<Product> list = new ArrayList<>();
        String sql = "SELECT * FROM Products ORDER BY price ASC";

        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Category category = new Category(rs.getInt("categoryID"), rs.getString("name"));
                Product product = new Product(
                        rs.getInt("productID"),
                        rs.getString("name"),
                        rs.getInt("price"),
                        rs.getInt("reducedPrice"),
                        rs.getInt("quantity"),
                        rs.getString("description"),
                        rs.getString("image"),
                        rs.getInt("categoryID")
                );
                list.add(product);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return list;
    }

    public List<Product> getProductHigh() {
        List<Product> list = new ArrayList<>();
        String sql = "SELECT * FROM Products ORDER BY price DESC";

        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Category category = new Category(rs.getInt("categoryID"), rs.getString("name"));
                Product product = new Product(
                        rs.getInt("productID"),
                        rs.getString("name"),
                        rs.getInt("price"),
                        rs.getInt("reducedPrice"),
                        rs.getInt("quantity"),
                        rs.getString("description"),
                        rs.getString("image"),
                        rs.getInt("categoryID")
                );
                list.add(product);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return list;
    }

    public List<Product> getProductAZ() {
        List<Product> list = new ArrayList<>();
        String sql = "SELECT * FROM Products ORDER BY name";

        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Category category = new Category(rs.getInt("categoryID"), rs.getString("name"));
                Product product = new Product(
                        rs.getInt("productID"),
                        rs.getString("name"),
                        rs.getInt("price"),
                        rs.getInt("reducedPrice"),
                        rs.getInt("quantity"),
                        rs.getString("description"),
                        rs.getString("image"),
                        rs.getInt("categoryID")
                );
                list.add(product);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return list;
    }
    
    public boolean categoryNameExists(String name) {
    String sql = "SELECT COUNT(*) FROM Categories WHERE name = ?";
    try (PreparedStatement ps = conn.prepareStatement(sql)) {
        ps.setString(1, name);
        ResultSet rs = ps.executeQuery();
        if (rs.next()) {
            return rs.getInt(1) > 0; // true if count > 0
        }
    } catch (SQLException e) {
        e.printStackTrace();
    }
    return false;
}
}
