package DAOs;

import DBConnect.DBConnection;
import Models.Product;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class ProductDAO {

    public List<Product> getAllProducts() {
        List<Product> products = new ArrayList<>();
        try (Connection conn = DBConnection.connect();
             PreparedStatement ps = conn.prepareStatement("SELECT * FROM Products")) {
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                products.add(new Product(rs.getInt("productID"), rs.getString("name"),
                                         rs.getInt("price"), rs.getInt("reducedPrice"),
                                         rs.getString("description"), rs.getString("image"),
                                         rs.getInt("categoryID")));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return products;
    }

    public void addProduct(Product product) {
        try (Connection conn = DBConnection.connect();
             PreparedStatement ps = conn.prepareStatement("INSERT INTO Products (name, price, reducedPrice, description, image, categoryID) VALUES (?, ?, ?, ?, ?, ?)")) {
            ps.setString(1, product.getName());
            ps.setInt(2, product.getPrice());
            ps.setInt(3, product.getReducedPrice());
            ps.setString(4, product.getDescription());
            ps.setString(5, product.getImage());
            ps.setInt(6, product.getCategoryID());
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void updateProduct(Product product) {
        try (Connection conn = DBConnection.connect();
             PreparedStatement ps = conn.prepareStatement("UPDATE Products SET name = ?, price = ?, reducedPrice = ?, description = ?, image = ?, categoryID = ? WHERE productID = ?")) {
            ps.setString(1, product.getName());
            ps.setInt(2, product.getPrice());
            ps.setInt(3, product.getReducedPrice());
            ps.setString(4, product.getDescription());
            ps.setString(5, product.getImage());
            ps.setInt(6, product.getCategoryID());
            ps.setInt(7, product.getProductID());
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void deleteProduct(int productId) {
        try (Connection conn = DBConnection.connect();
             PreparedStatement ps = conn.prepareStatement("DELETE FROM Products WHERE productID = ?")) {
            ps.setInt(1, productId);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public Product getProductByID(int productID) {
        Product product = null;
        try (Connection conn = DBConnection.connect();
             PreparedStatement ps = conn.prepareStatement("SELECT * FROM Products WHERE productID = ?")) {
            ps.setInt(1, productID);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                product = new Product(rs.getInt("productID"), rs.getString("name"),
                                      rs.getInt("price"), rs.getInt("reducedPrice"),
                                      rs.getString("description"), rs.getString("image"),
                                      rs.getInt("categoryID"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return product;
    }

    public List<Product> getProductsByCategoryId(int categoryId) {
        List<Product> products = new ArrayList<>();
        try (Connection conn = DBConnection.connect();
             PreparedStatement ps = conn.prepareStatement("SELECT * FROM Products WHERE categoryID = ?")) {
            ps.setInt(1, categoryId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Product product = new Product(rs.getInt("productID"), rs.getString("name"),
                                              rs.getInt("price"), rs.getInt("reducedPrice"),
                                              rs.getString("description"), rs.getString("image"),
                                              rs.getInt("categoryID"));
                products.add(product);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return products;
    }
}
