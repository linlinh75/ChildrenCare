/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;
//doing

import dal.UserDAO;
import model.User;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.sql.SQLException;
import java.util.Random;
import java.util.Properties;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.mail.*;
import javax.mail.internet.*;
import util.EncodePassword;

/**
 *
 * @author admin
 */
@WebServlet(name = "RegisterServlet", urlPatterns = {"/RegisterServlet"})
public class RegisterServlet extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    private void sendVerificationEmail(String email, String verificationCode) {
        String subject = "Verify your account on Children Care System";
        String content = "Your Verification Code is: " + verificationCode + "\n"
                + "Please click the link below to activate your account:\n"
                + "http://localhost:8080/ChildrenCare/activate?code=" + verificationCode;

        Properties props = new Properties();
        props.put("mail.smtp.host", "smtp.gmail.com");
        props.put("mail.smtp.socketFactory.port", "465");
        props.put("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory");
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.port", "465");
        Session session = Session.getDefaultInstance(props, new javax.mail.Authenticator() {
            @Override
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication("childrencaresystemse1874@gmail.com", "cgcu vqdd whlf cdiw");
                // id and
                // password here
            }
        });
        try {
            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress("childrencaresystemse1874@gmail.com"));
            message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(email));
            message.setSubject(subject);
            message.setText(content);
            Transport.send(message);
        } catch (MessagingException e) {
            e.printStackTrace();
        }
    }

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */

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
        Random rand = new Random();
        String action = request.getParameter("action");
        if ("resend".equals(action)) {
            String newVerificationCode = String.format("%06d", rand.nextInt(1000000));

            HttpSession session = request.getSession();
            if (session.getAttribute("activationMessage") != null) {
                response.sendRedirect("DataServlet?action=login");
            } else {
                session.setAttribute("verificationCode", newVerificationCode);

                String email = (String) session.getAttribute("userEmail");
                sendVerificationEmail(email, newVerificationCode);

                session.setAttribute("resendMessage", "A new verification code has been sent to your email.");
                request.getRequestDispatcher("verify.jsp").forward(request, response);
            }
            return;
        }
        UserDAO userdao = new UserDAO();
        String fullname = request.getParameter("fullname");
        String address = request.getParameter("address");
        Boolean gender = "true".equalsIgnoreCase(request.getParameter("gender"));
        String mobile = request.getParameter("phone");
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        try {
            if (userdao.getUserByEmail(email) != null) {
                request.setAttribute("error", "Email is exist. Please enter new email.");
                request.setAttribute("fullname", fullname);
                request.setAttribute("address", address);
                request.setAttribute("gender", gender);
                request.setAttribute("mobile", mobile);
                request.setAttribute("password", password);
                request.getRequestDispatcher("DataServlet?action=register").forward(request, response);
                return;
            }
            if (userdao.getUserByPhoneNumber(mobile) != null) {
                request.setAttribute("error", "Phone number is exist. Please enter new phone number.");
                request.setAttribute("fullname", fullname);
                request.setAttribute("address", address);
                request.setAttribute("gender", gender);
                request.setAttribute("email", email);
                request.setAttribute("password", password);
                request.getRequestDispatcher("DataServlet?action=register").forward(request, response);
                return;
            }
        } catch (SQLException ex) {
            Logger.getLogger(RegisterServlet.class.getName()).log(Level.SEVERE, null, ex);
        }
        String verificationCode = String.format("%06d", rand.nextInt(1000000));
        password=EncodePassword.encodeToSHA1(password);
        User newUser = new User();
        newUser.setEmail(email);
        newUser.setPassword(password);
        newUser.setFullName(fullname);
        newUser.setGender(gender);
        newUser.setMobile(mobile);
        newUser.setAddress(address);
        newUser.setImageLink("assets/images/default.png");
        newUser.setRoleId(4);
        newUser.setStatus("Inactive");

        HttpSession session = request.getSession();
        session.setAttribute("verificationCode", verificationCode);
        session.setAttribute("userEmail", email);
        session.setAttribute("user", newUser);
        sendVerificationEmail(email, verificationCode);
        request.getRequestDispatcher("DataServlet?action=verify").forward(request, response);
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
