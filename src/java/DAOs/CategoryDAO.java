/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAOs;

import DBConnect.DBConnection;
import Models.Category;
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
}
