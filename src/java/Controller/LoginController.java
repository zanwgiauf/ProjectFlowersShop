/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller;

import DAOs.AccountDAO;
import Models.Admin;
import Models.Customer;
import Models.Employee;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;

/**
 *
 * @author ADMIN
 */
@WebServlet(name = "LoginController", urlPatterns = {"/LoginController"})
/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

public class LoginController extends HttpServlet {

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
            out.println("<title>Servlet LoginController</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet LoginController at " + request.getContextPath() + "</h1>");
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
        String path = request.getRequestURI();
        if (path.endsWith("/login")) {
            response.sendRedirect("login.jsp");

        }

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
        if (request.getParameter("loginSubmit") != null) {
            String email = request.getParameter("email");
            String password = request.getParameter("password");
            if (email.contains("@gmail")) {
                AccountDAO ad = new AccountDAO();
                Customer customer = ad.loginByCustomer(email, password); // Di chuyển dòng này lên trước

                if (customer != null) {
                    int customerID = customer.getCustomerID();
                    String fullName = customer.getFullName();
                    Cookie idC = new Cookie("idC", String.valueOf(customerID));
                    Cookie fullnameC = new Cookie("fullNameC", ad.encodeString(fullName));
                    Cookie emailC = new Cookie("emailC", email);
                    Cookie passwordC = new Cookie("passwordC", password);
                    idC.setMaxAge((60 * 60 * 24) * 2);
                    fullnameC.setMaxAge((60 * 60 * 24) * 2);
                    emailC.setMaxAge((60 * 60 * 24) * 2);
                    passwordC.setMaxAge((60 * 60 * 24) * 2);
                    response.addCookie(idC);
                    response.addCookie(fullnameC);
                    response.addCookie(emailC);
                    response.addCookie(passwordC);
                    HttpSession session = request.getSession();
                    session.setAttribute("customerInfor", customer);
                    response.sendRedirect(request.getContextPath() + "/");
                    System.out.println("Add Cookie Successfully");
                } else {
                    String message = "Email or password is incorrect!";
                    HttpSession session = request.getSession();
                    session.setAttribute("checkLoginMess", message);
                    response.sendRedirect(request.getContextPath() + "/login");
                }
            } else if (email.contains("@AdminzFlowers")) {
                AccountDAO ad = new AccountDAO();
                Admin admin = ad.loginByAdmin(email, password);
                if (admin != null) {
                     HttpSession session = request.getSession();
                    session.setAttribute("Admin", admin);
                    String fullName = admin.getFullName();
                    int adminID = admin.getAdminID();
                    int roleID = admin.getRoleID();
                    Cookie fullNameA = new Cookie("fullNameA", ad.encodeString(fullName));
                    Cookie emailA = new Cookie("emailA", email);
                    Cookie roleA = new Cookie("roleA", String.valueOf(roleID));
                    Cookie adminIDA = new Cookie("adminIDA", String.valueOf(adminID));
                    Cookie passwordA = new Cookie("passwordA", password);
                    adminIDA.setMaxAge((60 * 60 * 24) * 2);
                    fullNameA.setMaxAge((60 * 60 * 24) * 2);
                    emailA.setMaxAge((60 * 60 * 24) * 2);
                    passwordA.setMaxAge((60 * 60 * 24) * 2);
                    roleA.setMaxAge((60 * 60 * 24) * 2);
                    response.addCookie(adminIDA);
                    response.addCookie(fullNameA);
                    response.addCookie(emailA);
                    response.addCookie(passwordA);
                    response.addCookie(roleA);
                    response.sendRedirect(request.getContextPath() + "/admin");
                } else {
                    String message = "Email or password is incorrect!";
                    HttpSession session = request.getSession();
                    session.setAttribute("checkLoginMess", message);
                    response.sendRedirect(request.getContextPath() + "/login");
                }
            } else if (email.contains("@zFlowers")) {
                AccountDAO ad = new AccountDAO();
                Employee employee = ad.loginByEmployee(email, password);
                if (employee != null && employee.getStatus() != 0) {
                    String fullName = employee.getFullName();
                    int employeeID = employee.getEmployeeID();
                    int roleID = employee.getRoleID();
                    Cookie fullNameE = new Cookie("fullNameE", ad.encodeString(fullName));
                    Cookie emailE = new Cookie("emailE", email);
                    Cookie roleE = new Cookie("roleE", String.valueOf(roleID));
                    Cookie employeeIDE = new Cookie("employeeIDE", String.valueOf(employeeID));
                    Cookie passwordE = new Cookie("employeeIDE", password);
                    employeeIDE.setMaxAge((60 * 60 * 24) * 2);
                    fullNameE.setMaxAge((60 * 60 * 24) * 2);
                    emailE.setMaxAge((60 * 60 * 24) * 2);
                    passwordE.setMaxAge((60 * 60 * 24) * 2);
                    roleE.setMaxAge((60 * 60 * 24) * 2);
                    response.addCookie(employeeIDE);
                    response.addCookie(fullNameE);
                    response.addCookie(emailE);
                    response.addCookie(passwordE);
                    response.addCookie(roleE);
                     HttpSession session = request.getSession();
                    session.setAttribute("employee", employee);
                    response.sendRedirect(request.getContextPath() + "/employee");
                } else {
                    String message = "Email or password is incorrect!";
                    HttpSession session = request.getSession();
                    session.setAttribute("checkLoginMess", message);
                    response.sendRedirect(request.getContextPath() + "/login");
                }

            } else {
                String message = "Email or password is incorrect!";
                HttpSession session = request.getSession();
                session.setAttribute("checkLoginMess", message);
                response.sendRedirect(request.getContextPath() + "/login");
            }
        }
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
