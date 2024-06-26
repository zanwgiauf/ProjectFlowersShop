/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DBConnect;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author Nguyen Van Giau - CE170449
 */
public class DBConnection {
    private static final String urlConnect = "jdbc:sqlserver://LAPTOP-BCDMRMAF\\MYLAPTOP:1433;databasename=FlowersShop;user=sa;password=sa;characterEncoding=UTF-8;encrypt=true;trustServerCertificate=true;";
    public static Connection connect() {
        try {
            Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
            // tao doi tuong connection 
            Connection conn = DriverManager.getConnection(urlConnect);
            return conn;
        } catch(ClassNotFoundException | SQLException ex) {
            System.out.println(ex);
        } 
        return null;
    }
    public static void closeConnection(Connection conn) {
        if (conn != null) {
            try {
                conn.close();
                System.out.println("Connection closed.");
            } catch (SQLException ex) {
                Logger.getLogger(DBConnection.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
    }
}