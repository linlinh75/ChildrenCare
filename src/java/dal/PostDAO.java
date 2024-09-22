package dal;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.Post;

public class PostDAO extends DBContext {

    public List<Post> getAllPosts() {
        List<Post> postList = new ArrayList<>();
        String query = "SELECT * FROM post";

        try {
            if (connection != null) {
                PreparedStatement stm = connection.prepareStatement(query);
                ResultSet rs = stm.executeQuery();
                while (rs.next()) {
                    Post post = new Post(
                            rs.getInt("id"),
                            rs.getString("content"),
                            rs.getString("description"),
                            rs.getDate("updated_date"),
                            rs.getBoolean("featured"),
                            rs.getString("thumbnail_link"),
                            rs.getInt("author_id"),
                            rs.getInt("category_id"),
                            rs.getInt("status_id"),
                            rs.getString("title")
                    );
                    postList.add(post);
                }
            } else {
                System.out.println("Connection is null, cannot execute query.");
            }
        } catch (SQLException ex) {
            Logger.getLogger(PostDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return postList;

    }

    public List<Post> getNewest() {
        List<Post> posts = new ArrayList<>();
        String query = "SELECT * FROM post ORDER BY updated_date DESC LIMIT 3"; // Thay đổi 'post' theo tên bảng thực tế của bạn

        try {
            PreparedStatement stm = connection.prepareStatement(query);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                Post post = new Post(
                        rs.getInt("id"),
                        rs.getString("content"),
                        rs.getString("description"),
                        rs.getDate("updated_date"),
                        rs.getBoolean("featured"),
                        rs.getString("thumbnail_link"),
                        rs.getInt("author_id"),
                        rs.getInt("category_id"),
                        rs.getInt("status_id"),
                        rs.getString("title")
                );
                posts.add(post);
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }

        return posts;
    }

    public static void main(String[] args) {
        PostDAO postDAO = new PostDAO();
        List<Post> posts = postDAO.getAllPosts();
        for (Post post : posts) {
            System.out.println(post.getId());
        }
        System.out.println("Total posts: " + posts.size());

    }
}
