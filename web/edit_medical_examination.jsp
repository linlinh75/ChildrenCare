<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <jsp:include page="common/common-homepage-header.jsp"/>
    <body>
        <div class="container mt-5">
            <div class="row justify-content-center">
                <div class="col-md-8">
                    <div class="card">
                        <div class="card-header">
                            <h4>Edit Medical Examination</h4>
                        </div>
                        <div class="card-body">
                            <c:if test="${not empty error}">
                                <div class="alert alert-danger">${error}</div>
                            </c:if>
                            
                            <form action="staff-exam?action=update" method="POST" id="updateForm">
                                <input type="hidden" name="examId" value="${examination.id}">
                                
                                <div class="form-group mb-3">
                                    <label for="reservationId">Reservation:</label><br/>
                                    <input type="text" class="form-control" 
                                           value="Reservation ${examination.reservationService.reservation_id} - ${examination.user.fullName}" 
                                           readonly>
                                    <input type="hidden" name="reservationId" 
                                           value="${examination.reservationService.reservation_id}">
                                </div>
                                <br/>
                                <br/>
                              
                                <div class="form-group mb-3">
                                    <label for="prescription" class="d-flex justify-content-start">Prescription:</label>
                                    <textarea class="form-control" id="prescription" name="prescription" 
                                              rows="4" required>${examination.prescription}</textarea>
                                </div>
                                
                                <div class="text-center">
                                    <button type="button" class="btn btn-primary" onclick="confirmUpdate()">Update Examination</button>
                                    <a href="staff-exam" class="btn btn-secondary">Cancel</a>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <script>
            function confirmUpdate() {
                if (confirm('Are you sure you want to update this medical examination?')) {
                    document.getElementById('updateForm').submit();
                }
            }
        </script>
    </body>
    <jsp:include page="./common/common-homepage-footer.jsp"></jsp:include>
</html> 