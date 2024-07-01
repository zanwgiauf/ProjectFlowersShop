/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller;

import DAOs.FeedbackDAO;
import Models.Customer;
import Models.Feedback;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

/**
 *
 * @author ADMIN
 */
@WebServlet(name = "FeedbackCustomerDAO", urlPatterns = {"/customer-feedback"})
public class FeedbackCustomerServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        Customer customer = (Customer) session.getAttribute("customerInfor");
        FeedbackDAO feedbackDAO = new FeedbackDAO();
        if (customer != null) {
            String action = request.getParameter("action");
            if (action.equals("add")) {
                System.out.println("GO TO ADD");
                Feedback feedback = new Feedback();
                int pid = Integer.parseInt(request.getParameter("pid"));
               
                String content = request.getParameter("content");
              
                feedback.setContent(content);
                feedback.setCustomer(customer);
                
                feedback.setProductID(pid);
                try {
                    feedbackDAO.addFeedback(feedback);
                    session.setAttribute("msg", "Feedback add successfully! ");
                } catch (Exception e) {
                    session.setAttribute("err", "Feedback add Fail! " + e.getMessage());
                }
                response.sendRedirect("ProductDetailsServlet?productID=" + pid);
            }
            if (action.equals("update")) {
                System.out.println("GO TO Edit ");
                Feedback feedback = new Feedback();
                int pid = Integer.parseInt(request.getParameter("pid"));
                int id = Integer.parseInt(request.getParameter("id"));
               
                String content = request.getParameter("content");
              
                feedback.setContent(content);
                feedback.setCustomer(customer);
                feedback.setFeedbackID(id);
                feedback.setProductID(pid);
                try {
                    feedbackDAO.updateFeedback(feedback);
                    session.setAttribute("msg", "Feedback Update successfully! ");
                } catch (Exception e) {
                    session.setAttribute("err", "Feedback Update Fail! " + e.getMessage());
                }
                response.sendRedirect("ProductDetailsServlet?productID=" + pid);
            }
        }
    }

}
