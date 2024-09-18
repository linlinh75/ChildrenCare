package dal;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import model.User;

/**
 * Data Access Object (DAO) for User entity.
 */
public class UserDAO extends DBContext {
    
    /**
     * Updates the user's profile information, except for the email.
     * 
     * @param user The user object containing the updated information.
     * @return The number of rows affected by the update.
     * @throws SQLException If there is an error executing the SQL query.
     */
    public int updateProfile(User user) throws SQLException {
        String sql = "UPDATE users "
                   + "SET fullName = ?, gender = ?, mobile = ?, address = ?, imageLink = ? "
                   + "WHERE id = ?";
        
        try (Connection conn = getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, user.getFullName());
            stmt.setBoolean(2, user.isGender());
            stmt.setString(3, user.getMobile());
            stmt.setString(4, user.getAddress());
            stmt.setString(5, user.getImageLink());
            stmt.setInt(6, user.getId());
            
            return stmt.executeUpdate();
        }
    }
    
    /**
     * Retrieves the user's profile information by their ID.
     * 
     * @param userId The ID of the user.
     * @return The User object containing the user's profile information.
     * @throws SQLException If there is an error executing the SQL query.
     */
    public User getProfileById(int userId) throws SQLException {
        String sql = "SELECT * FROM users WHERE id = ?";
        
        try (Connection conn = getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, userId);
            
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return new User(
                        rs.getInt("id"),
                        rs.getString("email"),
                        rs.getString("password"),
                        rs.getString("fullName"),
                        rs.getBoolean("gender"),
                        rs.getString("mobile"),
                        rs.getString("address"),
                        rs.getString("imageLink"),
                        rs.getInt("roleId"),
                        rs.getInt("status")
                    );
                }
            }
        }
        
        return null;
    }
}
