package controller;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.List;
import model.MedicalExamination;
import model.User;
import dal.MedicalExaminationDAO;
import dal.ReservationDAO;
import jakarta.servlet.http.HttpSession;
import model.Reservation;
import model.ReservationService;

public class MedicalExaminationServlet extends HttpServlet {

    private MedicalExaminationDAO medicalExaminationDAO;

    @Override
    public void init() {
        medicalExaminationDAO = new MedicalExaminationDAO();
    }

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        request.setAttribute("active", "med");
        
        // Get the logged-in user (doctor) ID from session
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("account");
        
        if (user == null || user.getRoleId() != 3) { // Assuming role_id 3 is for doctors
            response.sendRedirect("login.jsp");
            return;
        }

        String action = request.getParameter("action");
        if (action == null) {
            action = "list"; // Default action
        }

        switch (action) {
            case "add":
                handleAddExamination(request, response);
                break;
            case "list":
                handleListExaminations(request, response, user);
                break;
            case "edit":
                handleEditExamination(request, response);
                break;
            case "update":
                handleUpdateExamination(request, response);
                break;
            case "delete":
                handleDeleteExamination(request, response);
                break;
            default:
                handleListExaminations(request, response, user);
                break;
        }
    }

    private void handleAddExamination(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        // Get pending reservations for the add form
        List<Reservation> pendingReservations = medicalExaminationDAO.getPendingReservations();
        request.setAttribute("pendingReservations", pendingReservations);
        request.getRequestDispatcher("add_medical_examination.jsp").forward(request, response);
    }

    private void handleListExaminations(HttpServletRequest request, HttpServletResponse response, User user) 
            throws ServletException, IOException {
        // Get all examinations for this doctor
        List<MedicalExamination> examinations = medicalExaminationDAO.getAllExaminationByAuthor(user.getId());
        request.setAttribute("examinations", examinations);
        request.getRequestDispatcher("medical_examinations.jsp").forward(request, response);
    }

    private void handleSaveExamination(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        try {
            // Get form parameters
            int reservationId = Integer.parseInt(request.getParameter("reservationId"));
            System.out.println("id"+reservationId);
            
            String prescription = request.getParameter("prescription");
            
            // Get logged-in doctor
            HttpSession session = request.getSession();
            User doctor = (User) session.getAttribute("account");
            
            // Create new medical examination
            MedicalExamination exam = new MedicalExamination();
            
            // Set reservation info
            ReservationService rs = new ReservationService();
            rs.setReservation_id(reservationId);
            exam.setReservationService(rs);
            
            // Set patient info
            ReservationDAO reservationDAO = new ReservationDAO();
            User patient = reservationDAO.getUserByReservationID(reservationId);
            exam.setUser(patient);
            
            
            exam.setPrescription(prescription);
            exam.setAuthor_id(doctor.getId());
            
            // Save to database
            boolean success = medicalExaminationDAO.addMedicalExamination(exam);
            
            if (success) {
                response.sendRedirect("staff-exam?success=true");
            } else {
                request.setAttribute("error", "Failed to add medical examination");
                request.getRequestDispatcher("staff-exam?action=add").forward(request, response);
            }
        } catch (NumberFormatException e) {
            request.setAttribute("error", "Invalid input parameters");
            request.getRequestDispatcher("staff-exam?action=add").forward(request, response);
        }
    }

    private void handleEditExamination(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        try {
            int id = Integer.parseInt(request.getParameter("id"));
            MedicalExamination examination = medicalExaminationDAO.getExaminationById(id);
            
            if (examination != null) {
                request.setAttribute("examination", examination);
                request.getRequestDispatcher("edit_medical_examination.jsp").forward(request, response);
            } else {
                response.sendRedirect("staff-exam");
            }
        } catch (NumberFormatException e) {
            response.sendRedirect("staff-exam");
        }
    }

    private void handleUpdateExamination(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        try {
            int examId = Integer.parseInt(request.getParameter("examId"));
            String prescription = request.getParameter("prescription");
            
            MedicalExamination exam = medicalExaminationDAO.getExaminationById(examId);
            if (exam != null) {
                exam.setPrescription(prescription);
                
                boolean success = medicalExaminationDAO.updateMedicalExamination(exam);
                
                if (success) {
                    response.sendRedirect("staff-exam?success=true");
                } else {
                    request.setAttribute("error", "Failed to update medical examination");
                    request.setAttribute("examination", exam);
                    request.getRequestDispatcher("edit_medical_examination.jsp").forward(request, response);
                }
            } else {
                response.sendRedirect("staff-exam");
            }
        } catch (NumberFormatException e) {
            response.sendRedirect("staff-exam");
        }
    }

    private void handleDeleteExamination(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        try {
            int id = Integer.parseInt(request.getParameter("id"));
            
            // Check if the examination exists and belongs to the logged-in doctor
            HttpSession session = request.getSession();
            User doctor = (User) session.getAttribute("account");
            MedicalExamination exam = medicalExaminationDAO.getExaminationById(id);
            
            if (exam != null && exam.getAuthor_id() == doctor.getId()) {
                boolean success = medicalExaminationDAO.deleteMedicalExamination(id);
                
                if (success) {
                    response.sendRedirect("staff-exam?success=true");
                } else {
                    request.setAttribute("error", "Failed to delete medical examination");
                    handleListExaminations(request, response, doctor);
                }
            } else {
                response.sendRedirect("staff-exam");
            }
        } catch (NumberFormatException e) {
            response.sendRedirect("staff-exam");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        
        if (action != null) {
            switch (action) {
                case "add":
                    handleSaveExamination(request, response);
                    break;
                case "update":
                    handleUpdateExamination(request, response);
                    break;
                default:
                    processRequest(request, response);
                    break;
            }
        } else {
            processRequest(request, response);
        }
    }

    @Override
    public String getServletInfo() {
        return "Medical Examination Servlet";
    }
}
