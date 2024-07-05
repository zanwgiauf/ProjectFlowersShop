/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller;

import DAOs.EmployeeDAO;
import Models.Admin;
import Models.Employee;
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
import java.util.logging.Logger;


/**
 *
 * @author ADMIN
 */
@WebServlet(name = "EmployeeManagement", urlPatterns = {"/admin/employee-management"})
public class EmployeeManagement extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        Admin currentAdmin = (Admin) session.getAttribute("Admin");
//        System.out.println(currentAdmin);
        if (currentAdmin != null) {
            EmployeeDAO employeeDAO = new EmployeeDAO();

            String pageParam = request.getParameter("page");
            String searchParam = request.getParameter("search");
            int page = 1; // Default to the first page
            int pageSize = 5; // Set the desired page size
            if (pageParam != null && !pageParam.isEmpty()) {
                page = Integer.parseInt(pageParam);
            }
            List<Employee> employees = new ArrayList<>();
            if (searchParam != null && !searchParam.isEmpty()) {
                employees = employeeDAO.getAllEmployeeWithParam(searchParam.trim());
            } else {
                employees = employeeDAO.getAllEmployeeWithParam("");
            }
//            List<Employee> employees;
//if (searchParam != null && !searchParam.isEmpty()) {
//    employees = employeeDAO.getAllEmployeeWithParam(searchParam.trim());
//} else {
//    employees = employeeDAO.getAllEmployeeWithParam("");
//}


            List<Employee> pagingEmployee = employeeDAO.Paging(employees, page, pageSize);
      
            request.setAttribute("employee", pagingEmployee);
            request.setAttribute("totalPages", employees.size() % pageSize == 0 ? (employees.size() / pageSize) : (employees.size() / pageSize + 1));
            request.setAttribute("currentPage", page);
            request.setAttribute("searchParam", searchParam);
            request.getRequestDispatcher("employeeManagement.jsp").forward(request, response);
        } else {
            response.sendRedirect("../login.jsp");
        } 

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        Admin currentAdmin = (Admin) session.getAttribute("Admin");

        if (currentAdmin != null) {
            String action = request.getParameter("action");
            EmployeeDAO employeeDAO = new EmployeeDAO();

            if (action.equalsIgnoreCase("add")) {
                String fullName = request.getParameter("name").trim();
                String phone = request.getParameter("phone").trim();
                String email = request.getParameter("email").trim();
                String password = request.getParameter("password").trim();
                String rePassword = request.getParameter("re-password").trim();
                int roleId = 2; // role ID for an employee is 2

                String errorMessage = null;

                // Input validation
                if (fullName.isEmpty() || !fullName.matches("[a-zA-Z\\s]+")) {
                    errorMessage = "Invalid full name. Only letters and spaces are allowed.";
                } else if (!phone.matches("0\\d{9}")) {
                    errorMessage = "Invalid phone number. It must have 10 digits and start with 0.";
                } else if (!email.matches("^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\\.[a-zA-Z]{2,6}$")) {
                    errorMessage = "Invalid email format.";
                } else if (employeeDAO.emailExists(email)) {
                    errorMessage = "Email already exists.";
                } else if (password.length() < 8) {
                    errorMessage = "Password must be at least 8 characters long.";
                } else if (!password.equals(rePassword)) {
                    errorMessage = "Passwords do not match.";
                }

                if (errorMessage == null) {
                    boolean isAdded = employeeDAO.addEmployee(fullName, phone, email, password, roleId);

                    if (isAdded) {
                        session.setAttribute("notification", "Employee added successfully.");
                    } else {
                        session.setAttribute("notificationErr", "Failed to add employee.");
                    }
                } else {
                    session.setAttribute("notificationErr", errorMessage);
                }
                response.sendRedirect("employee-management");

            } else if (action.equalsIgnoreCase("change-status")) {
                int id = Integer.parseInt(request.getParameter("id"));
                int status = Integer.parseInt(request.getParameter("status"));

                if (status == 0) {
                    employeeDAO.changeStatus(1, id);
                    session.setAttribute("notification", "Unblock employee successfully.");
                } else {
                    employeeDAO.changeStatus(0, id);
                    session.setAttribute("notification", "Block employee successfully.");
                }
                response.sendRedirect("employee-management");

            } else if (action.equalsIgnoreCase("edit")) {
                int id = Integer.parseInt(request.getParameter("id"));
                String fullName = request.getParameter("name").trim();
                String phone = request.getParameter("phone").trim();
                String email = request.getParameter("email").trim();

                String errorMessage = null;

                // Input validation
                if (fullName.isEmpty() || !fullName.matches("[a-zA-Z\\s]+")) {
                    errorMessage = "Invalid full name. Only letters and spaces are allowed.";
                } else if (!phone.matches("0\\d{9}")) {
                    errorMessage = "Invalid phone number. It must have 10 digits and start with 0.";
                } else if (!email.matches("^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\\.[a-zA-Z]{2,6}$")) {
                    errorMessage = "Invalid email format.";
                }

                if (errorMessage == null) {
                    boolean isUpdated = employeeDAO.updateEmployee(id, fullName, phone, email);

                    if (isUpdated) {
                        session.setAttribute("notification", "Employee updated successfully.");
                    } else {
                        session.setAttribute("notificationErr", "Failed to update employee.");
                    }
                } else {
                    session.setAttribute("notificationErr", errorMessage);
                }
                response.sendRedirect("employee-management");
            }

        } else {
            response.sendRedirect("../login.jsp");
        }
    }
}
