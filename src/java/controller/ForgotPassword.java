/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;


import dal.UserDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.Properties;
import java.util.Random;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

/**
 *
 * @author Admin
 */
@WebServlet("/forgot")
public class ForgotPassword extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String email = request.getParameter("email");
        RequestDispatcher dispatcher;
        HttpSession mySession = request.getSession();
        UserDAO udao = new UserDAO();
        if (email != null && !email.isEmpty()) {
           
            String token = udao.addToken(email);
            String resetPasswordLink = "http://localhost:8080/ChildrenCare/newPassword?token=" + token;

            
            Properties props = new Properties();
            props.put("mail.smtp.host", "smtp.gmail.com");
            props.put("mail.smtp.socketFactory.port", "465");
            props.put("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory");
            props.put("mail.smtp.auth", "true");
            props.put("mail.smtp.port", "465");
            Session session = Session.getDefaultInstance(props, new javax.mail.Authenticator() {
                protected PasswordAuthentication getPasswordAuthentication() {
                    return new PasswordAuthentication("nguyetanh0945@gmail.com", "nmyz rizo oqri ihat");
                }
            });
            try {
                MimeMessage message = new MimeMessage(session);
                message.setFrom(new InternetAddress("nguyetanh0945@gmail.com"));
                message.addRecipient(Message.RecipientType.TO, new InternetAddress(email));
                message.setSubject("Reset Password");
                message.setContent("<p>Click this link to reset your password: </p>" +
                        "<a href=\"" + resetPasswordLink + "\">Reset my password</a>", "text/html");
                
                Transport.send(message);
                System.out.println("Message sent successfully");
            } catch (MessagingException e) {
                throw new RuntimeException(e);
            }
            request.setAttribute("message", "Link has been sent to your email address");
            mySession.setAttribute("email", email);
            request.getRequestDispatcher("forgotPw.jsp").forward(request, response);
        } else {
            // Handle error
            request.setAttribute("error", "Email cannot be empty");
            dispatcher = request.getRequestDispatcher("errorPage.jsp");
            dispatcher.forward(request, response);
        }
    }

}

