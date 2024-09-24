/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dal.UserDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.sql.SQLException;
import java.time.LocalDateTime;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.User;

/**
 *
 * @author admin
 */
@WebServlet(name = "ActivateServlet", urlPatterns = {"/activate"})
public class ActivateServlet extends HttpServlet {

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
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            HttpSession session = request.getSession();
            String enteredCode = request.getParameter("verificationCode");
            String verificationCode = (String) session.getAttribute("verificationCode");
            LocalDateTime expireAt = (LocalDateTime) session.getAttribute("expireAt");
            LocalDateTime now = LocalDateTime.now();

            UserDAO userdao = new UserDAO();
            if (verificationCode != null && verificationCode.equals(enteredCode) && now.isBefore(expireAt)) {

                String fullname = (String) session.getAttribute("fullname");
                String address = (String) session.getAttribute("address");
                Boolean gender = (Boolean) session.getAttribute("gender");
                String mobile = (String) session.getAttribute("mobile");
                String email = (String) session.getAttribute("email");
                String password = (String) session.getAttribute("password");

                User newUser = new User();
                newUser.setEmail(email);
                newUser.setPassword(password);
                newUser.setFullName(fullname);
                newUser.setGender(gender);
                newUser.setMobile(mobile);
                newUser.setAddress(address);
                newUser.setImageLink("default.jpg");
                newUser.setRoleId(4);
                newUser.setStatus(17);
                try {
                    userdao.addUser(newUser);
                } catch (SQLException ex) {
                    Logger.getLogger(ActivateServlet.class.getName()).log(Level.SEVERE, null, ex);
                }
                session.invalidate();
                session.setAttribute("alert", "Veriry successfull, now you can login to the web!");
                response.sendRedirect("login.jsp");
            } else {
                session.setAttribute("error", "Error!");
                response.sendRedirect("register.jsp");
            }
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

    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
