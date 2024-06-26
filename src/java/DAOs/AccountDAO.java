/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAOs;

import DBConnect.DBConnection;
import Models.Admin;
import Models.Customer;
import Models.Employee;
import java.math.BigInteger;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Base64;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author Nguyen Van Giau - CE170449
 */
public class AccountDAO {

    Connection conn;

    public AccountDAO() {
        try {
            conn = DBConnection.connect();
            if (conn != null) {
                System.out.println("Database connection established successfully.");
            } else {
                System.out.println("Failed to establish database connection.");
            }
        } catch (SQLException ex) {
            Logger.getLogger(AccountDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public String getMd5(String input) {
        try {

            // Static getInstance method is called with hashing MD5
            MessageDigest md = MessageDigest.getInstance("MD5");

            // digest() method is called to calculate message digest
            // of an input digest() return array of byte
            byte[] messageDigest = md.digest(input.getBytes());

            // Convert byte array into signum representation
            BigInteger no = new BigInteger(1, messageDigest);

            // Convert message digest into hex value
            String hashtext = no.toString(16);
            while (hashtext.length() < 32) {
                hashtext = "0" + hashtext;
            }
            return hashtext;
        } // For specifying wrong message digest algorithms
        catch (NoSuchAlgorithmException e) {
            throw new RuntimeException(e);
        }
    }

    public Admin loginByAdmin(String email, String password) {
        Admin admin = null;
        try {
            PreparedStatement ps = conn.prepareStatement("select * from Admin where email = ? and password = ?");
            ps.setString(1, email);
            ps.setString(2, getMd5(password));
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                admin = new Admin(rs.getInt(1), rs.getString(2), rs.getString(3), rs.getString(4), rs.getString(5), rs.getInt(6));
            }
        } catch (SQLException ex) {
            Logger.getLogger(AccountDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return admin;
    }
    public Employee loginByEmployee(String email, String password) {
        Employee employee = null;
        try {
            PreparedStatement ps = conn.prepareStatement("select * from Employees where email = ? and password = ?");
            ps.setString(1, email);
            ps.setString(2, getMd5(password));
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                employee = new Employee(rs.getInt(1), rs.getString(2), rs.getString(3), rs.getString(4), rs.getString(5), rs.getInt(6));
            }
        } catch (SQLException ex) {
            Logger.getLogger(AccountDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return employee;
    }

    public Customer loginByCustomer(String email, String password) {
        Customer customer = null;

        try {
            PreparedStatement ps = conn.prepareStatement("select * from Customers where email = ? and password = ?");
            ps.setString(1, email);
            ps.setString(2, getMd5(password));
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                customer = new Customer(rs.getInt(1), rs.getString(2), rs.getString(3), rs.getString(4), rs.getString(5), rs.getString(6), rs.getString(7));
            }
            rs.close();
            ps.close();
            conn.close();
        } catch (SQLException ex) {
            Logger.getLogger(AccountDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return customer;
    }
    // Hàm mã hóa văn bản thành Base64

    public String encodeString(String text) {
        try {
            byte[] encodedBytes = Base64.getEncoder().encode(text.getBytes("UTF-8"));
            return new String(encodedBytes, "UTF-8");
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }
    // Hàm giải mã Base64 thành văn bản

    public String decodeString(String encodedText) {
        try {
            byte[] decodedBytes = Base64.getDecoder().decode(encodedText.getBytes("UTF-8"));
            return new String(decodedBytes, "UTF-8");
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }
}
