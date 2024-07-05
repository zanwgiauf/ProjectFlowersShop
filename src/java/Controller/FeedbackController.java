/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller;

import DAOs.EmployeeDAO;
import DAOs.FeedbackDAO;
import Models.Admin;
import Models.Customer;
import Models.Employee;
import Models.Feedback;
import java.io.IOException;
import java.io.PrintWriter;
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
@WebServlet(name = "FeedbackController", urlPatterns = {"/employee/feedback-management"})
public class FeedbackController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        Employee currentEmployee = (Employee) session.getAttribute("employee");
//        System.out.println(currentAdmin);
        if (currentEmployee != null) {
            FeedbackDAO feedbackDAO = new FeedbackDAO();
            String pageParam = request.getParameter("page");
            String searchParam = request.getParameter("search");
            int page = 1; // Default to the first pagez
            int pageSize = 5; // Set the desired page size
            if (pageParam != null && !pageParam.isEmpty()) {
                page = Integer.parseInt(pageParam);
            }
            List<Feedback> feedbacks = new ArrayList<>();
            //Nếu sau khi khởi tạo feedbacks như trên mà bạn không sử dụng feedbacks để thêm phần tử
             //, truy cập phần tử, hoặc truyền feedbacks vào một phương thức nào đó, thì đây sẽ là một trường hợp của "unused assignment".
       
            if (searchParam != null && !searchParam.isEmpty()) {
                feedbacks = feedbackDAO.getAllFeedback(searchParam.trim(), null);
            } else {
                feedbacks = feedbackDAO.getAllFeedback("", null);
            }
            System.out.println(feedbacks.size());
            // ko nên sử dụng trong code này vì nó sẽ khó quản lí các cái log quan trọng
            //bo
            List<Feedback> pagingFeedback = feedbackDAO.Paging(feedbacks, page, pageSize);
            request.setAttribute("feedback", pagingFeedback);
            request.setAttribute("totalPages", feedbacks.size() % pageSize == 0 ? (feedbacks.size() / pageSize) : (feedbacks.size() / pageSize + 1));
            request.setAttribute("currentPage", page);
            request.setAttribute("searchParam", searchParam);
            request.getRequestDispatcher("feedback-management.jsp").forward(request, response);
        } else {
            response.sendRedirect("../login.jsp");
        }

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        Employee currentEmployee = (Employee) session.getAttribute("employee");
        if (currentEmployee != null) {

            FeedbackDAO feedbackDAO = new FeedbackDAO();
            int id = Integer.parseInt(request.getParameter("id"));
            try {
                feedbackDAO.deleteFeedback(id);
                session.setAttribute("notification", "Feedback delete successfully!");
            } catch (Exception e) {
                session.setAttribute("notificationErr", "Feedback delete faild !" + e.getMessage());
            }
            response.sendRedirect("feedback-management");

        } else {
            response.sendRedirect("../login.jsp");
        }
    }
}
