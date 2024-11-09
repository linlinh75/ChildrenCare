<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@page contentType="text/html" pageEncoding="UTF-8"%>
        <!DOCTYPE html>
        <html>
            <jsp:include page="common/common-homepage-header.jsp"/>
            <body>
                
                <div class="container mt-5 ">
                    <c:if test="${param.success == 'true'}">
                    <div class="alert alert-success">
                        You have been added medical examination for reservation 
                    </div>
                </c:if>
                        <h2>Medical Examinations</h2>
                        <div class="d-flex justify-content-between mt-5">
                            <div class="input-group w-50">
                                <input type="text" id="searchInput" class="form-control" 
                                       placeholder="Search by patient name...">
                                <button class="btn btn-outline-secondary" type="button" 
                                        onclick="searchExaminations()">Search</button>
                            </div>
                            <div><a href="staff-exam?action=add" class="btn btn-primary">Add Examination</a></div>
                            
                        </div>
                    
                    
                    
                    <div class="table-responsive mt-5">
                        <table class="table table-striped" id="examinationTable">
                            <thead>
                                <tr>
                                    <th>Reservation</th>
                                    
                                    <th>Patient Name</th>
                                    <th>Gender</th>
                                    <th>Email</th>
                                    <th>Prescription</th>
                                    <th>Actions</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="exam" items="${examinations}">
                                    <tr class="exam-row">
                                        <td>${exam.reservationService.reservation_id}</td>
                                        
                                        <td>${exam.user.fullName}</td>
                                        <td>${exam.user.gender ? 'Male' : 'Female'}</td>
                                        <td>${exam.user.email}</td>
                                        <td>${exam.prescription}</td>
                                        <td>
                                            <a href="staff-exam?action=edit&id=${exam.id}" 
                                               class="btn btn-primary btn-sm">Edit</a>
                                            <button onclick="confirmDelete(${exam.id})" 
                                                    class="btn btn-danger btn-sm">Delete</button>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                        
                        <div class="d-flex justify-content-center mt-3">
                            <nav aria-label="Page navigation">
                                <ul class="pagination" id="pagination">
                                </ul>
                            </nav>
                        </div>
                    </div>
                </div>
                
                <!-- Include necessary JavaScript files -->
                <script src="js/jquery.min.js"></script>
                <script src="js/bootstrap.min.js"></script>
                
                <style>
                    .pagination {
                        display: flex;
                        align-items: center;
                        gap: 5px;
                    }
                    
                    .pagination .page-item {
                        display: inline-block;
                        cursor: pointer;
                    }
                    
                    .pagination .page-link {
                        padding: 8px 12px;
                        border: 1px solid #dee2e6;
                        color: #007bff;
                        background-color: #fff;
                        text-decoration: none;
                        user-select: none;
                        -webkit-user-select: none;
                        -moz-user-select: none;
                    }
                    
                    .pagination .page-item.active .page-link {
                        background-color: #007bff;
                        border-color: #007bff;
                        color: white;
                    }
                    
                    .pagination .page-item.disabled .page-link {
                        color: #6c757d;
                        pointer-events: none;
                        background-color: #fff;
                        border-color: #dee2e6;
                        cursor: not-allowed;
                    }
                    
                    .pagination .page-numbers {
                        display: flex;
                        align-items: center;
                        gap: 5px;
                    }
                </style>
                
                <script>
                    function searchExaminations() {
                        const searchText = document.getElementById('searchInput').value.toLowerCase();
                        const rows = document.getElementsByClassName('exam-row');
                        
                        Array.from(rows).forEach(row => {
                            const patientName = row.getElementsByTagName('td')[1].textContent.toLowerCase();
                            if (patientName.includes(searchText)) {
                                row.style.display = '';
                            } else {
                                row.style.display = 'none';
                            }
                        });
                        
                        // Reset pagination to show first page
                        currentPage = 1;
                        showPage(1);
                    }
                    
                    // Add event listener for Enter key on search input
                    document.getElementById('searchInput').addEventListener('keypress', function(e) {
                        if (e.key === 'Enter') {
                            searchExaminations();
                        }
                    });
                    
                    // Update the existing pagination script to work with search
                    $(document).ready(function() {
                        const rowsPerPage = 4;
                        let rows = $('#examinationTable tbody tr.exam-row');
                        let rowsCount = rows.length;
                        let pageCount = Math.ceil(rowsCount / rowsPerPage);
                        const pagination = $('#pagination');
                        let currentPage = 1;
                        // Function to update pagination based on visible rows
                        function updatePagination() {
                            rows = $('#examinationTable tbody tr.exam-row:visible');
                            rowsCount = rows.length;
                            pageCount = Math.ceil(rowsCount / rowsPerPage);
                            
                            // Clear existing pagination
                            pagination.empty();
                            
                            // Generate pagination buttons
                            if (pageCount > 1) {
                                // Add Previous button
                                pagination.append('<li class="page-item disabled" id="prev-page"><span class="page-link">Previous</span></li>');
                                
                                // Add page numbers
                                for(let i = 1; i <= pageCount; i++) {
                                    pagination.append('<li class="page-item ' + (i === 1 ? 'active' : '') + '"><span class="page-link" data-page="' + i + '">' + i + '</span></li>');
                                }
                                
                                // Add Next button
                                pagination.append('<li class="page-item" id="next-page"><span class="page-link">Next</span></li>');
                            }
                            
                            showPage(1);
                        }
                        
                        // Update showPage function to work with visible rows only
                        function showPage(pageNum) {
                            const visibleRows = $('#examinationTable tbody tr.exam-row:visible');
                            const start = (pageNum - 1) * rowsPerPage;
                            const end = start + rowsPerPage;
                            
                            visibleRows.hide();
                            visibleRows.slice(start, end).show();
                            
                            // Update active state of pagination buttons
                            pagination.find('.page-item').removeClass('active');
                            pagination.find(`span[data-page="${pageNum}"]`).parent().addClass('active');
                            
                            // Update Previous/Next button states
                            $('#prev-page').toggleClass('disabled', pageNum === 1);
                            $('#next-page').toggleClass('disabled', pageNum === pageCount);
                            
                            // Store current page
                            currentPage = pageNum;
                        }
                        
                        // Initialize pagination
                        updatePagination();
                        
                        // Update pagination when search is performed
                        $('#searchInput').on('input', function() {
                            if (this.value === '') {
                                $('.exam-row').show();
                                updatePagination();
                                showPage(1);
                            }
                        });
                    });
                </script>
                
                <script>
                    function confirmDelete(examId) {
                        if (confirm('Are you sure you want to delete this medical examination?')) {
                            window.location.href = 'staff-exam?action=delete&id=' + examId;
                        }
                    }
                </script>
            </body>
            <jsp:include page="./common/common-homepage-footer.jsp"></jsp:include>
        </html>