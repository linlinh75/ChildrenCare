
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
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.List;
import model.GoogleAccount;
import model.Post;
import model.Service;
import model.Setting;
import model.Slider;
import model.User;

/**
 *
 * @author Admin
 */
public class LoginServlet extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String code = request.getParameter("code");
        String accessToken = GoogleLogin.getToken(code);
        GoogleAccount acc = GoogleLogin.getUserInfo(accessToken);
        System.out.println(acc);
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        UserDAO userdao = new UserDAO();
        List<User> ulist = userdao.getAllUser();
        if (request.getParameter("submit") != null) {
            String email = request.getParameter("email");
            String password = request.getParameter("password");
            System.out.println(email);
            System.out.println(password);
            User loggedInUser = null;
            for (User u : ulist) {
                if (email.equals(u.getEmail()) && password.equals(u.getPassword())) {
                    loggedInUser = u;
                    break;
                }
            }
            if (loggedInUser == null) {
                request.setAttribute("ms", "Invalid email or password");
                request.getRequestDispatcher("login.jsp").forward(request, response);
            } else {
                // Lưu thông tin người dùng vào session
                session.setAttribute("account", loggedInUser);
                session.setAttribute("email", email);
                request.setAttribute("ms", "Login successfully!");
                response.sendRedirect("/ChildrenCare/HomeServlet");
            }
        }
    }
}
