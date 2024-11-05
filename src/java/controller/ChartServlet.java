package controller;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Paths;

@WebServlet("/app")
public class ChartServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html");
        response.setCharacterEncoding("UTF-8");

        // Adjust the path to where the React app's build folder is located
        String indexPath = "./chart/build/index.html";
        String htmlContent = new String(Files.readAllBytes(Paths.get(indexPath)));

        // Write HTML content to the response
        response.getWriter().write(htmlContent);
    }
}
