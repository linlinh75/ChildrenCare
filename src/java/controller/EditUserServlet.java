package controller;

import dal.UserDAO;
import model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import jakarta.servlet.http.HttpSession;

@WebServlet(name = "EditUserServlet", urlPatterns = {"/edit-user"})
public class EditUserServlet extends HttpServlet {
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        
        try {
            HttpSession session = request.getSession();
            User loggedInUser = (User) session.getAttribute("account");
            
            if (loggedInUser != null && loggedInUser.getRoleId() == 1) {
                // Get parameters and create user object
                int userId = Integer.parseInt(request.getParameter("id"));
                
                // Check if trying to modify an admin's role
                UserDAO userDAO = new UserDAO();
                User currentUser = userDAO.getUserById(userId);
                
                if (currentUser == null) {
                    response.getWriter().write("{\"success\": false, \"message\": \"User not found.\"}");
                    return;
                }
                
                if (currentUser.getRoleId() == 1 && userId != loggedInUser.getId()) {
                    response.getWriter().write("{\"success\": false, \"message\": \"Cannot modify another admin's account.\"}");
                    return;
                }
                
                // Create updated user object
                User user = new User();
                user.setId(userId);
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
                
                int result = userDAO.updateUser(user);
                
                switch (result) {
                    case 1:
                        response.getWriter().write("{\"success\": true, \"message\": \"User updated successfully!\"}");
                        break;
                    case -1:
                        response.getWriter().write("{\"success\": false, \"message\": \"Email already exists!\"}");
                        break;
                    case -2:
                        response.getWriter().write("{\"success\": false, \"message\": \"Phone number already exists!\"}");
                        break;
                    default:
                        response.getWriter().write("{\"success\": false, \"message\": \"Failed to update user.\"}");
                }
            } else {
                response.getWriter().write("{\"success\": false, \"message\": \"Unauthorized access.\"}");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().write("{\"success\": false, \"message\": \"Error: " + e.getMessage() + "\"}");
        }
    }
} 