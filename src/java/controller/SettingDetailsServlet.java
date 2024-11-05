package controller;

import dal.SettingDAO;
import model.Setting;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet(name = "SettingDetailsServlet", urlPatterns = {"/setting-details"})
public class SettingDetailsServlet extends HttpServlet {
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            int settingId = Integer.parseInt(request.getParameter("id"));
            SettingDAO settingDAO = new SettingDAO();
            Setting setting = settingDAO.getSettingById(settingId);
            
            if (setting != null) {
                request.setAttribute("setting", setting);
                request.getRequestDispatcher("setting-details.jsp").forward(request, response);
            } else {
                response.sendRedirect("admin-manage-settings");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("error.jsp");
        }
    }
} 