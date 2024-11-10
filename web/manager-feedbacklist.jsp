<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Feedback List</title>
        <!-- favicon -->
        <link rel="shortcut icon" href="img/favicon.png">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
        <style>
            .table-container {
                width: 100%;
                margin: auto;
                background-color: #f9f9f9;
                padding: 20px;
                border-radius: 8px;
                min-height: 600px;
            }

            .table-header {
                display: flex;
                justify-content: space-between;
                margin-bottom: 10px;
            }

            .search-box input {
                padding: 8px;
                border-radius: 4px;
                border: 1px solid #ccc;
                width: 250px;

            }

            .search-box button {
                padding: 8px;
                background-color: #0a58ca;
                border: none;
                border-radius: 4px;
                color: white;
            }

            .feedback-table {
                width: 100%;
                border-collapse: collapse;
            }

            .feedback-table th, .feedback-table td {
                text-align: left;
                padding: 12px;
                border-bottom: 1px solid #ddd;
            }

            .feedback-table th {
                background-color: #f2f2f2;
            }

            .actions button {
                margin-right: 10px;
                padding: 5px 10px;
                border: none;
                color: white;
                border-radius: 4px;
                width: 70px;
            }

            .btn-public {
                background-color: #28a745;
            }

            .btn-hidden {
                background-color: #ccc !important;
            }
            .btn-view {
                background-color: #0a58ca !important;
                color: white !important;
            }

            .btn-edit {
                background-color: #ffc107;
            }

            .btn-delete {
                background-color: #f44336;
            }

            * {
                font-family: 'Poppins';
            }

            a:hover {
                cursor: pointer;
            }

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

        </style>
    </head>
    <body>
        <div class="page-wrapper doctris-theme toggled">
            <jsp:include page="./common/admin/side_bar_admin.jsp"></jsp:include>
                <main class="page-content bg-light">
                <jsp:include page="./common/common-homepage-header.jsp"></jsp:include>
                    <section class="container-fluid" style="padding: 20px; margin-top: 30px; margin-bottom: 30px;">
                        <div class="bread_crumb">
                            <nav aria-label="breadcrumb">
                                <ol class="breadcrumb" style="background-color: white; box-shadow: 0 0 2px 2px rgba(128, 128, 128, 0.1);">
                                    <li class="breadcrumb-item"><a href="HomeServlet">Home</a></li>
                                    <li class="breadcrumb-item"><a href="./profile">Manager Dashboard</a></li>
                                    <li class="breadcrumb-item active" aria-current="page">Feedback List</li>
                                </ol>
                            </nav>
                        </div>
                        <a id="close-sidebar" class="btn btn-icon btn-pills btn-soft-primary ms-2" href="#" style="margin-bottom:20px">
                            <i class="uil uil-bars"></i>
                        </a>
                        <div class="feedback-list" style="background-color: white; box-shadow: 0 0 2px 2px rgba(128, 128, 128, 0.1);">
                            <div class="table-container" style="background-color: white;">
                                <div class="table-header">
                                    <div class="search-box" style="margin-bottom: 20px">
                                        <input type="text" placeholder="Search by customer name, content" id="searchInput" onkeyup="applyFilters()">
                                        <button type="button">
                                            <i class="fa fa-search"></i>
                                        </button>
                                    </div>
                                    <div class="status-filter" style="display: flex; gap: 10px">
                                        <div>Filter:</div>
                                        <select id="statusFilter" onchange="applyFilters()">
                                            <option value="" class="label">Status</option>
                                            <option value="all">All</option>
                                            <option value="Processed">Processed</option>
                                            <option value="Processing">Processing</option>
                                        </select>
                                        <select id="serviceFilter" onchange="applyFilters()">
                                            <option value="" class="label">Service</option>
                                            <option value="all">All Services</option>
                                        <c:forEach var="service" items="${service.getAllService()}">
                                            <option value="${service.getFullname().trim()}">${service.getFullname()}</option>
                                        </c:forEach>
                                    </select>
                                    <select id="starFilter" onchange="applyFilters()">
                                        <option value="all">All Stars</option>
                                        <c:forEach var="star" begin="0" end="5">
                                            <option value="${star}">${star}</option>
                                        </c:forEach>
                                    </select>
                                    <select id="displayStatusFilter" onchange="applyFilters()">
                                        <option value="" class="label">Display Status</option>
                                        <option value="all">All</option>
                                        <option value="Public">Public</option>
                                        <option value="Hidden">Hidden</option>
                                    </select>
                                </div>
                            </div>
                            <table class="feedback-table">
                                <thead>
                                    <tr>
                                        <th onclick="sortTable(0)">Feedback ID <i class="fa fa-sort"></i></th>
                                        <th onclick="sortTable(1)">Customer Name<i class="fa fa-sort"></i></th>
                                        <th onclick="sortTable(2)">Service Name</th>
                                        <th onclick="sortTable(3)">Rated Star</th>
                                        <th>Content</th>
                                        <th onclick="sortTable(5)">Status</th>
                                        <th onclick="sortTable(6)">Display Status</th>
                                        <th>Action</th>
                                    </tr>
                                </thead>
                                <tbody id="feedbackTableBody">
                                    <c:forEach var="feedback" items="${feedback}">
                                        <tr>
                                            <td>${feedback.getId()}</td>
                                            <td>${user.getProfileById(feedback.getUser_id()).getFullName()}</td>
                                            <td>${service.getServiceById(feedback.getService_id()).getFullname()}</td>
                                            <td>${feedback.getRated_star()}</td>
                                            <td>${feedback.getContent()}</td>
                                            <td>${feedback.getStatus()}</td>
                                            <td>${feedback.isIsPublic()?'Public':'Hidden'}</td>
                                            <td><a href="./managerFeedbackList?action=detail&&id=${feedback.getId()}" class="btn btn-view">View</a></td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                            <div id="pagination"></div>
                        </div>
                    </div>
                </section>


                <jsp:include page="./common/common-homepage-footer.jsp"></jsp:include>
            </main>
        </div>
    </body>
    <script>
        let currentPage = 1;
        const rowsPerPage = 5;
        let allRows = [];
        let filteredRows = [];

        function initializeTable() {
            const table = document.getElementById('feedbackTableBody');
            allRows = Array.from(table.getElementsByTagName('tr'));
            filteredRows = allRows;
            applyFilters();
        }

        function applyFilters() {
            const searchValue = document.getElementById('searchInput').value.toLowerCase().trim();
            const statusFilter = document.getElementById("statusFilter").value.toLowerCase();
            const serviceFilter = document.getElementById("serviceFilter").value.toLowerCase();
            const starFilter = document.getElementById("starFilter").value;
            const displayStatusFilter = document.getElementById("displayStatusFilter").value.toLowerCase();
            filteredRows = allRows.filter(row => {
                const cells = row.getElementsByTagName("td");
                const fullname = cells[1].innerText.toLowerCase();
                const serviceName = cells[2].innerText.toLowerCase();
                const ratedStar = cells[3].innerText;
                const status = cells[5].innerText.toLowerCase();
                const displayStatus = cells[6].innerText.toLowerCase();

                const isStarFilterMatch = starFilter === "all" ||
                        (ratedStar === starFilter || ratedStar === (parseInt(starFilter) * -1).toString());

                return (fullname.includes(searchValue) || cells[4].innerText.toLowerCase().includes(searchValue)) &&
                        (statusFilter === "all" || status.includes(statusFilter)) &&
                        (serviceFilter === "all" || serviceName.includes(serviceFilter)) &&
                        isStarFilterMatch &&
                        (displayStatusFilter === "all" || displayStatus.includes(displayStatusFilter));
            });

            currentPage = 1;
            displayTable();
        }



        function displayTable() {
            const table = document.getElementById('feedbackTableBody');
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

        function sortTable(columnIndex) {
            const table = document.getElementById("feedbackTableBody");
            const isAscending = table.dataset.sortOrder === "asc";
            filteredRows.sort((a, b) => {
                let aValue, bValue;
                if (columnIndex === 0 || columnIndex === 3) {
                    aValue = parseInt(a.cells[columnIndex].innerText);
                    bValue = parseInt(b.cells[columnIndex].innerText);
                    return isAscending ? aValue - bValue : bValue - aValue;
                } else if (columnIndex === 1 || columnIndex === 2 || columnIndex === 5 || columnIndex === 6) {
                    aValue = a.cells[columnIndex].innerText.toLowerCase();
                    bValue = b.cells[columnIndex].innerText.toLowerCase();
                    return isAscending ? aValue.localeCompare(bValue) : bValue.localeCompare(aValue);
                }
                return 0;
            });
            while (table.firstChild) {
                table.removeChild(table.firstChild);
            }
            filteredRows.forEach(row => table.appendChild(row));
            table.dataset.sortOrder = isAscending ? "desc" : "asc";
            displayTable();
        }

        window.onload = initializeTable;
    </script>
</html>