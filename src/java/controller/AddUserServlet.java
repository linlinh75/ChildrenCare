package controller;

import dal.UserDAO;
import model.User;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import util.EmailUtil;
import java.security.SecureRandom;
import javax.mail.MessagingException;

@WebServlet(name = "AddUserServlet", urlPatterns = {"/add-user"})
public class AddUserServlet extends HttpServlet {

    private String generatePassword() {
        String chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789!@#$%^&*";
        SecureRandom random = new SecureRandom();
        StringBuilder password = new StringBuilder();
        
        for (int i = 0; i < 12; i++) {
            password.append(chars.charAt(random.nextInt(chars.length())));
        }
        
        return password.toString();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("add-user.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            String fullName = request.getParameter("fullName");
            String email = request.getParameter("email");
            boolean gender = Boolean.parseBoolean(request.getParameter("gender"));
            String mobile = request.getParameter("mobile");
            String address = request.getParameter("address");
            int roleId = Integer.parseInt(request.getParameter("roleId"));
            
            String password = generatePassword();
            
            User user = new User();
            user.setFullName(fullName);
            user.setEmail(email);
            user.setPassword(password);
            user.setGender(gender);
            user.setMobile(mobile);
            user.setAddress(address);
            user.setRoleId(roleId);
            user.setStatus("Active");
            user.setImageLink("assets/images/default.png");
            
            UserDAO userDAO = new UserDAO();
            int result = userDAO.addUser(user);
            
            if (result > 0) {
//                try {
//                    EmailUtil.sendPasswordEmail(email, password);
//                    request.getSession().setAttribute("successMessage", 
//                        "User added successfully! Login credentials have been sent to their email.");
//                } catch (MessagingException e) {
                    request.getSession().setAttribute("successMessage", "User added successfully! ");
//                                + "Failed to send email: " + e.getMessage());
//                }
            } else {
                request.getSession().setAttribute("errorMessage", "Failed to add user.");
            }
            
            response.sendRedirect("admin-manage-user");
            
        } catch (Exception e) {
            request.getSession().setAttribute("errorMessage", "Error adding user: " + e.getMessage());
            response.sendRedirect("admin-manage-user");
        }
    }
} 