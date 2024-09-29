/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package controller;

import dal.PostDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import model.Post;

public class PostServlet extends HttpServlet {
    private final PostDAO postDAO = new PostDAO();
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        String action = request.getParameter("action");
        request.setAttribute("active", "post");
        if ("detail".equals(action)) {
            int postId = Integer.parseInt(request.getParameter("id"));
            Post post = postDAO.getPostById(postId);
            List<Post> recentPosts = postDAO.getNewest();
            String authorName = postDAO.getAuthorNameByPostId(postId);
            request.setAttribute("post", post);
            request.setAttribute("authorName", authorName);
            request.setAttribute("recentPosts", recentPosts);
            request.getRequestDispatcher("blog-single.jsp").forward(request, response);
        } else {
            // Existing code for listing all posts
            List<Post> listPost = postDAO.getAllPosts();
            request.setAttribute("listPost", listPost);
            request.getRequestDispatcher("blog-grid.jsp").forward(request, response);
        }
    } 


    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        processRequest(request, response);
    }

   
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet PostServlet</title>");  
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet PostServlet at " + request.getContextPath () + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    } 

}
