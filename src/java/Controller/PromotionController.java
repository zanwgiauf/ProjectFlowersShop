/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller;

import DAOs.PromotionDAO;
import Models.Promotion;

import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.sql.Date;
import java.util.List;

/**
 *
 * @author Le Minh Truong - CE171886
 */
@WebServlet(name = "Promotion", urlPatterns = {"/promotions"})
public class PromotionController extends HttpServlet {

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
            out.println("<title>Servlet Promotion</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet Promotion at " + request.getContextPath() + "</h1>");
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
        PromotionDAO dao = new PromotionDAO();
        String searchCode = request.getParameter("searchCode");
        List<Promotion> promotions;

        if (searchCode != null && !searchCode.isEmpty()) {
            promotions = dao.searchPromotionsByCode(searchCode);
            request.setAttribute("promotions", promotions);
        } else {
            promotions = dao.getAllPromotions();
            request.setAttribute("promotions", promotions);

        }

        request.getRequestDispatcher("managePromotions.jsp").forward(request, response);

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
        String action = request.getParameter("action");
    PromotionDAO dao = new PromotionDAO();
    
    if (action == null) {
        // Handle case where no action is specified
        response.sendRedirect("managePromotions.jsp");
        return;
    }

    String startDateStr = request.getParameter("startDate");
    String endDateStr = request.getParameter("endDate");

    if ("add".equals(action) || "edit".equals(action)) {
        Date startDate = null;
        Date endDate = null;
        try {
            startDate = Date.valueOf(startDateStr);
            endDate = Date.valueOf(endDateStr);
            if (endDate.before(startDate)) {
                request.setAttribute("message", "End date must be after the start date. Please enter a valid end date.");
                List<Promotion> promotions = dao.getAllPromotions();
                request.setAttribute("promotions", promotions);
                request.getRequestDispatcher("managePromotions.jsp").forward(request, response);
                return;
            }
        } catch (IllegalArgumentException e) {
            request.setAttribute("message", "Invalid dates entered. Please enter valid dates.");
            request.getRequestDispatcher("managePromotions.jsp").forward(request, response);
            return;
        }

        String code = request.getParameter("promotionCode");
        String description = request.getParameter("description");
        String discount = request.getParameter("discount");
        int id = action.equals("edit") ? Integer.parseInt(request.getParameter("promotionID")) : 0;

        Promotion promo = new Promotion(id, code, description, discount, startDateStr, endDateStr, 0);

        if ("add".equals(action)) {
            dao.addPromotion(promo);
            request.setAttribute("message", "Promotion added successfully!");
        } else {
            dao.updatePromotion(promo);
            request.setAttribute("message", "Promotion updated successfully!");
        }
    } else if ("delete".equals(action)) {
        int id = Integer.parseInt(request.getParameter("promotionID"));
        dao.deletePromotion(id);
        request.setAttribute("message", "Promotion deleted successfully!");
    }

    List<Promotion> promotions = dao.getAllPromotions();
    request.setAttribute("promotions", promotions);
    request.getRequestDispatcher("managePromotions.jsp").forward(request, response);
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
