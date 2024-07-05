package Controller;

import DAOs.CartDAO;
import Models.Cart;
import Models.Customer;
import Models.Product;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author ADMIN
 */
@WebServlet(name = "CartController", urlPatterns = {"/cart"})
public class CartController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        Customer customer = (Customer) session.getAttribute("customerInfor");
        if (customer != null) {
            CartDAO cdao = new CartDAO();
            int cartSize = cdao.getCartSizeForCustomer(customer.getCustomerID());
            session.setAttribute("cartSize", cartSize);  // Storing cart size in session

            String pageParam = request.getParameter("page");
            String searchParam = request.getParameter("search");
            int page = 1; // Default to the first page
            int pageSize = 10; // Set the desired page size
            if (pageParam != null && !pageParam.isEmpty()) {
                page = Integer.parseInt(pageParam);
            }
            List<Cart> carts = new ArrayList<>();
              //List<Cart> carts;
            if (searchParam != null && !searchParam.isEmpty()) {
                carts = cdao.getAllCartForUserWithParam(searchParam.trim(), customer.getCustomerID());
            } else {
                carts = cdao.getAllCartForUserWithParam(null, customer.getCustomerID());
            }

            List<Cart> pagingCart = cdao.Paging(carts, page, pageSize);
            System.out.println(pagingCart.size());
            request.setAttribute("cart", pagingCart);
            request.setAttribute("totalPages", carts.size() % pageSize == 0 ? (carts.size() / pageSize) : (carts.size() / pageSize + 1));
            request.setAttribute("currentPage", page);
            request.setAttribute("searchParam", searchParam);

            request.getRequestDispatcher("cart.jsp").forward(request, response);
        } else {

            response.sendRedirect("login.jsp");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        Customer customer = (Customer) session.getAttribute("customerInfor");
        CartDAO cdao = new CartDAO();
        if (customer != null) {
            String action = request.getParameter("action");
            if (action.equalsIgnoreCase("remove")) {
                int id = Integer.parseInt(request.getParameter("id"));
                try {
                    cdao.deleteByID(id);
                    session.setAttribute("notification", "Delete successfully");
                } catch (Exception e) {
                    session.setAttribute("notificationErr", "Delete Faild " + e.getMessage());

                }
            }
            if (action.equalsIgnoreCase("update")) {
                int id = Integer.parseInt(request.getParameter("id"));
                int quantity = Integer.parseInt(request.getParameter("quantity"));
                Cart existingCart = cdao.getCartByID(id);
                Product product = cdao.getProductByID(existingCart.getProductID());
                int stock = product.getQuantity();

                // Check if the updated quantity exceeds stock
                if (quantity > stock) {
                    session.setAttribute("notificationErr", "Cannot update. Quantity exceeds available stock (" + stock + ")");
                    response.sendRedirect("cart");
                    return;
                }
                // Check if quantity is valid (greater than 0)
                if (quantity < 1) {
                    session.setAttribute("notificationErr", "Quantity must be greater than 0");
                    response.sendRedirect("cart");
                    return;
                }

                // Retrieve the existing cart item
                if (existingCart != null) {
                    // Calculate new total based on updated quantity
                    int newTotal = existingCart.getPrice() * quantity;

                    // Update cart item with new quantity and total
                    existingCart.setQuantity(quantity);
                    existingCart.setTotal(newTotal);

                    try {
                        // Attempt to update the cart in the database
                        cdao.updateCart(existingCart);
                        session.setAttribute("notification", "Cart updated successfully");
                    } catch (Exception e) {
                        // Handle database update errors
                        session.setAttribute("notificationErr", "Update failed: " + e.getMessage());
                    }
                } else {
                    // Handle case where cart item with given ID is not found
                    session.setAttribute("notificationErr", "Cart item not found");
                }

                // Redirect back to cart page after processing
            }
            if (action.equalsIgnoreCase("add")) {
                int productID = Integer.parseInt(request.getParameter("productID"));
                int quantity = Integer.parseInt(request.getParameter("quantity"));

                // Get product details including stock quantity
                Product product = cdao.getProductByID(productID);
                int stock = product.getQuantity();

                // Check if requested quantity exceeds stock
                if (quantity > stock) {
                    session.setAttribute("notification", "Insufficient stock. Available stock: " + stock);
                } else {
                    // Check if the product already exists in the cart for this customer
                    Cart existingCart = cdao.getCartByProductAndCustomer(productID, customer.getCustomerID());

                    if (existingCart != null) {
                        // Product already exists in the cart, update quantity and total
                        int newQuantity = existingCart.getQuantity() + quantity;
                        int newTotal = existingCart.getPrice() * newQuantity;

                        existingCart.setQuantity(newQuantity);
                        existingCart.setTotal(newTotal);

                        // Update the cart
                        cdao.updateCart(existingCart);
                        session.setAttribute("notification", "Cart updated successfully");
                    } else {
                        // Product does not exist in the cart, add it
                        Cart newCart = new Cart();
                        newCart.setProductID(productID);
                        newCart.setCustomerID(customer.getCustomerID());
                        newCart.setQuantity(quantity);
                        newCart.setPrice(product.getPrice());
                        newCart.setTotal(product.getPrice() * quantity);
                        cdao.addToCart(newCart);
                        session.setAttribute("notification", "Product added to cart successfully");
                    }
                }
            }
            response.sendRedirect("cart");
        } else {

            response.sendRedirect("login.jsp");
        }
    }

}
