/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller;

import DAOs.CategoryDAO;
import DAOs.ProductDAO;
import Models.Category;
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
 * @author Le Minh Truong - CE171886
 */
@WebServlet(name = "CategoryController", urlPatterns = {"/categories"})
public class CategoryController extends HttpServlet {

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
        String action = request.getParameter("action");

        // Lưu lại các tham số lọc và sắp xếp
        String categoryID = request.getParameter("categoryID");
        String type = request.getParameter("type");
        String text = request.getParameter("text");

        if (action == null) {
            ProductDAO p = new ProductDAO();
            CategoryDAO c = new CategoryDAO();
            List<Product> productList = p.getAllProducts();
            List<Category> category = c.getAllCategories();
            int page, numperpage = 9;
            int size = productList.size();
            int num = (size % 9 == 0 ? (size / 9) : ((size / 9)) + 1);//so trang
            String xpage = request.getParameter("page");
            if (xpage == null) {
                page = 1;
            } else {
                page = Integer.parseInt(xpage);
            }
            int start, end;
            start = (page - 1) * numperpage;
            end = Math.min(page * numperpage, size);
            List<Product> product = p.getListByPage(productList, start, end);
            request.setAttribute("page", page);
            request.setAttribute("num", num);
            request.setAttribute("CategoryData", category);
            request.setAttribute("ProductData", product);
            request.setAttribute("action", action);
            request.setAttribute("categoryID", categoryID);
            request.setAttribute("type", type);
            request.setAttribute("text", text);
            request.getRequestDispatcher("category.jsp").forward(request, response);
        } else {
            if (action.equalsIgnoreCase("listByCategory")) {
                String category_id = request.getParameter("categoryID");
                System.out.println("Category ID: " + category_id);

                if (category_id != null && !category_id.isEmpty()) {
                    int category_id1 = Integer.parseInt(category_id);
                    ProductDAO p = new ProductDAO();
                    CategoryDAO c = new CategoryDAO();
                    List<Product> productList = p.getProductByCategory(category_id1);
                    List<Category> category = c.getAllCategories();
                    int page, numperpage = 9;
                    int size = productList.size();
                    int num = (size % 9 == 0 ? (size / 9) : ((size / 9)) + 1);//so trang
                    String xpage = request.getParameter("page");
                    if (xpage == null) {
                        page = 1;
                    } else {
                        page = Integer.parseInt(xpage);
                    }
                    int start, end;
                    start = (page - 1) * numperpage;
                    end = Math.min(page * numperpage, size);
                    List<Product> product = p.getListByPage(productList, start, end);
                    request.setAttribute("page", page);
                    request.setAttribute("num", num);
                    request.setAttribute("CategoryData", category);
                    request.setAttribute("ProductData", product);
                    request.setAttribute("action", action);
                    request.setAttribute("categoryID", categoryID);
                    request.setAttribute("type", type);
                    request.setAttribute("text", text);
                    request.getRequestDispatcher("category.jsp").forward(request, response);
                } else {
                    System.out.println("Error: Category ID is null or empty.");
                }
            }

            if (action.equals("sort")) {
                type = request.getParameter("type");
                System.out.println("Sort type: " + type);
                ProductDAO p = new ProductDAO();
                CategoryDAO c = new CategoryDAO();
                List<Product> productList = null;

                if (type.equals("low")) {
                    productList = p.getProductLow();
                } else if (type.equals("high")) {
                    productList = p.getProductHigh();
                } else if (type.equals("a-z")) {
                    productList = p.getProductAZ();
                }

                if (productList != null) {
                    System.out.println("Number of products found: " + productList.size());
                    List<Category> category = c.getAllCategories();
                    int page, numperpage = 9;
                    int size = productList.size();
                    int num = (size % 9 == 0 ? (size / 9) : ((size / 9)) + 1);//so trang
                    String xpage = request.getParameter("page");

                    if (xpage == null) {
                        page = 1;
                    } else {
                        page = Integer.parseInt(xpage);
                    }
                    int start, end;
                    start = (page - 1) * numperpage;
                    end = Math.min(page * numperpage, size);
                    List<Product> product = p.getListByPage(productList, start, end);
                    System.out.println("Products on page " + page + ": " + product.size());

                    request.setAttribute("page", page);
                    request.setAttribute("num", num);
                    request.setAttribute("CategoryData", category);
                    request.setAttribute("ProductData", product);
                    request.setAttribute("action", action);
                    request.setAttribute("categoryID", categoryID);
                    request.setAttribute("type", type);
                    request.setAttribute("text", text);
                    request.getRequestDispatcher("category.jsp").forward(request, response);
                } else {
                    System.out.println("Error: Invalid sort type " + type);
                }
            }

            if (action.equals("search")) {
                text = request.getParameter("text");
                System.out.println("Search text: " + text);

                ProductDAO p = new ProductDAO();
                CategoryDAO c = new CategoryDAO();
                List<Product> productList = p.SearchAll(text);
                System.out.println("Number of products found: " + productList.size());

                List<Category> category = c.getAllCategories();
                int page, numperpage = 9;
                int size = productList.size();
                int num = (size % 9 == 0 ? (size / 9) : ((size / 9)) + 1);//so trang
                String xpage = request.getParameter("page");

                if (xpage == null) {
                    page = 1;
                } else {
                    page = Integer.parseInt(xpage);
                }

                int start, end;
                start = (page - 1) * numperpage;
                end = Math.min(page * numperpage, size);
                List<Product> product = p.getListByPage(productList, start, end);
                System.out.println("Products on page " + page + ": " + product.size());

                request.setAttribute("page", page);
                request.setAttribute("num", num);
                request.setAttribute("CategoryData", category);
                request.setAttribute("ProductData", product);
                request.getRequestDispatcher("category.jsp").forward(request, response);
            }
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
        processRequest(request, response);
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
        processRequest(request, response);
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
