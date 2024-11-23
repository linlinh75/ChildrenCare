package controller;

import dal.PostCategoryDAO;
import dal.ServiceCategoryDAO;
import jakarta.servlet.ServletContext;
import jakarta.servlet.ServletContextEvent;
import jakarta.servlet.ServletContextListener;
import jakarta.servlet.annotation.WebListener;

@WebListener
public class ServiceBlogListener implements ServletContextListener {

    private final ServiceCategoryDAO serviceDAO = new ServiceCategoryDAO();
    private final PostCategoryDAO postDAO = new PostCategoryDAO();

    public void contextInitialized(ServletContextEvent sce) {
        ServletContext context = sce.getServletContext();
        context.setAttribute("listServiceCategory", serviceDAO.getAll1());
        System.out.println("dang hien thi list service category");
        context.setAttribute("listPostCategory", postDAO.getAll1());
        System.out.println("dang hien thi list post category");
    }
}
