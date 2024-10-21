package dal;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import model.PostComment;

public class PostCommentDAO extends DBContext {

    public List<PostComment> findAll() {
        List<PostComment> comments = new ArrayList<>();
        String sql = "SELECT * FROM post_comment";

        try (Connection conn = new DBContext().connection; PreparedStatement ps = conn.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                PostComment comment = getFromResultSet(rs);
                comments.add(comment);
            }
        } catch (SQLException e) {
            System.out.println("Error in findAll(): " + e.getMessage());
        }

        return comments;
    }

    public List<PostComment> findByPostId(int postId) {
        List<PostComment> comments = new ArrayList<>();
        String sql = "SELECT * FROM post_comment WHERE post_id = ?";

        try (Connection conn = new DBContext().connection; PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, postId);

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    PostComment comment = getFromResultSet(rs);
                    comments.add(comment);
                }
            }
        } catch (SQLException e) {
            System.out.println("Error in findByPostId(): " + e.getMessage());
        }

        return comments;
    }

    public PostComment getFromResultSet(ResultSet rs) throws SQLException {
        PostComment comment = new PostComment(
                rs.getInt("id"),
                rs.getInt("post_id"),
                rs.getObject("parent_id", Integer.class),
                rs.getString("content"),
                rs.getInt("user_id"),
                rs.getDate("created_at")
        );
        return comment;
    }

    public static void main(String[] args) {
        PostCommentDAO dao = new PostCommentDAO();
        dao.findByPostId(46).stream().forEach(item -> {
            System.out.println(item);
        });
    }
}
