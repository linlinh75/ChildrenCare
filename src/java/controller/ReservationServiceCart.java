package controller;

import dal.ReservationDAO;
import dal.ServiceDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import model.ReservationCart;
import model.Service;
import model.User;
import java.sql.Timestamp;
import model.Reservation;

@WebServlet(name = "ReservationServiceCart", urlPatterns = {"/customer-reservation-service-cart"})
public class ReservationServiceCart extends HttpServlet {

    private static final String LOGIN_PAGE = "login.jsp";
    private static final String CART_PAGE = "customer-reservationServiceCart.jsp";

    private static final String SERVICE_PAGE = "service";

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        User account = (User) session.getAttribute("account");

//        // Check if user is logged in
//        if (account == null) {
//            session.setAttribute("message", "Please log in to view your cart");
//            response.sendRedirect(LOGIN_PAGE);
//            return;
//        }

        // Initialize cart if needed
        ReservationCart cart = getOrCreateCart(session);

        // Add any error or success messages to request
        String error = (String) session.getAttribute("error");
        String success = (String) session.getAttribute("success");
        if (error != null) {
            request.setAttribute("error", error);
            session.removeAttribute("error");
        }
        if (success != null) {
            request.setAttribute("success", success);
            session.removeAttribute("success");
        }

        // Forward to cart display page
        request.getRequestDispatcher(CART_PAGE).forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        User account = (User) session.getAttribute("account");

//        // Check if user is logged in
//        if (account == null) {
//            session.setAttribute("message", "Please log in to modify your cart");
//            response.sendRedirect(LOGIN_PAGE);
//            return;
//        }

        String action = request.getParameter("action");
        ReservationCart cart = getOrCreateCart(session);

        try {
            switch (action) {
                case "add":
                    addToCart(request, session, cart);
                    session.setAttribute("success", "Service added to cart successfully");
                    response.sendRedirect(CART_PAGE);
                    break;

                case "remove":
                    removeFromCart(request, cart);
                    session.setAttribute("success", "Service removed from cart");
                    response.sendRedirect(CART_PAGE);
                    break;

                case "clear":
                    clearCart(cart);
                    session.setAttribute("success", "Cart cleared successfully");
                    response.sendRedirect(CART_PAGE);
                    break;
                case "book-appointment":
                    bookAppointment(request, response, session, cart);
                    break;

                default:
                    session.setAttribute("error", "Invalid action specified");
                    response.sendRedirect(CART_PAGE);
                    break;
            }
        } catch (NumberFormatException e) {
            handleError(session, "Invalid service ID provided");
            response.sendRedirect(CART_PAGE);
        } catch (Exception e) {
            handleError(session, e);
            response.sendRedirect(CART_PAGE);
        }
    }

    private ReservationCart getOrCreateCart(HttpSession session) {
        ReservationCart cart = (ReservationCart) session.getAttribute("cart");
        if (cart == null) {
            cart = new ReservationCart();
            session.setAttribute("cart", cart);
        }
        return cart;
    }

    private void addToCart(HttpServletRequest request, HttpSession session, ReservationCart cart) throws Exception {
        // Validate service ID
        String serviceIdStr = request.getParameter("serviceId");
        if (serviceIdStr == null || serviceIdStr.trim().isEmpty()) {
            throw new IllegalArgumentException("Service ID is required");
        }

        int serviceId = Integer.parseInt(serviceIdStr);
        ServiceDAO serviceDAO = new ServiceDAO();
        Service service = serviceDAO.getServiceById(serviceId);

        if (service == null) {
            throw new IllegalArgumentException("Service not found");
        }

        // Check if service is already in cart
        if (cart.hasService(serviceId)) {
            throw new IllegalArgumentException("This service is already in your cart");
        }

        cart.addService(service);
        setCustomerInfo(session, cart);
    }

    private void setCustomerInfo(HttpSession session, ReservationCart cart) {
        User account = (User) session.getAttribute("account");
        if (account != null) {
            cart.setCustomerInfo(account.getId(), account.getFullName());
        }
    }

    private void removeFromCart(HttpServletRequest request, ReservationCart cart) {
        String serviceIdStr = request.getParameter("serviceId");
        if (serviceIdStr == null || serviceIdStr.trim().isEmpty()) {
            throw new IllegalArgumentException("Service ID is required for removal");
        }

        int serviceId = Integer.parseInt(serviceIdStr);
        cart.removeService(serviceId);
    }

    private void clearCart(ReservationCart cart) {
        cart.clear();
    }

    private void handleError(HttpSession session, String message) {
        session.setAttribute("error", message);
    }

    private void handleError(HttpSession session, Exception e) {
        session.setAttribute("error", "Failed to process cart action: " + e.getMessage());
        e.printStackTrace();
    }

    private void bookAppointment(HttpServletRequest request, HttpServletResponse response, HttpSession session, ReservationCart cart) throws Exception {
        // Validate cart is not empty
        if (cart.getReservation().getList_service().isEmpty()) {
            throw new IllegalStateException("Cart is empty");
        }

        try {
            // Get form data
            String fullName = request.getParameter("fullName");
            String email = request.getParameter("email");
            String phone = request.getParameter("phone");
            String address = request.getParameter("address");
            String paymentMethod = request.getParameter("paymentMethod");
            String checkupTimeStr = request.getParameter("checkupTime");
            System.out.println(paymentMethod);
            // Validate required fields
            validateBookingData(fullName, email, phone, address, paymentMethod, checkupTimeStr);

            // Parse checkup time
            Timestamp checkupTime = Timestamp.valueOf(checkupTimeStr.replace("T", " ") + ":00");

            // Create a new Reservation object
            Reservation reservation = new Reservation();
            reservation.setCustomer_id(cart.getReservation().getCustomer_id());
            reservation.setCustomer_name(fullName);
            reservation.setReservation_date(new Timestamp(System.currentTimeMillis()));
            reservation.setStatus("Pending");
            reservation.setCheckup_time(checkupTime);
            reservation.setList_service(cart.getReservation().getList_service());
            reservation.setPay_option(paymentMethod);
            // Save reservation to database
            ReservationDAO reservationDAO = new ReservationDAO();
            int reservationId = reservationDAO.insertReservation(reservation);
            reservation.setId(reservationId);
            request.setAttribute("reservation", reservation);
request.setAttribute("reservationId", reservationId);
            if (reservationId > 0) {
                // Clear the cart after successful booking
                clearCart(cart);

                // Set success message
                session.setAttribute("book-success", "Appointment booked successfully! Your reservation ID is: " + reservationId);

                // Redirect to appropriate page
               request.getRequestDispatcher("reservecompletion").forward(request, response);
            } else {
                throw new Exception("Failed to create reservation");
            }
        } catch (Exception e) {
            session.setAttribute("error", "Failed to book appointment: " + e.getMessage());
            response.sendRedirect(CART_PAGE);
        }
    }

    private void validateBookingData(String fullName, String email, String phone,
            String address, String paymentMethod, String checkupTime) {
        List<String> errors = new ArrayList<>();

        if (fullName == null || fullName.trim().isEmpty()) {
            errors.add("Full name is required");
        }
        if (email == null || !email.matches("^[A-Za-z0-9+_.-]+@(.+)$")) {
            errors.add("Valid email is required");
        }
        if (phone == null || !phone.matches("^\\d{10,}$")) {
            errors.add("Valid phone number is required");
        }
        if (address == null || address.trim().isEmpty()) {
            errors.add("Address is required");
        }
        if (paymentMethod == null || paymentMethod.trim().isEmpty()) {
            errors.add("Payment method is required");
        }
        if (checkupTime == null || checkupTime.trim().isEmpty()) {
            errors.add("Checkup time is required");
        }

        if (!errors.isEmpty()) {
            throw new IllegalArgumentException("Validation errors: " + String.join(", ", errors));
        }
    }
}
