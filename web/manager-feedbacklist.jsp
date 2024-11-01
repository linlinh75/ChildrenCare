<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Feedback List</title>
    <style>
        .table-container {
                width: 100%;
                margin: auto;
                background-color: #f9f9f9;
                padding: 20px;
                border-radius: 8px;
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

            .slider-table {
                width: 100%;
                border-collapse: collapse;
            }

            .slider-table th, .slider-table td {
                text-align: left;
                padding: 12px;
                border-bottom: 1px solid #ddd;
            }

            .slider-table th {
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
<jsp:include page="./common/common-homepage-header.jsp"></jsp:include>
<body>
<section class="container-fluid" style="width: 80%">
    <div class="bread_crumb">
        <nav aria-label="breadcrumb">
            <ol class="breadcrumb">
                <li class="breadcrumb-item"><a href="HomeServlet">Home</a></li>
                <li class="breadcrumb-item"><a href="./profile">Profile</a></li>
                <li class="breadcrumb-item active" aria-current="page">Feedback List</li>
            </ol>
        </nav>
    </div>
    <div class="feedback-list">
        <div class="table-container">
            <div class="table-header">
                <div class="search-box">
                    <input type="text" placeholder="Search by customer name, content" id="searchInput" onkeyup="applyFilters()">
                    <button type="button">
                        <i class="fa fa-search"></i>
                    </button>
                </div>
                <div class="status-filter" style="display: flex">
                    <div>Filter by status:</div>
                    <select id="statusFilter" onchange="applyFilters()">
                        <option value="all">All</option>
                        <option value="Public">Public</option>
                        <option value="Hidden">Hidden</option>
                        <option value="Processing">Processing</option>
                    </select>
                    <div>Service Name:</div>
                    <select id="serviceFilter" onchange="applyFilters()">
                        <option value="all">All Services</option>
                        <c:forEach var="service" items="${service.getAllService()}">
                            <option value="${service.getFullname()}">${service.getFullname()}</option>
                        </c:forEach>
                    </select>
                    <div>Rated Star:</div>
                    <select id="starFilter" onchange="applyFilters()">
                        <option value="all">All Stars</option>
                        <c:forEach var="star" begin="0" end="5">
                            <option value="${star}">${star}</option>
                        </c:forEach>
                    </select>
                </div>
            </div>
            <table class="feedback-table table .table-striped">
                <thead>
                <tr>
                    <th onclick="sortTable(0)">Feedback ID <i class="fa fa-sort"></i></th>
                    <th onclick="sortTable(1)">Customer Name<i class="fa fa-sort"></i></th>
                    <th onclick="sortTable(2)">Service Name</th>
                    <th onclick="sortTable(3)">Rated Star</th>
                    <th>Content</th>
                    <th onclick="sortTable(5)">Status</th>
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
                        <td>${feedback.getStatus() == 'Processing' ? "Processing" : (feedback.getRated_star() <= 0 ? "Hidden" : "Public")}</td>
                        <td><a href="#" class="btn btn-view">View</a></td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
            <div id="pagination"></div>
        </div>
    </div>
</section>
</body>
<jsp:include page="./common/common-homepage-footer.jsp"></jsp:include>

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

        filteredRows = allRows.filter(row => {
            const cells = row.getElementsByTagName("td");
            const fullname = cells[1].innerText.toLowerCase();
            const serviceName = cells[2].innerText.toLowerCase();
            const ratedStar = cells[3].innerText;
            const status = cells[5].innerText.toLowerCase();

            return (fullname.includes(searchValue) || cells[4].innerText.toLowerCase().includes(searchValue)) &&
                   (statusFilter === "all" || status.includes(statusFilter)) &&
                   (serviceFilter === "all" || serviceName.includes(serviceFilter)) &&
                   (starFilter === "all" || ratedStar === starFilter);
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
            if (filteredRows[i]) filteredRows[i].style.display = "";
        }

        createPagination(Math.ceil(totalRows / rowsPerPage), currentPage);
    }

    function createPagination(totalPages, currentPage) {
        let pagination = document.getElementById('pagination');
        let str = '<ul>';

        if (currentPage > 1) str += `<li><a onclick="goToPage(${currentPage - 1})">Previous</a></li>`;

        for (let p = 1; p <= totalPages; p++) {
            const active = currentPage === p ? "active" : "";
            str += `<li class="${active}"><a onclick="goToPage(${p})">${p}</a></li>`;
        }

        if (currentPage < totalPages) str += `<li><a onclick="goToPage(${currentPage + 1})">Next</a></li>`;
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
                if (columnIndex === 0 ||columnIndex === 3) {
                    aValue = parseInt(a.cells[columnIndex].innerText);
                    bValue = parseInt(b.cells[columnIndex].innerText);
                    return isAscending ? aValue - bValue : bValue - aValue;
                } else if (columnIndex === 1 || columnIndex === 2 || columnIndex === 5) {
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