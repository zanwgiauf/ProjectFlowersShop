/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAOs;

/**
 *
 * @author Nguyen Van Giau - CE170449
 */
import DBConnect.DBConnection;
import Models.Cart;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

public class CartDAO {

    Connection conn;
    PreparedStatement ps;
    ResultSet rs;

     public CartDAO() {
        conn = DBConnection.connect();
        if (conn != null) {
            System.out.println("Database connection established successfully.");
        } else {
            System.out.println("Failed to establish database connection.");
        }
    }

    public List<Cart> getListCartsByCustomerID(int customerID) {
        List<Cart> list = new ArrayList<>();
        String query = "SELECT c.cartID, c.price, c.quantity, c.productID, c.customerID, p.image, p.name "
                + "FROM Carts c "
                + "INNER JOIN Products p ON c.productID = p.productID "
                + "WHERE c.customerID = ?";
        try {
            ps = conn.prepareStatement(query);
            ps.setInt(1, customerID);
            rs = ps.executeQuery();
            while (rs.next()) {
                Cart cart = new Cart(
                        rs.getInt("cartID"),
                        rs.getInt("price"),
                        rs.getInt("quantity"),
                        rs.getInt("productID"),
                        rs.getInt("customerID"),
                        rs.getString("image"),
                        rs.getString("name")
                );
                list.add(cart);
            }
        } catch (SQLException ex) {
            Logger.getLogger(CartDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return list;
    }

    public List<Cart> getListCartByCustomerID(int customerID) {
        List<Cart> cartItems = new ArrayList<>();
        String sql = "SELECT c.cartID, c.price, c.quantity, c.productID, c.customerID"
                + "FROM Carts c "
                + "WHERE c.customerID = ?";
        try {
            ps = conn.prepareStatement(sql);
            ps.setInt(1, customerID);
            rs = ps.executeQuery();
            while (rs.next()) {
                Cart cart = new Cart(
                        rs.getInt("cartID"),
                        rs.getInt("price"),
                        rs.getInt("quantity"),
                        rs.getInt("productID"),
                        rs.getInt("customerID")
                );
                cartItems.add(cart);
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return cartItems;
    }

    public int getTotalPrice(List<Cart> cartItems) {
        int total = 0;
        for (Cart item : cartItems) {
            total += item.getPrice() * item.getQuantity();
        }
        return total;
    }

    public int applyDiscount(String promoCode, int totalPrice) {
        int discount = 0;
        String query = "SELECT discount FROM Promotions WHERE promotionCode = ? AND GETDATE() BETWEEN startDate AND endDate";
        try {
            ps = conn.prepareStatement(query);
            ps.setString(1, promoCode);
            rs = ps.executeQuery();
            if (rs.next()) {
                String dis_raw = rs.getString("discount");
                if (dis_raw != null && !dis_raw.isEmpty()) {
                    try {
                        discount = Integer.parseInt(dis_raw);
                    } catch (NumberFormatException e) {
                        System.out.println("Invalid discount value: " + dis_raw);
                    }
                }
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return totalPrice - (totalPrice * discount / 100);
    }

    public Cart getCartById(int cartID) {
        Cart cart = null;
        String sql = "select c.cartID, c.price, c.quantity, c.productID, c.customerID, p.image, p.name from Carts c join Products p on c.productID = p.productID where cartID = ?";
        try {
            ps = conn.prepareStatement(sql);
            ps.setInt(1, cartID);
            rs = ps.executeQuery();
            if (rs.next()) {
                cart = new Cart(
                        rs.getInt("cartID"),
                        rs.getInt("price"),
                        rs.getInt("quantity"),
                        rs.getInt("productID"),
                        rs.getInt("customerID"),
                        rs.getString("image"),
                        rs.getString("name"));
            }
        } catch (SQLException ex) {
            Logger.getLogger(CartDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return cart;
    }

    public void deleteItemInCart(int cartID) {
        String sql = "delete from Carts where cartID = ?";
        try {
            ps = conn.prepareStatement(sql);
            ps.setInt(1, cartID);
            ps.executeUpdate();
            ps.close();
        } catch (SQLException ex) {
            Logger.getLogger(CartDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public int getCountCartByCustomerID(int customerID) {
        int count = 0;
        String sql = "select count(*) as cart_all from Carts where customerID = ?";
        try {
            ps = conn.prepareStatement(sql);
            ps.setInt(1, customerID);
            rs = ps.executeQuery();
            if (rs.next()) {
                count = rs.getInt("cart_all");
            }
        } catch (SQLException ex) {
            Logger.getLogger(CartDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return count;
    }

}
