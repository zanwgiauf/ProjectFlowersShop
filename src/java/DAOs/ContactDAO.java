/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAOs;

import DBConnect.DBConnection;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author Le Minh Truong - CE171886
 */
public class ContactDAO {

   Connection conn;
    PreparedStatement ps;
    ResultSet rs;

     public ContactDAO() {
        conn = DBConnection.connect();
        if (conn != null) {
            System.out.println("Database connection established successfully.");
        } else {
            System.out.println("Failed to establish database connection.");
        }
    }

    // Method to check if the email exists in the Customers table
    private boolean isCustomerExists(String email) throws SQLException {
        String sql = "SELECT COUNT(*) FROM Customers WHERE email = ?";
        try ( Connection conn = DBConnection.connect();  PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, email);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return rs.getInt(1) > 0;
            }
            return false;
        }
    }

    // Method to save feedback
    public void saveFeedback(String email, String message) throws SQLException {
        if (!isCustomerExists(email)) {
            throw new SQLException("No customer found with the provided email.");
        }

        String sql = "INSERT INTO Feedbacks (content, customerID) VALUES (?, (SELECT customerID FROM Customers WHERE email = ?))";
        try ( Connection conn = DBConnection.connect();  PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, message);
            stmt.setString(2, email);
            stmt.executeUpdate();
        }
    }
}
