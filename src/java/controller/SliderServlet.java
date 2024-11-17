/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import dal.SliderDAO;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;
import java.io.File;
import java.io.InputStream;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.util.List;
import model.Slider;
import model.User;

/**
 *
 * @author admin
 */
@MultipartConfig(
        fileSizeThreshold = 1024 * 1024, // 1 MB
        maxFileSize = 1024 * 1024 * 5, // 5 MB
        maxRequestSize = 1024 * 1024 * 10 // 10 MB
)
@WebServlet(name = "managerSliderServlet", urlPatterns = {"/managerSliderList"})
public class SliderServlet extends HttpServlet {

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
            HttpSession session = request.getSession();
            SliderDAO s = new SliderDAO();
            List<Slider> list_slider = s.getManageSliders();
            String action = request.getParameter("action");
            if ("detail".equals(action)) {
                if (request.getParameter("id") != null) {
                    int id = Integer.parseInt(request.getParameter("id"));
                    Slider slider_detail = s.getSliderbyId(id);
                    request.setAttribute("slider", slider_detail);
                }
                request.getRequestDispatcher("manager-slider-details.jsp").forward(request, response);
            }
            if ("delete".equals(action)) {
                if (request.getParameter("id") != null) {
                    int id = Integer.parseInt(request.getParameter("id"));
                    s.deleteSlider(id);
                    session.setAttribute("message", "Slider deleted successfully!");
                    response.sendRedirect(request.getContextPath() + "/managerSliderList");
                }
            }
            if (action == null) {
                request.setAttribute("slider", list_slider);
                request.getRequestDispatcher("manager-sliderlist.jsp").forward(request, response);
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
        HttpSession session = request.getSession();
        SliderDAO s = new SliderDAO();
        String submit = request.getParameter("submit");
        if (submit != null) {
            if ("add".equals(submit)) {
                Part filePart = request.getPart("sliderImage");
                if (filePart != null && filePart.getSize() > 0) {
                    String fileName = getFileName(filePart);
                    String uploadDir = getServletContext().getRealPath("/uploads");

                    File uploadDirFile = new File(uploadDir);
                    if (!uploadDirFile.exists()) {
                        uploadDirFile.mkdirs();
                    }

                    String filePath = uploadDir + File.separator + fileName;

                    try (InputStream input = filePart.getInputStream()) {
                        Files.copy(input, Paths.get(filePath), StandardCopyOption.REPLACE_EXISTING);
                    }

                    String imagePath = "./uploads/" + fileName;
                    String title = request.getParameter("sliderTitle");
                    String backlink = request.getParameter("sliderBacklink");
                    String status = request.getParameter("sliderStatus");
                    String note = request.getParameter("sliderNote");
                    User loggedInUser = (User) session.getAttribute("account");
                    int author_id = loggedInUser.getId();

                    s.addSlider(title, imagePath, backlink, status, note, author_id);
                    session.setAttribute("message", "Slider added successfully!");
                }
            } else {
                int id = Integer.parseInt(request.getParameter("sliderId"));

                if ("1".equals(submit)) {
                    s.updateStatus(id, "0");
                } else if ("0".equals(submit)) {
                    s.updateStatus(id, "1");
                }

                if ("edit".equals(submit)) {
                    Part filePart = request.getPart("sliderImage");
                    String old_image = s.getSliderbyId(id).getImageLink();
                    String title = request.getParameter("sliderTitle");
                    String backlink = request.getParameter("sliderBacklink");
                    String status = request.getParameter("sliderStatus");
                    String note = request.getParameter("sliderNote");
                    if (filePart != null && filePart.getSize() > 0) {
                        String fileName = getFileName(filePart);
                        String uploadDir = getServletContext().getRealPath("/uploads");

                        File uploadDirFile = new File(uploadDir);
                        if (!uploadDirFile.exists()) {
                            uploadDirFile.mkdirs();
                        }

                        String filePath = uploadDir + File.separator + fileName;

                        try (InputStream input = filePart.getInputStream()) {
                            Files.copy(input, Paths.get(filePath), StandardCopyOption.REPLACE_EXISTING);
                        }

                        String imagePath = "./uploads/" + fileName;

                        s.updateSlider(id, title, imagePath, backlink, status, note);
                        session.setAttribute("message", "Slider update successfully!");

                    } else {
                        s.updateSlider(id, title, old_image, backlink, status, note);
                        session.setAttribute("message", "Slider update successfully!");
                    }
                }
            }
            response.sendRedirect(request.getContextPath() + "/managerSliderList");
        }
    }

    private String getFileName(Part part) {
        String contentDisp = part.getHeader("content-disposition");
        String[] tokens = contentDisp.split(";");
        for (String token : tokens) {
            if (token.trim().startsWith("filename")) {
                return token.substring(token.indexOf("=") + 2, token.length() - 1);
            }
        }
        return "";
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
