/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dal.PostDAO;
import dal.ServiceDAO;
import dal.SettingDAO;
import dal.SliderDAO;
import dal.UserDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;
import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.util.List;
import model.Post;
import model.Service;
import model.Setting;
import model.Slider;
import model.User;

@MultipartConfig(
        fileSizeThreshold = 1024 * 1024, // 1 MB
        maxFileSize = 1024 * 1024 * 5, // 5 MB
        maxRequestSize = 1024 * 1024 * 10 // 10 MB
)
public class ProfileUserServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        HttpSession session = request.getSession();
        User loggedInUser = (User) session.getAttribute("account");
        // bo sung message (na)
        if (loggedInUser != null) {
            request.setAttribute("user", loggedInUser);
            request.setAttribute("role", new UserDAO().getRoleString(loggedInUser.getRoleId()));
            request.setAttribute("successChange", request.getParameter("successChange"));
            request.setAttribute("erChange", request.getParameter("erChange"));
            request.getRequestDispatcher("user/profile.jsp").forward(request, response);
        } else {
            // Nếu không có người dùng đăng nhập, chuyển hướng về trang đăng nhập
            response.sendRedirect("login.jsp");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        User loggedInUser = (User) session.getAttribute("account");

        if (loggedInUser != null) {
            Part filePart = request.getPart("profileImage");
            if (filePart != null && filePart.getSize() > 0) {
                String fileName = getFileName(filePart);
                String uploadDir = getServletContext().getRealPath("/uploads");

                File uploadDirFile = new File(uploadDir);
                if (!uploadDirFile.exists()) {
                    uploadDirFile.mkdirs();
                }

                String filePath = uploadDir + File.separator + fileName;

                try (InputStream input = filePart.getInputStream()) {
                    Files.copy(input, Paths.get(filePath), StandardCopyOption.REPLACE_EXISTING);
                }

                String imagePath = "/uploads/" + fileName;
                loggedInUser.setImageLink(imagePath);
                UserDAO userDAO = new UserDAO();
                boolean updateSuccess = userDAO.updateProfileImage(loggedInUser.getId(), imagePath);

                if (updateSuccess) {
                    session.setAttribute("account", loggedInUser);
                    response.sendRedirect(request.getContextPath() + "/profile");
                } else {
                    response.sendRedirect(request.getContextPath() + "/profile");
                }
            } else {
                // Lấy thông tin từ form
                String fullName = request.getParameter("fullName");
                String mobile = request.getParameter("mobile");
                String gender = request.getParameter("gender");
                String address = request.getParameter("address");

                // Cập nhật thông tin user
                loggedInUser.setFullName(fullName);
                loggedInUser.setMobile(mobile);
                loggedInUser.setGender("Male".equalsIgnoreCase(gender));
                loggedInUser.setAddress(address);

                // Lưu thông tin vào database
                UserDAO userDAO = new UserDAO();
                boolean updateSuccess = userDAO.updateProfile(loggedInUser);

                if (updateSuccess) {
                    // Cập nhật session với thông tin mới
                    session.setAttribute("account", loggedInUser);
                    request.setAttribute("message", "Profile updated successfully!");
                } else {
                    request.setAttribute("error", "Failed to update profile. Please try again.");
                }

                request.setAttribute("user", loggedInUser);
                response.sendRedirect(request.getContextPath() + "/profile");
            }
        } else {
            response.sendRedirect("login.jsp");
        }
    }

    private String getFileName(Part part) {
        String contentDisp = part.getHeader("content-disposition");
        String[] tokens = contentDisp.split(";");
        for (String token : tokens) {
            if (token.trim().startsWith("filename")) {
                return token.substring(token.indexOf("=") + 2, token.length() - 1);
            }
        }
        return "";
    }

}
