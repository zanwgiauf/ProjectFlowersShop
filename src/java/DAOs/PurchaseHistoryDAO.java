package DAOs;

import DBConnect.DBConnection;
import Models.OrderDetail;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

public class PurchaseHistoryDAO {

    Connection conn;
    PreparedStatement ps;
    ResultSet rs;

    public PurchaseHistoryDAO() {
        try {
            conn = DBConnection.connect();
            if (conn != null) {
                System.out.println("Database connection established successfully.");
            } else {
                System.out.println("Failed to establish database connection.");
            }
        } catch (SQLException ex) {
            Logger.getLogger(PurchaseHistoryDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public List<OrderDetail> getOrderDetailsByCustomerID(int customerID) throws SQLException {
        List<OrderDetail> list = new ArrayList<>();
        String query = "SELECT od.detailID, od.name, od.price, od.quantity, od.orderID, od.productID, p.image, o.dateCreate "
                + "FROM OrderDetails od "
                + "INNER JOIN Orders o ON od.orderID = o.orderID "
                + "INNER JOIN Products p ON od.productID = p.productID "
                + "WHERE o.customerID = ?";
        try {
            ps = conn.prepareStatement(query);
            ps.setInt(1, customerID);
            rs = ps.executeQuery();
            while (rs.next()) {
                OrderDetail orderDetail = new OrderDetail(
                        rs.getInt("detailID"),
                        rs.getString("name"),
                        rs.getInt("price"),
                        rs.getInt("quantity"),
                        rs.getInt("orderID"),
                        rs.getInt("productID"),
                        rs.getString("image"),
                        rs.getDate("dateCreate")
                );
                list.add(orderDetail);
            }
        } catch (SQLException e) {
            System.out.println("Error fetching order details by customer ID: " + e.getMessage());
            throw e;
        } finally {
            if (rs != null) {
                rs.close();
            }
            if (ps != null) {
                ps.close();
            }
        }
        return list;
    }

}
