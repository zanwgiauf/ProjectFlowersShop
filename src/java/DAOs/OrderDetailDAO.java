/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAOs;

import DBConnect.DBConnection;
import Models.OrderDetail;
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
public class OrderDetailDAO {
    Connection conn;
    PreparedStatement ps;
    ResultSet rs;

    public OrderDetailDAO() {
        try {
            conn = DBConnection.connect();
        } catch (SQLException ex) {
            Logger.getLogger(OrderDetailDAO.class.getName()).log(Level.SEVERE, null, ex);
        }

    }
    public OrderDetail addOrderDetail(OrderDetail orderDetail){
        int  orderDetailID = 0;
        String sql = "insert into OrderDetails values(?,?,?,?,?)";
        try {
            ps = conn.prepareStatement(sql);
            ps.setString(1, orderDetail.getName());
            ps.setInt(2,orderDetail.getPrice());
            ps.setInt(3,orderDetail.getQuantity());
            ps.setInt(4, orderDetail.getOrderID());
            ps.setInt(5, orderDetail.getProductID());
            ps.executeUpdate();
            rs = ps.getGeneratedKeys();
            if(rs.next()){
                orderDetailID = rs.getInt(1);
            }
        } catch (SQLException ex) {
            Logger.getLogger(OrderDetailDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return orderDetail;
    }
    
}
