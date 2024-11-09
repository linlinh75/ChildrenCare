package controller;

import dal.SettingDAO;
import model.Setting;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet(name = "EditSettingServlet", urlPatterns = {"/edit-setting"})
public class EditSettingServlet extends HttpServlet {
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            HttpSession session = request.getSession();
            
            // Lấy thông tin từ form
            int id = Integer.parseInt(request.getParameter("id"));
            String type = request.getParameter("type");
            String name = request.getParameter("name");
            int value = Integer.parseInt(request.getParameter("value"));
            String description = request.getParameter("description");
            int status = Integer.parseInt(request.getParameter("status"));
            
            // Tạo đối tượng Setting với thông tin mới
            Setting setting = new Setting(type, name, value, description, status);
            
            // Cập nhật setting và xử lý kết quả
            SettingDAO settingDAO = new SettingDAO();
            int result = settingDAO.updateSetting(setting);
            
            switch (result) {
                case 1:
                    session.setAttribute("successMessage", "Setting updated successfully!");
                    break;
                case -1:
                    session.setAttribute("errorMessage", "Invalid setting type!");
                    break;
                case -2:
                    session.setAttribute("errorMessage", 
                        "A setting with this name or value already exists in " + type + "!");
                    break;
                case -3:
                    session.setAttribute("errorMessage", "Database error occurred!");
                    break;
                default:
                    session.setAttribute("errorMessage", "Failed to update setting!");
            }
            
            // Redirect về trang chi tiết setting
            response.sendRedirect("setting-details?id=" + value);
            
        } catch (Exception e) {
            request.getSession().setAttribute("errorMessage", "Error updating setting: " + e.getMessage());
            response.sendRedirect(request.getHeader("Referer"));
        }
    }
} 