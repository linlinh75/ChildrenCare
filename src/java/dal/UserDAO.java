/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.User;
/**
 *
 * @author Admin
 */
public class UserDAO extends DBContext {
    PreparedStatement stm;
    ResultSet rs;
    public List<User> getAllUser(){
        List<User> ulist = new ArrayList<>();
        String s = "Select * from user";
        try{
            stm = connection.prepareStatement(s);
            rs = stm.executeQuery();
            while(rs.next()){
                User u = new User(rs.getInt("id"), rs.getString("email"),  rs.getString("password"), rs.getString("full_name"),rs.getInt("gender") , rs.getString("mobile"), rs.getString("address"), rs.getString("image_link"), rs.getInt("role_id"), rs.getInt("status"));
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
        for(User u: ulist){
            System.out.println(u.getId());
        }
    }
}
