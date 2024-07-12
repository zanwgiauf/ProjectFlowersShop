/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAOs;

import DBConnect.DBConnection;
import Models.Feedback;

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
public class FeedbackDAO {

    Connection conn;

    public FeedbackDAO() {
        conn = DBConnection.connect();
        if (conn != null) {
            System.out.println("Database connection established successfully.");
        } else {
            System.out.println("Failed to establish database connection.");
        }
    }

    public List<Feedback> getAllFeedback(String searchParam, Integer productID) {
        List<Feedback> feedbacks = new ArrayList<>();
        List<Object> list = new ArrayList<>();
        CustomerDAO customerDAO = new CustomerDAO();
        ProductDAO productDAO = new ProductDAO();
        try {
            StringBuilder query = new StringBuilder();
            query.append("Select f.*, p.quantity, c.fullName from Feedbacks f JOIN Products p \n"
                    + "ON f.productID = p.productID\n"
                    + "JOIN Customers c \n"
                    + "ON c.customerID = f.customerID where 1=1 ");
            if (searchParam != null && !searchParam.trim().isEmpty()) {
                query.append(" AND (f.content LIKE ? OR c.fullName like ? OR p.name LIKE ?)");
                list.add("%" + searchParam + "%");
                list.add("%" + searchParam + "%");
                list.add("%" + searchParam + "%");
            }
            if (productID != null) {
                query.append(" AND f.productID = ? ");
                list.add(productID);
            }

            query.append(" ORDER BY f.feedbackID DESC");
            PreparedStatement preparedStatement;
            preparedStatement = conn.prepareStatement(query.toString());
            mapParams(preparedStatement, list);

            try ( ResultSet resultSet = preparedStatement.executeQuery()) {
                while (resultSet.next()) {
                    Feedback feedback = new Feedback();
                    feedback.setFeedbackID(resultSet.getInt("feedbackID"));
                    feedback.setContent(resultSet.getString("content"));
                    feedback.setCustomer(customerDAO.getById(resultSet.getInt("customerID")));
                    feedback.setProduct(productDAO.getProductById(resultSet.getInt("productID")));
                    feedbacks.add(feedback);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return feedbacks;
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
// Method to add a new feedback

    public void addFeedback(Feedback feedback) {
        String sql = "INSERT INTO Feedbacks (content, customerID, productID) VALUES (?, ?, ?)";
        try ( PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, feedback.getContent());
            ps.setInt(2, feedback.getCustomer().getCustomerID());
            ps.setInt(3, feedback.getProductID());
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    // Method to update an existing feedback
    public void updateFeedback(Feedback feedback) {
        String sql = "UPDATE Feedbacks SET content = ?, customerID = ?, productID = ? WHERE feedbackID = ?";
        try ( PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, feedback.getContent());
            ps.setInt(2, feedback.getCustomer().getCustomerID());
            ps.setInt(3, feedback.getProductID());
            ps.setInt(4, feedback.getFeedbackID());
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    // Method to delete a feedback by its ID
    public void deleteFeedback(int feedbackID) {
        String sql = "DELETE FROM Feedbacks WHERE feedbackID = ?";
        try ( PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, feedbackID);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public List<Feedback> Paging(List<Feedback> feedbacks, int page, int pageSize) {
        int fromIndex = (page - 1) * pageSize;
        int toIndex = Math.min(fromIndex + pageSize, feedbacks.size());

        if (fromIndex > toIndex) {
            // Handle the case where fromIndex is greater than toIndex
            fromIndex = toIndex;
        }

        return feedbacks.subList(fromIndex, toIndex);
    }
}
