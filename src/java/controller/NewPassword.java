package controller;

import dal.UserDAO;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import util.EncodePassword;
import util.VerifyPassword;

/**
 * Servlet implementation class NewPassword
 */
@WebServlet("/newPassword")
public class NewPassword extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)throws ServletException, IOException {
        HttpSession session = request.getSession();
        UserDAO udao = new UserDAO();
        String token=request.getParameter("token");
        String email = request.getParameter("email");
        if(!udao.isTokenValid(token)){
            udao.cleanupExpiredTokens();
            String error = "Token invalid!";
            request.setAttribute("error",error);
            request.setAttribute("email",email);
            request.getRequestDispatcher("forgotPw.jsp").forward(request, response);
        }else{
                udao.cleanupExpiredTokens();
                request.setAttribute("token", token);
                request.getRequestDispatcher("newPw.jsp").forward(request, response);

        }
        
    
    }
   
	private static final long serialVersionUID = 1L;

    @Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		HttpSession session = request.getSession();
		String newPassword = request.getParameter("password");
                
		String confPassword = request.getParameter("confPassword");
                
		RequestDispatcher dispatcher = null;
                UserDAO udao = new UserDAO();
                VerifyPassword ver = new VerifyPassword();
        try {
            if(udao.isTokenValid(request.getParameter("token"))){
            if(VerifyPassword.verify(newPassword)){
                newPassword = EncodePassword.encodeToSHA1(newPassword);
                confPassword = EncodePassword.encodeToSHA1(confPassword);
            if(!newPassword.equals(udao.getUserByEmail((String)session.getAttribute("email")).getPassword())){
                if (newPassword.equals(confPassword)) {
                        try {
                            int rowCount=udao.changePassword((String)session.getAttribute("email"), newPassword);
                            if (rowCount > 0) {
                                request.setAttribute("statusSuccess", "Reset Password Success");
                                dispatcher = request.getRequestDispatcher("login.jsp");
                            } else {
                                request.setAttribute("statusFailed", "Reset Password Failed");
                                dispatcher = request.getRequestDispatcher("login.jsp");
                            }
                            dispatcher.forward(request, response);
                        } catch (Exception e) {
                            e.printStackTrace();
                        }
                    }else{
                    request.setAttribute("token", request.getParameter("token"));
                    String erChange = "Wrong Confirm Password";
                    request.setAttribute("erChange", erChange);
                    request.getRequestDispatcher("newPw.jsp").forward(request, response);
                        
                    }
                    
                }else{
                 request.setAttribute("token", request.getParameter("token"));
                 String erChange = "New Password has to different from Old Password";
                        request.setAttribute("erChange", erChange);
                        request.getRequestDispatcher("newPw.jsp").forward(request, response); 
                   
                }
        }else{
                 request.setAttribute("token", request.getParameter("token"));
                 String erChange = "Password must be between 8-24 characters, include at least one uppercase letter and one number";
                        request.setAttribute("erChange", erChange);
                        request.getRequestDispatcher("newPw.jsp").forward(request, response); 
        }
            }else{
                udao.cleanupExpiredTokens();
            String error = "Token invalid!";
            request.setAttribute("error",error);
            request.setAttribute("email",(String)session.getAttribute("email"));
            request.getRequestDispatcher("forgotPw.jsp").forward(request, response);
            }
        } catch (SQLException ex) {
            Logger.getLogger(NewPassword.class.getName()).log(Level.SEVERE, null, ex);
        }}
                

}
