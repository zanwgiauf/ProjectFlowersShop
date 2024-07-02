/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAOs;

import DBConnect.DBConnection;
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
public class ProductDAO {

    private Connection conn;

    public ProductDAO() {
        conn = DBConnection.connect();
        if (conn != null) {
            System.out.println("Database connection established successfully.");
        } else {
            System.out.println("Failed to establish database connection.");
        }
    }

    public List<Product> getAllProducts() {
        List<Product> products = new ArrayList<>();
        String query = "SELECT * FROM Products";
        try ( PreparedStatement ps = conn.prepareStatement(query);  ResultSet rs = ps.executeQuery()) {
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

    public List<Product> searchProductsByName(String name) {
        List<Product> products = new ArrayList<>();
        String query = "SELECT * FROM Products WHERE name LIKE ?";
        try ( PreparedStatement ps = conn.prepareStatement(query)) {
            ps.setString(1, "%" + name + "%");
            try ( ResultSet rs = ps.executeQuery()) {
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
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return products;
    }

}
