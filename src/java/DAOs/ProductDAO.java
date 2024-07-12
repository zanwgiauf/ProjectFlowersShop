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
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author Nguyen Van Giau - CE170449
 */
public class ProductDAO {

    Connection conn;
    PreparedStatement ps;
    ResultSet rs;

    public ProductDAO() {
        conn = DBConnection.connect();
        if (conn != null) {
            System.out.println("Database connection established successfully.");
        } else {
            System.out.println("Failed to establish database connection.");
        }
    }
//Nguyen Van Giau

    public Product getProductByID(int productID) {
        Product product = null;
        String sql = "select p.productID, p.name, p.price, p.reducedPrice, p.quantity, p.description, p.image, p.categoryID, sd.quantity as stock_quantity from Products p join StockDetails sd on p.productID = sd.productID where p.productID = ?";
        try {
            ps = conn.prepareStatement(sql);
            ps.setInt(1, productID);
            rs = ps.executeQuery();
            if (rs.next()) {
                product = new Product(
                        rs.getInt("productID"),
                        rs.getString("name"),
                        rs.getInt("price"),
                        rs.getInt("reducedPrice"),
                        rs.getInt("quantity"),
                        rs.getString("description"),
                        rs.getString("image"),
                        rs.getInt("categoryID"),
                        rs.getInt("stock_quantity"));
            }

        } catch (SQLException ex) {
            Logger.getLogger(ProductDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return product;
    }

    public int UpdateQuantityProduct(int quantity, int productID) {
        String sql = "update Products set quantity = ? where productID = ?";
        int count = 0;
        try {
            ps = conn.prepareStatement(sql);
            ps.setInt(1, quantity);
            ps.setInt(2, productID);
            count = ps.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(ProductDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return count;
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

    public Product getProductById(int id) {
        String query = "SELECT * FROM Products WHERE ProductID = ?";
        try ( Connection conn = DBConnection.connect();  PreparedStatement ps = conn.prepareStatement(query)) {
            ps.setInt(1, id);
            try ( ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return new Product(
                            rs.getInt("productID"),
                            rs.getString("name"),
                            rs.getInt("price"),
                            rs.getInt("reducedPrice"),
                            rs.getInt("quantity"),
                            rs.getString("description"),
                            rs.getString("image"),
                            rs.getInt("categoryID")
                    );
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
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

    // Lấy thông tin sản phẩm dựa trên tên
    public List<Product> getProductsByName(String name) {
        List<Product> productList = new ArrayList<>();
        String query = "SELECT * FROM Products WHERE Name LIKE ?";

        try ( Connection conn = DBConnection.connect();  PreparedStatement ps = conn.prepareStatement(query)) {

            ps.setString(1, "%" + name + "%");
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Product product = new Product();
                product.setProductID(rs.getInt("productID"));
                product.setName(rs.getString("name"));
                product.setPrice(rs.getInt("price"));
                product.setReducedPrice(rs.getInt("reducedPrice"));
                product.setQuantity(rs.getInt("quantity"));
                product.setDescription(rs.getString("description")); // Corrected typo
                product.setImage(rs.getString("image"));
                product.setCategoryID(rs.getInt("categoryID"));
                productList.add(product);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return productList;
    }

//    public Statistics getStatistics() {
//        Statistics statistics = new Statistics();
//
//        try ( Connection conn = DBConnection.connect()) {
//            // Total Products
//            String productCountQuery = "SELECT COUNT(*) FROM products";
//            try ( PreparedStatement stmt = conn.prepareStatement(productCountQuery)) {
//                ResultSet rs = stmt.executeQuery();
//                if (rs.next()) {
//                    statistics.setProductCount(rs.getInt(1));
//                }
//            }
//
//            // Total Quantity
//            String totalQuantityQuery = "SELECT SUM(quantity) FROM products";
//            try ( PreparedStatement stmt = conn.prepareStatement(totalQuantityQuery)) {
//                ResultSet rs = stmt.executeQuery();
//                if (rs.next()) {
//                    statistics.setTotalQuantity(rs.getInt(1));
//                }
//            }
//
//            // Average Price
//            String avgPriceQuery = "SELECT AVG(price) FROM products";
//            try ( PreparedStatement stmt = conn.prepareStatement(avgPriceQuery)) {
//                ResultSet rs = stmt.executeQuery();
//                if (rs.next()) {
//                    statistics.setAvgPrice(rs.getDouble(1));
//                }
//            }
//
//            // Revenue Today
//            String revenueTodayQuery = "SELECT SUM(total_amount) FROM orders WHERE DATE(order_date) = ?";
//            try ( PreparedStatement stmt = conn.prepareStatement(revenueTodayQuery)) {
//                stmt.setDate(1, java.sql.Date.valueOf(LocalDate.now()));
//                ResultSet rs = stmt.executeQuery();
//                if (rs.next()) {
//                    statistics.setRevenueToday(rs.getDouble(1));
//                }
//            }
//
//            // Revenue This Week
//            LocalDate now = LocalDate.now();
//            WeekFields weekFields = WeekFields.of(Locale.getDefault());
//            int weekNumber = now.get(weekFields.weekOfWeekBasedYear());
//            String revenueThisWeekQuery = "SELECT SUM(total_amount) FROM orders WHERE WEEK(order_date) = ? AND YEAR(order_date) = ?";
//            try ( PreparedStatement stmt = conn.prepareStatement(revenueThisWeekQuery)) {
//                stmt.setInt(1, weekNumber);
//                stmt.setInt(2, now.getYear());
//                ResultSet rs = stmt.executeQuery();
//                if (rs.next()) {
//                    statistics.setRevenueThisWeek(rs.getDouble(1));
//                }
//            }
//
//            // Revenue This Month
//            String revenueThisMonthQuery = "SELECT SUM(total_amount) FROM orders WHERE MONTH(order_date) = ? AND YEAR(order_date) = ?";
//            try ( PreparedStatement stmt = conn.prepareStatement(revenueThisMonthQuery)) {
//                stmt.setInt(1, now.getMonthValue());
//                stmt.setInt(2, now.getYear());
//                ResultSet rs = stmt.executeQuery();
//                if (rs.next()) {
//                    statistics.setRevenueThisMonth(rs.getDouble(1));
//                }
//            }
//
//            // Revenue This Year
//            String revenueThisYearQuery = "SELECT SUM(total_amount) FROM orders WHERE YEAR(order_date) = ?";
//            try ( PreparedStatement stmt = conn.prepareStatement(revenueThisYearQuery)) {
//                stmt.setInt(1, now.getYear());
//                ResultSet rs = stmt.executeQuery();
//                if (rs.next()) {
//                    statistics.setRevenueThisYear(rs.getDouble(1));
//                }
//            }
//
//        } catch (SQLException e) {
//            e.printStackTrace();
//        }
//
//        return statistics;
//    }
    public List<Product> getProductsByCategoryId(int categoryId, int currentProductId) {
        List<Product> list = new ArrayList<>();
        String query = "SELECT * FROM Products WHERE CategoryID = ? AND ProductID != ?";
        try ( Connection conn = DBConnection.connect();  PreparedStatement ps = conn.prepareStatement(query)) {
            ps.setInt(1, categoryId);
            ps.setInt(2, currentProductId);
            try ( ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Product p = new Product(
                            rs.getInt("ProductID"),
                            rs.getString("Name"),
                            rs.getInt("Price"),
                            rs.getInt("reducedPrice"),
                            rs.getInt("Quantity"),
                            rs.getString("Description"),
                            rs.getString("Image"),
                            rs.getInt("CategoryID")
                    );
                    list.add(p);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public List<Product> getProductsByCategoryId(int categoryId) {
        List<Product> products = new ArrayList<>();
        try ( Connection conn = DBConnection.connect();  PreparedStatement ps = conn.prepareStatement("SELECT * FROM Products WHERE categoryID = ?")) {
            ps.setInt(1, categoryId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Product product = new Product(
                        rs.getInt("productID"),
                        rs.getString("name"),
                        rs.getInt("price"),
                        rs.getInt("reducedPrice"),
                        rs.getInt("quantity"),
                        rs.getString("description"),
                        rs.getString("image"),
                        rs.getInt("categoryID"));
                products.add(product);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return products;
    }

    public List<Product> searchProducts(Integer minPrice, Integer maxPrice) {
        List<Product> productList = new ArrayList<>();
        StringBuilder query = new StringBuilder("SELECT * FROM Products WHERE 1=1");

        if (minPrice != null) {
            query.append(" AND Price >= ?");
        }
        if (maxPrice != null) {
            query.append(" AND Price <= ?");
        }

        try ( Connection conn = DBConnection.connect();  PreparedStatement ps = conn.prepareStatement(query.toString())) {
            int paramIndex = 1;

            if (minPrice != null) {
                ps.setInt(paramIndex++, minPrice);
            }
            if (maxPrice != null) {
                ps.setInt(paramIndex++, maxPrice);
            }

            try ( ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Product product = new Product(
                            rs.getInt("ProductID"),
                            rs.getString("Name"),
                            rs.getInt("Price"),
                            rs.getInt("reducedPrice"),
                            rs.getInt("Quantity"),
                            rs.getString("Description"),
                            rs.getString("Image"),
                            rs.getInt("CategoryID")
                    );
                    productList.add(product);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return productList;
    }

    public void addProduct(Product product) {
        try ( Connection conn = DBConnection.connect();  PreparedStatement ps = conn.prepareStatement("INSERT INTO Products (name, price, reducedPrice, quantity, description, image, categoryID) VALUES (?, ?, ?, ?, ?, ?, ?)")) {
            ps.setString(1, product.getName());
            ps.setInt(2, product.getPrice());
            ps.setInt(3, product.getReducedPrice());
            ps.setInt(4, product.getQuantity());
            ps.setString(5, product.getDescription());
            ps.setString(6, product.getImage());
            ps.setInt(7, product.getCategoryID());
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void updateProduct(Product product) {
        try ( Connection conn = DBConnection.connect();  PreparedStatement ps = conn.prepareStatement("UPDATE Products SET name = ?, price = ?, reducedPrice = ?, quantity = ?, description = ?, image = ?, categoryID = ? WHERE productID = ?")) {
            ps.setString(1, product.getName());
            ps.setInt(2, product.getPrice());
            ps.setInt(3, product.getReducedPrice());
            ps.setInt(4, product.getQuantity());
            ps.setString(5, product.getDescription());
            ps.setString(6, product.getImage());
            ps.setInt(7, product.getCategoryID());
            ps.setInt(8, product.getProductID());
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void deleteProduct(int productId) {
        try ( Connection conn = DBConnection.connect();  PreparedStatement ps = conn.prepareStatement("DELETE FROM StockDetails WHERE productID = ?; DELETE FROM Products WHERE productID = ?")) {
            ps.setInt(1, productId);
            ps.setInt(2, productId);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public List<Product> searchProducts(String keyword) {
        List<Product> products = new ArrayList<>();
        String sql = "SELECT * FROM Products WHERE name LIKE ? OR description LIKE ?";

        try ( Connection conn = DBConnection.connect();  PreparedStatement ps = conn.prepareStatement(sql)) {
            String searchKeyword = "%" + keyword + "%";
            ps.setString(1, searchKeyword);
            ps.setString(2, searchKeyword);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Product product = new Product(
                        rs.getInt("productID"),
                        rs.getString("name"),
                        rs.getInt("price"),
                        rs.getInt("reducedPrice"),
                        rs.getInt("quantity"),
                        rs.getString("description"),
                        rs.getString("image"),
                        rs.getInt("categoryID"));
                products.add(product);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return products;
    }

    public Product getProductByQuan(int productID) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }
}
