///*
// * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
// * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
// */
//package Controller;
//
//import DAOs.CustomerDAO;
//import jakarta.servlet.ServletException;
//import jakarta.servlet.annotation.WebServlet;
//import jakarta.servlet.http.HttpServlet;
//import jakarta.servlet.http.HttpServletRequest;
//import jakarta.servlet.http.HttpServletResponse;
//import java.io.IOException;
//import java.io.PrintWriter;
//import java.util.Properties;
//import java.util.UUID;
//import javax.mail.Message;
//import javax.mail.MessagingException;
//import javax.mail.PasswordAuthentication;
//import javax.mail.Session;
//import javax.mail.Transport;
//import javax.mail.internet.InternetAddress;
//import javax.mail.internet.MimeMessage;
//
///**
// *
// * @author AN515-57
// */
//@WebServlet(name = "ForgotPasswordController", urlPatterns = {"/forgotpassword"})
//public class ForgotPasswordController extends HttpServlet {
//
//    private static final long serialVersionUID = 1L;
//
//    /**
//     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
//     * methods.
//     *
//     * @param request servlet request
//     * @param response servlet response
//     * @throws ServletException if a servlet-specific error occurs
//     * @throws IOException if an I/O error occurs
//     */
//    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
//            throws ServletException, IOException {
//        response.setContentType("text/html;charset=UTF-8");
//        try ( PrintWriter out = response.getWriter()) {
//            /* TODO output your page here. You may use following sample code. */
//            out.println("<!DOCTYPE html>");
//            out.println("<html>");
//            out.println("<head>");
//            out.println("<title>Servlet ForgotPasswordController</title>");
//            out.println("</head>");
//            out.println("<body>");
//            out.println("<h1>Servlet ForgotPasswordController at " + request.getContextPath() + "</h1>");
//            out.println("</body>");
//            out.println("</html>");
//        }
//    }
//
//    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
//    /**
//     * Handles the HTTP <code>GET</code> method.
//     *
//     * @param request servlet request
//     * @param response servlet response
//     * @throws ServletException if a servlet-specific error occurs
//     * @throws IOException if an I/O error occurs
//     */
//    @Override
//    protected void doGet(HttpServletRequest request, HttpServletResponse response)
//            throws ServletException, IOException {
//        request.getRequestDispatcher("/forgotpassword.jsp").forward(request, response);
//    }
//
//    /**
//     * Handles the HTTP <code>POST</code> method.
//     *
//     * @param request servlet request
//     * @param response servlet response
//     * @throws ServletException if a servlet-specific error occurs
//     * @throws IOException if an I/O error occurs
//     */
//    @Override
//    protected void doPost(HttpServletRequest request, HttpServletResponse response)
//            throws ServletException, IOException {
//       String email = request.getParameter("email");
//    CustomerDAO customerDAO = new CustomerDAO();
//    
//    if (customerDAO.isEmailRegistered(email)) {
//        String token = UUID.randomUUID().toString();
//        customerDAO.saveResetToken(email, token);
//        
//        // Gửi email với token
//        sendEmail(email, token);
//        
//        response.getWriter().println("Reset password link has been sent to your email.");
//    } else {
//        response.getWriter().println("Email not registered.");
//    }
//    }
//
//    private void sendEmail(String email, String token) {
//        String host = "smtp.gmail.com";
//        final String user = "Cuongncce171631@fpt.edu.vn";
//        final String password = "Zxcvbnm12300";
//
//        String to = email;
//
//        // Nhận thông tin hệ thống
//        Properties properties = System.getProperties();
//        properties.setProperty("mail.smtp.host", host);
//        properties.setProperty("mail.smtp.auth", "true");
//
//        // Nhận phiên email mặc định
//        Session session = Session.getDefaultInstance(properties,
//                new javax.mail.Authenticator() {
//            protected PasswordAuthentication getPasswordAuthentication() {
//                return new PasswordAuthentication(user, password);
//            }
//        });
//
//        try {
//            MimeMessage message = new MimeMessage(session);
//            message.setFrom(new InternetAddress(user));
//            message.addRecipient(Message.RecipientType.TO, new InternetAddress(to));
//            message.setSubject("Password Reset Request");
//            message.setText("Click on the following link to reset your password: "
//                    + "http://your-domain.com/resetpassword?token=" + token + "&email=" + email);
//
//            Transport.send(message);
//            System.out.println("Message sent successfully...");
//        } catch (MessagingException e) {
//            e.printStackTrace();
//        }
//
//        
//
//    }
//}
