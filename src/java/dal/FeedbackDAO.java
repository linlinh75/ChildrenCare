package dal;

import java.lang.System.Logger;
import java.lang.System.Logger.Level;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import model.Feedback;

public class FeedbackDAO extends DBContext {

    public List<Feedback> getFeedbackByServiceId(int serviceId) {
        List<Feedback> listFeedbacks = new ArrayList<>();

        String sql = "SELECT * FROM feedback WHERE service_id = ? and isPublic=1";
        try {
            if (connection != null) {
                PreparedStatement statement = connection.prepareStatement(sql);
                statement.setObject(1, serviceId);
                ResultSet rs = statement.executeQuery();
                if (rs.next()) {
                    Feedback feedback = getFromResultSet(rs);
                    listFeedbacks.add(feedback);
                }
            } else {
                System.out.println("Connection is null, cannot execute query.");
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return listFeedbacks;
    }
    public List<Feedback> getAllFeedbackByServiceId(int serviceId) {
        List<Feedback> listFeedbacks = new ArrayList<>();

        String sql = "SELECT * FROM feedback WHERE service_id = ?";
        try {
            if (connection != null) {
                PreparedStatement statement = connection.prepareStatement(sql);
                statement.setObject(1, serviceId);
                ResultSet rs = statement.executeQuery();
                if (rs.next()) {
                    Feedback feedback = getFromResultSet(rs);
                    listFeedbacks.add(feedback);
                }
            } else {
                System.out.println("Connection is null, cannot execute query.");
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return listFeedbacks;
    }

    public List<Feedback> getAllFeedback() {
        List<Feedback> ulist = new ArrayList<>();
        String s = "SELECT * FROM feedback";

        try {
            if (connection != null) {
                PreparedStatement stm = connection.prepareStatement(s);
                ResultSet rs = stm.executeQuery();
                while (rs.next()) {
                    Feedback feedback = getFromResultSet(rs);
                    ulist.add(feedback);
                }
            } else {
                System.out.println("Connection is null, cannot execute query.");
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return ulist;
    }

    public Feedback getFromResultSet(ResultSet rs) throws SQLException {
        Feedback feedback = new Feedback(
                rs.getInt("id"),
                rs.getInt("user_id"),
                rs.getInt("reservation_id"),
                rs.getInt("service_id"),
                rs.getInt("rated_star"),
                rs.getString("content"),
                rs.getString("image_link"),
                rs.getString("status"),
                rs.getTimestamp("feedback_time"),
                rs.getBoolean("isPublic")
        );
        return feedback;
    }

    public boolean isFeedback(int reservation_id) {
        FeedbackDAO f = new FeedbackDAO();
        List<Feedback> list = f.getAllFeedback();
        for (Feedback fb : list) {
            if (fb.getReservation_id() == reservation_id) {
                return true;
            }
        }
        return false;
    }

    public List<Feedback> getFeedbackByCustomerId(int customer_id) {
        String s = "SELECT * FROM swp.feedback WHERE user_id = ?";
        List<Feedback> feedbackList = new ArrayList<>();
        try {
            PreparedStatement stmt = connection.prepareStatement(s);
            stmt.setInt(1, customer_id);
            try (ResultSet resultSet = stmt.executeQuery()) {
                while (resultSet.next()) {
                    Feedback feedback = getFromResultSet(resultSet);
                    feedbackList.add(feedback);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return feedbackList;
    }

    public Feedback getFeedbackByReservationId(int id) {
        String s = "SELECT * FROM swp.feedback WHERE reservation_id = ?";
        Feedback feedback = new Feedback();
        try {
            PreparedStatement stmt = connection.prepareStatement(s);
            stmt.setInt(1, id);
            try (ResultSet resultSet = stmt.executeQuery()) {
                while (resultSet.next()) {
                    feedback = getFromResultSet(resultSet);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return feedback;
    }

    public Feedback getFeedbackById(int id) {
        String s = "SELECT * FROM swp.feedback WHERE id = ?";
        Feedback feedback = null;
        try {
            PreparedStatement stmt = connection.prepareStatement(s);
            stmt.setInt(1, id);
            try (ResultSet resultSet = stmt.executeQuery()) {
                while (resultSet.next()) {
                    feedback = getFromResultSet(resultSet);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return feedback;
    }

    public void updateFeedback(int reservationId, int serviceId, int ratedStar, String content, String status) throws SQLException {
        String sql = "UPDATE feedback SET rated_star = ?, content = ?, status = ?, feedback_time = NOW(),isPublic=1 WHERE reservation_id = ? AND service_id = ?";

        try (
                PreparedStatement preparedStatement = connection.prepareStatement(sql)) {
            preparedStatement.setInt(1, ratedStar);
            preparedStatement.setString(2, content);
            preparedStatement.setString(3, status);
            preparedStatement.setInt(4, reservationId);
            preparedStatement.setInt(5, serviceId);

            int rowsUpdated = preparedStatement.executeUpdate();

            if (rowsUpdated > 0) {
                System.out.println("Update successful!");
            } else {
                System.out.println("No matching record found to update.");
            }
        } catch (SQLException e) {
            System.err.println("Error updating feedback: " + e.getMessage());
        }
    }

    public void updateDisplayStatus(int Id, boolean newstatus) throws SQLException {
        String sql = "UPDATE feedback SET isPublic= ? WHERE id = ?";

        try (
                PreparedStatement preparedStatement = connection.prepareStatement(sql)) {
            preparedStatement.setBoolean(1, newstatus);
            preparedStatement.setInt(2, Id);
            int rowsUpdated = preparedStatement.executeUpdate();

            if (rowsUpdated > 0) {
                System.out.println("Update successful!");
            } else {
                System.out.println("No matching record found to update.");
            }
        } catch (SQLException e) {
            System.err.println("Error updating feedback: " + e.getMessage());
        }
    }

    public static void main(String[] args) {
        FeedbackDAO f = new FeedbackDAO();
        System.out.println(f.getAllFeedback().get(0).getContent());
        try {
            f.updateDisplayStatus(1, false);
        } catch (SQLException ex) {
            java.util.logging.Logger.getLogger(FeedbackDAO.class.getName()).log(java.util.logging.Level.SEVERE, null, ex);
        }
    }
}
