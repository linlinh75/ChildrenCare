package dal;

import java.lang.System.Logger;
import java.lang.System.Logger.Level;
import model.Slider;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class SliderDAO extends DBContext {

    PreparedStatement stm;
    ResultSet rs;

    public List<Slider> getAllSliders() {
        List<Slider> sliders = new ArrayList<>();
        String query = "SELECT * FROM slider WHERE status = 1";

        try {
            stm = connection.prepareStatement(query);
            rs = stm.executeQuery();
            while (rs.next()) {
                Slider slider = new Slider(
                        rs.getInt("id"),
                        rs.getString("title"),
                        rs.getString("image_link"),
                        rs.getString("backlink"),
                        rs.getString("status"),
                        rs.getString("notes"),
                        rs.getDate("update_date"),
                        rs.getInt("author_id")
                );
                sliders.add(slider);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return sliders;
    }

    public List<Slider> getManageSliders() {
        List<Slider> sliders = new ArrayList<>();
        String query = "SELECT * FROM slider where status!='Deleted'";

        try {
            stm = connection.prepareStatement(query);
            rs = stm.executeQuery();
            while (rs.next()) {
                Slider slider = new Slider(
                        rs.getInt("id"),
                        rs.getString("title"),
                        rs.getString("image_link"),
                        rs.getString("backlink"),
                        rs.getString("status"),
                        rs.getString("notes"),
                        rs.getDate("update_date"),
                        rs.getInt("author_id")
                );
                sliders.add(slider);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return sliders;
    }

    public void updateStatus(int id, String status) {
        String s = "UPDATE swp.slider set status = ? where id = ?";
        try {
            PreparedStatement stmt = connection.prepareStatement(s);
            stmt.setString(1, status);
            stmt.setInt(2, id);
            int rowsUpdated = stmt.executeUpdate();
            if (rowsUpdated > 0) {
                System.out.println("Succesfull update ID: " + id);
            } else {
                System.out.println("Cannot found ID: " + id);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void deleteSlider(int id) {
        String sql = "Update swp.slider set status ='Deleted' WHERE id = ?";
        try {
            PreparedStatement stmt = connection.prepareStatement(sql);
            stmt.setInt(1, id);

            int rowsDeleted = stmt.executeUpdate();
            if (rowsDeleted > 0) {
                System.out.println("Successfully deleted slider with ID: " + id);
            } else {
                System.out.println("Slider with ID: " + id + " not found.");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void updateSlider(int id, String title, String imagePath, String backlink, String status, String notes) {
        String sql = "UPDATE swp.slider SET title = ?, image_link = ?, backlink = ?, status = ?, notes = ?, update_date = CURRENT_DATE WHERE id = ?";
        try {
            PreparedStatement stmt = connection.prepareStatement(sql);
            stmt.setString(1, title);
            stmt.setString(2, imagePath);
            stmt.setString(3, backlink);
            stmt.setString(4, status);
            stmt.setString(5, notes);
            stmt.setInt(6, id);
            
            int rowsUpdated = stmt.executeUpdate();
            if (rowsUpdated > 0) {
                
                System.out.println("Successful update ID: " + id);
            } else {
                System.out.println("Cannot find ID: " + id);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public Slider getSliderbyId(int id) {
        String sql = "SELECT * FROM swp.slider WHERE id = ?";
        try (
                PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setInt(1, id);
            try (ResultSet resultSet = statement.executeQuery()) {
                if (resultSet.next()) {
                    Slider slider = new Slider(
                            resultSet.getInt("id"),
                            resultSet.getString("title"),
                            resultSet.getString("image_link"),
                            resultSet.getString("backlink"),
                            resultSet.getString("status"),
                            resultSet.getString("notes"),
                            resultSet.getDate("update_date"),
                            resultSet.getInt("author_id")
                    );
                    return slider;
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public void addSlider(String title, String imagePath, String backlink, String status, String notes, int id) {
        String sql = "INSERT INTO swp.slider (title, image_link, backlink, status, notes,author_id,update_date) VALUES (?, ?, ?, ?, ?,?, CURRENT_DATE)";

        try {
            PreparedStatement stmt = connection.prepareStatement(sql);
            stmt.setString(1, title);
            stmt.setString(2, imagePath);
            stmt.setString(3, backlink);
            stmt.setString(4, status);
            stmt.setString(5, notes);
            stmt.setInt(6, id);
            int rowsInserted = stmt.executeUpdate();
            if (rowsInserted > 0) {
                System.out.println("Slider added successfully!");
            } else {
                System.out.println("Failed to add the slider.");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public static void main(String[] args) {
        SliderDAO s = new SliderDAO();
        List<Slider> list = s.getAllSliders();
        for (Slider sl : list) {
            System.out.println(sl.getTitle());
        }
        //s.updateStatus(1, "0");
        System.out.println(s.getSliderbyId(1).getTitle());
        System.out.println("A Response Plan to counter Covid-19".toLowerCase().contains("a r"));
    }

}
