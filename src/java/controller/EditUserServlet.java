package controller;

import com.google.gson.Gson;
import dal.UserDAO;
import model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet(name = "EditUserServlet", urlPatterns = {"/edit-user"})
public class EditUserServlet extends HttpServlet {
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            int userId = Integer.parseInt(request.getParameter("id"));
            UserDAO userDAO = new UserDAO();
            User user = userDAO.getUserById(userId);
            
            if (user != null) {
                Gson gson = new Gson();
                String userJson = gson.toJson(user);
                response.setContentType("application/json");
                response.setCharacterEncoding("UTF-8");
                response.getWriter().write(userJson);
            }
        } catch (Exception e) {
            response.setStatus(500);
            response.getWriter().write("Error: " + e.getMessage());
        }
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            // Get parameters
            int id = Integer.parseInt(request.getParameter("id"));
            String fullName = request.getParameter("fullName");
            String email = request.getParameter("email");
            boolean gender = Boolean.parseBoolean(request.getParameter("gender"));
            String mobile = request.getParameter("mobile");
            String address = request.getParameter("address");
            int roleId = Integer.parseInt(request.getParameter("roleId"));
            String status = request.getParameter("status");
            
            // Create user object
            User user = new User();
            user.setId(id);
            user.setFullName(fullName);
            user.setEmail(email);
            user.setGender(gender);
            user.setMobile(mobile);
            user.setAddress(address);
            user.setRoleId(roleId);
            user.setStatus(status);
            
            // Update user
            UserDAO userDAO = new UserDAO();
            userDAO.updateUser(user);
            
            request.getSession().setAttribute("successMessage", "User updated successfully!");
            response.sendRedirect("admin-manage-user");
            
        } catch (Exception e) {
            request.getSession().setAttribute("errorMessage", "Error updating user: " + e.getMessage());
            response.sendRedirect("admin-manage-user");
        }
    }
} 