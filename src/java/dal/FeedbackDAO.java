package dal;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import model.Feedback;

public class FeedbackDAO extends DBContext {

    //get list feedback by service id
    public List<Feedback> getFeedbackByServiceId(int serviceId) {
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

    public Feedback getFromResultSet(ResultSet rs) {
        Feedback feedback = new Feedback();
        try {
            feedback.setId(rs.getInt("id"));
            feedback.setUser_id(rs.getInt("user_id"));
            feedback.setRated_star(rs.getInt("rated_star"));
            feedback.setContent(rs.getString("content"));
            feedback.setService_id(rs.getInt("service_id"));
            feedback.setImage_link(rs.getString("image_link"));
            feedback.setStatus(rs.getString("status"));
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return feedback;
    }

}
