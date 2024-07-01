/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
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

/**
 *
 * @author Nguyen Van Giau - CE170449
 */
public class OrderDAO {

    Connection conn;
    PreparedStatement ps;
    ResultSet rs;

    public OrderDAO() {
        try {
            conn = DBConnection.connect();
            if (conn != null) {
                System.out.println("Database connection established successfully.");
            } else {
                System.out.println("Failed to establish database connection.");
            }
        } catch (SQLException ex) {
            Logger.getLogger(OrderDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    // Method to get pending orders by customer ID
    public List<OrderDetail> getPendingOrdersByCustomerID(int customerID) throws SQLException {
        List<OrderDetail> pendingOrders = new ArrayList<>();
        String query = "SELECT od.detailID, od.name, od.price, od.quantity, od.orderID, od.productID, p.image, o.dateCreate "
                + "FROM OrderDetails od "
                + "INNER JOIN Orders o ON od.orderID = o.orderID "
                + "INNER JOIN Products p ON od.productID = p.productID "
                + "WHERE o.customerID = ? AND o.status = 1"; // Assuming status 1 means pending

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
                pendingOrders.add(orderDetail);
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return pendingOrders;
    }

    public boolean cancelOrder(int orderID) throws SQLException {
        String query = "UPDATE Orders SET status = 3 WHERE orderID = ?";
        try {
            ps = conn.prepareStatement(query);
            ps.setInt(1, orderID);
            int rowsUpdated = ps.executeUpdate();
            return rowsUpdated > 0;
        } catch (SQLException e) {
            System.out.println(e);
            return false;
        }
    }

    public void close() {
        try {
            if (rs != null) {
                rs.close();
            }
            if (ps != null) {
                ps.close();
            }
            if (conn != null) {
                conn.close();
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
    }
}
