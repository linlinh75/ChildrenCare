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
import model.PostCategory;
import dal.DBContext;

/**
 *
 * @author admin
 */
public class PostCategoryDAO extends DBContext{
    PreparedStatement stm;
    ResultSet rs;
    public List<PostCategory> getAll() {
        List<PostCategory> ulist = new ArrayList<>();
        String s = "Select * from  swp.post_category";
        try {
            stm = connection.prepareStatement(s);
            rs = stm.executeQuery();
            while (rs.next()) {
                PostCategory u = new PostCategory(rs.getInt("id"), rs.getString("name"), rs.getString("description"));
                ulist.add(u);
            }
        } catch (SQLException ex) {
            Logger.getLogger(UserDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return ulist;
    }
    public List<PostCategory> getAll1() {
        List<PostCategory> ulist = new ArrayList<>();
        String s = "Select * from  swp.post_category where status=1";
        try {
            stm = connection.prepareStatement(s);
            rs = stm.executeQuery();
            while (rs.next()) {
                PostCategory u = new PostCategory(rs.getInt("id"), rs.getString("name"), rs.getString("description"));
                ulist.add(u);
            }
        } catch (SQLException ex) {
            Logger.getLogger(UserDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return ulist;
    }
    public static void main(String[] args) {
        PostCategoryDAO dao = new PostCategoryDAO();
        List<PostCategory> ulist = dao.getAll();
        for ( PostCategory s : ulist ){
            System.out.println(s.getName());
        }
    }
}
