
package Controller;

import java.io.File;
import java.io.IOException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;
import DAOs.ProductDAO;
import Models.Product;

/**
 * Servlet điều khiển quản lý sản phẩm cho trang admin
 */
@WebServlet(name = "AdminProductController", urlPatterns = {"/admin/adminproducts"})
@MultipartConfig(fileSizeThreshold = 1024 * 1024 * 2, // 2MB
                 maxFileSize = 1024 * 1024 * 10,      // 10MB
                 maxRequestSize = 1024 * 1024 * 50)   // 50MB
public class AdminProductController extends HttpServlet {

    private static final long serialVersionUID = 1L;
    private ProductDAO productDAO = new ProductDAO();
    private static final String SAVE_DIR = "images";

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        List<Product> products = productDAO.getAllProducts();
        request.setAttribute("products", products);
        request.getRequestDispatcher("/admin/adminproducts.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        HttpSession session = request.getSession();

        if ("add".equals(action)) {
            addProduct(request, response, session);
        } else if ("update".equals(action)) {
            updateProduct(request, response, session);
        } else if ("delete".equals(action)) {
            deleteProduct(request, response, session);
        }

        response.sendRedirect(request.getContextPath() + "/admin/adminproducts");
    }

    private void addProduct(HttpServletRequest request, HttpServletResponse response, HttpSession session)
            throws ServletException, IOException {
        String name = request.getParameter("name");
        String description = request.getParameter("description");
        int price = 0;
        int reducedPrice = 0;
        int quantity = 0;
        int categoryID = 0;
        String image = "";

        try {
            price = Integer.parseInt(request.getParameter("price"));
            reducedPrice = Integer.parseInt(request.getParameter("reducedPrice"));
            quantity = Integer.parseInt(request.getParameter("quantity"));
            categoryID = Integer.parseInt(request.getParameter("categoryID"));
        } catch (NumberFormatException e) {
            // Handle exception if price, reducedPrice, quantity, or categoryID is not a valid integer
        }

        // Handle file upload
        Part filePart = request.getPart("image");
        if (filePart != null && filePart.getSize() > 0) {
            String fileName = extractFileName(filePart);
            String savePath = getServletContext().getRealPath("") + File.separator + SAVE_DIR;
            File fileSaveDir = new File(savePath);
            if (!fileSaveDir.exists()) {
                fileSaveDir.mkdir();
            }
            filePart.write(savePath + File.separator + fileName);
            image = SAVE_DIR + "/" + fileName; // Update the image path
        }

        Product product = new Product(0, name, price, reducedPrice, quantity, description, image, categoryID);
        productDAO.addProduct(product);
        session.setAttribute("message", "Product added successfully.");
    }

    private void updateProduct(HttpServletRequest request, HttpServletResponse response, HttpSession session)
            throws ServletException, IOException {
        int productId = Integer.parseInt(request.getParameter("productId"));
        String name = request.getParameter("name");
        String description = request.getParameter("description");
        int price = 0;
        int reducedPrice = 0;
        int quantity = 0;
        int categoryID = 0;
        String image = request.getParameter("existingImage");

        try {
            price = Integer.parseInt(request.getParameter("price"));
            reducedPrice = Integer.parseInt(request.getParameter("reducedPrice"));
            quantity = Integer.parseInt(request.getParameter("quantity"));
            categoryID = Integer.parseInt(request.getParameter("categoryID"));
        } catch (NumberFormatException e) {
            // Handle exception if price, reducedPrice, quantity, or categoryID is not a valid integer
        }

        // Handle file upload
        Part filePart = request.getPart("image");
        if (filePart != null && filePart.getSize() > 0) {
            String fileName = extractFileName(filePart);
            String savePath = getServletContext().getRealPath("") + File.separator + SAVE_DIR;
            File fileSaveDir = new File(savePath);
            if (!fileSaveDir.exists()) {
                fileSaveDir.mkdir();
            }
            filePart.write(savePath + File.separator + fileName);
            image = SAVE_DIR + "/" + fileName; // Update the image path
        }

        Product product = new Product(productId, name, price, reducedPrice, quantity, description, image, categoryID);
        productDAO.updateProduct(product);
        session.setAttribute("message", "Product updated successfully.");
    }

    private void deleteProduct(HttpServletRequest request, HttpServletResponse response, HttpSession session) {
        int productId = 0;
        try {
            productId = Integer.parseInt(request.getParameter("productId"));
        } catch (NumberFormatException e) {
            // Handle exception if productId is not a valid integer
        }

        if (productId != 0) {
            productDAO.deleteProduct(productId);
            session.setAttribute("message", "Product deleted successfully.");
        } else {
            // Handle error case where productId is not valid
            session.setAttribute("message", "Invalid product ID.");
        }
    }

    private String extractFileName(Part part) {
        String contentDisp = part.getHeader("content-disposition");
        String[] items = contentDisp.split(";");
        for (String s : items) {
            if (s.trim().startsWith("filename")) {
                return s.substring(s.indexOf("=") + 2, s.length() - 1);
            }
        }
        return "";
    }
}
