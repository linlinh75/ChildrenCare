package controller;

import dal.DashboardDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.time.LocalDate;
import model.DashboardStats;
import model.User;

@WebServlet(name = "AdminDashboardServlet", urlPatterns = {"/admin-dashboard"})
public class AdminDashboardServlet extends HttpServlet {
    private DashboardDAO dashboardDAO;
    
    @Override
    public void init() {
        dashboardDAO = new DashboardDAO();
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("account");
        
        // Check if user is admin
        if (user == null || user.getRoleId() != 1) {
            response.sendRedirect("login.jsp");
            return;
        }
        
        // Get date range (default to last 30 days)
        LocalDate endDate = LocalDate.now();
        LocalDate startDate = endDate.minusDays(30);
        
        // Get dashboard statistics
        DashboardStats stats = dashboardDAO.getDashboardStats(startDate, endDate);
        request.setAttribute("stats", stats);
        
        request.getRequestDispatcher("admin_dashboard.jsp").forward(request, response);
    }
} 