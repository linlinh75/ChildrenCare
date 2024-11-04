package controller;

import dal.UserDAO;
import model.User;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(name = "AddUserServlet", urlPatterns = {"/add-user"})
public class AddUserServlet extends HttpServlet {

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
            String password = request.getParameter("password");
            boolean gender = Boolean.parseBoolean(request.getParameter("gender"));
            String mobile = request.getParameter("mobile");
            String address = request.getParameter("address");
            int roleId = Integer.parseInt(request.getParameter("roleId"));
            
            User user = new User();
            user.setFullName(fullName);
            user.setEmail(email);
            user.setPassword(password);
            user.setGender(gender);
            user.setMobile(mobile);
            user.setAddress(address);
            user.setRoleId(roleId);
            
            UserDAO userDAO = new UserDAO();
            userDAO.addUser(user);
            
            request.getSession().setAttribute("successMessage", "User added successfully!");
            response.sendRedirect("admin-manage-user");
            
        } catch (Exception e) {
            request.getSession().setAttribute("errorMessage", "Error adding user: " + e.getMessage());
            response.sendRedirect("admin-manage-user");
        }
    }
} 