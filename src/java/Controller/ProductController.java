/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller;

import DAOs.ProductDAO;
import Models.Product;
import Models.Statistics;
import java.io.IOException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(name = "ProductController", urlPatterns = {"/ProductController"})
public class ProductController extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        String searchQuery = request.getParameter("txtSearch");

        ProductDAO productDAO = new ProductDAO();
        List<Product> products = null;

        try {
            if (searchQuery != null && !searchQuery.trim().isEmpty()) {
                products = productDAO.getProductsByName(searchQuery);
            } else {
                products = productDAO.getAllProducts();
            }

            request.setAttribute("data", products);

            // Thêm logic lấy thống kê nếu cần
            if ("viewStatistics".equals(action)) {
                Statistics statistics = productDAO.getStatistics();
                request.setAttribute("statistics", statistics);
            }

            request.getRequestDispatcher("listProductManagement.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("searchError", "An error occurred while processing your request.");
            request.getRequestDispatcher("listProductManagement.jsp").forward(request, response);
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Product controller servlet";
    }
}