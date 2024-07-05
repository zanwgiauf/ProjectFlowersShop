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
        try {
            conn = DBConnection.connect();
        } catch (SQLException ex) {
            Logger.getLogger(ProductDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

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
}
