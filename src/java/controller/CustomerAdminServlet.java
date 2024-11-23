package controller;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.google.gson.TypeAdapter;
import com.google.gson.stream.JsonReader;
import com.google.gson.stream.JsonWriter;
import dal.UserDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.User;

import java.io.IOException;
import java.io.PrintWriter;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

@WebServlet(name = "CustomerAdminServlet", urlPatterns = {"/patients"})
public class CustomerAdminServlet extends HttpServlet {

    private static class LocalDateAdapter extends TypeAdapter<LocalDate> {
        private final DateTimeFormatter formatter = DateTimeFormatter.ISO_LOCAL_DATE;

        @Override
        public void write(JsonWriter out, LocalDate value) throws IOException {
            out.value(value != null ? formatter.format(value) : null);
        }

        @Override
        public LocalDate read(JsonReader in) throws IOException {
            String dateString = in.nextString();
            return dateString != null ? LocalDate.parse(dateString, formatter) : null;
        }
    }

    private UserDAO userDAO;

    @Override
    public void init() throws ServletException {
        userDAO = new UserDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        if (action == null) {
            action = "list";
        }

        switch (action) {
            case "list":
                listCustomers(request, response);
                break;
            case "search":
                searchCustomers(request, response);
                break;
            case "view":
                viewCustomer(request, response);
                break;
            case "getCustomer":
                getCustomerJson(request, response);
                break;
            default:
                listCustomers(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");

        switch (action) {
            case "update":
                updateCustomer(request, response);
                break;
            case "delete":
                deleteCustomer(request, response);
                break;
            default:
                listCustomers(request, response);
        }
    }

    private void listCustomers(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            // Get all customers
            List<User> allCustomers = userDAO.getAllUser();
            // Filter only customers (role_id = 4)
            allCustomers.removeIf(user -> !user.isCustomer());

            // Pagination parameters
            int recordsPerPage = 10;
            int currentPage = 1;
            String pageStr = request.getParameter("page");
            if (pageStr != null && !pageStr.isEmpty()) {
                currentPage = Integer.parseInt(pageStr);
            }

            // Calculate pagination indices
            int totalCustomers = allCustomers.size();
            int totalPages = (int) Math.ceil((double) totalCustomers / recordsPerPage);

            // Adjust currentPage if it's out of bounds
            if (currentPage < 1) {
                currentPage = 1;
            } else if (currentPage > totalPages) {
                currentPage = totalPages;
            }

            // Calculate start and end indices
            int startIndex = (currentPage - 1) * recordsPerPage;
            int endIndex = Math.min(startIndex + recordsPerPage, totalCustomers);

            // Get current page customers
            List<User> currentPageCustomers;
            if (startIndex < totalCustomers) {
                currentPageCustomers = allCustomers.subList(startIndex, endIndex);
            } else {
                currentPageCustomers = new ArrayList<>();
            }

            // Set attributes for JSP
            request.setAttribute("customers", currentPageCustomers);
            request.setAttribute("currentPage", (int) currentPage);
            request.setAttribute("recordsPerPage", (int) recordsPerPage);
            request.setAttribute("totalCustomers", (int) totalCustomers);
            request.setAttribute("totalPages", (int) totalPages);

            // Forward to JSP
            request.getRequestDispatcher("/admin/customer_list_admin.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Error retrieving customer list: " + e.getMessage());
            request.getRequestDispatcher("/error.jsp").forward(request, response);
        }
    }

    private void searchCustomers(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            String searchTerm = request.getParameter("search");
            List<User> allCustomers = userDAO.getAllUser();

            // Filter customers based on search term
            List<User> filteredCustomers = allCustomers.stream()
                    .filter(user -> user.isCustomer()
                    && (user.getFullName().toLowerCase().contains(searchTerm.toLowerCase())
                    || user.getEmail().toLowerCase().contains(searchTerm.toLowerCase())
                    || user.getMobile().contains(searchTerm)))
                    .collect(Collectors.toList());

            // Pagination parameters
            int recordsPerPage = 10;
            int currentPage = 1;
            String pageStr = request.getParameter("page");
            if (pageStr != null && !pageStr.isEmpty()) {
                currentPage = Integer.parseInt(pageStr);
            }

            // Calculate pagination indices
            int totalCustomers = filteredCustomers.size();
            int totalPages = (int) Math.ceil((double) totalCustomers / recordsPerPage);

            // Adjust currentPage if it's out of bounds
            if (currentPage < 1) {
                currentPage = 1;
            } else if (currentPage > totalPages) {
                currentPage = totalPages;
            }

            // Calculate start and end indices
            int startIndex = (currentPage - 1) * recordsPerPage;
            int endIndex = Math.min(startIndex + recordsPerPage, totalCustomers);

            // Get current page customers
            List<User> currentPageCustomers;
            if (startIndex < totalCustomers) {
                currentPageCustomers = filteredCustomers.subList(startIndex, endIndex);
            } else {
                currentPageCustomers = new ArrayList<>();
            }

            // Set attributes for JSP
            request.setAttribute("customers", currentPageCustomers);
            request.setAttribute("currentPage", currentPage);
            request.setAttribute("totalPages", totalPages);
            request.setAttribute("totalCustomers", totalCustomers);
            request.setAttribute("recordsPerPage", recordsPerPage);
            request.setAttribute("searchTerm", searchTerm);

            request.getRequestDispatcher("/admin/customer_list_admin.jsp").forward(request, response);
        } catch (Exception e) {
            request.setAttribute("error", "Error searching customers: " + e.getMessage());
            request.getRequestDispatcher("/error.jsp").forward(request, response);
        }
    }

    private void viewCustomer(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            int customerId = Integer.parseInt(request.getParameter("id"));
            User customer = userDAO.getProfileById(customerId);

            if (customer != null && customer.isCustomer()) {
                request.setAttribute("customer", customer);
                request.getRequestDispatcher("/admin/customer_view.jsp").forward(request, response);
            } else {
                response.sendError(HttpServletResponse.SC_NOT_FOUND, "Customer not found");
            }
        } catch (Exception e) {
            request.setAttribute("error", "Error viewing customer: " + e.getMessage());
            request.getRequestDispatcher("/error.jsp").forward(request, response);
        }
    }

    private void updateCustomer(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            int customerId = Integer.parseInt(request.getParameter("id"));
            User customer = userDAO.getProfileById(customerId);

            if (customer != null && customer.isCustomer()) {
                customer.setFullName(request.getParameter("fullName"));
                customer.setGender(Boolean.parseBoolean(request.getParameter("gender")));
                customer.setMobile(request.getParameter("mobile"));
                customer.setAddress(request.getParameter("address"));
                customer.setStatus(request.getParameter("status"));

                if (userDAO.updateProfile(customer)) {
                    response.sendRedirect(request.getContextPath() + "/patients");
                } else {
                    throw new Exception("Failed to update customer");
                }
            } else {
                response.sendError(HttpServletResponse.SC_NOT_FOUND);
            }
        } catch (Exception e) {
            request.setAttribute("error", "Error updating customer: " + e.getMessage());
            request.getRequestDispatcher("/error.jsp").forward(request, response);
        }
    }

    private void deleteCustomer(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Note: Instead of actually deleting the customer, we'll just update their status to "Inactive"
        try {
            int customerId = Integer.parseInt(request.getParameter("id"));
            User customer = userDAO.getProfileById(customerId);

            if (customer != null && customer.isCustomer()) {
                if (userDAO.updateProfile(customer)) {
                    response.sendRedirect(request.getContextPath() + "/patients");
                } else {
                    throw new Exception("Failed to deactivate customer");
                }
            } else {
                System.out.println("Loi~~------------------------");
                response.sendError(HttpServletResponse.SC_NOT_FOUND, "Customer not found");
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Error deactivating customer: " + e.getMessage());
            response.sendRedirect(request.getContextPath() + "/patients");
        }
    }

    private void getCustomerJson(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            int customerId = Integer.parseInt(request.getParameter("id"));
            User customer = userDAO.getProfileById(customerId);

            if (customer != null && customer.isCustomer()) {
                // Clear any existing headers/data
                response.reset();
                // Set the content type before writing the response
                response.setContentType("application/json");
                response.setCharacterEncoding("UTF-8");

                // Create a custom Gson instance with LocalDate TypeAdapter
                Gson gson = new GsonBuilder()
                        .registerTypeAdapter(LocalDate.class, new LocalDateAdapter())
                        .create();

                // Convert customer to JSON
                String jsonCustomer = gson.toJson(customer);

                // Write the JSON response
                PrintWriter out = response.getWriter();
                out.print(jsonCustomer);
                out.flush();
            } else {
                response.setStatus(HttpServletResponse.SC_NOT_FOUND);
                response.getWriter().write("{\"error\": \"Customer not found\"}");
            }
        } catch (Exception e) {
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            response.getWriter().write("{\"error\": \"" + e.getMessage() + "\"}");
        }
    }
}
