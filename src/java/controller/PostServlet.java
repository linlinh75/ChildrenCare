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
    private final int POSTS_PER_PAGE = 6;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");

        // Common data for all actions
        ServiceDAO s = new ServiceDAO();
        List<Service> list_service = s.getAllService();
        List<Post> new_post = postDAO.getNewest();
        ServiceCategoryDAO sc = new ServiceCategoryDAO();
        List<ServiceCategory> s_category = sc.getAll();
        PostCategoryDAO pc = new PostCategoryDAO();
        List<PostCategory> p_category = pc.getAll();
        SliderDAO sliderDAO = new SliderDAO();
        List<Slider> list_sliders = sliderDAO.getAllSliders();

        // Set common attributes
        request.setAttribute("list_sliders", list_sliders);
        request.setAttribute("list_sc", s_category);
        request.setAttribute("list_pc", p_category);
        request.setAttribute("services", list_service);
        request.setAttribute("new_posts", new_post);
        request.setAttribute("active", "post");

        // Get current page number
        int pageNumber = 1;
        try {
            String pageParam = request.getParameter("page");
            if (pageParam != null && !pageParam.isEmpty()) {
                pageNumber = Integer.parseInt(pageParam);
                if (pageNumber < 1) {
                    pageNumber = 1;
                }
            }
        } catch (NumberFormatException e) {
            pageNumber = 1;
        }

        if ("detail".equals(action)) {
            handlePostDetail(request, response);
        } else if ("search".equals(action)) {
            handleSearch(request, response, pageNumber);
        } else if ("category".equals(action)) {
            handleCategoryPosts(request, response, pageNumber);
        } else {
            handleListPosts(request, response, pageNumber);
        }
    }

    private void handlePostDetail(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int postId = Integer.parseInt(request.getParameter("id"));
        Post post = postDAO.getPostById(postId);
        List<Post> recentPosts = postDAO.getNewest();
        String authorName = postDAO.getAuthorNameByPostId(postId);
        List<PostComment> comments = new PostCommentDAO().findByPostId(postId);

        request.setAttribute("postServlet", this);
        request.setAttribute("comments", comments);
        request.setAttribute("post", post);
        request.setAttribute("authorName", authorName);
        request.setAttribute("recentPosts", recentPosts);
        request.getRequestDispatcher("blog-single.jsp").forward(request, response);
    }

    private void handleSearch(HttpServletRequest request, HttpServletResponse response, int pageNumber)
            throws ServletException, IOException {
        String query = request.getParameter("query");

        List<Post> searchResults = postDAO.searchPosts(query, POSTS_PER_PAGE, pageNumber);
        List<Post> recentPosts = postDAO.getNewest();

        int totalPosts = postDAO.countSearchResults(query);
        int totalPages = (int) Math.ceil((double) totalPosts / POSTS_PER_PAGE);

        request.setAttribute("listPost", searchResults);
        request.setAttribute("recentPosts", recentPosts);
        request.setAttribute("searchQuery", query);
        request.setAttribute("currentPage", pageNumber);
        request.setAttribute("totalPages", totalPages);
        request.setAttribute("pageType", "search"); // To differentiate between search and list in JSP

        request.getRequestDispatcher("blog-grid.jsp").forward(request, response);
    }

    private void handleListPosts(HttpServletRequest request, HttpServletResponse response, int pageNumber)
            throws ServletException, IOException {
        // Get paginated posts
        List<Post> listPost = postDAO.getPostsWithPagination(pageNumber, POSTS_PER_PAGE);
        List<Post> recentPosts = postDAO.getNewest();

        // Calculate total pages
        int totalPosts = postDAO.getTotalPosts();
        int totalPages = (int) Math.ceil((double) totalPosts / POSTS_PER_PAGE);

        request.setAttribute("listPost", listPost);
        request.setAttribute("recentPosts", recentPosts);
        request.setAttribute("currentPage", pageNumber);
        request.setAttribute("totalPages", totalPages);
        request.setAttribute("pageType", "list"); // To differentiate between search and list in JSP

        request.getRequestDispatcher("blog-grid.jsp").forward(request, response);
    }

    private void handleCategoryPosts(HttpServletRequest request, HttpServletResponse response, int pageNumber)
            throws ServletException, IOException {
        int categoryId;
        try {
            categoryId = Integer.parseInt(request.getParameter("categoryId"));
        } catch (NumberFormatException e) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid category ID");
            return;
        }

        List<Post> categoryPosts = postDAO.getPostsByCategoryWithPagination(categoryId, pageNumber, POSTS_PER_PAGE);
        List<Post> recentPosts = postDAO.getNewest();
        System.out.println(categoryPosts.size() + "-----------------");
        int totalPosts = postDAO.getTotalPostsByCategory(categoryId);
        int totalPages = (int) Math.ceil((double) totalPosts / POSTS_PER_PAGE);

        request.setAttribute("listPost", categoryPosts);
        request.setAttribute("recentPosts", recentPosts);
        request.setAttribute("currentPage", pageNumber);
        request.setAttribute("totalPages", totalPages);
        request.setAttribute("categoryId", categoryId);
        request.setAttribute("pageType", "category"); // To differentiate in JSP

        request.getRequestDispatcher("blog-grid.jsp").forward(request, response);
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
