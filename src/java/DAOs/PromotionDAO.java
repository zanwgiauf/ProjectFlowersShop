/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAOs;

import DBConnect.DBConnection;
import Models.Promotion;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author Le Minh Truong - CE171886
 */
public class PromotionDAO {

    private Connection conn;
    PreparedStatement stmt = null;
    ResultSet rs = null;

    public PromotionDAO() {
        conn = DBConnection.connect();
        if (conn != null) {
            System.out.println("Database connection established successfully.");
        } else {
            System.out.println("Failed to establish database connection.");
        }
    } // Your DB connection method
    // Method to get all promotions

    public List<Promotion> getAllPromotions() {
        List<Promotion> promotionsList = new ArrayList<>();
        try {
            conn = DBConnection.connect();
            String query = "SELECT * FROM Promotions";
            stmt = conn.prepareStatement(query);
            rs = stmt.executeQuery();

            while (rs.next()) {
                Promotion promo = new Promotion(
                        rs.getInt("promotionID"),
                        rs.getString("promotionCode"),
                        rs.getString("description"),
                        rs.getString("discount"),
                        rs.getString("startDate"),
                        rs.getString("endDate"),
                        rs.getInt("orderID")
                );
                promotionsList.add(promo);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return promotionsList;
    }

    // Method to add a new promotion
    public void addPromotion(Promotion promotion) {

        try {
            conn = DBConnection.connect();
            String query = "INSERT INTO Promotions (promotionCode, description, discount, startDate, endDate) VALUES (?, ?, ?, ?, ?)";
            stmt = conn.prepareStatement(query);
            stmt.setString(1, promotion.getPromotionCode());
            stmt.setString(2, promotion.getDescription());
            stmt.setString(3, promotion.getDiscount());
            stmt.setString(4, promotion.getStartDate());
            stmt.setString(5, promotion.getEndDate());
            stmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    // Method to update an existing promotion
    public void updatePromotion(Promotion promotion) {
        try {
            conn = DBConnection.connect();
            String query = "UPDATE Promotions SET promotionCode = ?, description = ?, discount = ?, startDate = ?, endDate = ? WHERE promotionID = ?";
            stmt = conn.prepareStatement(query);
            stmt.setString(1, promotion.getPromotionCode());
            stmt.setString(2, promotion.getDescription());
            stmt.setString(3, promotion.getDiscount());
            stmt.setString(4, promotion.getStartDate());
            stmt.setString(5, promotion.getEndDate());
            stmt.setInt(6, promotion.getPromotionID());
            stmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    // Method to delete a promotion
    public void deletePromotion(int promotionID) {

        try {
            conn = DBConnection.connect();
            String query = "DELETE FROM Promotions WHERE promotionID = ?";
            stmt = conn.prepareStatement(query);
            stmt.setInt(1, promotionID);
            stmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    // Method to get a single promotion by ID
    public Promotion getPromotionByID(int promotionID) {
        Promotion promo = null;

        try {
            conn = DBConnection.connect();
            String query = "SELECT * FROM Promotions WHERE promotionID = ?";
            stmt = conn.prepareStatement(query);
            stmt.setInt(1, promotionID);
            rs = stmt.executeQuery();
            if (rs.next()) {
                promo = new Promotion(
                        rs.getInt("promotionID"),
                        rs.getString("promotionCode"),
                        rs.getString("description"),
                        rs.getString("discount"),
                        rs.getString("startDate"),
                        rs.getString("endDate"),
                        rs.getInt("orderID")
                );
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return promo;
    }

    // Method to search promotions by code
    public List<Promotion> searchPromotionsByCode(String code) {
        List<Promotion> promotionsList = new ArrayList<>();
        try {
            conn = DBConnection.connect();
            String query = "SELECT * FROM Promotions WHERE promotionCode LIKE ?";
            stmt = conn.prepareStatement(query);
            stmt.setString(1, "%" + code + "%"); // Use % for partial match
            rs = stmt.executeQuery();

            while (rs.next()) {
                Promotion promo = new Promotion(
                        rs.getInt("promotionID"),
                        rs.getString("promotionCode"),
                        rs.getString("description"),
                        rs.getString("discount"),
                        rs.getString("startDate"),
                        rs.getString("endDate"),
                        rs.getInt("orderID")
                );
                promotionsList.add(promo);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return promotionsList;
    }

    public boolean promotionCodeExists(String code) {
        try {
            conn = DBConnection.connect();
            String query = "SELECT COUNT(*) FROM Promotions WHERE promotionCode = ?";
            stmt = conn.prepareStatement(query);
            stmt.setString(1, code);
            rs = stmt.executeQuery();
            if (rs.next()) {
                return rs.getInt(1) > 0; // true if count > 0
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
}
