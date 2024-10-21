
/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dal.PostDAO;

import dal.UserDAO;
import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.sql.SQLException;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.GoogleAccount;
import model.User;
import util.EncodePassword;
import util.VerifyPassword;

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
        try {
            UserDAO userdao = new UserDAO();
            HttpSession session = request.getSession(false);
            String code = request.getParameter("code");
            VerifyPassword ver = new VerifyPassword();
            if (code != null) {
                String accessToken = GoogleLogin.getToken(code);
                GoogleAccount acc = GoogleLogin.getUserInfo(accessToken);
                session.setAttribute("ggAcc", acc);
            }
            GoogleAccount ggAcc = (GoogleAccount) session.getAttribute("ggAcc");
            if (userdao.getUserByEmail(ggAcc.getEmail()) == null) {
                if (request.getParameter("ggpass") == null) {
                    request.getRequestDispatcher("ggPw.jsp").forward(request, response);
                } else {
                    System.out.println(ggAcc.toString());
                    String password = request.getParameter("ggpass");
                    String confPassword = request.getParameter("confPassword");
                    if(!ver.verify(password)){
                        String erChange = "Password must be between 8-24 characters, include at least one uppercase letter and one number";
                        request.setAttribute("erChange", erChange);
                        request.getRequestDispatcher("ggPw.jsp").forward(request, response);
                    }else{
                    if (!password.equals(confPassword)) {
                        String erChange = "Wrong Confirm Password";
                        request.setAttribute("erChange", erChange);
                        request.getRequestDispatcher("ggPw.jsp").forward(request, response);
                    } else {
                        password = EncodePassword.encodeToSHA1(password);
                        User newUser = new User();
                        newUser.setEmail(ggAcc.getEmail());
                        newUser.setPassword(password);
                        newUser.setFullName(ggAcc.getName());
                        newUser.setImageLink(ggAcc.getPicture());
                        newUser.setRoleId(4);
                        newUser.setStatus("Active");
                        
                        userdao.addUser(newUser);
                        session.setAttribute("account", newUser);
                        session.setAttribute("email", ggAcc.getEmail());
                        response.sendRedirect("/ChildrenCare/HomeServlet");
                    }

                }

            }} else {
                session.setAttribute("email", ggAcc.getEmail());
                session.setAttribute("account", userdao.getUserByEmail(ggAcc.getEmail()));
                response.sendRedirect("/ChildrenCare/HomeServlet");
            }
        } catch (SQLException ex) {
            Logger.getLogger(LoginServlet.class.getName()).log(Level.SEVERE, null, ex);
        }

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

            password = EncodePassword.encodeToSHA1(password);
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
