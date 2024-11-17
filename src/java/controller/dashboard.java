package controller;



import dal.UserDAO;
import model.User;
import java.io.IOException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;


@WebServlet(name = "dashboard", urlPatterns = {"/admin-manage-user"})
public class dashboard extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            UserDAO userDAO = new UserDAO();
            
            // Pagination
            int page = 1;
            int recordsPerPage = 10;
            if(request.getParameter("page") != null)
                page = Integer.parseInt(request.getParameter("page"));
            
            List<User> listUser = userDAO.getAllUsersWithPagination(page, recordsPerPage);
            int totalRecords = userDAO.getTotalUsers();
            int totalPages = (int) Math.ceil(totalRecords * 1.0 / recordsPerPage);
            
            // Get success/error messages if any
            String successMessage = request.getParameter("success");
            String errorMessage = request.getParameter("error");
            
            request.setAttribute("listUser", listUser);
            request.setAttribute("totalPages", totalPages);
            request.setAttribute("currentPage", page);
            request.setAttribute("successMessage", successMessage);
            request.setAttribute("errorMessage", errorMessage);
            
            request.getRequestDispatcher("admin-UserList.jsp").forward(request, response);
            
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("error.jsp");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            String searchKeyword = request.getParameter("search");
            UserDAO userDAO = new UserDAO();
            
            List<User> listUser;
            if (searchKeyword != null && !searchKeyword.trim().isEmpty()) {
                listUser = userDAO.searchUsers(searchKeyword);
            } else {
                listUser = userDAO.getAllUsersWithPagination(1, 10);
            }
            
            request.setAttribute("listUser", listUser);
            request.setAttribute("searchKeyword", searchKeyword);
            request.getRequestDispatcher("admin-UserList.jsp").forward(request, response);
            
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("error.jsp");
        }
    }
}
