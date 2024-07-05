/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller;

import DAOs.CategoryDAO;
import Models.Category;
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
 * @author Le Minh Truong - CE171886
 */
@WebServlet(name = "ManageCategoryController", urlPatterns = {"/managecategories"})
public class ManageCategoryController extends HttpServlet {

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

        CategoryDAO dao = new CategoryDAO();
        String action = request.getParameter("action");
        if ("search".equals(action)) {
            String name = request.getParameter("name");
            List<Category> categories = dao.searchCategoriesByName(name);
            request.setAttribute("categories", categories);
        } else {
            // Nếu không có yêu cầu tìm kiếm, trả về toàn bộ danh sách danh mục
            List<Category> categories = dao.getAllCategories();
            request.setAttribute("categories", categories);
        }

        // Chuyển tiếp đến trang JSP để hiển thị danh sách các category
        request.getRequestDispatcher("manageCategory.jsp").forward(request, response);
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
        if (action == null) {
            // Handle error or redirect as there is no action provided
            request.setAttribute("error", "No action provided.");
            request.getRequestDispatcher("manageCategory.jsp").forward(request, response);
            return;
        }

        CategoryDAO dao = new CategoryDAO();
        if ("delete".equals(action)) {
            String idStr = request.getParameter("categoryID");
            if (idStr != null && !idStr.isEmpty()) {
                try {
                    int deleteID = Integer.parseInt(idStr);
                    dao.deleteCategory(deleteID);
                    request.setAttribute("message", "Category deleted successfully!");
                } catch (NumberFormatException e) {
                    request.setAttribute("error", "Invalid category ID.");
                }
            } else {
                request.setAttribute("error", "Category ID is missing.");
            }
        } else {
            String name = request.getParameter("name");
            if (name == null || !name.matches("^[a-zA-Z\\s]+$")) {
                request.setAttribute("error", "Name must contain only alphabets and spaces.");
            } else if (dao.categoryNameExists(name)) {
                request.setAttribute("error", "This category name already exists. Please choose another.");
            } else {
                if ("add".equals(action)) {
                    dao.addCategory(new Category(0, name));
                    request.setAttribute("message", "Category added successfully!");
                } else if ("edit".equals(action)) {
                    try {
                        int editID = Integer.parseInt(request.getParameter("categoryID"));
                        dao.editCategory(new Category(editID, name));
                        request.setAttribute("message", "Category updated successfully!");
                    } catch (NumberFormatException e) {
                        request.setAttribute("error", "Invalid category ID for editing.");
                    }
                }
            }
        }

        // Refresh category list and forward to JSP
        List<Category> categories = dao.getAllCategories();
        request.setAttribute("categories", categories);
        request.getRequestDispatcher("manageCategory.jsp").forward(request, response);
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
