<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
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
        
    #medicalTable tr:nth-child(odd) {
        background-color: #f9f9f9; /* Light gray for odd rows */
    }

    #medicalTable tr:nth-child(even) {
        background-color: #ffffff; /* White for even rows */
    }
    th span {
    margin-left: 5px;
    font-size: 12px;
}
</style>
    </style>
    <body>
        <div class="page-wrapper doctris-theme toggled">
            <jsp:include page="./common/admin/side_bar_admin.jsp"></jsp:include>
                <main class="page-content bg-light">
                <jsp:include page="./common/common-homepage-header.jsp"></jsp:include>
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
                                    <th onclick="sortTable(0)" style="cursor: pointer;">No. <span id="sort-indicator-0"></span></th>
                                    <th onclick="sortTable(1)" style="cursor: pointer;">Patient Name <span id="sort-indicator-1"></span></th>
                                    <th onclick="sortTable(2)" style="cursor: pointer;">Gender <span id="sort-indicator-2"></span></th>
                                    <th onclick="sortTable(3)" style="cursor: pointer;">Email <span id="sort-indicator-3"></span></th>
                                    <th onclick="sortTable(4)" style="cursor: pointer;">Prescription <span id="sort-indicator-4"></span></th>
                                    <th>Actions</th>
                                </tr>
                            </thead>
                            <tbody id="medicalTable">
                                <c:forEach var="exam" items="${examinations}">
                                    <tr class="exam-row">
                                        <td>${exam.getId()}</td>

                                        <td>${exam.user.fullName}</td>
                                        <td>${exam.user.gender ? 'Male' : 'Female'}</td>
                                        <td>${exam.user.email}</td>
                                        <td>${exam.prescription}</td>
                                        <td>

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
        </body>


        <script>
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
        if (cellA < cellB) return isAscending ? -1 : 1;
        if (cellA > cellB) return isAscending ? 1 : -1;
        return 0;
    });

    // Clear and re-append sorted rows
    tbody.innerHTML = "";
    rows.forEach(row => tbody.appendChild(row));

    // Update sort indicators
    updateSortIndicators(columnIndex, isAscending, totalColumns);
}

function updateSortIndicators(columnIndex, isAscending, totalColumns) {
    // Reset all indicators
    for (let i = 0; i < totalColumns; i++) {
        const indicator = document.getElementById(`sort-indicator-${i}`);
//        if (indicator) indicator.innerHTML = "";
    }

    // Set the current column's indicator
    const currentIndicator = document.getElementById(`sort-indicator-${columnIndex}`);
    if (currentIndicator) {
        currentIndicator.innerHTML = isAscending ? "▲" : "▼";
    }
}

            let currentPage = 1;
            const rowsPerPage = 5;
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
            }
            function displayTable() {
                const table = document.getElementById('medicalTable');
                const totalRows = filteredRows.length;

                Array.from(table.children).forEach(row => row.style.display = "none");

                const startIndex = (currentPage - 1) * rowsPerPage;
                const endIndex = Math.min(startIndex + rowsPerPage, totalRows);

                for (let i = startIndex; i < endIndex; i++) {
                    if (filteredRows[i])
                        filteredRows[i].style.display = "";
                }

                createPagination(Math.ceil(totalRows / rowsPerPage), currentPage);
            }

            function createPagination(totalPages, currentPage) {
                let pagination = document.getElementById('pagination');
                let str = '<ul>';
                let active;

                if (currentPage > 1) {
                    str += '<li class="page-item previous no"><a onclick="goToPage(' + (currentPage - 1) + ')">Previous</a></li>';
                }

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