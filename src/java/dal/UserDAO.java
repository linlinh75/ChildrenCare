package dal;

import java.sql.Timestamp;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDateTime;
import static java.time.LocalDateTime.now;
import java.util.ArrayList;
import java.util.List;
import java.util.Random;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.User;

/**
 * Data Access Object (DAO) for User entity.
 */
public class UserDAO extends DBContext {

    PreparedStatement stm;
    ResultSet rs;

    public boolean updateProfile(User user) {
        String sql = "UPDATE user "
                + "SET full_name = ?, gender = ?, mobile = ?, address = ?, image_link = ? "
                + "WHERE id = ?";

        try {
            PreparedStatement stmt = connection.prepareStatement(sql);
            stmt.setString(1, user.getFullName());
            stmt.setBoolean(2, user.isGender());
            stmt.setString(3, user.getMobile());
            stmt.setString(4, user.getAddress());
            stmt.setString(5, user.getImageLink());
            stmt.setInt(6, user.getId());

            return stmt.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    /**
     * Retrieves the user's profile information by their ID.
     *
     * @param userId The ID of the user.
     * @return The User object containing the user's profile information.
     * @throws SQLException If there is an error executing the SQL query.
     */
    public User getProfileById(int userId) throws SQLException {
        String sql = "SELECT * FROM user WHERE id = ?";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
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
                            rs.getString("status")
                    );
                }
            }
        }

        return null;
    }

    public User getUserByEmail(String email) throws SQLException {
        String sql = "SELECT * FROM user WHERE email = ?";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setString(1, email);

            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return new User(
                            rs.getInt("id"),
                            rs.getString("email"),
                            rs.getString("password"),
                            rs.getString("full_name"),
                            rs.getBoolean("gender"),
                            rs.getString("mobile"),
                            rs.getString("address"),
                            rs.getString("image_link"),
                            rs.getInt("role_id"),
                            rs.getString("status")
                    );
                }
            }
        }
        return null;
    }
    public User getUserByPhoneNumber(String phone) throws SQLException {
        String sql = "SELECT * FROM user WHERE mobile = ?";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setString(1, phone);

            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return new User(
                            rs.getInt("id"),
                            rs.getString("email"),
                            rs.getString("password"),
                            rs.getString("full_name"),
                            rs.getBoolean("gender"),
                            rs.getString("mobile"),
                            rs.getString("address"),
                            rs.getString("image_link"),
                            rs.getInt("role_id"),
                            rs.getString("status")
                    );
                }
            }
        }
        return null;
    }
    public void updateToken(String email, String token) {
        String s = "Update password_reset_tokens set token";
    }

    public String addToken(String email) {
        int leftLimit = 97; // letter 'a'
        int rightLimit = 122; // letter 'z'
        int targetStringLength = 20;
        Random random = new Random();
        StringBuilder buffer = new StringBuilder(targetStringLength);
        for (int i = 0; i < targetStringLength; i++) {
            int randomLimitedInt = leftLimit + (int) (random.nextFloat() * (rightLimit - leftLimit + 1));
            buffer.append((char) randomLimitedInt);
        }
        String token = buffer.toString();
        LocalDateTime now = LocalDateTime.now();
        LocalDateTime expiresAt = now.plusMinutes(10); // Token valid for 10 minutes

        try {
            stm = connection.prepareStatement("INSERT INTO password_reset_tokens (token, email, created_at, expires_at, user_id) VALUES (?, ?, ?, ?,?)");
            stm.setString(1, token);
            stm.setString(2, email);
            stm.setTimestamp(3, Timestamp.valueOf(now));
            stm.setTimestamp(4, Timestamp.valueOf(expiresAt));
            stm.setInt(5, getUserByEmail(email).getId());
            stm.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(UserDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return token;
    }

    public boolean isTokenValid(String token) {
        try {
            stm = connection.prepareStatement("SELECT expires_at FROM password_reset_tokens WHERE token = ?");
            stm.setString(1, token);
            ResultSet rs = stm.executeQuery();
            if (rs.next()) {
                Timestamp expiresAt = rs.getTimestamp("expires_at");
                return expiresAt.after(Timestamp.valueOf(LocalDateTime.now()));
            }
        } catch (SQLException ex) {
            Logger.getLogger(UserDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return false;
    }

    public void cleanupExpiredTokens() {
        try {
            stm = connection.prepareStatement("DELETE FROM password_reset_tokens WHERE expires_at < ?");
            stm.setTimestamp(1, Timestamp.valueOf(LocalDateTime.now()));
            stm.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(UserDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public int changePassword(String email, String password) {
        String s = "update user set password = ? where email=?";
        int count = 0;
        try {
            stm = connection.prepareStatement(s);
            stm.setString(1, password);
            stm.setString(2, email);
            count = stm.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(UserDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return count;
    }

    public List<User> getAllUser() {
        List<User> ulist = new ArrayList<>();
        String s = "Select * from user";
        try {
            stm = connection.prepareStatement(s);
            rs = stm.executeQuery();
            while (rs.next()) {
                User u = new User(rs.getInt("id"), rs.getString("email"), rs.getString("password"), rs.getString("full_name"), rs.getBoolean("gender"), rs.getString("mobile"), rs.getString("address"), rs.getString("image_link"), rs.getInt("role_id"), rs.getString("status"));
                ulist.add(u);
            }
        } catch (SQLException ex) {
            Logger.getLogger(UserDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return ulist;
    }

    public int addUser(User user) throws SQLException {
        String sql = "INSERT INTO user (email, password, full_name, gender, mobile, address, image_link, role_id, status) "
                + "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";

        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setString(1, user.getEmail());
            stmt.setString(2, user.getPassword());
            stmt.setString(3, user.getFullName());
            stmt.setBoolean(4, user.isGender());
            stmt.setString(5, user.getMobile());
            stmt.setString(6, user.getAddress());
            stmt.setString(7, user.getImageLink());
            stmt.setInt(8, user.getRoleId());
            stmt.setString(9, user.getStatus());

            return stmt.executeUpdate();
        }
    }

    public String getRoleString(int role) {
        String sql = "SELECT role_name FROM role\n"
                + "where id = ?";
        try {
            PreparedStatement stmt = connection.prepareStatement(sql);
            stmt.setObject(1, role);
            ResultSet resultSet = stmt.executeQuery();
            if (resultSet.next()) {
                return resultSet.getString(1);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    public boolean updateProfileImage(int userId, String imagePath) {
        String sql = "UPDATE user SET image_link = ? WHERE id = ?";
        try (Connection conn = new DBContext().connection; PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, imagePath);
            stmt.setInt(2, userId);
            int affectedRows = stmt.executeUpdate();
            return affectedRows > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public static void main(String[] args) {
        UserDAO userdao = new UserDAO();
        List<User> ulist = userdao.getAllUser();
        for (User u : ulist) {
            System.out.println(u.getId());
            //System.out.println(u.getId());
        }
        User newUser = new User();
            newUser.setEmail("thanhthanh16102004@gmail.com");
            newUser.setPassword("Thanhcute16");
            newUser.setFullName("Thanhne");
            newUser.setGender(false);
            newUser.setMobile("0902004117");
            newUser.setAddress("123 Test Street");
            newUser.setImageLink("assets/images/default.png");
            newUser.setRoleId(4);
            newUser.setStatus("Activate");

            try {
            int result = userdao.addUser(newUser);
            if (result > 0) {
            System.out.println("User added successfully!");
            } else {
            System.out.println("Failed to add user.");
            }
            } catch (SQLException ex) {
            Logger.getLogger(UserDAO.class.getName()).log(Level.SEVERE, null, ex);
            }
        try {
            System.out.println(userdao.getUserByEmail("thanhthanh16102004@gmail.com"));
        } catch (SQLException ex) {
            Logger.getLogger(UserDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

}
