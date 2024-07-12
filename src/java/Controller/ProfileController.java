/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller;

import DAOs.AccountDAO;
import DAOs.CustomerDAO;
import Models.Customer;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/**
 *
 * @author C15TQK
 */
public class ProfileController extends HttpServlet {

    private static final long serialVersionUID = 1L;
    private final CustomerDAO customerDAO = new CustomerDAO();

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
            out.println("<title>Servlet ProfileController</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ProfileController at " + request.getContextPath() + "</h1>");
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
        if (path.endsWith("/profile")) {
            Cookie[] cookies = request.getCookies();
            String customerID = null;
            if (cookies != null) {
                for (Cookie cookie : cookies) {
                    if ("idC".equals(cookie.getName())) {
                        customerID = cookie.getValue();
                        break;
                    }
                }
            }

            if (customerID == null) {
                // Xử lý trường hợp không tìm thấy customerID
                response.sendRedirect("login.jsp");
                return;
            }

            int customerIDInt = Integer.parseInt(customerID);
            Customer customer = customerDAO.getCustomerById(customerIDInt);
            if (customer == null) {
                // Xử lý trường hợp khách hàng không được tìm thấy
                request.setAttribute("errorMessage", "Customer not found.");
                request.getRequestDispatcher("error.jsp").forward(request, response);
                return;
            }

            request.setAttribute("customer", customer);
            request.getRequestDispatcher("profile.jsp").forward(request, response);
        } else {
            // Đảm bảo rằng các URL khác cũng được xử lý đúng
            response.sendRedirect(request.getContextPath() + "/error.jsp");
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
        Cookie[] cookies = request.getCookies();
        String customerIDC = null;
        if (cookies != null) {
            for (Cookie cookie : cookies) {
                if ("idC".equals(cookie.getName())) {
                    customerIDC = cookie.getValue();
                    break;
                }
            }
        }

        if (customerIDC == null || customerIDC.isEmpty()) {
            System.err.println("Customer ID cookie is missing.");
            request.setAttribute("errorMessage", "Customer ID cookie is missing.");
            request.getRequestDispatcher("error.jsp").forward(request, response);
            return;
        }

        int customerIDInt;
        try {
            customerIDInt = Integer.parseInt(customerIDC);
        } catch (NumberFormatException e) {
            System.err.println("Invalid Customer ID format.");
            request.setAttribute("errorMessage", "Invalid Customer ID format.");
            request.getRequestDispatcher("error.jsp").forward(request, response);
            return;
        }

        String fullName = request.getParameter("fullName");
        String birthday = request.getParameter("birthday");
        String phone = request.getParameter("phone");
        String email = request.getParameter("email");
        String address = request.getParameter("address");

        Customer customer = new Customer();
        customer.setCustomerID(customerIDInt);
        customer.setFullName(fullName);
        customer.setBirthday(birthday);
        customer.setPhone(phone);
        customer.setEmail(email);
        customer.setAddress(address);

        customerDAO.updateCustomer(customer);

        AccountDAO ad = new AccountDAO();
        
        // Cập nhật cookie cho fullName và email
        Cookie fullnameC = new Cookie("fullNameC", ad.encodeString(fullName));
        fullnameC.setMaxAge((60 * 60 * 24) * 2);
        response.addCookie(fullnameC);

        Cookie emailC = new Cookie("emailC", email);
        emailC.setMaxAge((60 * 60 * 24) * 2);
        response.addCookie(emailC);

        // Redirect hoặc forward tới trang profile
        request.setAttribute("customer", customer);
        request.getRequestDispatcher("profile.jsp").forward(request, response);
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
