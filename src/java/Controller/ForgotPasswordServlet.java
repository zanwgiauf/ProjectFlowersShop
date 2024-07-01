package Controller;

import DAOs.CustomerDAO;
import DAOs.PasswordResetDAO;
import java.io.IOException;
import java.time.Duration;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.Properties;
import java.util.Random;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import javax.activation.DataHandler;
import javax.activation.DataSource;
import javax.activation.FileDataSource;
import javax.mail.Multipart;
import javax.mail.internet.MimeBodyPart;
import javax.mail.internet.MimeMultipart;

@WebServlet("/forgotPassword")
public class ForgotPasswordServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private static final String FROM_EMAIL = "Cuongncc2002@gmail.com";
    private static final String PASSWORD = "otok kkly imyk lixi";

    private PasswordResetDAO passwordResetDAO = new PasswordResetDAO();
    private CustomerDAO customerDAO = new CustomerDAO();

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("forgot_password.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String email = request.getParameter("email");

        if (emailExistsInDatabase(email)) {
            String otp = generateOTP();
            LocalDateTime changeTime = LocalDateTime.now();
            Duration otpDuration = Duration.ofMinutes(15);
            LocalDateTime expirationTime = changeTime.plus(otpDuration);

            passwordResetDAO.savePasswordResetRequest(email, otp, expirationTime);
            sendOTPEmail(email, otp, changeTime, otpDuration);

            response.sendRedirect("verify_otp.jsp?email=" + email);
        } else {
            request.setAttribute("error", "Email không tồn tại trong hệ thống.");
            request.getRequestDispatcher("forgot_password.jsp").forward(request, response);
        }
    }

    private boolean emailExistsInDatabase(String email) {
        return customerDAO.emailExists(email); // Đảm bảo rằng phương thức này tồn tại và được triển khai chính xác trong CustomerDAO
    }

    private String generateOTP() {
        Random random = new Random();
        int otp = 100000 + random.nextInt(900000);
        return String.valueOf(otp);
    }

    private void sendOTPEmail(String recipientEmail, String otp, LocalDateTime changeTime, Duration otpDuration) {
    Properties props = new Properties();
    props.put("mail.smtp.auth", "true");
    props.put("mail.smtp.starttls.enable", "true");
    props.put("mail.smtp.host", "smtp.gmail.com");
    props.put("mail.smtp.port", "587");

    Session session = Session.getInstance(props, new javax.mail.Authenticator() {
        protected javax.mail.PasswordAuthentication getPasswordAuthentication() {
            return new javax.mail.PasswordAuthentication(FROM_EMAIL, PASSWORD);
        }
    });

    try {
        Message message = new MimeMessage(session);
        message.setFrom(new InternetAddress(FROM_EMAIL));
        message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(recipientEmail));
        message.setSubject("Password retrieval - OTP code");

        // Tạo nội dung HTML
        String htmlContent = "<html><body>" +
                "<h1>Dear " + recipientEmail.split("@")[0] + ",</h1>" +
                "<div style='font-size: 16px;'>" +
                "You have requested to change password on " + 
                changeTime.format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss")) + ".<br>" +
                "In order to proceed, please enter the verification code: <b>" + otp + "</b> in Account Center.<br>" +
                "This code will expire " + otpDuration.toMinutes() + " minutes after this email was sent.<br>" +
                "If this is not requested by you, please contact our <a href='mailto:Cuongncce171631@fpt.edu.vn'>customer service</a> immediately.<br><br>" +
                "This is a computer-generated email. Please do not reply to this email.<br>" +
                "</div>" +
                "<p>Best Regards,<br>" +
                "<img src='cid:logo' alt='Logo' style='height: 50px;'><br>" +
                "Your Company Name<br>" +
                "</p></body></html>";

        // Đính kèm logo như một phần của multipart email
        Multipart multipart = new MimeMultipart();

        // Thêm phần HTML
        MimeBodyPart htmlPart = new MimeBodyPart();
        htmlPart.setContent(htmlContent, "text/html; charset=utf-8");
        multipart.addBodyPart(htmlPart);

        // Thêm logo
        MimeBodyPart imagePart = new MimeBodyPart();
        DataSource fds = new FileDataSource("/D:\\giau\\ProjectFlowersShop\\web\\images\\logoF.png"); // Đường dẫn đến file logo
        imagePart.setDataHandler(new DataHandler(fds));
        imagePart.setHeader("Content-ID", "<logo>"); // Sử dụng Content-ID này trong thẻ img của HTML
        multipart.addBodyPart(imagePart);

        message.setContent(multipart);
        Transport.send(message);

        System.out.println("HTML email with logo sent to " + recipientEmail);
    } catch (MessagingException e) {
        throw new RuntimeException(e);
    }
}


}
