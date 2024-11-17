
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
        
        if (user == null || user.getRoleId() != 1) {
            response.sendRedirect("login.jsp");
            return;
        }
        
        // Get today's stats
        LocalDate startDate;
        LocalDate endDate;
        if (request.getParameter("startDate") != null && request.getParameter("endDate") != null) {
            startDate = LocalDate.parse(request.getParameter("startDate"));
            endDate = LocalDate.parse(request.getParameter("endDate"));
        } else {
            startDate = LocalDate.now().minusDays(7);
            endDate = LocalDate.now();
        }
         DashboardStats stats = dashboardDAO.getDashboardStats(startDate, endDate);
        request.setAttribute("stats", stats);
        request.setAttribute("startDate", startDate);
        request.setAttribute("endDate", endDate);
        request.getRequestDispatcher("admin_dashboard.jsp").forward(request, response);
    }
}
 