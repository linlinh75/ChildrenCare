package controller;

import dal.SettingDAO;
import model.Setting;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet(name = "AddSettingServlet", urlPatterns = {"/add-setting"})
public class AddSettingServlet extends HttpServlet {
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("add-setting.jsp").forward(request, response);
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            String type = request.getParameter("type");
            String name = request.getParameter("name");
            int value = Integer.parseInt(request.getParameter("value"));
            String description = request.getParameter("description");
            String status = request.getParameter("status");
            
            Setting setting = new Setting();
            setting.setType(type);
            setting.setName(name);
            setting.setValue(value);
            setting.setDescription(description);
            setting.setStatus(status);
            
            SettingDAO settingDAO = new SettingDAO();
            boolean success = settingDAO.addSetting(setting);
            
            if (success) {
                request.getSession().setAttribute("successMessage", "Setting added successfully!");
            } else {
                request.getSession().setAttribute("errorMessage", "Failed to add setting.");
            }
            
            response.sendRedirect("admin-manage-settings");
            
        } catch (Exception e) {
            request.getSession().setAttribute("errorMessage", "Error adding setting: " + e.getMessage());
            response.sendRedirect("admin-manage-settings");
        }
    }
} 