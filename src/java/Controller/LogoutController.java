/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller;

import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.Enumeration;

/**
 *
 * @author giaun
 */
public class LogoutController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        Cookie cookies[] = request.getCookies();
        if (cookies != null) {
            for (Cookie cookie : cookies) {
                cookie.setMaxAge(0);
                response.addCookie(cookie);
            }
        }
        HttpSession session = request.getSession();
        if (session != null) {
            removeAllSessions(request);
        }
response.sendRedirect("index.jsp");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

     
            Cookie cookies[] = request.getCookies();
            if (cookies != null) {
                for (Cookie cookie : cookies) {
                    cookie.setMaxAge(0);
                    response.addCookie(cookie);
                }
            }
            HttpSession session = request.getSession();
            if (session != null) {
                removeAllSessions(request);
            }

       
        response.sendRedirect("index.jsp");
    }

    private void removeAllSessions(HttpServletRequest request) {
        Enumeration<String> sessionNames = request.getSession().getAttributeNames();

        while (sessionNames.hasMoreElements()) {
            String sessionName = sessionNames.nextElement();
            HttpSession session = request.getSession(false);
            if (session != null) {
                session.invalidate();
            }
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
