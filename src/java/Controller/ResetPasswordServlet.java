package Controller;

import DAOs.CustomerDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/resetPassword")
public class ResetPasswordServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private CustomerDAO customerDAO = new CustomerDAO();

   protected void doPost(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
    String email = request.getParameter("email");
    String newPassword = request.getParameter("password");

    if (newPassword == null || newPassword.trim().isEmpty()) {
        System.out.println("Mật khẩu mới không được để trống");
        response.sendRedirect("reset_password.jsp");
    } else {
        boolean passwordUpdated = customerDAO.updatePassword(email, newPassword);

        if (passwordUpdated) {
            response.sendRedirect("login.jsp");
        } else {
            response.sendRedirect("reset_password.jsp");
        }
    }
}

}
