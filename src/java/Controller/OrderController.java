/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller;

import DAOs.CartDAO;
import DAOs.EmployeeDAO;
import DAOs.OrderDAO;
import DAOs.OrderDetailDAO;
import DAOs.ProductDAO;
import Models.Cart;
import Models.Employee;
import Models.Order;
import Models.OrderDetail;
import Models.Product;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.sql.Date;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author Nguyen Van Giau - CE170449
 */
public class OrderController extends HttpServlet {

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
            out.println("<title>Servlet OrderController</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet OrderController at " + request.getContextPath() + "</h1>");
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
        OrderDAO odao = new OrderDAO();
        OrderDetailDAO oddao = new OrderDetailDAO();
        ProductDAO pdao = new ProductDAO();
        String cus_id = null;
        HttpSession session = request.getSession();
        Cookie[] cookies = request.getCookies();
        if (cookies != null) {
            for (Cookie cookie : cookies) {
                if (cookie.getName().equals("idC")) {
                    cus_id = cookie.getValue();
                }
            }

            if (request.getRequestURI().endsWith("/order")) {
                request.getRequestDispatcher("./customer/checkout.jsp").forward(request, response);
            } else {
                //purchase history
                if (request.getRequestURI().endsWith("/order/purchasehistory")) {
                    OrderDAO phdao = new OrderDAO();
                    int cid = Integer.parseInt(cus_id);
                    try {
                        List<OrderDetail> orders = phdao.getOrderDetailsByCustomerID(cid);
                        request.setAttribute("orderDetails", orders);
                        request.getRequestDispatcher("../customer/purchaseHistory.jsp").forward(request, response);
                    } catch (NumberFormatException | SQLException ex) {
                        throw new ServletException("Error retrieving orders", ex);
                    }
                }

                //pending order
                if (request.getRequestURI().endsWith("/order/pendingOrder")) {
                    int cid;
                    try {
                        cid = Integer.parseInt(cus_id);
                        List<OrderDetail> pendingOrders = odao.getPendingOrdersByCustomerID(cid);
                        request.setAttribute("pendingOrders", pendingOrders);
                        request.getRequestDispatcher("../customer/pendingOrders.jsp").forward(request, response);
                    } catch (NumberFormatException | SQLException ex) {
                        throw new ServletException("Error retrieving orders", ex);
                    }
                }
                //cancel order
                if (request.getRequestURI().endsWith("/order/cancelOrder")) {
                    try {
                        int cid = Integer.parseInt(cus_id);
                        int orderId = Integer.parseInt(request.getParameter("orderId"));

                        boolean isCanceled = odao.cancelOrder(orderId);
                        if (isCanceled) {
                            List<OrderDetail> pendingOrders = odao.getPendingOrdersByCustomerID(cid);
                            request.setAttribute("pendingOrders", pendingOrders);
                        }
                    } catch (NumberFormatException | SQLException ex) {
                        throw new ServletException("Error retrieving orders", ex);
                    }
                    request.getRequestDispatcher("../customer/pendingOrders.jsp").forward(request, response);
                }
                //cancelled order
                if (request.getRequestURI().endsWith("/order/cancelled")) {
                    OrderDAO orderDAO = new OrderDAO();
                    int cid;
                    try {
                        cid = Integer.parseInt(cus_id);
                        List<OrderDetail> cancelledOrders = orderDAO.getAllCancelledOrdersByCustomerID(cid);
                        request.setAttribute("cancelledOrders", cancelledOrders);

                    } catch (NumberFormatException | SQLException ex) {
                        throw new ServletException("Error retrieving orders", ex);
                    }
                    request.getRequestDispatcher("../customer/cancelledOrders.jsp").forward(request, response);
                }
            }
        }
        if (cookies == null) {
            response.sendRedirect("login");
        }
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

        CartDAO cdao = new CartDAO();
        ProductDAO pdao = new ProductDAO();
        OrderDAO odao = new OrderDAO();
        OrderDetailDAO oddao = new OrderDetailDAO();
        HttpSession session = request.getSession();
        if (request.getParameter("btnCheckout") != null) {
            List<Cart> cart_buy = new ArrayList<>();
            List<Cart> cart_out = new ArrayList<>();//list of product out of stock
            String[] listCartID = request.getParameterValues("checkbox");
            for (String cid : listCartID) {
                int cartID = Integer.parseInt(cid);
                Cart cart = cdao.getCartById(cartID);
                Product product = pdao.getProductByID(cart.getProductID());
                int quantityStockProduct = product.getQuantity();
                int quantityCartPro = cart.getQuantity();
                if (quantityCartPro <= quantityStockProduct) {
                    cart_buy.add(cart);
                } else {
                    cart_out.add(cart);
                }
            }
            int totalPrice = 0;
            if (cart_buy.size() >= 1) {
                for (Cart cb : cart_buy) {
                    int total = cb.getTotalCart();
                    totalPrice = totalPrice + total;
                }
            } else {
                for (Cart cart : cart_buy) {
                    int total = cart.getTotalCart();
                    totalPrice = total;
                }
            }
            session.setAttribute("cart_out", cart_out);
            session.setAttribute("totalPrice", totalPrice);
            session.setAttribute("cart_buy", cart_buy);
            response.sendRedirect("order");
        } else if (request.getParameter("btnPlaceOrder") != null) {
            List<Cart> cart_buy = (List<Cart>) session.getAttribute("cart_buy");
            if (cart_buy == null) {
                response.sendRedirect("cart");
                return;
            }

            Cookie cookies[] = request.getCookies();
            int customerID = 0;
            if (cookies != null) {
                for (Cookie cookie : cookies) {
                    if (cookie.getName().equals(("idC"))) {
                        customerID = Integer.parseInt(cookie.getValue());
                    }
                }
            }
            String phone = request.getParameter("phone");
            String address = request.getParameter("address") + " Can Tho";
            String note = request.getParameter("note");
            int shippingFee = calculateShippingFee(request.getParameter("address"));
            int totalPrice = (Integer) session.getAttribute("totalPrice") + shippingFee;
            Date dateCreate = new Date(System.currentTimeMillis());
            Date paymentCreateAt = new Date(System.currentTimeMillis());
            EmployeeDAO edao = new EmployeeDAO();
            Employee e = edao.getEmployeeIsNull();
            Order o = new Order(dateCreate, phone, address, totalPrice, note, paymentCreateAt, customerID, e.getEmployeeID(), shippingFee);
            int orderID = odao.addOrder(o);

            for (Cart c : cart_buy) {
                OrderDetail od = new OrderDetail(c.getName(), c.getPrice(), c.getQuantity(), orderID, c.getProductID());
                oddao.addOrderDetail(od);
                //update quantity product
                Product update = pdao.getProductByID(od.getProductID());
                pdao.UpdateQuantityProduct(update.getQuantity() - od.getQuantity(), update.getProductID());
            }
            for (Cart cart : cart_buy) {
                cdao.deleteItemInCart(cart.getCartID());
            }
            //get list order and add in session
            List<Order> order = odao.getListOrderByCustomerID(customerID);
            session.setAttribute("orders", order);
            response.sendRedirect(request.getContextPath() + "/cart");

        }

    }

    private int calculateShippingFee(String district) {
        switch (district) {
            case "Ninh Kieu":
                return 20000;
            case "Binh Thuy":
                return 25000;
            case "Cai Rang":
                return 30000;
            case "O Mon":
                return 35000;
            case "Thot Not":
                return 40000;
            case "Phong Dien":
                return 45000;
            case "Co Do":
                return 50000;
            case "Thoi Lai":
                return 55000;
            case "Vinh Thanh":
                return 60000;
            default:
                return 0;
        }
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
