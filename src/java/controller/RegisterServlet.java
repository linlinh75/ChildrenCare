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
import static java.lang.System.out;
import java.time.LocalDateTime;
import java.util.Random;
import java.util.Properties;
import javax.mail.*;
import javax.mail.internet.*;

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
			protected PasswordAuthentication getPasswordAuthentication() {
					return new PasswordAuthentication("nguyetanh0945@gmail.com", "nmyz rizo oqri ihat");
																									// id and
																									// password here
				}
			});
        try {
            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress("nguyetanh0945@gmail.com"));
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
        UserDAO userdao = new UserDAO();
        String submit = request.getParameter("submit");
        String fullname = request.getParameter("fullname");
        String address = request.getParameter("address");
        String gender = request.getParameter("gender");
        String mobile = request.getParameter("phone");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        out.print(submit);
        Random rand = new Random();
        String verificationCode = String.format("%06d", rand.nextInt(1000000));

        HttpSession session = request.getSession();
        session.setAttribute("fullname", fullname);
        session.setAttribute("address", address);
        session.setAttribute("gender", gender);
        session.setAttribute("mobile", mobile);
        session.setAttribute("email", email);
        session.setAttribute("password", password);
        session.setAttribute("verificationCode", verificationCode);
        session.setAttribute("expireAt", LocalDateTime.now().plusMinutes(3));
        
        sendVerificationEmail(email, verificationCode);
        
        session.setAttribute("verificationCode", verificationCode);
        session.setAttribute("expireAt", LocalDateTime.now().plusMinutes(3)); 
        //response.sendRedirect("verify.jsp");
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