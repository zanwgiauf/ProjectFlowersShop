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
        CategoryDAO dao = new CategoryDAO();
        if (action != null) {
            switch (action) {
                case "add":
                    String addName = request.getParameter("name");
                    dao.addCategory(new Category(0, addName));
                    request.setAttribute("message", "Category added successfully!");
                    break;
                case "edit":
                    int editID = Integer.parseInt(request.getParameter("categoryID"));
                    String editName = request.getParameter("name");
                    dao.editCategory(new Category(editID, editName));
                    request.setAttribute("message", "Category updated successfully!");
                    break;
                case "delete":
                    int deleteID = Integer.parseInt(request.getParameter("categoryID"));
                    dao.deleteCategory(deleteID);
                    request.setAttribute("message", "Category deleted successfully!");
                    break;
            }
        }

        // Load lại danh sách các category sau mỗi thao tác và hiển thị chúng
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
