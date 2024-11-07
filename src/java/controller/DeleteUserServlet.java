package controller;

import dal.UserDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import jakarta.servlet.http.HttpSession;
import model.User;

@WebServlet(name = "DeleteUserServlet", urlPatterns = {"/delete-user"})
public class DeleteUserServlet extends HttpServlet {
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            HttpSession session = request.getSession();
            User loggedInUser = (User) session.getAttribute("account");
            int userId = Integer.parseInt(request.getParameter("id"));
            
            // Prevent deletion of logged-in admin
            if (loggedInUser != null && loggedInUser.getId() == userId) {
                request.getSession().setAttribute("errorMessage", "Cannot delete your own admin account!");
                response.sendRedirect("admin-manage-user");
                return;
            }
            
            UserDAO userDAO = new UserDAO();
            userDAO.deleteUser(userId);
            
            request.getSession().setAttribute("successMessage", "User deleted successfully!");
            response.sendRedirect("admin-manage-user");
            
        } catch (Exception e) {
            request.getSession().setAttribute("errorMessage", "Error deleting user: " + e.getMessage());
            response.sendRedirect("admin-manage-user");
        }
    }
} 