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
     * @param query      the search query
     * @param pageSize   the number of posts to display per page
     * @param pageNumber the current page number (starting from 1)
     * @return a list of matching posts
     */
    public List<Post> searchPosts(String query, int pageSize, int pageNumber) {
        List<Post> posts = new ArrayList<>();
        try (
                PreparedStatement statement = connection.prepareStatement(
                        "SELECT * FROM post WHERE (title LIKE ? OR content LIKE ?) AND status = 'Published'  ORDER BY updated_date DESC LIMIT ?, ?")) {
            statement.setString(1, "%" + query + "%");
            statement.setString(2, "%" + query + "%");
            statement.setInt(3, (pageNumber - 1) * pageSize);
            statement.setInt(4, pageSize);
            try (ResultSet resultSet = statement.executeQuery()) {
                while (resultSet.next()) {
                    Post post = getFromResultSet(resultSet);
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
        String query = "SELECT * FROM post WHERE status = 'Published' ORDER BY updated_date DESC LIMIT 3";

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

    public int countSearchResults(String query) {
        int count = 0;
        String sql = "SELECT COUNT(*) FROM post WHERE title LIKE ? OR content LIKE ?";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setString(1, "%" + query + "%");
            stmt.setString(2, "%" + query + "%");
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    count = rs.getInt(1);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return count;
    }

    public List<Post> getPostsWithPagination(int page, int postsPerPage) {
        List<Post> posts = new ArrayList<>();
        String query = "SELECT * FROM post WHERE status = 'Published' ORDER BY updated_date DESC LIMIT ? OFFSET ?";
        ;

        try (PreparedStatement stmt = connection.prepareStatement(query)) {
            stmt.setInt(1, postsPerPage);
            stmt.setInt(2, (page - 1) * postsPerPage);

            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    Post post = getFromResultSet(rs);
                    posts.add(post);
                }
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return posts;
    }

    public int getTotalPosts() {
        int count = 0;
        String query = "SELECT COUNT(*) FROM post WHERE status = 'Published' ";

        try (PreparedStatement stmt = connection.prepareStatement(query); ResultSet rs = stmt.executeQuery()) {
            if (rs.next()) {
                count = rs.getInt(1);
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return count;
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
        post.setStatusId(resultSet.getString("status"));
        return post;
    }

    public boolean addPost(Post post) {
        String query = "INSERT INTO post (title, content, description, updated_date, featured, thumbnail_link, author_id, category_id, status) "
                + "VALUES (?, ?, ?, NOW(), ?, ?, ?, ?, ?)";

        try (PreparedStatement stmt = connection.prepareStatement(query)) {
            stmt.setString(1, post.getTitle());
            stmt.setString(2, post.getContent());
            stmt.setString(3, post.getDescription());
            stmt.setBoolean(4, post.isFeatured());
            stmt.setString(5, post.getThumbnailLink());
            stmt.setInt(6, post.getAuthorId());
            stmt.setInt(7, post.getCategoryId());
            stmt.setString(8, post.getStatusId());

            int rowsAffected = stmt.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException ex) {
            Logger.getLogger(PostDAO.class.getName()).log(Level.SEVERE, "Error adding new post", ex);
            return false;
        }
    }

    public boolean updatePost(Post post, String newImagePath) {
        String query = "UPDATE post SET title=?, content=?, description=?, updated_date=NOW(), "
                + (newImagePath != null ? "thumbnail_link=?, " : "")
                + "category_id=?, status=? WHERE id=?";

        try (PreparedStatement stmt = connection.prepareStatement(query)) {
            int paramIndex = 1;
            stmt.setString(paramIndex++, post.getTitle());
            stmt.setString(paramIndex++, post.getContent());
            stmt.setString(paramIndex++, post.getDescription());
            if (newImagePath != null) {
                stmt.setString(paramIndex++, newImagePath);
            }
            stmt.setInt(paramIndex++, post.getCategoryId());
            stmt.setString(paramIndex++, post.getStatusId());
            stmt.setInt(paramIndex++, post.getId());

            int rowsAffected = stmt.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException ex) {
            Logger.getLogger(PostDAO.class.getName()).log(Level.SEVERE, "Error updating post", ex);
            return false;
        }
    }

    public boolean hidePost(int postId) {
        String query = "UPDATE post SET status = 'Hidden' WHERE id = ?";

        try (PreparedStatement stmt = connection.prepareStatement(query)) {
            stmt.setInt(1, postId);
            int rowsAffected = stmt.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException ex) {
            Logger.getLogger(PostDAO.class.getName()).log(Level.SEVERE, "Error hiding post with ID: " + postId, ex);
            return false;
        }
    }

    public List<Post> getPostsWithPaginationAndStatus(int page, int postsPerPage, String status) {
        List<Post> posts = new ArrayList<>();
        String query = "SELECT * FROM post";

        if (status != null && !status.equals("all")) {
            query += " WHERE status = ?";
        }

        query += " ORDER BY updated_date DESC LIMIT ? OFFSET ?";

        try (PreparedStatement stmt = connection.prepareStatement(query)) {
            int paramIndex = 1;
            if (status != null && !status.equals("all")) {
                stmt.setString(paramIndex++, status);
            }
            stmt.setInt(paramIndex++, postsPerPage);
            stmt.setInt(paramIndex++, (page - 1) * postsPerPage);

            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    Post post = getFromResultSet(rs);
                    posts.add(post);
                }
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return posts;
    }

    public List<Post> searchPostsWithPagination(String searchQuery, String status, int page, int postsPerPage) {
        List<Post> posts = new ArrayList<>();
        StringBuilder queryBuilder = new StringBuilder();
        queryBuilder.append("SELECT * FROM post WHERE 1=1");

        // Add search condition if search query exists
        if (searchQuery != null && !searchQuery.trim().isEmpty()) {
            queryBuilder.append(" AND (LOWER(title) LIKE LOWER(?) OR LOWER(content) LIKE LOWER(?) OR LOWER(description) LIKE LOWER(?))");
        }

        // Add status condition if status is specified
        if (status != null && !status.isEmpty() && !status.equalsIgnoreCase("all")) {
            queryBuilder.append(" AND LOWER(status) = LOWER(?)");
        }

        queryBuilder.append(" ORDER BY updated_date DESC LIMIT ? OFFSET ?");

        try (PreparedStatement stmt = connection.prepareStatement(queryBuilder.toString())) {
            int paramIndex = 1;

            // Set search parameters if search query exists
            if (searchQuery != null && !searchQuery.trim().isEmpty()) {
                String likePattern = "%" + searchQuery.toLowerCase() + "%";
                stmt.setString(paramIndex++, likePattern);
                stmt.setString(paramIndex++, likePattern);
                stmt.setString(paramIndex++, likePattern);
            }

            // Set status parameter if status is specified
            if (status != null && !status.isEmpty() && !status.equalsIgnoreCase("all")) {
                stmt.setString(paramIndex++, status);
            }

            // Set pagination parameters
            stmt.setInt(paramIndex++, postsPerPage);
            stmt.setInt(paramIndex++, (page - 1) * postsPerPage);

            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    Post post = getFromResultSet(rs);
                    posts.add(post);
                }
            }
        } catch (SQLException ex) {
            Logger.getLogger(PostDAO.class.getName()).log(Level.SEVERE, "Error searching posts", ex);
        }
        return posts;
    }

    // Also update the count method to be case-insensitive
    public int getTotalSearchResults(String searchQuery, String status) {
        StringBuilder queryBuilder = new StringBuilder();
        queryBuilder.append("SELECT COUNT(*) FROM post WHERE 1=1");

        if (searchQuery != null && !searchQuery.trim().isEmpty()) {
            queryBuilder.append(" AND (LOWER(title) LIKE LOWER(?) OR LOWER(content) LIKE LOWER(?) OR LOWER(description) LIKE LOWER(?))");
        }

        if (status != null && !status.isEmpty() && !status.equalsIgnoreCase("all")) {
            queryBuilder.append(" AND LOWER(status) = LOWER(?)");
        }

        try (PreparedStatement stmt = connection.prepareStatement(queryBuilder.toString())) {
            int paramIndex = 1;

            if (searchQuery != null && !searchQuery.trim().isEmpty()) {
                String likePattern = "%" + searchQuery.toLowerCase() + "%";
                stmt.setString(paramIndex++, likePattern);
                stmt.setString(paramIndex++, likePattern);
                stmt.setString(paramIndex++, likePattern);
            }

            if (status != null && !status.isEmpty() && !status.equalsIgnoreCase("all")) {
                stmt.setString(paramIndex++, status);
            }

            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1);
                }
            }
        } catch (SQLException ex) {
            Logger.getLogger(PostDAO.class.getName()).log(Level.SEVERE, "Error counting search results", ex);
        }
        return 0;
    }

    public List<Post> getPostsByCategoryWithPagination(int categoryId, int page, int postsPerPage) {
        List<Post> posts = new ArrayList<>();
        String query = "SELECT * FROM post WHERE category_id = ? AND status = 'Published' ORDER BY updated_date DESC LIMIT ? OFFSET ?";

        try (PreparedStatement stmt = connection.prepareStatement(query)) {
            stmt.setInt(1, categoryId);
            stmt.setInt(2, postsPerPage);
            stmt.setInt(3, (page - 1) * postsPerPage);

            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    Post post = getFromResultSet(rs);
                    posts.add(post);
                }
            }
        } catch (SQLException ex) {
            Logger.getLogger(PostDAO.class.getName()).log(Level.SEVERE, "Error getting posts by category", ex);
        }
        return posts;
    }

    public int getTotalPostsByCategory(int categoryId) {
        int count = 0;
        String query = "SELECT COUNT(*) FROM post WHERE category_id = ? AND status = 'Published'";

        try (PreparedStatement stmt = connection.prepareStatement(query)) {
            stmt.setInt(1, categoryId);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    count = rs.getInt(1);
                }
            }
        } catch (SQLException ex) {
            Logger.getLogger(PostDAO.class.getName()).log(Level.SEVERE, "Error counting posts by category", ex);
        }
        return count;
    }


    public static void main(String[] args) {
        PostDAO postDAO = new PostDAO();
        postDAO.getAllPosts().stream().forEach(item -> {
            System.out.println(item);
        });
    }
}
