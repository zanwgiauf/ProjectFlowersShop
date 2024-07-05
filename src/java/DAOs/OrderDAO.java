package DAOs;

import DBConnect.DBConnection;
import Models.Order;
import Models.OrderDetail;
import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import java.time.LocalDate;

public class OrderDAO {

    Connection conn;
    PreparedStatement ps;
    ResultSet rs;

    public OrderDAO() {
        try {
            conn = DBConnection.connect();
        } catch (SQLException ex) {
            Logger.getLogger(OrderDAO.class.getName()).log(Level.SEVERE, null, ex);
        }

    }

    public List<OrderDetail> getOrderDetailsByCustomerID(int customerID) throws SQLException {
        List<OrderDetail> list = new ArrayList<>();
        String query = "SELECT od.detailID, od.name, od.price, o.totalPrice, od.quantity, od.orderID, od.productID, p.image, o.dateCreate , o.status "
                + "FROM OrderDetails od "
                + "INNER JOIN Orders o ON od.orderID = o.orderID "
                + "INNER JOIN Products p ON od.productID = p.productID "
                + "WHERE o.customerID = ? and o.status = 1";
        try {
            ps = conn.prepareStatement(query);
            ps.setInt(1, customerID);
            rs = ps.executeQuery();
            while (rs.next()) {
                OrderDetail orderDetail = new OrderDetail(
                        rs.getInt("detailID"),
                        rs.getString("name"),
                        rs.getInt("price"),
                        rs.getInt("totalPrice"),
                        rs.getInt("quantity"),
                        rs.getInt("orderID"),
                        rs.getInt("productID"),
                        rs.getString("image"),
                        rs.getDate("dateCreate"),
                        rs.getInt("status")
                );
                list.add(orderDetail);
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return list;
    }
    // Method to get pending orders by customer ID

    public List<OrderDetail> getPendingOrdersByCustomerID(int customerID) throws SQLException {
        List<OrderDetail> pendingOrders = new ArrayList<>();
        String query = "SELECT od.detailID, od.name, od.price, o.totalPrice, od.quantity, od.orderID, od.productID, p.image, o.dateCreate, o.status "
                + "FROM OrderDetails od "
                + "INNER JOIN Orders o ON od.orderID = o.orderID "
                + "INNER JOIN Products p ON od.productID = p.productID "
                + "WHERE o.customerID = ? AND o.status = 0"; // Assuming status 0 means pending

        try {
            ps = conn.prepareStatement(query);
            ps.setInt(1, customerID);
            rs = ps.executeQuery();
            while (rs.next()) {
                OrderDetail orderDetail = new OrderDetail(
                        rs.getInt("detailID"),
                        rs.getString("name"),
                        rs.getInt("price"),
                        rs.getInt("totalPrice"),
                        rs.getInt("quantity"),
                        rs.getInt("orderID"),
                        rs.getInt("productID"),
                        rs.getString("image"),
                        rs.getDate("dateCreate"),
                        rs.getInt("status")
                );
                pendingOrders.add(orderDetail);
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return pendingOrders;
    }

    // Method to get all cancelled orders by customer ID
    public List<OrderDetail> getAllCancelledOrdersByCustomerID(int customerID) throws SQLException {
        List<OrderDetail> cancelledOrders = new ArrayList<>();
        String query = "SELECT od.detailID, od.name, od.price, o.totalPrice, od.quantity, od.orderID, od.productID, p.image, o.dateCreate, o.status "
                + "FROM OrderDetails od "
                + "INNER JOIN Orders o ON od.orderID = o.orderID "
                + "INNER JOIN Products p ON od.productID = p.productID "
                + "WHERE o.customerID = ? AND o.status = 3"; // Assuming status 3 means cancelled

        try {
            ps = conn.prepareStatement(query);
            ps.setInt(1, customerID);
            rs = ps.executeQuery();
            while (rs.next()) {
                OrderDetail orderDetail = new OrderDetail(
                        rs.getInt("detailID"),
                        rs.getString("name"),
                        rs.getInt("price"),
                        rs.getInt("totalPrice"),
                        rs.getInt("quantity"),
                        rs.getInt("orderID"),
                        rs.getInt("productID"),
                        rs.getString("image"),
                        rs.getDate("dateCreate"),
                        rs.getInt("status")
                );
                cancelledOrders.add(orderDetail);
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return cancelledOrders;
    }

    // Method to cancel order by order ID
    public boolean cancelOrder(int orderID) throws SQLException {
        String query = "UPDATE Orders SET status = 3, dateCreate = ? WHERE orderID = ?";
        try {
            ps = conn.prepareStatement(query);
            ps.setDate(1, java.sql.Date.valueOf(LocalDate.now())); // Update the dateCreate to current date
            ps.setInt(2, orderID);
            int rowsUpdated = ps.executeUpdate();
            return rowsUpdated > 0;
        } catch (SQLException e) {
            System.out.println(e);
            return false;
        }
    }

//    public int addOrder(Order order) {
//        int orderID = 0;
//        Order o = new Order();
//        String sql = "insert into Orders values (?,?,?,?,?,?,?,?,?,?)";
//
//        try {
//            PreparedStatement ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
//            ps.setDate(1, order.getDateCreate());
//            ps.setString(2, order.getPhone());
//            ps.setString(3, order.getAddress());
//            ps.setInt(4, order.getTotalPrice());
//            ps.setString(5, order.getNote());
//            ps.setInt(6, order.getStatus());
//            ps.setInt(7, order.getPaymentStatus());
//            ps.setDate(8, order.getPaymentCreateAt());
//            ps.setInt(9, order.getCustomerID());
//            ps.setInt(10, order.getEmployeeID());
////            ps.setDate(1, dateCreate);
////            ps.setString(2, phone);
////            ps.setString(3, address);
////            ps.setInt(4, totalPrice);
////            ps.setString(5, note);
////            ps.setInt(6, o.getStatus());
////            ps.setInt(7, o.getPaymentStatus());
////            ps.setDate(8, payCreateAt);
////            ps.setInt(9, customerID);
////            ps.setInt(10, employeeID);
//            ps.executeUpdate();
//            rs = ps.getGeneratedKeys();
//            if (rs.next()) {
//                orderID = rs.getInt(1);
//            }
//            return orderID;
//        } catch (SQLException ex) {
//            Logger.getLogger(OrderDAO.class.getName()).log(Level.SEVERE, null, ex);
//        }
//
//        return orderID;
//    }
    public int addOrder(Order order) {
        int orderID = 0;
        String sql = "INSERT INTO Orders (dateCreate, phone, address, totalPrice, note, status, paymentStatus, paymentCreateAt, customerID, employeeID, shipping_fee) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

        try {
            ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
            ps.setDate(1, order.getDateCreate());
            ps.setString(2, order.getPhone());
            ps.setString(3, order.getAddress());
            ps.setInt(4, order.getTotalPrice());
            ps.setString(5, order.getNote());
            ps.setInt(6, order.getStatus());
            ps.setInt(7, order.getPaymentStatus());
            ps.setDate(8, order.getPaymentCreateAt());
            ps.setInt(9, order.getCustomerID());
            ps.setInt(10, order.getEmployeeID());
            ps.setInt(11, order.getShippingFee());
            ps.executeUpdate();
            rs = ps.getGeneratedKeys();
            if (rs.next()) {
                orderID = rs.getInt(1);
            }
            return orderID;
        } catch (SQLException ex) {
            Logger.getLogger(OrderDAO.class.getName()).log(Level.SEVERE, null, ex);
        }

        return orderID;
    }

    public List<Order> getListOrderByCustomerID(int customerID) {
        List<Order> list = new ArrayList<>();
        String sql = "select o.orderID, o.dateCreate, o.phone, o.address, o.totalPrice, "
                + "o.note,o.status,o.paymentStatus, o.paymentCreateAt,o.customerID, o.employeeID, "
                + "od.quantity, p.image, p.name from Orders o "
                + "join Employees e on o.employeeID = e.employeeID "
                + "join OrderDetails od on o.orderID = od.orderID "
                + "join Products p on od.productID = p.productID "
                + "where o.customerID = ? "
                + "order by o.orderID desc ";
        try {
            ps = conn.prepareStatement(sql);
            ps.setInt(1, customerID);
            rs = ps.executeQuery();
            while (rs.next()) {
                Order order = new Order(
                        rs.getInt("orderID"),
                        rs.getDate("dateCreate"),
                        rs.getString("phone"),
                        rs.getString("address"),
                        rs.getInt("totalPrice"),
                        rs.getString("note"),
                        rs.getInt("status"),
                        rs.getInt("paymentStatus"),
                        rs.getDate("paymentCreateAt"),
                        rs.getInt("customerID"),
                        rs.getInt("employeeID"),
                        rs.getInt("quantity"),
                        rs.getString("image"),
                        rs.getString("name")
                );
                list.add(order);
            }
        } catch (SQLException ex) {
            Logger.getLogger(OrderDAO.class.getName()).log(Level.SEVERE, null, ex);
        }

        return list;
    }
}
