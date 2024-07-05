/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAOs;

import DBConnect.DBConnection;
import Models.Cart;
import Models.Product;
import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author ADMIN
 */
public class CartDAO {

    Connection conn;

    public CartDAO() {
        conn = DBConnection.connect();
        if (conn != null) {
            System.out.println("Database connection established successfully.");
        } else {
            System.out.println("Failed to establish database connection.");
        }
    }

    public List<Cart> getAllCartForUserWithParam(String searchParam, int cid) {
        List<Cart> carts = new ArrayList<>();
        List<Object> list = new ArrayList<>();

        try {
            StringBuilder query = new StringBuilder();
            query.append("Select c.* from Carts c JOIN Products p ON p.ProductId = c.ProductId  where c.customerID = ?");

            list.add(cid);
            if (searchParam != null && !searchParam.trim().isEmpty()) {
                query.append(" AND p.Name LIKE ? ");
                list.add("%" + searchParam + "%");
            }
            query.append(" ORDER BY c.CartID DESC");
            PreparedStatement preparedStatement;
            preparedStatement = conn.prepareStatement(query.toString());
            mapParams(preparedStatement, list);
            try ( ResultSet resultSet = preparedStatement.executeQuery()) {
                while (resultSet.next()) {
                    Cart cart = new Cart();
                    cart.setCartID(resultSet.getInt("CartID"));
                    cart.setPrice(resultSet.getInt("Price"));

                    cart.setProduct(getProductByID(resultSet.getInt("ProductID")));
                    cart.setCustomerID(resultSet.getInt("customerID"));
                    cart.setQuantity(resultSet.getInt("Quantity"));
                    carts.add(cart);
                }
            }
        } catch (Exception e) {
            
        }
        return carts;
    }

    public Cart getCartByProductAndCustomer(int productID, int customerID) {
        Cart cart = null;
        String query = "SELECT * FROM Carts WHERE ProductID = ? AND CustomerID = ?";

        try ( PreparedStatement preparedStatement = conn.prepareStatement(query)) {
            preparedStatement.setInt(1, productID);
            preparedStatement.setInt(2, customerID);

            try ( ResultSet resultSet = preparedStatement.executeQuery()) {
                if (resultSet.next()) {
                    cart = new Cart();
                    cart.setCartID(resultSet.getInt("CartID"));
                    cart.setPrice(resultSet.getInt("Price"));
                    cart.setQuantity(resultSet.getInt("Quantity"));

                    cart.setProductID(resultSet.getInt("ProductID"));
                    cart.setCustomerID(resultSet.getInt("CustomerID"));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return cart;
    }

    public Cart getCartByID(int cartID) {
        Cart cart = null;
        String query = "SELECT * FROM Carts WHERE CartID = ? ";

        try ( PreparedStatement preparedStatement = conn.prepareStatement(query)) {
            preparedStatement.setInt(1, cartID);

            try ( ResultSet resultSet = preparedStatement.executeQuery()) {
                if (resultSet.next()) {
                    cart = new Cart();
                    cart.setCartID(resultSet.getInt("CartID"));
                    cart.setPrice(resultSet.getInt("Price"));
                    cart.setQuantity(resultSet.getInt("Quantity"));

                    cart.setProductID(resultSet.getInt("ProductID"));
                    cart.setCustomerID(resultSet.getInt("CustomerID"));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return cart;
    }

    public void updateCart(Cart cart) {
        String query = "UPDATE Carts SET Quantity = ?  WHERE CartID = ?";

        try ( PreparedStatement preparedStatement = conn.prepareStatement(query)) {
            preparedStatement.setInt(1, cart.getQuantity());

            preparedStatement.setInt(2, cart.getCartID());

            int rowsUpdated = preparedStatement.executeUpdate();

            if (rowsUpdated > 0) {
                System.out.println("Cart with ID " + cart.getCartID() + " updated successfully.");
            } else {
                System.out.println("No cart found with ID " + cart.getCartID() + ". Update failed.");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void addToCart(Cart cart) {
        String query = "INSERT INTO Carts (Price, Quantity,   ProductID, CustomerID) VALUES (?, ?,   ?, ?)";

        try ( PreparedStatement preparedStatement = conn.prepareStatement(query)) {
            preparedStatement.setDouble(1, cart.getPrice());
            preparedStatement.setInt(2, cart.getQuantity());

            preparedStatement.setInt(3, cart.getProductID());
            preparedStatement.setInt(4, cart.getCustomerID());

            int rowsInserted = preparedStatement.executeUpdate();

            if (rowsInserted > 0) {
                System.out.println("Cart item added successfully.");
            } else {
                System.out.println("Failed to add cart item.");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public Product getProductByID(int id) {

        try {
            String query = "Select * from products where ProductId  = ?";

            PreparedStatement preparedStatement;
            preparedStatement = conn.prepareStatement(query);
            preparedStatement.setInt(1, id);
            try ( ResultSet resultSet = preparedStatement.executeQuery()) {
                if (resultSet.next()) {
                    Product product = new Product();
                    product.setProductID(resultSet.getInt("productID"));
                    product.setName(resultSet.getString("name"));
                    product.setPrice(resultSet.getInt("Price"));
                    product.setQuantity(resultSet.getInt("Quantity"));
                    product.setImage(resultSet.getString("Image"));

                    return product;
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    public void deleteByID(int cartID) {
        String query = "DELETE FROM Carts WHERE CartID = ?";

        try ( PreparedStatement preparedStatement = conn.prepareStatement(query)) {
            preparedStatement.setInt(1, cartID);

            int rowsAffected = preparedStatement.executeUpdate();

            if (rowsAffected > 0) {
                System.out.println("Cart with ID " + cartID + " deleted successfully.");
            } else {
                System.out.println("No cart found with ID " + cartID + ". Nothing deleted.");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void mapParams(PreparedStatement ps, List<Object> args) throws SQLException {
        int i = 1;
        for (Object arg : args) {
            if (arg instanceof Date) {
                ps.setTimestamp(i++, new Timestamp(((Date) arg).getTime()));
            } else if (arg instanceof Integer) {
                ps.setInt(i++, (Integer) arg);
            } else if (arg instanceof Long) {
                ps.setLong(i++, (Long) arg);
            } else if (arg instanceof Double) {
                ps.setDouble(i++, (Double) arg);
            } else if (arg instanceof Float) {
                ps.setFloat(i++, (Float) arg);
            } else {
                ps.setString(i++, (String) arg);
            }

        }
    }

    public int getCartSizeForCustomer(int customerId) {
        int cartSize = 0;
        String query = "SELECT COUNT(*) AS cartSize FROM Carts WHERE CustomerID = ?";

        try ( PreparedStatement preparedStatement = conn.prepareStatement(query)) {
            preparedStatement.setInt(1, customerId);
            try ( ResultSet resultSet = preparedStatement.executeQuery()) {
                if (resultSet.next()) {
                    cartSize = resultSet.getInt("cartSize");
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return cartSize;
    }

    public List<Cart> Paging(List<Cart> carts, int page, int pageSize) {
        int fromIndex = (page - 1) * pageSize;
        int toIndex = Math.min(fromIndex + pageSize, carts.size());

        if (fromIndex > toIndex) {
            // Handle the case where fromIndex is greater than toIndex
            fromIndex = toIndex;
        }

        return carts.subList(fromIndex, toIndex);
    }

    public static void main(String[] args) {
        CartDAO cdao = new CartDAO();
        Cart c = new Cart();
        Cart newCart = new Cart();
        newCart.setProductID(1);
        newCart.setCustomerID(1);
        newCart.setQuantity(1);
        newCart.setPrice(1);
        newCart.setTotal(1);

        cdao.addToCart(c);
    }

}
