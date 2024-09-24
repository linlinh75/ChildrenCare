package dal;

import model.Slider;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class SliderDAO extends DBContext {

    public List<Slider> getAllSliders() {
        List<Slider> sliders = new ArrayList<>();
        String query = "SELECT * FROM slider WHERE status = 1"; 

        try {
            PreparedStatement stm = connection.prepareStatement(query);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                Slider slider = new Slider(
                        rs.getInt("id"),
                        rs.getString("title"),
                        rs.getString("image_link"),
                        rs.getString("backlink"),
                        rs.getBoolean("status"),
                        rs.getString("notes")
                );
                sliders.add(slider);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return sliders;
    }
}
