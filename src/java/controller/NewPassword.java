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
        System.out.println(token);
        if(!udao.isTokenValid(token)){
            System.out.println("false");
            udao.cleanupExpiredTokens();
        }else{
            String tokenInURL = request.getParameter("token");
            if(tokenInURL.equals(token)){
                udao.cleanupExpiredTokens();
                System.out.println("gan dung");
                request.getRequestDispatcher("newPw.jsp").forward(request, response);
            }
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
		if (newPassword != null && confPassword != null && newPassword.equals(confPassword)) {

			try {
				UserDAO udao = new UserDAO();
                                int rowCount=udao.changePassword((String)session.getAttribute("email"), newPassword);
				if (rowCount > 0) {
					request.setAttribute("statusSuccess", "Reset Success");
					dispatcher = request.getRequestDispatcher("login.jsp");
				} else {
					request.setAttribute("statusFailed", "Reset Failed");
					dispatcher = request.getRequestDispatcher("login.jsp");
				}
				dispatcher.forward(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}else{
                    request.setAttribute("token", request.getParameter("token"));
                    request.getRequestDispatcher("login.jsp").forward(request, response);
                }
                
	}

}
