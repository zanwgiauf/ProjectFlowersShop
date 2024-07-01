package Controller;

import DAOs.PasswordResetDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.time.LocalDateTime;

@WebServlet("/verifyOTP")
public class VerifyOTPServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private PasswordResetDAO passwordResetDAO = new PasswordResetDAO();

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("verify_otp.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String email = request.getParameter("email");
        String otp = request.getParameter("otp");

        if (passwordResetDAO.isOTPValid(email, otp)) {
            response.sendRedirect("reset_password.jsp?email=" + email);
        } else {
            request.setAttribute("error", "The OTP code is invalid or has expired.");
            request.getRequestDispatcher("verify_otp.jsp").forward(request, response);
        }
    }

}
