/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Controller;

import DAOs.FeedbackDAO;
import DAOs.ProductDAO;
import Models.Feedback;
import Models.Product;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

/**
 *
 * @author Thang Tai
 */
@WebServlet(name = "ProductDetailsServlet", urlPatterns = {"/ProductDetailsServlet"})
public class ProductDetailsServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String productID = request.getParameter("productID");

        int id = Integer.parseInt(productID);
        ProductDAO productDAO = new ProductDAO();
        FeedbackDAO fdao = new FeedbackDAO();
        Product product = productDAO.getProductById(id);
        List<Product> suggestedProducts = productDAO.getProductsByCategoryId(product.getCategoryID(), product.getProductID());
        List<Feedback> listfFeedbacks = fdao.getAllFeedback(null, Integer.parseInt(productID));

        listfFeedbacks.forEach(System.out::println);
        request.setAttribute("product", product);
        request.setAttribute("feedback", listfFeedbacks);
        request.setAttribute("suggestedProducts", suggestedProducts);
        request.getRequestDispatcher("productDetails.jsp").forward(request, response);
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
        return "ProductDetailsServlet";
    }
}
