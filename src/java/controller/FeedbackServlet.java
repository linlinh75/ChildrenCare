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
            FeedbackDAO feedbackDAO = new FeedbackDAO();
            ReservationDAO reservationDAO = new ReservationDAO();
            ServiceDAO serviceDAO = new ServiceDAO();
            HttpSession session = request.getSession();
            User loggedInUser = (User) session.getAttribute("account");

            updateOldFeedbacks(feedbackDAO, loggedInUser.getId());

            String action = request.getParameter("action");
            if ("provide".equals(action) && request.getParameter("reservationId") != null) {
                int resId = Integer.parseInt(request.getParameter("reservationId"));
                Reservation reservation = reservationDAO.getReservationById(resId);

                if (reservation.getList_service() != null && !reservation.getList_service().isEmpty()) {
                    request.setAttribute("reservation", reservation);
                    request.getRequestDispatcher("customer-feedbackForm.jsp").forward(request, response);
                }
                return;
            }

            List<Feedback> ratedFeedback = feedbackDAO.getFeedbackByCustomerId(loggedInUser.getId());
            List<Reservation> unratedReservations = filterUnratedReservations(feedbackDAO, reservationDAO, loggedInUser.getId());

            request.setAttribute("rated", ratedFeedback);
            request.setAttribute("unrated", unratedReservations);
            request.setAttribute("service", serviceDAO);
            request.getRequestDispatcher("customer-feedback.jsp").forward(request, response);
        } catch (SQLException ex) {
            Logger.getLogger(FeedbackServlet.class.getName()).log(Level.SEVERE, null, ex);
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

    private List<Reservation> filterUnratedReservations(FeedbackDAO feedbackDAO, ReservationDAO reservationDAO, int customerId) throws SQLException {
        List<Reservation> unratedReservations = reservationDAO.getReservationbyCustomerId(customerId);
        Iterator<Reservation> iterator = unratedReservations.iterator();

        while (iterator.hasNext()) {
            Reservation res = iterator.next();
            Feedback feedback = feedbackDAO.getFeedbackByReservationId(res.getId());

            if (feedback != null && "Processed".equals(feedback.getStatus()) || !"Completed".equals(res.getStatus()) || !feedbackDAO.isFeedback(res.getId())) {
                iterator.remove();
            }
        }
        return unratedReservations;
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
        ReservationDAO reservationDAO = new ReservationDAO();
        FeedbackDAO feedbackDAO = new FeedbackDAO();

        if (submit != null && request.getParameter("reservation_id") != null) {
            int id = Integer.parseInt(request.getParameter("reservation_id"));
            Reservation reservation = reservationDAO.getReservationById(id);

            if (reservation.getList_service() != null && !reservation.getList_service().isEmpty()) {
                for (ReservationService rs : reservation.getList_service()) {
                    String rateParam = "rating_" + rs.getService_id();
                    String contentParam = "feedbackContent_" + rs.getService_id();

                    if (request.getParameter(rateParam) != null && request.getParameter(contentParam) != null) {
                        try {
                            int rate = Integer.parseInt(request.getParameter(rateParam));
                            String content = request.getParameter(contentParam);
                            feedbackDAO.updateFeedback(id, rs.getService_id(), rate, content, "Processed");
                        } catch (SQLException ex) {
                            Logger.getLogger(FeedbackServlet.class.getName()).log(Level.SEVERE, null, ex);
                        }
                    }
                }
            }
            response.sendRedirect(request.getContextPath() + "/customer-feedback");
        }
    }

    @Override
    public String getServletInfo() {
        return "FeedbackServlet for managing customer feedback.";
    }
}
