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
            
            // Debug log
            System.out.println("POST request received");
            System.out.println("Form parameters:");
            request.getParameterMap().forEach((key, value) -> {
                System.out.println(key + ": " + String.join(", ", value));
            });
            
            // Check if user is admin
            if (loggedInUser != null && loggedInUser.getRoleId() == 1) {
                // Get form data with null checks
                String idStr = request.getParameter("id");
                System.out.println("Received ID: " + idStr); // Debug log
                
                if (idStr == null || idStr.trim().isEmpty()) {
                    throw new IllegalArgumentException("User ID is required");
                }
                
                int id = Integer.parseInt(idStr);
                
                // Get current user data first
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
                
                // Update only the fields that are provided
                String fullName = request.getParameter("fullName");
                String email = request.getParameter("email");
                String genderStr = request.getParameter("gender");
                String mobile = request.getParameter("mobile");
                String address = request.getParameter("address");
                String roleIdStr = request.getParameter("roleId");
                String status = request.getParameter("status");
                
                // Debug logs
                System.out.println("Updating user with ID: " + id);
                System.out.println("Full Name: " + fullName);
                System.out.println("Email: " + email);
                System.out.println("Gender: " + genderStr);
                System.out.println("Mobile: " + mobile);
                System.out.println("Address: " + address);
                System.out.println("Role ID: " + roleIdStr);
                System.out.println("Status: " + status);
                
                // Create user object with current values
                User user = new User();
                user.setId(id);
                user.setFullName(fullName != null ? fullName : currentUser.getFullName());
                user.setEmail(email != null ? email : currentUser.getEmail());
                user.setGender(genderStr != null ? Boolean.parseBoolean(genderStr) : currentUser.isGender());
                user.setMobile(mobile != null ? mobile : currentUser.getMobile());
                user.setAddress(address != null ? address : currentUser.getAddress());
                user.setRoleId(roleIdStr != null ? Integer.parseInt(roleIdStr) : currentUser.getRoleId());
                user.setStatus(status != null ? status : currentUser.getStatus());
                
                // Keep existing values that shouldn't be modified
                user.setPassword(currentUser.getPassword());
                user.setImageLink(currentUser.getImageLink());
                
                // Update user
                boolean success = userDAO.updateUser(user);
                
                if (success) {
                    session.setAttribute("successMessage", "User updated successfully!");
                    System.out.println("User updated successfully");
                } else {
                    session.setAttribute("errorMessage", "Failed to update user.");
                    System.out.println("Failed to update user");
                }
            } else {
                session.setAttribute("errorMessage", "You don't have permission to modify user information.");
                System.out.println("Permission denied");
            }
            
            // Redirect back to the same page
            String redirectUrl = "user-details?id=" + request.getParameter("id");
            System.out.println("Redirecting to: " + redirectUrl);
            response.sendRedirect(redirectUrl);
            
        } catch (Exception e) {
            System.out.println("Error in doPost: " + e.getMessage());
            e.printStackTrace();
            request.getSession().setAttribute("errorMessage", "Error updating user: " + e.getMessage());
            response.sendRedirect(request.getHeader("Referer"));
        }
    }
} 