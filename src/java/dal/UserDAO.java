package dal;


import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
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
        } catch(Exception e) {
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
            stmt.setInt(9, user.getStatus());

            return stmt.executeUpdate();
        }
    }
    public static void main(String[] args) {
        UserDAO userdao = new UserDAO();
        List<User> ulist = userdao.getAllUser();
        for (User u : ulist) {
            System.out.println(u.getId());
            //System.out.println(u.getId());
        }
        /*User newUser = new User();
        newUser.setEmail("testuser@example.com");
        newUser.setPassword("password123");
        newUser.setFullName("Test User");
        newUser.setGender(true); 
        newUser.setMobile("1234567890");
        newUser.setAddress("123 Test Street");
        newUser.setImageLink("default.jpg");
        newUser.setRoleId(4); 
        newUser.setStatus(17); 

        try {
            // Gọi phương thức addUser để thêm người dùng mới
            int result = userdao.addUser(newUser);
            if (result > 0) {
                System.out.println("User added successfully!");
            } else {
                System.out.println("Failed to add user.");
            }
        } catch (SQLException ex) {
            Logger.getLogger(UserDAO.class.getName()).log(Level.SEVERE, null, ex);
        }*/
    }
}
