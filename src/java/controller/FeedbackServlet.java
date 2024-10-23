package controller;

import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import dal.FeedbackDAO;
import jakarta.servlet.http.HttpSession;
import java.util.List;
import model.Feedback;
import model.User;
import dal.ServiceDAO;
import model.Reservation;
import dal.ReservationDAO;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.Iterator;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.ReservationService;

@WebServlet(name = "FeedbackServlet", urlPatterns = {"/customer-feedback"})
public class FeedbackServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            FeedbackDAO f = new FeedbackDAO();
            ReservationDAO r = new ReservationDAO();
            ServiceDAO s = new ServiceDAO();
            HttpSession session = request.getSession();
            User loggedInUser = (User) session.getAttribute("account");
            String action = request.getParameter("action");
            if ("provide".equals(action)) {
                if (request.getParameter("reservationId") != null) {
                    int resId = Integer.parseInt(request.getParameter("reservationId"));
                    Reservation reservation = r.getReservationById(resId);

                    if (reservation.getList_service() != null && !reservation.getList_service().isEmpty()) {
                        request.setAttribute("reservation", reservation);
                        request.getRequestDispatcher("customer-feedbackForm.jsp").forward(request, response);
                    } else {
                    }
                    return;
                }
            }

            List<Feedback> rated_feedback = f.getFeedbackByCustomerId(loggedInUser.getId());
            List<Reservation> unrated = r.getReservationbyCustomerId(loggedInUser.getId());
            Iterator<Reservation> iterator = unrated.iterator();
            while (iterator.hasNext()) {
                Reservation res = iterator.next();
                System.out.println("Checking reservation ID: " + res.getId());
                boolean check = false;
                Feedback feedback = f.getFeedbackByReservationId(res.getId());

                if (feedback != null) {
                    check = feedback.getStatus().equals("Processed");
                    Timestamp feedbackTimestamp = feedback.getFeedback_time();
                    long feedbackTime = feedbackTimestamp.getTime(); 
                    long currentTime = System.currentTimeMillis();
                    long thirtyDaysAgo = currentTime - (30L * 24 * 60 * 60 * 1000);
                    if (feedbackTime < thirtyDaysAgo) {
                        f.updateFeedback(feedback.getReservation_id(), feedback.getService_id(), 0, "No feedback", "Processed");
                    }

                    System.out.println("Feedback Status: " + feedback.getStatus());
                    if (check == true) {
                        iterator.remove();
                    }
                }

                if (!"Success".equals(res.getStatus())) {
                    if (feedback != null && check) {
                        System.out.println("Removing reservation ID: " + res.getId());
                        iterator.remove();
                    }
                }
                if (!f.isFeedback(res.getId())) {
                    System.out.println("Removing reservation ID due to lack of feedback: " + res.getId());
                    iterator.remove();
                }
            }
            request.setAttribute("rated", rated_feedback);
            request.setAttribute("unrated", unrated);
            request.setAttribute("service", s);
            request.getRequestDispatcher("customer-feedback.jsp").forward(request, response);
        } catch (SQLException ex) {
            Logger.getLogger(FeedbackServlet.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String submit = request.getParameter("submit");
        System.out.println("Submit: " + submit);
        System.out.println(request.getParameter("reservation_id"));
        System.out.println(request.getParameter("reservation_id") != null);
        ReservationDAO r = new ReservationDAO();
        FeedbackDAO f = new FeedbackDAO();
        if (submit != null && request.getParameter("reservation_id") != null) {
            int id = Integer.parseInt(request.getParameter("reservation_id"));
            Reservation reservation = r.getReservationById(id);
            if (reservation.getList_service() != null && !reservation.getList_service().isEmpty()) {
                for (ReservationService rs : reservation.getList_service()) {
                    String rate = "rating_" + rs.getService_id();
                    String content = "feedbackContent_" + rs.getService_id();
                    if (request.getParameter(rate) != null && request.getParameter(content) != null) {
                        int rate_star = Integer.parseInt(request.getParameter(rate));
                        String content_feedback = request.getParameter(content);
                        System.out.println(rate_star);
                        System.out.println(content_feedback);
                        try {
                            f.updateFeedback(id, rs.getService_id(), rate_star, content_feedback, "Processed");
                        } catch (SQLException ex) {
                            Logger.getLogger(FeedbackServlet.class.getName()).log(Level.SEVERE, null, ex);
                        }
                    }
                }
            } else {
                Logger.getLogger(FeedbackServlet.class.getName()).log(Level.WARNING, "error.");
            }
            response.sendRedirect(request.getContextPath() + "/customer-feedback");
        }
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }
}
