package dal;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import model.Post;
import java.util.logging.Level;
import java.util.logging.Logger;

public class PostDAO extends DBContext {

    /**
     * Get a post by its ID.
     *
     * @param postId the ID of the post to retrieve
     * @return the post with the specified ID, or null if not found
     */
    public Post getPostById(int postId) {
        Post post = null;
        try (
                PreparedStatement statement = connection.prepareStatement(
                        "SELECT * FROM post WHERE id = ?")) {
            statement.setInt(1, postId);
            try (ResultSet resultSet = statement.executeQuery()) {
                if (resultSet.next()) {
                    post = getFromResultSet(resultSet);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return post;
    }

    /**
     * Get the author name for a given post.
     *
     * @param postId the ID of the post
     * @return the name of the author, or null if not found
     */
    public String getAuthorNameByPostId(int postId) {
        String authorName = null;
        String query = "SELECT u.full_name AS author_name FROM post p "
                + "JOIN user u ON p.author_id = u.id "
                + "WHERE p.id = ?";

        try (PreparedStatement stmt = connection.prepareStatement(query)) {
            stmt.setInt(1, postId);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    authorName = rs.getString("author_name");
                }
            }
        } catch (SQLException e) {
            Logger.getLogger(PostDAO.class.getName()).log(Level.SEVERE, "Error getting author name for post ID: " + postId, e);
        }

        return authorName;
    }

    /**
     * Get the category name for a given post.
     *
     * @param postId the ID of the post
     * @return the name of the category, or null if not found
     */
    public String getCategoryNameByPostId(int postId) {
        String categoryName = null;
        try (
                PreparedStatement statement = connection.prepareStatement(
                        "SELECT c.name AS categoryName "
                        + "FROM posts p "
                        + "JOIN categories c ON p.categoryId = c.id "
                        + "WHERE p.id = ?")) {
            statement.setInt(1, postId);
            try (ResultSet resultSet = statement.executeQuery()) {
                if (resultSet.next()) {
                    categoryName = resultSet.getString("categoryName");
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return categoryName;
    }

    /**
     * Get a list of distinct post categories.
     *
     * @return a list of distinct post categories
     */
    public List<String> getPostCategories() {
        List<String> categories = new ArrayList<>();
        try (
                PreparedStatement statement = connection.prepareStatement(
                        "SELECT DISTINCT name FROM categories")) {
            try (ResultSet resultSet = statement.executeQuery()) {
                while (resultSet.next()) {
                    categories.add(resultSet.getString("name"));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return categories;
    }

    /**
     * Search for posts by title or content.
     *
     * @param query the search query
     * @param pageSize the number of posts to display per page
     * @param pageNumber the current page number (starting from 1)
     * @return a list of matching posts
     */
    public List<Post> searchPosts(String query, int pageSize, int pageNumber) {
        List<Post> posts = new ArrayList<>();
        try (
                PreparedStatement statement = connection.prepareStatement(
                        "SELECT * FROM posts WHERE title LIKE ? OR content LIKE ? ORDER BY updatedDate DESC LIMIT ?, ?")) {
            statement.setString(1, "%" + query + "%");
            statement.setString(2, "%" + query + "%");
            statement.setInt(3, (pageNumber - 1) * pageSize);
            statement.setInt(4, pageSize);
            try (ResultSet resultSet = statement.executeQuery()) {
                while (resultSet.next()) {
                    Post post = new Post();
                    post.setId(resultSet.getInt("id"));
                    post.setTitle(resultSet.getString("title"));
                    post.setDescription(resultSet.getString("description"));
                    post.setThumbnailLink(resultSet.getString("thumbnailLink"));
                    post.setUpdatedDate(resultSet.getDate("updatedDate"));
                    posts.add(post);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return posts;
    }

    public List<Post> getAllPosts() {
        List<Post> postList = new ArrayList<>();
        String query = "SELECT * FROM post";

        try {
            if (connection != null) {
                PreparedStatement stm = connection.prepareStatement(query);
                ResultSet rs = stm.executeQuery();
                while (rs.next()) {
                    Post post = getFromResultSet(rs);
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
        String query = "SELECT * FROM post where status_id=25 ORDER BY updated_date DESC LIMIT 3";

        try {
            PreparedStatement stm = connection.prepareStatement(query);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                Post post = getFromResultSet(rs);
                posts.add(post);
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }

        return posts;
    }

    public Post getFromResultSet(ResultSet resultSet) throws SQLException {
        Post post = new Post();
        post.setId(resultSet.getInt("id"));
        post.setTitle(resultSet.getString("title"));
        post.setContent(resultSet.getString("content"));
        post.setDescription(resultSet.getString("description"));
        post.setUpdatedDate(resultSet.getDate("updated_date"));
        post.setFeatured(resultSet.getBoolean("featured"));
        post.setThumbnailLink(resultSet.getString("thumbnail_link"));
        post.setAuthorId(resultSet.getInt("author_id"));
        post.setCategoryId(resultSet.getInt("category_id"));
        post.setStatusId(resultSet.getInt("status_id"));
        return post;
    }

    public static void main(String[] args) {
        PostDAO postDAO = new PostDAO();
        postDAO.getNewest().stream().forEach(item -> {

            System.out.println(item.getThumbnailLink());
        });

    }
}
