package DAOs;

import DBConnect.DBConnection;
import Models.Product;
import Models.Statistics;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDate;
import java.time.temporal.WeekFields;
import java.util.ArrayList;
import java.util.List;
import java.util.Locale;

public class ProductDAO {
//     private static final String PRODUCT_ID = "productID";
//    private static final String NAME = "name";
//    private static final String PRICE = "price";
//    private static final String REDUCED_PRICE = "reducedPrice";
//    private static final String QUANTITY = "quantity";
//    private static final String DESCRIPTION = "description";
//    private static final String IMAGE = "image";
//    private static final String CATEGORY_ID = "categoryID";

    public List<Product> getAllProducts() {
        List<Product> products = new ArrayList<>();
        try ( Connection conn = DBConnection.connect();  PreparedStatement ps = conn.prepareStatement("SELECT * FROM Products")) {
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
                        rs.getInt("categoryID")));
//                 rs.getInt(PRODUCT_ID),
//                        rs.getString(NAME),
//                        rs.getInt(PRICE),
//                        rs.getInt(REDUCED_PRICE),
//                        rs.getInt(QUANTITY),
//                        rs.getString(DESCRIPTION),
//                        rs.getString(IMAGE),
//                        rs.getInt(CATEGORY_ID)));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return products;
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
        try ( Connection conn = DBConnection.connect();  PreparedStatement ps = conn.prepareStatement("DELETE FROM Products WHERE productID = ?")) {
            ps.setInt(1, productId);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
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

        public Statistics getStatistics() {
        Statistics statistics = new Statistics();

        try ( Connection conn = DBConnection.connect()) {
            // Total Products
            String productCountQuery = "SELECT COUNT(*) FROM products";
            try ( PreparedStatement stmt = conn.prepareStatement(productCountQuery)) {
                ResultSet rs = stmt.executeQuery();
                if (rs.next()) {
                    statistics.setProductCount(rs.getInt(1));
                }
            }

            // Total Quantity
            String totalQuantityQuery = "SELECT SUM(quantity) FROM products";
            try ( PreparedStatement stmt = conn.prepareStatement(totalQuantityQuery)) {
                ResultSet rs = stmt.executeQuery();
                if (rs.next()) {
                    statistics.setTotalQuantity(rs.getInt(1));
                }
            }

            // Average Price
            String avgPriceQuery = "SELECT AVG(price) FROM products";
            try ( PreparedStatement stmt = conn.prepareStatement(avgPriceQuery)) {
                ResultSet rs = stmt.executeQuery();
                if (rs.next()) {
                    statistics.setAvgPrice(rs.getDouble(1));
                }
            }

            // Revenue Today
            String revenueTodayQuery = "SELECT SUM(total_amount) FROM orders WHERE DATE(order_date) = ?";
            try ( PreparedStatement stmt = conn.prepareStatement(revenueTodayQuery)) {
                stmt.setDate(1, java.sql.Date.valueOf(LocalDate.now()));
                ResultSet rs = stmt.executeQuery();
                if (rs.next()) {
                    statistics.setRevenueToday(rs.getDouble(1));
                }
            }

            // Revenue This Week
            LocalDate now = LocalDate.now();
            WeekFields weekFields = WeekFields.of(Locale.getDefault());
            int weekNumber = now.get(weekFields.weekOfWeekBasedYear());
            String revenueThisWeekQuery = "SELECT SUM(total_amount) FROM orders WHERE WEEK(order_date) = ? AND YEAR(order_date) = ?";
            try ( PreparedStatement stmt = conn.prepareStatement(revenueThisWeekQuery)) {
                stmt.setInt(1, weekNumber);
                stmt.setInt(2, now.getYear());
                ResultSet rs = stmt.executeQuery();
                if (rs.next()) {
                    statistics.setRevenueThisWeek(rs.getDouble(1));
                }
            }

            // Revenue This Month
            String revenueThisMonthQuery = "SELECT SUM(total_amount) FROM orders WHERE MONTH(order_date) = ? AND YEAR(order_date) = ?";
            try ( PreparedStatement stmt = conn.prepareStatement(revenueThisMonthQuery)) {
                stmt.setInt(1, now.getMonthValue());
                stmt.setInt(2, now.getYear());
                ResultSet rs = stmt.executeQuery();
                if (rs.next()) {
                    statistics.setRevenueThisMonth(rs.getDouble(1));
                }
            }

            // Revenue This Year
            String revenueThisYearQuery = "SELECT SUM(total_amount) FROM orders WHERE YEAR(order_date) = ?";
            try ( PreparedStatement stmt = conn.prepareStatement(revenueThisYearQuery)) {
                stmt.setInt(1, now.getYear());
                ResultSet rs = stmt.executeQuery();
                if (rs.next()) {
                    statistics.setRevenueThisYear(rs.getDouble(1));
                }
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return statistics;
    }

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
}
