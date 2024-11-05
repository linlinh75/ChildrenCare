/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dal.FeedbackDAO;
import dal.ReservationDAO;
import dal.ServiceDAO;
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
import java.sql.Timestamp;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.Feedback;
import model.Reservation;
import model.User;

/**
 *
 * @author admin
 */
@WebServlet(name = "ManagerFeedbackServlet", urlPatterns = {"/managerFeedbackList"})
public class ManageFeedbackServlet extends HttpServlet {

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
            FeedbackDAO feedbackDAO = new FeedbackDAO();
            ReservationDAO reservationDAO = new ReservationDAO();
            ServiceDAO serviceDAO = new ServiceDAO();
            UserDAO u = new UserDAO();
            List<User> users = u.getAllUser();
            HttpSession session = request.getSession();
            User loggedInUser = (User) session.getAttribute("account");

            updateOldFeedbacks(feedbackDAO, loggedInUser.getId());

            String action = request.getParameter("action");
            if ("detail".equals(action)) {
                String id = request.getParameter("id");
                if (id != null && id != "") {
                    int fid = Integer.parseInt(id);
                    Feedback f = feedbackDAO.getFeedbackById(fid);
                    User user = u.getProfileById(f.getUser_id());
                    request.setAttribute("feedback", f);
                    request.setAttribute("service", serviceDAO);
                    request.setAttribute("user", user);
                    request.getRequestDispatcher("manager-feedbackdetail.jsp").forward(request, response);
                }

            } else {
                if ("change".equals(action)) {
                    String id = request.getParameter("id");
                    if (id != null && id != "") {
                        int fid = Integer.parseInt(id);
                        Feedback f = feedbackDAO.getFeedbackById(fid);
                        boolean newstatus= true;
                        if (f.isIsPublic()){
                            newstatus=false;
                        }
                        feedbackDAO.updateDisplayStatus(fid, newstatus);
                        response.sendRedirect("managerFeedbackList");
                    return;
                    }
                }
                List<Feedback> feedback = feedbackDAO.getAllFeedback();

                request.setAttribute("feedback", feedback);
                request.setAttribute("service", serviceDAO);
                request.setAttribute("user", u);
                request.getRequestDispatcher("manager-feedbacklist.jsp").forward(request, response);
            }
        } catch (SQLException ex) {
            Logger.getLogger(ManageFeedbackServlet.class.getName()).log(Level.SEVERE, null, ex);
        }

    }

    private void updateOldFeedbacks(FeedbackDAO feedbackDAO, int customerId) throws SQLException {
        List<Feedback> feedbacks = feedbackDAO.getAllFeedback();
        long thirtyDaysAgo = System.currentTimeMillis() - (30L * 24 * 60 * 60 * 1000);

        for (Feedback feedback : feedbacks) {
            Timestamp feedbackTimestamp = feedback.getFeedback_time();
            if (feedbackTimestamp.getTime() < thirtyDaysAgo && !"Processed".equals(feedback.getStatus())) {
                feedbackDAO.updateFeedback(feedback.getReservation_id(), feedback.getService_id(), 0, "No feedback", "Processed");
            }
            if (feedback.getRated_star()==0&&feedback.isIsPublic()){
                feedbackDAO.updateDisplayStatus(feedback.getId(), false);
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
