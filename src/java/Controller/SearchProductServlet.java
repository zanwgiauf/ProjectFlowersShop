/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller;

import DAOs.ProductDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.List;
import Models.Product;

/**
 *
 * @author Thang Tai
 */
@WebServlet(name = "SearchProductServlet", urlPatterns = {"/SearchProductServlet"})
public class SearchProductServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String searchQuery = request.getParameter("txtSearch");
        System.out.println("Search Query: " + searchQuery); // Kiểm tra giá trị searchQuery

        ProductDAO productDAO = new ProductDAO();

        List<Product> productList = productDAO.getProductsByName(searchQuery);

        if (productList.isEmpty()) {
            request.setAttribute("searchError", "No products found with keyword '" + searchQuery + "'");
        } else {
            request.setAttribute("data", productList);
        }
        request.getRequestDispatcher("listProductManagement.jsp").forward(request, response);
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
        return "SearchProductServlet";
    }
}
