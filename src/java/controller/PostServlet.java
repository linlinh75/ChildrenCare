/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dal.PostCategoryDAO;
import dal.PostDAO;
import dal.ServiceCategoryDAO;
import dal.PostCommentDAO;
import dal.PostDAO;
import dal.ServiceDAO;
import dal.SliderDAO;
import dal.UserDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import model.PostCategory;
import model.ServiceCategory;
import java.sql.SQLException;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.Post;
import model.PostComment;
import model.Service;
import model.Slider;
import model.User;

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
        ServiceCategoryDAO sc = new ServiceCategoryDAO();
        List<ServiceCategory> s_category = sc.getAll();
        PostCategoryDAO pc = new PostCategoryDAO();
        List<PostCategory> p_category = pc.getAll();
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

            //lấy danh sách bình luận
            List<PostComment> comments = new PostCommentDAO().findByPostId(postId);

            request.setAttribute("postServlet", this);
            request.setAttribute("comments", comments);
            request.setAttribute("post", post);
            request.setAttribute("authorName", authorName);
            request.setAttribute("recentPosts", recentPosts);
            request.getRequestDispatcher("blog-single.jsp").forward(request, response);
        } else if ("search".equals(action)) {
            String query = request.getParameter("query");
            int pageNumber = 1; // Mặc định là trang đầu tiên
            int pageSize = 10; // Số bài viết trên mỗi trang

            try {
                pageNumber = Integer.parseInt(request.getParameter("page"));
            } catch (NumberFormatException e) {
                // Giữ nguyên giá trị mặc định nếu không có tham số page hợp lệ
            }

            List<Post> searchResults = postDAO.searchPosts(query, pageSize, pageNumber);
            List<Post> recentPosts = postDAO.getNewest();

            request.setAttribute("listPost", searchResults);
            request.setAttribute("recentPosts", recentPosts);
            request.setAttribute("searchQuery", query);
            request.setAttribute("currentPage", pageNumber);

            // Tính toán số trang
            int totalPosts = postDAO.countSearchResults(query);
            int totalPages = (int) Math.ceil((double) totalPosts / pageSize);
            request.setAttribute("totalPages", totalPages);

            request.getRequestDispatcher("blog-grid.jsp").forward(request, response);
        } else {
            // Existing code for listing all posts
            List<Post> listPost = postDAO.getAllPosts();
            List<Post> recentPosts = postDAO.getNewest();
            request.setAttribute("listPost", listPost);
            request.setAttribute("recentPosts", recentPosts);
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

    public String getUserName(int userId) {
        try {
            User user = new UserDAO().getProfileById(userId);
            return user != null ? user.getFullName() : "Unknown User";
        } catch (SQLException ex) {
            Logger.getLogger(PostServlet.class.getName()).log(Level.SEVERE, null, ex);
            return "Unknown User";
        }
    }

}
