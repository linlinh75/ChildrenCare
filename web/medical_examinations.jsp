<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>

        <link href="//maxcdn.bootstrapcdn.com/font-awesome/4.1.0/css/font-awesome.min.css" rel="stylesheet">
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Medical Examination</title>
    </head>
    <style>
        #pagination {
            display: flex;
            align-items: center;
            justify-content: center;
            flex-direction: column;
        }

        #pagination ul {
            list-style: none;
            padding: 0;
            margin: 0;
            display: flex;
        }

        #pagination ul li {
            color: #fff;
            display: flex;
        }

        #pagination ul li a {
            background-color: #fff;
            padding: 5px 10px;
            border: 2px solid #ccc;
            text-decoration: none;
            color: #333;
        }

        #pagination ul li a:hover {
            background-color: #333;
            color: #fff;
        }

        #pagination ul li.active a {
            background-color: #333 !important;
            border-color: #0a58ca;
            color: #fff;
        }
        .page-item a {
            text-decoration: none;
        }

        th span {
            margin-left: 5px;
            font-size: 12px;
        }
        tr:nth-child(even) {
            background-color: #f2f2f2;
        }
    </style>

    <body>
        <div class="page-wrapper doctris-theme toggled">
            <jsp:include page="./common/admin/side_bar_admin.jsp"></jsp:include>
                <main class="page-content bg-light">
                <jsp:include page="./common/common-homepage-header.jsp"></jsp:include>
                    <div class="container mt-5 ">
                    <c:if test="${param.success!=null }">
                        <div class="alert alert-success">
                            You have been added medical examination for reservation 
                        </div>
                    </c:if>
                    <c:if test="${param.error!=null}">
                        <div class="alert alert-danger">
                            ${param.error}
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
                                    <th onclick="sortTable(0)" style="cursor: pointer;">No. <span id="sort-indicator-0"><i class="fa fa-fw fa-sort"></i></span></th>
                                    <th onclick="sortTable(1)" style="cursor: pointer;">Patient Name <span id="sort-indicator-1"><i class="fa fa-fw fa-sort"></i></span></th>
                                    <th onclick="sortTable(2)" style="cursor: pointer;">Gender <span id="sort-indicator-2"><i class="fa fa-fw fa-sort"></i></span></th>
                                    <th onclick="sortTable(3)" style="cursor: pointer;">Email <span id="sort-indicator-3"><i class="fa fa-fw fa-sort"></i></span></th>
                                    <th onclick="sortTable(4)" style="cursor: pointer;">Prescription <span id="sort-indicator-4"><i class="fa fa-fw fa-sort"></i></span></th>
                                    <th onclick="sortTable(5)" style="cursor: pointer;">Create Date <span id="sort-indicator-5"><i class="fa fa-fw fa-sort"></i></span></th>
                                    <th>Medicines</th>
                                </tr>
                            </thead>
                            <tbody id="medicalTable">
                                <c:forEach var="exam" items="${examinations}" varStatus="status">
                                    <tr class="exam-row">
                                        <td class="row-number">${status.index + 1}</td>

                                        <td>${exam.user.fullName}</td>
                                        <td>${exam.user.gender ? 'Male' : 'Female'}</td>
                                        <td>${exam.user.email}</td>
                                        <td>${exam.prescription}</td>
                                        <td>${exam.date} </td>
                                        <td id="medi-${exam.id}" style="display: none;" type="hidden">${exam.medicines}</td>

                                        <td>
                                            <button 
                                                class="btn btn-danger"
                                                data-id="${exam.id}"
                                                data-patient-name="${exam.user.fullName}"
                                                data-prescription="${exam.prescription}"
                                                data-author-name="${exam.user.email}" 
                                                data-create-date="${exam.date}" 
                                                data-medicines='${exam.medicines}' 
                                                data-bs-toggle="modal"
                                                data-bs-target="#examinationDetailsModal">
                                                View Details
                                            </button>
                                            <input type="hidden" id="medicine-${exam.id}" value="${exam.medicines}"/>
                                        </td>

                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                        <div id="pagination"></div>
                    </div>
                </div>
                <jsp:include page="./common/common-homepage-footer.jsp"></jsp:include>            

            </main>
        </div>
        Modal 
        <div class="modal fade" id="examinationDetailsModal" tabindex="-1" aria-labelledby="examinationDetailsModalLabel" aria-hidden="true">
            <div class="modal-dialog modal-lg">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="examinationDetailsModalLabel">Examination Details</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        Examination details go here 
                        <table class="table table-striped">
                            <tbody>
                                <tr>
                                    <th>Patient Name:</th>
                                    <td id="patientName"></td>
                                </tr>
                                <tr>
                                    <th>Prescription:</th>
                                    <td id="prescription"></td>
                                </tr>
                                <tr>
                                    <th>Author Name:</th>
                                    <td id="authorName"></td>
                                </tr>
                                <tr>
                                    <th>Create Date:</th>
                                    <td id="createDate"></td>
                                </tr>
                            </tbody>
                        </table>
                        <h5 class="mt-4">Medicines</h5>
                        <table class="table table-bordered">
                            <thead>
                                <tr>
                                    <th>Medicine Name</th>
                                    <th>Dosage</th>
                                    <th>Instructions</th>
                                </tr>
                            </thead>
                            <tbody id="medicineDetails"></tbody>
                        </table>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                    </div>
                </div>
            </div>
        </div>

    </body>


    <script>
        document.getElementById('examinationDetailsModal').addEventListener('show.bs.modal', function (event) {
            // Nút được nhấn
            const button = event.relatedTarget;
            // Lấy dữ liệu từ các thuộc tính data-*
            const id = button.getAttribute('data-id');
            const patientName = button.getAttribute('data-patient-name');
            const prescription = button.getAttribute('data-prescription');
            const authorName = button.getAttribute('data-author-name');
            const createDate = button.getAttribute('data-create-date');
            const medi = document.getElementById('medi-'+id).textContent;
            const medicines = medi
                    .replace(/[\[\]]/g, "") // Loại bỏ dấu ngoặc vuông []
                    .split("},") // Tách từng đối tượng
                    .map(item => {
                        if (!item.endsWith("}"))
                            item += "}"; // Đảm bảo đối tượng kết thúc bằng }
                        const parsed = item.match(/(\w+)=['"]?([^,'"}]+)/g); // Tách key-value
                        return parsed.reduce((acc, pair) => {
                            const [key, value] = pair.split("=");
                            acc[key.trim()] = value.trim().replace(/^'|'$/g, ""); // Xóa dấu nháy
                            return acc;
                        }, {});
                    });
            document.getElementById('patientName').textContent = patientName;
            document.getElementById('prescription').textContent = prescription;
            document.getElementById('authorName').textContent = authorName;
            document.getElementById('createDate').textContent = createDate;
            console.log('Medicines:', medicines);
            console.log('Medicines Type:', Object.prototype.toString.call(medicines));
            const medicineDetailsTable = document.getElementById('medicineDetails');
            medicineDetailsTable.innerHTML = ''; // Xóa nội dung cũ
            medicines.forEach(medicine => {
                console.log("Medicine:", medicine);
                console.log("Medicine Name:", medicine.medicineName);
                // Tạo các phần tử HTML trực tiếp và gán giá trị vào các thẻ <td>
                const row = document.createElement('tr'); // Tạo một <tr> mới

                const tdName = document.createElement('td'); // Tạo thẻ <td> cho tên thuốc
                tdName.textContent = medicine.medicineName || 'N/A'; // Gán giá trị vào thẻ <td>
                row.appendChild(tdName); // Thêm thẻ <td> vào <tr>

                const tdDosage = document.createElement('td'); // Tạo thẻ <td> cho liều lượng
                tdDosage.textContent = medicine.dosage || 'N/A'; // Gán giá trị vào thẻ <td>
                row.appendChild(tdDosage); // Thêm thẻ <td> vào <tr>

                const tdInstructions = document.createElement('td'); // Tạo thẻ <td> cho hướng dẫn
                tdInstructions.textContent = medicine.instructions || 'N/A'; // Gán giá trị vào thẻ <td>
                row.appendChild(tdInstructions); // Thêm thẻ <td> vào <tr>

                medicineDetailsTable.appendChild(row); // Thêm <tr> vào bảng
            });
        });
        function updateRowNumbers() {
            const visibleRows = Array.from(document.querySelectorAll("#medicalTable tr")).filter(row => row.style.display !== "none");
            visibleRows.forEach((row, index) => {
                // Update the row number based on the visible order
                row.querySelector(".row-number").innerText = index + 1;
            });
        }
        function sortTable(columnIndex) {
            const table = document.getElementById("examinationTable");
            const tbody = table.getElementsByTagName("tbody")[0];
            const rows = Array.from(tbody.getElementsByTagName("tr"));
            const totalColumns = table.getElementsByTagName("thead")[0].getElementsByTagName("th").length;
            // Determine the current sort direction
            let isAscending = table.getAttribute("data-sort-dir") === "asc";
            table.setAttribute("data-sort-dir", isAscending ? "desc" : "asc");
            // Sort rows
            rows.sort((rowA, rowB) => {
                const cellA = rowA.getElementsByTagName("td")[columnIndex].innerText.toLowerCase();
                const cellB = rowB.getElementsByTagName("td")[columnIndex].innerText.toLowerCase();
                // Handle numeric columns
                if (!isNaN(cellA) && !isNaN(cellB)) {
                    return isAscending ? cellA - cellB : cellB - cellA;
                }

                // Handle text columns
                if (cellA < cellB)
                    return isAscending ? -1 : 1;
                if (cellA > cellB)
                    return isAscending ? 1 : -1;
                return 0;
            });
            // Clear and re-append sorted rows
            tbody.innerHTML = "";
            rows.forEach(row => tbody.appendChild(row));
            // Reapply the striped row styles and pagination

            displayTable(); // This ensures pagination and row display updates
            // Update sort indicators
            updateSortIndicators(columnIndex, isAscending, totalColumns);
        }

        function reapplyStripedRows() {
            const visibleRows = Array.from(document.querySelectorAll("#medicalTable tr")).filter(row => row.style.display !== "none");
            visibleRows.forEach((row, index) => {
                // Apply alternating background colors
                if (index % 2 === 0) {
                    row.style.backgroundColor = "#f9f9f9"; // Light gray for odd rows
                } else {
                    row.style.backgroundColor = "#ffffff"; // White for even rows
                }
            });
        }

        function updateSortIndicators(columnIndex, isAscending, totalColumns) {
            // Get all table headers
            const headers = document.querySelectorAll("#examinationTable thead th");
            headers.forEach(header => {
                const span = header.querySelector("span");
                if (span)
                    span.innerHTML = "<i class='fa fa-fw fa-sort'></i>"; // Clear existing indicator
            });
            // Set the indicator for the current column
            const currentHeader = headers[columnIndex];
            if (currentHeader) {
                const currentSpan = currentHeader.querySelector("span");
                if (currentSpan) {
                    currentSpan.innerHTML = isAscending ? "<i class='fa fa-arrow-up'></i>" : "<i class='fa fa-arrow-down'></i>"; // Add ascending or descending arrow
                }
            }
        }

        let currentPage = 1;
        const rowsPerPage = 10;
        let allRows = [];
        let filteredRows = [];
        function initializeTable() {
            const table = document.getElementById('medicalTable');
            allRows = Array.from(table.getElementsByTagName('tr'));
            filteredRows = allRows;
            applyFilters();
        }

        function applyFilters() {
            const searchValue = document.getElementById('searchInput').value.toLowerCase().trim();
            filteredRows = allRows.filter(row => {
                const cells = row.getElementsByTagName("td");
                const fullname = cells[1].innerText.toLowerCase();
                return fullname.includes(searchValue);
            });
            currentPage = 1;
            displayTable();
            updateRowNumbers();
        }

        function displayTable() {
            const table = document.getElementById('medicalTable');
            const totalRows = filteredRows.length;
            // Hide all rows initially
            Array.from(table.children).forEach(row => row.style.display = "none");
            // Determine the range of rows for the current page
            const startIndex = (currentPage - 1) * rowsPerPage;
            const endIndex = Math.min(startIndex + rowsPerPage, totalRows);
            // Display the rows for the current page
            for (let i = startIndex; i < endIndex; i++) {
                if (filteredRows[i]) {
                    filteredRows[i].style.display = "";
                }
            }

            // Reapply striped row styling for the current page
            reapplyStripedRows();
            // Create pagination
            createPagination(Math.ceil(totalRows / rowsPerPage), currentPage);
            updateRowNumbers();
        }

        function createPagination(totalPages, currentPage) {
            let pagination = document.getElementById('pagination');
            let str = '<ul>';
            let active;
            // Previous Page Button
            if (currentPage > 1) {
                str += '<li class="page-item previous no"><a onclick="goToPage(' + (currentPage - 1) + ')">Previous</a></li>';
            }

            // Page Numbers
            let maxVisiblePages = 6;
            let startPage = Math.max(1, currentPage - 2);
            let endPage = Math.min(totalPages, currentPage + 2);
            if (totalPages > maxVisiblePages) {
                if (startPage > 1) {
                    str += '<li class="no"><a onclick="goToPage(1)">1</a></li>';
                    if (startPage > 2) {
                        str += '<li class="no" style="color: black; padding: 5px 10px;border: 2px solid #ccc;">...</li>';
                    }
                }

                for (let p = startPage; p <= endPage; p++) {
                    active = currentPage === p ? "active" : "no";
                    str += '<li class="' + active + '"><a onclick="goToPage(' + p + ')">' + p + '</a></li>';
                }

                if (endPage < totalPages - 1) {
                    str += '<li class="no" style="color: black; padding: 5px 10px;border: 2px solid #ccc;">...</li>';
                }
                if (endPage < totalPages) {
                    str += '<li class="no"><a onclick="goToPage(' + totalPages + ')">' + totalPages + '</a></li>';
                }
            } else {
                for (let p = 1; p <= totalPages; p++) {
                    active = currentPage === p ? "active" : "no";
                    str += '<li class="' + active + '"><a onclick="goToPage(' + p + ')">' + p + '</a></li>';
                }
            }

            // Next Page Button
            if (currentPage < totalPages) {
                str += '<li class="page-item next no"><a onclick="goToPage(' + (currentPage + 1) + ')">Next</a></li>';
            }
            str += '</ul>';
            pagination.innerHTML = str;
        }

        function goToPage(pageNumber) {
            currentPage = pageNumber;
            displayTable();
        }

        window.onload = initializeTable;

    </script>

</html>
