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
        conn = DBConnection.connect();
        if (conn != null) {
            System.out.println("Database connection established successfully.");
        } else {
            System.out.println("Failed to establish database connection.");
        }
    }

    public List<OrderDetail> getPurchaseHistoryOrderByCustomerID(int customerID) throws SQLException {
        List<OrderDetail> list = new ArrayList<>();
        String query = "SELECT od.detailID, od.name, od.price, o.totalPrice, od.quantity, od.orderID, od.productID, p.image, o.dateCreate , o.status "
                + "FROM OrderDetails od "
                + "INNER JOIN Orders o ON od.orderID = o.orderID "
                + "INNER JOIN Products p ON od.productID = p.productID "
                + "WHERE o.customerID = ? and o.status = 3";
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

    // Method to get delivering orders by customer ID
    public List<OrderDetail> getAcceptedOrdersByCustomerID(int customerID) throws SQLException {
        List<OrderDetail> acceptedOrders = new ArrayList<>();
        String query = "SELECT od.detailID, od.name, od.price, o.totalPrice, od.quantity, od.orderID, od.productID, p.image, o.dateCreate, o.status "
                + "FROM OrderDetails od "
                + "INNER JOIN Orders o ON od.orderID = o.orderID "
                + "INNER JOIN Products p ON od.productID = p.productID "
                + "WHERE o.customerID = ? AND o.status = 1"; // Assuming status 0 means pending

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
                acceptedOrders.add(orderDetail);
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return acceptedOrders;
    }

    // Method to get delivering orders by customer ID
    public List<OrderDetail> getDeliveringOrdersByCustomerID(int customerID) throws SQLException {
        List<OrderDetail> deliveringOrders = new ArrayList<>();
        String query = "SELECT od.detailID, od.name, od.price, o.totalPrice, od.quantity, od.orderID, od.productID, p.image, o.dateCreate, o.status "
                + "FROM OrderDetails od "
                + "INNER JOIN Orders o ON od.orderID = o.orderID "
                + "INNER JOIN Products p ON od.productID = p.productID "
                + "WHERE o.customerID = ? AND o.status = 2"; // Assuming status 0 means pending

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
                deliveringOrders.add(orderDetail);
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return deliveringOrders;
    }

    // Method to get all cancelled orders by customer ID
    public List<OrderDetail> getAllCancelledOrdersByCustomerID(int customerID) throws SQLException {
        List<OrderDetail> cancelledOrders = new ArrayList<>();
        String query = "SELECT od.detailID, od.name, od.price, o.totalPrice, od.quantity, od.orderID, od.productID, p.image, o.dateCreate, o.status "
                + "FROM OrderDetails od "
                + "INNER JOIN Orders o ON od.orderID = o.orderID "
                + "INNER JOIN Products p ON od.productID = p.productID "
                + "WHERE o.customerID = ? AND o.status = 4"; // Assuming status 3 means cancelled

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

    //add order
    public int addOrder(Order order) {
        int orderID = 0;
        String sql = "INSERT INTO Orders (dateCreate, phone, address, totalPrice, note, status, paymentStatus, paymentCreateAt, shippingFee, customerID, employeeID) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

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
            ps.setInt(9, order.getShippingFee());
            ps.setInt(10, order.getCustomerID());
            ps.setInt(11, order.getEmployeeID());
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

    public List<Order> getOrderById(int orderID) {
        List<Order> list = new ArrayList<>();
        String sql = "select * from Orders  o join OrderDetails od on o.orderID = od.orderID join Products p on od.productID = p.productID  where o.orderID = ?";
        try {
            ps = conn.prepareStatement(sql);
            ps.setInt(1, orderID);
            rs = ps.executeQuery();
            if (rs.next()) {
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
                        rs.getInt("shippingFee"),
                        rs.getInt("customerID"),
                        rs.getInt("employeeID"));
                list.add(order);
            }

        } catch (SQLException ex) {
            Logger.getLogger(OrderDAO.class.getName()).log(Level.SEVERE, null, ex);
        }

        return list;
    }
}
