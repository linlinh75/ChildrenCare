package controller;

import com.itextpdf.text.Document;
import com.itextpdf.text.DocumentException;
import com.itextpdf.text.Paragraph;
import com.itextpdf.text.pdf.PdfWriter;
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
import dal.UserDAO;
import jakarta.servlet.http.HttpSession;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.Date;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.Medicine;
import model.Reservation;
import model.ReservationService;
import util.EmailSender;

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
            case "detail":
                handleDetailExamination(request, response);
                break;
//            case "update":
//                handleUpdateExamination(request, response);
//                break;
//            case "delete":
//                handleDeleteExamination(request, response);
//                break;
            default:
                handleListExaminations(request, response, user);
                break;
        }
    }

    private void handleAddExamination(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Get pending reservations for the add form
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("account");
        List<Reservation> pendingReservations = medicalExaminationDAO.getApprovedReservations(user.getId());
        request.setAttribute("pendingReservations", pendingReservations);
        request.getRequestDispatcher("add_medical_examination.jsp").forward(request, response);
    }

    private void handleDetailExamination(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Get pending reservations for the add form
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("account");
        List<Reservation> pendingReservations = medicalExaminationDAO.getApprovedReservations(user.getId());
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
            throws ServletException, IOException, DocumentException {
//        try {
//            // Get form parameters
//            int reservationId = Integer.parseInt(request.getParameter("reservationId"));
//            System.out.println("id"+reservationId);
//            
//            String prescription = request.getParameter("prescription");
//            
//            // Get logged-in doctor
//            HttpSession session = request.getSession();
//            User doctor = (User) session.getAttribute("account");
//            
//            // Create new medical examination
//            MedicalExamination exam = new MedicalExamination();
//            
//            // Set reservation info
//            ReservationService rs = new ReservationService();
//            rs.setReservation_id(reservationId);
//            exam.setReservationService(rs);
//            
//            // Set patient info
//            ReservationDAO reservationDAO = new ReservationDAO();
//            User patient = reservationDAO.getUserByReservationID(reservationId);
//            exam.setUser(patient);
//            
//            
//            exam.setPrescription(prescription);
//            exam.setAuthor_id(doctor.getId());
//            
//            // Save to database
//            boolean success = medicalExaminationDAO.addMedicalExamination(exam);
//            
//            if (success) {
//                response.sendRedirect("staff-exam?success=true");
//            } else {
//                request.setAttribute("error", "Failed to add medical examination");
//                request.getRequestDispatcher("staff-exam?action=add").forward(request, response);
//            }
//        } catch (NumberFormatException e) {
//            request.setAttribute("error", "Invalid input parameters");
//            request.getRequestDispatcher("staff-exam?action=add").forward(request, response);
//        }
        int reservationId = Integer.parseInt(request.getParameter("reservationId"));
        String prescription = request.getParameter("prescription");
        HttpSession session = request.getSession();
        User doctor = (User) session.getAttribute("account");
        int authorId = doctor.getId();
        ReservationDAO rdao = new ReservationDAO();
        Reservation rnow = rdao.getReservationById(reservationId);
        int patientId = rnow.getCustomer_id();
        UserDAO udao = new UserDAO();
        User patient = udao.getUserById(patientId);

        // Retrieve Medicines
        String[] medicineNames = request.getParameterValues("medicineName[]");
        String[] dosages = request.getParameterValues("dosage[]");
        String[] instructions = request.getParameterValues("instructions[]");

        // Create Medical Examination
        MedicalExamination exam = new MedicalExamination();
        exam.setReservationService(new ReservationService(reservationId));
        exam.setPrescription(prescription);
        exam.setAuthor_id(authorId);
        exam.setUser(patient);
        List<Medicine> medicines = new ArrayList<>();
        for (int i = 0; i < medicineNames.length; i++) {
            Medicine med = new Medicine();
            med.setMedicineName(medicineNames[i]);
            med.setDosage(dosages[i]);
            med.setInstructions(instructions[i]);
            medicines.add(med);
        }
        exam.setMedicines(medicines);
        exam.setDate(Timestamp.valueOf(LocalDateTime.now()));
        // Save to database using DAO
        MedicalExaminationDAO dao = new MedicalExaminationDAO();
        boolean success = dao.addMedicalExamination(exam);

        if (success) {
            request.setAttribute("success", "Successfully save examination");
            createPdfExam(exam, request, response);
            rdao.statusReservation(reservationId, "Examined", patientId);
            response.sendRedirect("staff-exam?action=list"); // Redirect to the list of examinations
        } else {
            request.setAttribute("error", "Failed to save examination");
            request.getRequestDispatcher("add_medical_examination.jsp").forward(request, response);
        }

    }

    private void createPdfExam(MedicalExamination exam, HttpServletRequest request, HttpServletResponse response) throws DocumentException {
        try {
            // Define the file path
            Date examDate = exam.getDate();
            SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");  // Format date as yyyy-MM-dd
            String formattedDate = dateFormat.format(examDate);
            String fileName = "D:\\MedicalExamination\\" + exam.getUser().getFullName().replaceAll("\\s+", "") + "" + formattedDate + "_" + exam.getReservationService().getReservation_id() + ".pdf";

            // Create a new document
            Document doc = new Document();
            PdfWriter.getInstance(doc, new FileOutputStream(fileName));

            doc.open();

            // Add a title to the PDF
            doc.add(new Paragraph("Medical Examination Report"));
            doc.add(new Paragraph("------------------------------------------------"));

            // Add patient details
            doc.add(new Paragraph("Patient Name: " + exam.getUser().getFullName()));
            doc.add(new Paragraph("Patient ID: " + exam.getUser().getId()));
            doc.add(new Paragraph("Date of Examination: " + exam.getDate().toString()));
            doc.add(new Paragraph("Prescription: " + exam.getPrescription()));

            // Add doctor details (author)
            User doctor = (User) request.getSession().getAttribute("account"); // Get the doctor from session
            doc.add(new Paragraph("Doctor Name: " + doctor.getFullName()));

            // Add Medicines prescribed
            List<Medicine> medicines = exam.getMedicines();
            if (medicines != null && !medicines.isEmpty()) {
                doc.add(new Paragraph("Medicines Prescribed:"));
                for (Medicine med : medicines) {
                    doc.add(new Paragraph("  - " + med.getMedicineName() + " | Dosage: " + med.getDosage() + " | Instructions: " + med.getInstructions()));
                }
            } else {
                doc.add(new Paragraph("No medicines prescribed."));
            }

            // Add reservation details (if needed)
            Reservation rnow = new ReservationDAO().getReservationById(exam.getReservationService().getReservation_id());
            doc.add(new Paragraph("Reservation ID: " + rnow.getId()));
            doc.add(new Paragraph("Reservation Date: " + rnow.getReservation_date().toString()));

            doc.add(new Paragraph("------------------------------------------------"));

            // Close the document
            doc.close();
            String body = "Your reservation has been completed, below is your examination details, please carry this to nearest pharmacy to take pills. Thanks again for chosing our service! ";

            EmailSender.sendEmailWithAttachment(exam.getUser().getEmail(), "Medical Examination Claimed", body, fileName);
        } catch (FileNotFoundException ex) {
            Logger.getLogger(MedicalExaminationServlet.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

//    private void handleEditExamination(HttpServletRequest request, HttpServletResponse response) 
//            throws ServletException, IOException {
//        try {
//            int id = Integer.parseInt(request.getParameter("id"));
//            MedicalExamination examination = medicalExaminationDAO.getExaminationById(id);
//            
//            if (examination != null) {
//                request.setAttribute("examination", examination);
//                request.getRequestDispatcher("edit_medical_examination.jsp").forward(request, response);
//            } else {
//                response.sendRedirect("staff-exam");
//            }
//        } catch (NumberFormatException e) {
//            response.sendRedirect("staff-exam");
//        }
//    }
//
//    private void handleUpdateExamination(HttpServletRequest request, HttpServletResponse response) 
//            throws ServletException, IOException {
//        try {
//            int examId = Integer.parseInt(request.getParameter("examId"));
//            String prescription = request.getParameter("prescription");
//            
//            MedicalExamination exam = medicalExaminationDAO.getExaminationById(examId);
//            if (exam != null) {
//                exam.setPrescription(prescription);
//                
//                boolean success = medicalExaminationDAO.updateMedicalExamination(exam);
//                
//                if (success) {
//                    response.sendRedirect("staff-exam?success=true");
//                } else {
//                    request.setAttribute("error", "Failed to update medical examination");
//                    request.setAttribute("examination", exam);
//                    request.getRequestDispatcher("edit_medical_examination.jsp").forward(request, response);
//                }
//            } else {
//                response.sendRedirect("staff-exam");
//            }
//        } catch (NumberFormatException e) {
//            response.sendRedirect("staff-exam");
//        }
//    }
//    private void handleDeleteExamination(HttpServletRequest request, HttpServletResponse response) 
//            throws ServletException, IOException {
//        try {
//            int id = Integer.parseInt(request.getParameter("id"));
//            
//            // Check if the examination exists and belongs to the logged-in doctor
//            HttpSession session = request.getSession();
//            User doctor = (User) session.getAttribute("account");
//            MedicalExamination exam = medicalExaminationDAO.getExaminationById(id);
//            
//            if (exam != null && exam.getAuthor_id() == doctor.getId()) {
//                boolean success = medicalExaminationDAO.deleteMedicalExamination(id);
//                
//                if (success) {
//                    response.sendRedirect("staff-exam?success=true");
//                } else {
//                    request.setAttribute("error", "Failed to delete medical examination");
//                    handleListExaminations(request, response, doctor);
//                }
//            } else {
//                response.sendRedirect("staff-exam");
//            }
//        } catch (NumberFormatException e) {
//            response.sendRedirect("staff-exam");
//        }
//    }
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
                case "add": {
                    try {
                        handleSaveExamination(request, response);
                    } catch (DocumentException ex) {
                        Logger.getLogger(MedicalExaminationServlet.class.getName()).log(Level.SEVERE, null, ex);
                    }
                }
                break;

//                case "update":
//                    handleUpdateExamination(request, response);
//                    break;
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
