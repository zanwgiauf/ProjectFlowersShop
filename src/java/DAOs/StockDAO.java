/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAOs;

import DBConnect.DBConnection;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

/**
 *
 * @author Le Minh Truong - CE171886
 */
public class StockDAO {
    private Connection conn;
    PreparedStatement ps = null;
    ResultSet rs = null;

    public StockDAO() {
        conn = DBConnection.connect();
        if (conn != null) {
            System.out.println("Database connection established successfully.");
        } else {
            System.out.println("Failed to establish database connection.");
        }
    } // Your DB connection method
    
    public void updateStock(int productID, int importQuantity, int exportQuantity) {
        String query = "UPDATE Products SET quantity = quantity + ? - ? WHERE productID = ?";
        try {
            PreparedStatement ps = conn.prepareStatement(query);
            ps.setInt(1, importQuantity);
            ps.setInt(2, exportQuantity);
            ps.setInt(3, productID);
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    
}
