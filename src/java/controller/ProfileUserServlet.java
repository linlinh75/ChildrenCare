/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dal.PostDAO;
import dal.ServiceDAO;
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
import model.Slider;
import model.User;

@MultipartConfig(fileSizeThreshold = 1024 * 1024, // 1 MB
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
        request.setAttribute("userDAO", new UserDAO());
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
        request.setAttribute("userDAO", new UserDAO());
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
                request.setAttribute("role", new UserDAO().getRoleString(loggedInUser.getRoleId()));
                // Kiểm tra các trường không được bỏ trống
                if (fullName == null || fullName.trim().isEmpty()
                        || mobile == null || mobile.trim().isEmpty()
                        || gender == null || gender.trim().isEmpty()
                        || address == null || address.trim().isEmpty()) {

                    request.setAttribute("error", "All fields are required.");
                    request.setAttribute("user", loggedInUser);
                    request.getRequestDispatcher("user/profile.jsp").forward(request, response);
                    return;
                }

                if (!mobile.trim().matches("[0][0-9]{9}")) {
                    request.setAttribute("error", "Number must be 10 digit and start with 0");
                    request.setAttribute("user", loggedInUser);
                    request.getRequestDispatcher("user/profile.jsp").forward(request, response);
                    return;
                }

                // Kiểm tra số điện thoại có tồn tại trong DB
                UserDAO userDAO = new UserDAO();
                try {
                    User user = userDAO.getUserByPhoneNumber(mobile);
                    if (user != null && !mobile.equals(loggedInUser.getMobile())) {
                        request.setAttribute("user", loggedInUser);
                        request.setAttribute("error", "Mobile number already exists.");
                        request.getRequestDispatcher("user/profile.jsp").forward(request, response);
                        return;
                    }
                } catch (Exception e) {
                    e.printStackTrace();
                }

                // Cập nhật thông tin user
                loggedInUser.setFullName(fullName);
                loggedInUser.setMobile(mobile);
                loggedInUser.setGender("Male".equalsIgnoreCase(gender));
                loggedInUser.setAddress(address);
                boolean updateSuccess = userDAO.updateProfile(loggedInUser);

                if (updateSuccess) {
                    request.setAttribute("user", loggedInUser);
                    session.setAttribute("account", loggedInUser);
                    request.setAttribute("message", "Profile updated successfully!");
                } else {
                    request.setAttribute("user", loggedInUser);
                    session.setAttribute("account", loggedInUser);
                    request.setAttribute("error", "Failed to update profile. Please try again.");
                }

                request.getRequestDispatcher("user/profile.jsp").forward(request, response);
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
