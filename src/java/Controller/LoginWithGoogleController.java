/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller;

import DAOs.AccountDAO;
import DAOs.UserDAO;
import Models.Constants;
import Models.UserGoogleDto;
import com.google.gson.Gson;
import com.google.gson.JsonObject;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.net.URLEncoder;
import java.sql.SQLException;
import org.apache.http.client.ClientProtocolException;
import org.apache.http.client.HttpResponseException;
import org.apache.http.client.fluent.Form;
import org.apache.http.client.fluent.Request;

/**
 *
 * @author Le Minh Truong - CE171886
 */
@WebServlet(name = "LoginWithGoogleController", urlPatterns = {"/loginwithgoogle"})
public class LoginWithGoogleController extends HttpServlet {

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
        String code = request.getParameter("code");
        if (code != null && !code.isEmpty()) {
            try {
                String accessToken = getToken(code);
                UserGoogleDto user = getUserInfo(accessToken);
                if (user != null) {
                    UserDAO userDAO = new UserDAO();
                    boolean exists = userDAO.userExists(user.getEmail());
                    if (!exists) {
                        userDAO.insertUser(user); // Chỉ chèn người dùng mới
                        System.out.println("New user inserted.");
                    }
                    // Store user information in session or cookies
                HttpSession session = request.getSession();
                session.setAttribute("fullName", user.getName()); // Store full name in session
                session.setAttribute("email", user.getEmail()); // Store email in session
                AccountDAO d = new AccountDAO();
                Cookie fullNameCookie = new Cookie("fullNameC", d.encodeString(user.getName()));
                fullNameCookie.setMaxAge(60 * 60 * 24 * 2); // Set expiry for 2 days
                response.addCookie(fullNameCookie);

                System.out.println(user);
                response.sendRedirect(request.getContextPath() + "/"); // Redirect to home page
                }
            } catch (SQLException e) {
                e.printStackTrace();
                response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Database error occurred");
            } catch (Exception e) {
                e.printStackTrace();
                response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Failed to process login");
            }
        }
    }

    public String getToken(String code) throws ClientProtocolException, IOException {
        try {
            String response = Request.Post(Constants.GOOGLE_LINK_GET_TOKEN)
                    .bodyForm(Form.form().add("client_id", Constants.GOOGLE_CLIENT_ID)
                            .add("client_secret", Constants.GOOGLE_CLIENT_SECRET)
                            .add("redirect_uri", Constants.GOOGLE_REDIRECT_URI)
                            .add("code", code)
                            .add("grant_type", Constants.GOOGLE_GRANT_TYPE).build())
                    .execute().returnContent().asString();
            JsonObject jobj = new Gson().fromJson(response, JsonObject.class);
            String accessToken = jobj.get("access_token").getAsString();
            if (accessToken == null || accessToken.isEmpty()) {
                throw new IOException("Failed to retrieve access token");
            }
            return accessToken.replaceAll("\"", "");
        } catch (HttpResponseException e) {
            System.err.println("HTTP Status Code: " + e.getStatusCode());
            throw new IOException("Error retrieving access token: " + e.getMessage());
        }
    }

    public UserGoogleDto getUserInfo(final String accessToken) throws ClientProtocolException, IOException {
        String link = Constants.GOOGLE_LINK_GET_USER_INFO + accessToken;
        String response = Request.Get(link).execute().returnContent().asString();
        return new Gson().fromJson(response, UserGoogleDto.class);
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
