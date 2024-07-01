/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package Controller;

import DAOs.ProductDAO;
import Models.Product;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.List;

/**
 *
 * @author Thang Tai
 */
@WebServlet(name = "AdvancedSearchProductServlet", urlPatterns = {"/AdvancedSearchProductServlet"})
public class AdvancedSearchProductServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String name = request.getParameter("name");
        String minPriceStr = request.getParameter("minPrice");
        String maxPriceStr = request.getParameter("maxPrice");
        String categoryIDStr = request.getParameter("categoryID");

        Integer minPrice = (minPriceStr != null && !minPriceStr.isEmpty()) ? Integer.parseInt(minPriceStr) : null;
        Integer maxPrice = (maxPriceStr != null && !maxPriceStr.isEmpty()) ? Integer.parseInt(maxPriceStr) : null;
        Integer categoryID = (categoryIDStr != null && !categoryIDStr.isEmpty()) ? Integer.parseInt(categoryIDStr) : null;

        if ((minPriceStr == null || minPriceStr.isEmpty()) && (maxPriceStr == null || maxPriceStr.isEmpty())) {
            request.setAttribute("priceError", "Minimum price and maximum price cannot both be empty.");
            request.getRequestDispatcher("listProductManagement.jsp").forward(request, response);
            return;
        }

        if (minPrice != null && maxPrice != null && maxPrice < minPrice) {
            request.setAttribute("priceError", "Maximum price cannot be less than minimum price.");
            request.getRequestDispatcher("listProductManagement.jsp").forward(request, response);
            return;
        }

        ProductDAO productDAO = new ProductDAO();
        List<Product> productList = productDAO.searchProducts(minPrice, maxPrice);

        if (productList.isEmpty()) {
            request.setAttribute("searchError", "No products found with the given criteria.");
        } else {
            request.setAttribute("data", productList);
        }
        request.getRequestDispatcher("listProductManagement.jsp").forward(request, response);
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /** 
     * Handles the HTTP <code>GET</code> method.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        processRequest(request, response);
    } 

    /** 
     * Handles the HTTP <code>POST</code> method.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        processRequest(request, response);
    }

    /** 
     * Returns a short description of the servlet.
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
