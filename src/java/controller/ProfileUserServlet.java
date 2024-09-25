/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package controller;

import dal.UserDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;
import model.User;

public class ProfileUserServlet extends HttpServlet {
   
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        
        HttpSession session = request.getSession();
        User loggedInUser = (User) session.getAttribute("account");
        
        if (loggedInUser != null) {
            request.setAttribute("user", loggedInUser);
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
            request.getRequestDispatcher("user/profile.jsp").forward(request, response);
        } else {
            response.sendRedirect("login.jsp");
        }
    }

   
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet ProfileUserServlet</title>");  
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ProfileUserServlet at " + request.getContextPath () + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    } 

}
