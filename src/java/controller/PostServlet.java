/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dal.PostDAO;
import dal.ServiceDAO;
import dal.SettingDAO;
import dal.SliderDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import model.Post;
import model.Service;
import model.Setting;
import model.Slider;

public class PostServlet extends HttpServlet {

    private final PostDAO postDAO = new PostDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        ServiceDAO s = new ServiceDAO();
        List<Service> list_service = s.getAllService();
        PostDAO p = new PostDAO();
        List<Post> list_post = p.getAllPosts();
        List<Post> new_post = p.getNewest();
        SettingDAO st = new SettingDAO();
        List<Setting> s_category = st.getServiceCategory();
        List<Setting> p_category = st.getPostCategory();
        SliderDAO sliderDAO = new SliderDAO();
        List<Slider> list_sliders = sliderDAO.getAllSliders();
        request.setAttribute("list_sliders", list_sliders);
        if (s_category == null || s_category.isEmpty()) {
        } else {
            request.setAttribute("list_sc", s_category);
        }
        if (p_category == null || p_category.isEmpty()) {
        } else {
            request.setAttribute("list_pc", p_category);
        }
        if (list_service == null || list_service.isEmpty()) {
        } else {
            request.setAttribute("services", list_service);
        }
        if (list_post == null || list_post.isEmpty()) {
        } else {
            request.setAttribute("posts", list_post);
        }
        request.setAttribute("new_posts", new_post);
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
            out.println("<h1>Servlet PostServlet at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

}
