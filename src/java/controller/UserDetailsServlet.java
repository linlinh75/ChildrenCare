package controller;

import dal.UserDAO;
import model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet(name = "UserDetailsServlet", urlPatterns = {"/user-details"})
public class UserDetailsServlet extends HttpServlet {
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            String userId = request.getParameter("id");
            UserDAO userDAO = new UserDAO();
            User user;
            
            if (userId != null && !userId.trim().isEmpty()) {
                // View specific user
                user = userDAO.getUserById(Integer.parseInt(userId));
            } else {
                // View logged-in user's profile
                HttpSession session = request.getSession();
                user = (User) session.getAttribute("account");
            }
            
            if (user != null) {
                request.setAttribute("user", user);
                request.getRequestDispatcher("user-details.jsp").forward(request, response);
            } else {
                response.sendRedirect("admin-manage-user");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("error.jsp");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            HttpSession session = request.getSession();
            User loggedInUser = (User) session.getAttribute("account");
            
            if (loggedInUser != null && loggedInUser.getRoleId() == 1) {
                String idStr = request.getParameter("id");
                if (idStr == null || idStr.trim().isEmpty()) {
                    throw new IllegalArgumentException("User ID is required");
                }
                
                int id = Integer.parseInt(idStr);
                UserDAO userDAO = new UserDAO();
                User currentUser = userDAO.getUserById(id);
                
                if (currentUser == null) {
                    throw new IllegalArgumentException("User not found");
                }
                
                // Check if trying to modify an admin's role
                if (currentUser.getRoleId() == 1) {
                    String roleIdStr = request.getParameter("roleId");
                    if (roleIdStr != null && Integer.parseInt(roleIdStr) != 1) {
                        session.setAttribute("errorMessage", "Cannot modify an admin's role.");
                        response.sendRedirect("user-details?id=" + id);
                        return;
                    }
                }
                
                // Create user object with updated values
                User user = new User();
                user.setId(id);
                user.setFullName(request.getParameter("fullName"));
                user.setEmail(request.getParameter("email"));
                user.setGender(Boolean.parseBoolean(request.getParameter("gender")));
                user.setMobile(request.getParameter("mobile"));
                user.setAddress(request.getParameter("address"));
                user.setRoleId(Integer.parseInt(request.getParameter("roleId")));
                user.setStatus(request.getParameter("status"));
                
                // Keep existing values
                user.setPassword(currentUser.getPassword());
                user.setImageLink(currentUser.getImageLink());
                
                // Update user and handle result
                int result = userDAO.updateUser(user);
                switch (result) {
                    case 1:
                        session.setAttribute("successMessage", "User updated successfully!");
                        break;
                    case -1:
                        session.setAttribute("errorMessage", "Email already exists!");
                        break;
                    case -2:
                        session.setAttribute("errorMessage", "Phone number already exists!");
                        break;
                    case -3:
                        session.setAttribute("errorMessage", "Database error occurred!");
                        break;
                    default:
                        session.setAttribute("errorMessage", "Failed to update user!");
                }
            } else {
                session.setAttribute("errorMessage", "You don't have permission to modify user information.");
            }
            
            response.sendRedirect("user-details?id=" + request.getParameter("id"));
            
        } catch (Exception e) {
            System.out.println("Error in doPost: " + e.getMessage());
            e.printStackTrace();
            request.getSession().setAttribute("errorMessage", "Error updating user: " + e.getMessage());
            response.sendRedirect(request.getHeader("Referer"));
        }
    }
} 