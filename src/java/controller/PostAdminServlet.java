/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dal.PostCategoryDAO;
import dal.PostDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.util.List;
import model.Post;
import model.PostCategory;
import model.User;

@WebServlet("/post-list-admin")
@MultipartConfig
public class PostAdminServlet extends HttpServlet {

    private final PostDAO postDAO = new PostDAO();
    private final PostCategoryDAO postCategoryDAO = new PostCategoryDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");

        if (action == null) {
            action = "list"; // Default action
        }

        List<PostCategory> listPostCategorys = postCategoryDAO.getAll();

        request.setAttribute("listPostCategorys", listPostCategorys);
        switch (action) {
            case "list":
                listPosts(request, response);
                break;
            case "add":
                showAddForm(request, response);
                break;
            case "edit":
                showEditForm(request, response);
                break;
            case "remove":
                hidePost(request, response);
                break;
            default:
                listPosts(request, response);
                break;
        }
    }

    private void listPosts(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Get pagination parameters
        int page = 1;
        int postsPerPage = 8;

        String pageParam = request.getParameter("page");
        if (pageParam != null && !pageParam.isEmpty()) {
            page = Integer.parseInt(pageParam);
        }

        // Get search and filter parameters
        String searchQuery = request.getParameter("searchQuery");
        String status = request.getParameter("status");

        // Get posts based on search and filter criteria
        List<Post> posts = postDAO.searchPostsWithPagination(searchQuery, status, page, postsPerPage);

        // Get total results for pagination
        int totalPosts = postDAO.getTotalSearchResults(searchQuery, status);
        int totalPages = (int) Math.ceil((double) totalPosts / postsPerPage);

        // Set attributes for JSP
        request.setAttribute("posts", posts);
        request.setAttribute("currentPage", page);
        request.setAttribute("totalPages", totalPages);
        request.setAttribute("selectedStatus", status);
        request.setAttribute("searchQuery", searchQuery);

        // Forward to JSP
        request.getRequestDispatcher("admin/blog_list_admin.jsp").forward(request, response);
    }

    private void showAddForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("admin/add_post_admin.jsp").forward(request, response);
    }

    private void showEditForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int postId = Integer.parseInt(request.getParameter("id"));
        Post post = postDAO.getPostById(postId);

        if (post != null) {
            request.setAttribute("post", post);
            request.getRequestDispatcher("admin/edit_post_admin.jsp").forward(request, response);
        } else {
            response.sendRedirect(request.getContextPath() + "/post-list-admin?action=list");
        }
    }

    private void hidePost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            int postId = Integer.parseInt(request.getParameter("id"));
            boolean success = postDAO.hidePost(postId);

            if (success) {
                // Optionally add a success message
                request.getSession().setAttribute("successMessage", "Post has been hidden successfully.");
            } else {
                // Optionally add an error message
                request.getSession().setAttribute("errorMessage", "Failed to hide the post. Please try again.");
            }
        } catch (NumberFormatException e) {
            request.getSession().setAttribute("errorMessage", "Invalid post ID.");
        }

        // Redirect back to the post list
        response.sendRedirect(request.getContextPath() + "/post-list-admin?action=list");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        if (action == null) {
            action = "list"; // Default action
        }

        switch (action) {
            case "add":
                addPost(request, response);
                break;
            case "update":
                updatePost(request, response);
                break;
            default:
                listPosts(request, response);
                break;
        }
    }

    private void addPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String title = request.getParameter("title");
        String description = request.getParameter("description");
        String content = request.getParameter("content");
        int categoryId = Integer.parseInt(request.getParameter("category"));
        String status = request.getParameter("status");

        // Handle file upload
        Part filePart = request.getPart("image");
        String fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
        String uploadPath = getServletContext().getRealPath("/uploads");

        // Ensure the upload directory exists
        Files.createDirectories(Paths.get(uploadPath));

        // Save the file
        try (InputStream fileContent = filePart.getInputStream()) {
            Files.copy(fileContent, Paths.get(uploadPath).resolve(fileName),
                    StandardCopyOption.REPLACE_EXISTING);
        }

        // Create a new Post object
        Post newPost = new Post();
        newPost.setTitle(title);
        newPost.setDescription(description);
        newPost.setContent(content);
        newPost.setCategoryId(categoryId);
        newPost.setStatusId(status);
        newPost.setThumbnailLink(request.getContextPath() + "/uploads/" + fileName);
        newPost.setAuthorId(((User) request.getSession().getAttribute("account")).getId());

        // Save the post to the database
        boolean success = postDAO.addPost(newPost);

        if (success) {
            response.sendRedirect("post-list-admin");
        } else {
            request.setAttribute("error", "Failed to add the post. Please try again.");
            response.sendRedirect("post-list-admin");
        }
    }

    private void updatePost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        String title = request.getParameter("title");
        String description = request.getParameter("description");
        String content = request.getParameter("content");
        int categoryId = Integer.parseInt(request.getParameter("category"));
        String status = request.getParameter("status");

        Post post = postDAO.getPostById(id);
        post.setTitle(title);
        post.setDescription(description);
        post.setContent(content);
        post.setCategoryId(categoryId);
        post.setStatusId(status);

        String newImagePath = null;
        Part filePart = request.getPart("image");
        if (filePart != null && filePart.getSize() > 0) {
            String fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
            String uploadPath = getServletContext().getRealPath("/uploads");
            Files.createDirectories(Paths.get(uploadPath));

            try (InputStream fileContent = filePart.getInputStream()) {
                Files.copy(fileContent, Paths.get(uploadPath).resolve(fileName),
                        StandardCopyOption.REPLACE_EXISTING);
            }
            newImagePath = request.getContextPath() + "/uploads/" + fileName;
        }

        boolean success = postDAO.updatePost(post, newImagePath);

        if (success) {
            response.sendRedirect(request.getContextPath() + "/post-list-admin?action=list");
        } else {
            request.setAttribute("error", "Failed to update the post. Please try again.");
            request.setAttribute("post", post);
            request.getRequestDispatcher("admin/edit_post_admin.jsp").forward(request, response);
        }
    }
}
