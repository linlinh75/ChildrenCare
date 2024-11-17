/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dal.UserDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.User;
import util.EncodePassword;
import util.VerifyPassword;

/**
 *
 * @author Admin
 */
public class ChangePasswordServlet extends HttpServlet {

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
        try {
            response.setContentType("text/html;charset=UTF-8");
            String oldPass = request.getParameter("Old password");
            oldPass = EncodePassword.encodeToSHA1(oldPass);
            String newPass = request.getParameter("New password");
            String checkPass = request.getParameter("confPassword");
            HttpSession session = request.getSession(false);
            String email = (String) session.getAttribute("email");
            UserDAO udao = new UserDAO();
            VerifyPassword ver = new VerifyPassword();
            if (oldPass != null && newPass != null && checkPass != null && oldPass.equals(udao.getUserByEmail(email).getPassword())) {
                if (EncodePassword.encodeToSHA1(newPass).equals(oldPass)) {
                    String erChange = "New Password has to different from Old Password ";
                    request.setAttribute("erChange", erChange);
                    request.getRequestDispatcher("changePw.jsp").forward(request, response);
                }
                if (newPass.equals(checkPass)) {
                    if (ver.verify(newPass)) {
                        newPass = EncodePassword.encodeToSHA1(newPass);
                        udao.changePassword(email, newPass);
                        String successChange = "Password Changed!";
                        session.setAttribute("account", udao.getUserByEmail(email));
                        request.setAttribute("user", udao.getUserByEmail(email));
                        request.setAttribute("successChange", successChange);
                        request.getRequestDispatcher("user/profile.jsp").forward(request, response);
                    } else {
                        String erChange = "Password must be between 8-24 characters, include at least one uppercase letter and one number";
                        request.setAttribute("erChange", erChange);
                        request.getRequestDispatcher("changePw.jsp").forward(request, response);
                    }
                } else {
                    String erChange = "Wrong Confirm Password";
                    request.setAttribute("erChange", erChange);
                    request.getRequestDispatcher("changePw.jsp").forward(request, response);
                }

            } else {
                String erChange = "Wrong Old Password!";
                request.setAttribute("erChange", erChange);
                request.getRequestDispatcher("changePw.jsp").forward(request, response);
            }

        } catch (SQLException ex) {
            Logger.getLogger(ChangePasswordServlet.class.getName()).log(Level.SEVERE, null, ex);
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
        processRequest(request, response);
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
