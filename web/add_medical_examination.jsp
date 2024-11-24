<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <jsp:include page="common/common-homepage-header.jsp"/>
    <body>
        <div class="container mt-5">
            <div class="row justify-content-center">
                <div class="col-md-12">
                    <div class="card">
                        <div class="card-header">
                            <h4>Add Medical Examination</h4>
                        </div>
                        <div class="card-body">
                            <c:if test="${not empty error}">
                                <div class="alert alert-danger">${error}</div>
                            </c:if>
                            
                            <form action="staff-exam?action=add" method="POST">
                                <div class="form-group mb-3">
                                    <label for="reservationId">Select Reservation:</label><br/>
                                    <select class="form-control" id="reservationId" name="reservationId" required>
                                        <option value="">Select a reservation</option>
                                        <c:forEach var="reservation" items="${pendingReservations}">
                                            <option value="${reservation.id}">
                                                Reservation ${reservation.id} - ${reservation.customer_name} ${reservation.checkup_time}
                                            </option>
                                        </c:forEach>
                                    </select>
                                </div>
                                <br/>
                              <br/>
                              
                                <div class="form-group mb-3">
                                    <label for="prescription" class="d-flex justify-content-start">Prescription:</label>
                                    <textarea class="form-control" id="prescription" name="prescription" 
                                              rows="4" required></textarea>
                                </div>
                                 <!-- Medicines Section -->
    <div class="form-group mb-3">
        <label>Medicines:</label>
        <table class="table table-bordered" id="medicinesTable">
            <thead>
                <tr>
                    <th>Medicine Name</th>
                    <th>Dosage</th>
                    <th>Instructions</th>
                    <th>Action</th>
                </tr>
            </thead>
            <tbody>
                <!-- Default row for one medicine -->
                <tr>
                    <td><input type="text" name="medicineName[]" class="form-control" required></td>
                    <td><input type="text" name="dosage[]" class="form-control" required></td>
                    <td><input type="text" name="instructions[]" class="form-control" required></td>
                    <td><button type="button" class="btn btn-danger removeMedicine">Remove</button></td>
                </tr>
            </tbody>
        </table>
        <button type="button" class="btn btn-primary" id="addMedicineRow">Add Medicine</button>
    </div>
                              
                                <input type="hidden" id="userId" name="userId">
                                
                                <div class="text-center">
                                    <button type="submit" class="btn btn-primary">Save Examination</button>
                                    <a href="staff-exam" class="btn btn-secondary">Cancel</a>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        
       
    </body>
    <jsp:include page="./common/common-homepage-footer.jsp"></jsp:include>
    <script>
       document.getElementById('addMedicineRow').addEventListener('click', function() {
    const tableBody = document.querySelector('#medicinesTable tbody');
    const newRow = `
        <tr>
            <td><input type="text" name="medicineName[]" class="form-control" required></td>
            <td><input type="text" name="dosage[]" class="form-control" required></td>
            <td><input type="text" name="instructions[]" class="form-control" required></td>
            <td><button type="button" class="btn btn-danger removeMedicine">Remove</button></td>
        </tr>`;
    tableBody.insertAdjacentHTML('beforeend', newRow);
});

document.addEventListener('click', function(event) {
    if (event.target.classList.contains('removeMedicine')) {
        event.target.closest('tr').remove();
    }
});
</script>
</html> 
