package dal;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;
import model.User;

/**
 * Data Access Object (DAO) for User entity.
 */
public class UserDAO extends DBContext {


    PreparedStatement stm;
    ResultSet rs;

    public int updateProfile(User user) throws SQLException {
        String sql = "UPDATE users "
                + "SET fullName = ?, gender = ?, mobile = ?, address = ?, imageLink = ? "
                + "WHERE id = ?";

        try ( PreparedStatement stmt = connection.prepareStatement(sql)) {
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

        try ( PreparedStatement stmt = connection.prepareStatement(sql)) {
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

    public List<User> getAllUser() {
        List<User> ulist = new ArrayList<>();
        String s = "Select * from user";
        try {
            stm = connection.prepareStatement(s);
            rs = stm.executeQuery();

            while(rs.next()){
                User u = new User(rs.getInt("id"), rs.getString("email"),  rs.getString("password"), rs.getString("full_name"),rs.getBoolean("gender") , rs.getString("mobile"), rs.getString("address"), rs.getString("image_link"), rs.getInt("role_id"), rs.getInt("status"));

                ulist.add(u);
            }
        } catch (SQLException ex) {
            Logger.getLogger(UserDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return ulist;
    }

    public static void main(String[] args) {
        UserDAO userdao = new UserDAO();
        List<User> ulist = userdao.getAllUser();
        for (User u : ulist) {
            System.out.println(u.getId());
        }
    }
}
