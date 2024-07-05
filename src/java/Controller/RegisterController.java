/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller;

import java.io.PrintWriter;

import DAOs.AccountDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.time.format.DateTimeParseException;
import java.util.regex.Pattern;

/**
 *
 * @author Nguyen Van Giau - CE170449
 */
public class RegisterController extends HttpServlet {
    
    private static final long serialVersionUID = 1L;

    private AccountDAO accountDAO;

    public void init() throws ServletException {
        super.init();
        accountDAO = new AccountDAO();
    }

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try ( PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet RegisterController</title>");            
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet RegisterController at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
               
            request.getRequestDispatcher("register.jsp").forward(request, response);

        }
    

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
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

        // Perform registration logic here
        boolean registrationSuccessful = false;

        // Example: Check if passwords match and other validation checks
        if (password.equals(repeatPassword)) {
            registrationSuccessful = accountDAO.registerCustomer(name, date, phone, email, address, password);
        }

        if (registrationSuccessful) {
            request.setAttribute("registrationStatus", "success");
        } else {
            request.setAttribute("registrationStatus", "error");
        }

        request.getRequestDispatcher("/register.jsp").forward(request, response);
    }
    

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}