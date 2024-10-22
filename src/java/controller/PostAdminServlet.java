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
            default:
                listPosts(request, response);
                break;
        }
    }

    private void listPosts(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int page = 1;
        int postsPerPage = 8; // You can adjust this number

        String pageParam = request.getParameter("page");
        if (pageParam != null && !pageParam.isEmpty()) {
            page = Integer.parseInt(pageParam);
        }

        List<Post> posts = postDAO.getPostsWithPagination(page, postsPerPage);
        int totalPosts = postDAO.getTotalPosts();
        int totalPages = (int) Math.ceil((double) totalPosts / postsPerPage);

        request.setAttribute("posts", posts);
        request.setAttribute("currentPage", page);
        request.setAttribute("totalPages", totalPages);
        request.getRequestDispatcher("admin/blog_list_admin.jsp").forward(request, response);
    }

    private void showAddForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("admin/add_post_admin.jsp").forward(request, response);
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
            response.sendRedirect(request.getContextPath() + "/post-list-admin?action=list");
        } else {
            request.setAttribute("error", "Failed to add the post. Please try again.");
            request.getRequestDispatcher("admin/add_post_admin.jsp").forward(request, response);
        }
    }
}
