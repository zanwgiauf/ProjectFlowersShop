/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller;

import DAOs.AccountDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.time.format.DateTimeParseException;
import java.util.regex.Pattern;

/**
 * Servlet implementation class RegisterController
 */
@WebServlet("/RegisterController")
public class RegisterController extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private AccountDAO accountDAO;

    public void init() throws ServletException {
        super.init();
        accountDAO = new AccountDAO();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String path = request.getRequestURI();
        if (path.endsWith("/register")) {
            request.getRequestDispatcher("register.jsp").forward(request, response);
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String name = request.getParameter("yourName");
        String date = request.getParameter("yourDate");
        String phone = request.getParameter("yourPhone");
        String email = request.getParameter("yourEmail");
        String address = request.getParameter("yourAddress");
        String password = request.getParameter("yourPassword");
        String repeatPassword = request.getParameter("yourRepeatPassword");

        // Kiểm tra định dạng số điện thoại và email
        Pattern phonePattern = Pattern.compile("^\\d{10}$"); // Số điện thoại có 10 chữ số
        Pattern emailPattern = Pattern.compile("^[^\\s@]+@gmail\\.com$"); // Chỉ cho phép email @gmail.com
        Pattern namePattern = Pattern.compile("^[A-Z][a-z]+(?:\\s[A-Z][a-z]+)+$"); // Tên có ít nhất 2 từ và viết hoa chữ cái đầu
        Pattern addressPattern = Pattern.compile("^[A-Za-z0-9\\s]+$"); // Địa chỉ không chứa ký tự đặc biệt

        // Set form data back to the request
        request.setAttribute("yourName", name);
        request.setAttribute("yourDate", date);
        request.setAttribute("yourPhone", phone);
        request.setAttribute("yourEmail", email);
        request.setAttribute("yourAddress", address);

        if (!phonePattern.matcher(phone).matches()) {
            request.setAttribute("registrationStatus", "invalidPhone");
            request.getRequestDispatcher("/register.jsp").forward(request, response);
            return;
        }

        if (!emailPattern.matcher(email).matches()) {
            request.setAttribute("registrationStatus", "invalidEmail");
            request.getRequestDispatcher("/register.jsp").forward(request, response);
            return;
        }

        if (!namePattern.matcher(name).matches()) {
            request.setAttribute("registrationStatus", "invalidName");
            request.getRequestDispatcher("/register.jsp").forward(request, response);
            return;
        }

        if (!addressPattern.matcher(address).matches()) {
            request.setAttribute("registrationStatus", "invalidAddress");
            request.getRequestDispatcher("/register.jsp").forward(request, response);
            return;
        }

        if (accountDAO.emailExists(email)) {
            request.setAttribute("registrationStatus", "emailExists");
            request.getRequestDispatcher("/register.jsp").forward(request, response);
            return;
        }

        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
        try {
            LocalDate birthDate = LocalDate.parse(date, formatter);
            LocalDate today = LocalDate.now();
            if (birthDate.isAfter(today)) {
                request.setAttribute("registrationStatus", "invalidDate");
                request.getRequestDispatcher("/register.jsp").forward(request, response);
                return;
            }
        } catch (DateTimeParseException e) {
            request.setAttribute("registrationStatus", "invalidDate");
            request.getRequestDispatcher("/register.jsp").forward(request, response);
            return;
        }

        // Check if passwords match and have at least 6 characters
        if (password.length() < 6) {
            request.setAttribute("registrationStatus", "shortPassword");
            request.getRequestDispatcher("/register.jsp").forward(request, response);
            return;
        }

        if (!password.equals(repeatPassword)) {
            request.setAttribute("registrationStatus", "passwordMismatch");
            request.getRequestDispatcher("/register.jsp").forward(request, response);
            return;
        }

        // Perform registration logic here
        boolean registrationSuccessful = accountDAO.registerCustomer(name, date, phone, email, address, password);

        if (registrationSuccessful) {
            request.setAttribute("registrationStatus", "success");
        } else {
            request.setAttribute("registrationStatus", "error");
        }

        request.getRequestDispatcher("/register.jsp").forward(request, response);
    }
}
