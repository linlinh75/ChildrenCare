package controller;

import dal.UserDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import model.User;

@WebServlet(name = "GetUserDataServlet", urlPatterns = {"/get-user-data"})
public class GetUserDataServlet extends HttpServlet {
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            int userId = Integer.parseInt(request.getParameter("id"));
            UserDAO userDAO = new UserDAO();
            User user = userDAO.getUserById(userId);
            
            if (user != null) {
                response.setContentType("application/json");
                response.setCharacterEncoding("UTF-8");
                
                // Manually create JSON string
                String json = String.format(
                    "{\"id\":%d," +
                    "\"email\":\"%s\"," +
                    "\"fullName\":\"%s\"," +
                    "\"gender\":%b," +
                    "\"mobile\":\"%s\"," +
                    "\"address\":\"%s\"," +
                    "\"imageLink\":\"%s\"," +
                    "\"roleId\":%d," +
                    "\"status\":\"%s\"}",
                    user.getId(),
                    escapeJsonString(user.getEmail()),
                    escapeJsonString(user.getFullName()),
                    user.isGender(),
                    escapeJsonString(user.getMobile()),
                    escapeJsonString(user.getAddress()),
                    escapeJsonString(user.getImageLink()),
                    user.getRoleId(),
                    escapeJsonString(user.getStatus())
                );
                
                response.getWriter().write(json);
            } else {
                response.setStatus(HttpServletResponse.SC_NOT_FOUND);
            }
        } catch (Exception e) {
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            response.getWriter().write("{\"error\": \"" + escapeJsonString(e.getMessage()) + "\"}");
        }
    }
    
    // Helper method to escape special characters in JSON strings
    private String escapeJsonString(String input) {
        if (input == null) {
            return "";
        }
        
        StringBuilder escaped = new StringBuilder();
        for (char c : input.toCharArray()) {
            switch (c) {
                case '"':
                    escaped.append("\\\"");
                    break;
                case '\\':
                    escaped.append("\\\\");
                    break;
                case '\b':
                    escaped.append("\\b");
                    break;
                case '\f':
                    escaped.append("\\f");
                    break;
                case '\n':
                    escaped.append("\\n");
                    break;
                case '\r':
                    escaped.append("\\r");
                    break;
                case '\t':
                    escaped.append("\\t");
                    break;
                default:
                    escaped.append(c);
            }
        }
        return escaped.toString();
    }
} 