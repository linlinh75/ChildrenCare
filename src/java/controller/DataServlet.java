/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dal.MedicalExaminationDAO;
import dal.PostDAO;
import dal.ServiceDAO;
import dal.SliderDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.List;
import model.Post;
import model.Service;
import model.Slider;
import dal.ServiceCategoryDAO;
import model.ServiceCategory;
import model.PostCategory;
import dal.PostCategoryDAO;
import model.MedicalExamination;
import model.User;

/**
 *
 * @author admin
 */
@WebServlet(name = "DataServlet", urlPatterns = {"/DataServlet"})
public class DataServlet extends HttpServlet {

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
            HttpSession session = request.getSession(false);
            ServiceDAO s = new ServiceDAO();
            List<Service> list_service = s.getAllService();
            PostDAO p = new PostDAO();
            List<Post> list_post = p.getAllPosts();
            List<Post> new_post = p.getNewest();
            ServiceCategoryDAO sc = new ServiceCategoryDAO();
            List<ServiceCategory> s_category=sc.getAll();
            PostCategoryDAO pc = new PostCategoryDAO();
            List<PostCategory> p_category= pc.getAll();
            SliderDAO sliderDAO = new SliderDAO();
            List<Slider> list_sliders = sliderDAO.getAllSliders();
            request.setAttribute("list_sliders", list_sliders);

//               MedicalExaminationDAO medDAO = new MedicalExaminationDAO();
//            List<MedicalExamination> list_examination = medDAO.getAllExaminationByAuthor(((User)session.getAttribute("account")).getId());
//            
//            request.setAttribute("list_examination", list_examination); 

            
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
            String action = request.getParameter("action");
            if (null == action) {
            } else {
                switch (action) {
                    case "register": {
                        HttpSession ses = request.getSession(false);
                        if (ses.getAttribute("account") != null) {
                            response.sendRedirect("/ChildrenCare/HomeServlet");
                        } else {
                            request.getRequestDispatcher("register.jsp").forward(request, response);
                        }
                        break;
                    }
                    case "login": {
                        HttpSession ses = request.getSession(false);

                    if (ses.getAttribute("account") != null) {
                            response.sendRedirect("/ChildrenCare/HomeServlet");
                        } else {
                            request.getRequestDispatcher("login.jsp").forward(request, response);
                        
                        }
                        break;
                    }
                    case "service": {
                        request.getRequestDispatcher("./service").forward(request, response);
                        break;
                    }
                    case "post": {
                        request.getRequestDispatcher("./post").forward(request, response);
                        break;
                    }
                    case "verify": {
                        request.getRequestDispatcher("verify.jsp").forward(request, response);
                        break;
                    }
                    case "med": {
                        request.getRequestDispatcher("staff-exam").forward(request, response);
                        break;
                    }
                    case "profile": {
                        request.getRequestDispatcher("./profile").forward(request, response);
                    }
                    default:
                        break;
                }
            }
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
