/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dal.PostCategoryDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import dal.ServiceDAO;
import dal.PostDAO;
import dal.ServiceCategoryDAO;
import java.util.List;
import model.Service;
import model.Post;
import dal.SliderDAO;
import model.PostCategory;
import model.ServiceCategory;
import model.Slider;

/**
 *
 * @author admin
 */
public class HomeServlet extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            ServiceDAO s = new ServiceDAO();
            List<Service> list_service = s.getAllService();
            List<Service> firstThreeServices = list_service.subList(0, Math.min(3, list_service.size()));
            PostDAO p = new PostDAO();
            List<Post> list_post = p.getAllPosts();
            List<Post> new_post = p.getNewest();
            ServiceCategoryDAO sc = new ServiceCategoryDAO();
            List<ServiceCategory> s_category=sc.getAll1();
            PostCategoryDAO pc = new PostCategoryDAO();
            List<PostCategory> p_category= pc.getAll1();
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
                request.setAttribute("services", firstThreeServices);
            }
            if (list_post == null || list_post.isEmpty()) {
            } else {
                request.setAttribute("posts", list_post);
            }
            request.setAttribute("new_posts", new_post);
            request.getRequestDispatcher("homepage.jsp").forward(request, response);
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
