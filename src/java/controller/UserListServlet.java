package controller;

import dal.UserDAO;
import model.User;
import java.io.IOException;
import java.util.List;
import java.util.ArrayList;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.sql.SQLException;

@WebServlet(name = "UserListServlet", urlPatterns = {"/admin-manage-user"})
public class UserListServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            UserDAO userDAO = new UserDAO();
            
            // Get parameters
            int page = 1;
            int recordsPerPage = 10;
            String pageStr = request.getParameter("page");
            if (pageStr != null && !pageStr.isEmpty()) {
                page = Integer.parseInt(pageStr);
            }
            
            // Get filter parameters
            String genderFilter = request.getParameter("gender");
            String roleFilter = request.getParameter("role");
            String statusFilter = request.getParameter("status");
            String searchKeyword = request.getParameter("search");
            
            // Get sort parameters
            String sortBy = request.getParameter("sortBy");
            String sortOrder = request.getParameter("sortOrder");
            
            // Get filtered and sorted users
            List<User> userList = userDAO.getFilteredAndSortedUsers(
                genderFilter, roleFilter, statusFilter, searchKeyword,
                sortBy, sortOrder, page, recordsPerPage
            );
            
            // Get total records for pagination
            int totalRecords = userDAO.getTotalFilteredUsers(
                genderFilter, roleFilter, statusFilter, searchKeyword
            );
            
            // Calculate total pages
            int totalPages = (int) Math.ceil(totalRecords * 1.0 / recordsPerPage);
            
            // Set attributes
            request.setAttribute("listUser", userList);
            request.setAttribute("currentPage", page);
            request.setAttribute("totalPages", totalPages);
            request.setAttribute("recordsPerPage", recordsPerPage);
            request.setAttribute("totalRecords", totalRecords);
            request.setAttribute("genderFilter", genderFilter);
            request.setAttribute("roleFilter", roleFilter);
            request.setAttribute("statusFilter", statusFilter);
            request.setAttribute("searchKeyword", searchKeyword);
            request.setAttribute("sortBy", sortBy);
            request.setAttribute("sortOrder", sortOrder);
            
            // Add these lines before forwarding to JSP
            System.out.println("Total records found: " + totalRecords);
            System.out.println("Users in current page: " + userList.size());
            System.out.println("Current page: " + page);
            System.out.println("Total pages: " + totalPages);
            
            // Forward to JSP
            request.getRequestDispatcher("admin-UserList.jsp").forward(request, response);
            
        } catch (Exception e) {
            System.out.println("Error in UserListServlet: " + e.getMessage());
            e.printStackTrace();
            response.sendRedirect("error.jsp");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
} 