package DAOs;

import DBConnect.DBConnection;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.time.LocalDateTime;

public class PasswordResetDAO {

    public boolean savePasswordResetRequest(String email, String otp, LocalDateTime expirationTime) {
        String sql = "INSERT INTO password_reset (email, otp, expiration_time) VALUES (?, ?, ?)";
        try (Connection conn = DBConnection.connect();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, email);
            stmt.setString(2, otp);
            stmt.setTimestamp(3, Timestamp.valueOf(expirationTime));
            stmt.executeUpdate();
            return true;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

   public boolean isOTPValid(String email, String otp) {
    String sql = "SELECT otp, expiration_time FROM password_reset WHERE email = ? AND otp = ? AND expiration_time > ?";
    try (Connection conn = DBConnection.connect();
         PreparedStatement stmt = conn.prepareStatement(sql)) {
        stmt.setString(1, email);
        stmt.setString(2, otp);
        stmt.setTimestamp(3, Timestamp.valueOf(LocalDateTime.now())); // So sánh thời gian hiện tại được di chuyển vào truy vấn SQL
        ResultSet rs = stmt.executeQuery();
        return rs.next(); // Trả về đơn giản, giả định nếu có kết quả, OTP hợp lệ
    } catch (SQLException e) {
        e.printStackTrace();
    }
    return false;
}

}
