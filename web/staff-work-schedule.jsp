<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>My Work Schedule</title>
        <link rel="shortcut icon" href="img/favicon.png">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
        <script type="text/javascript" src="https://cdn.jsdelivr.net/jquery/latest/jquery.min.js"></script>
        <script type="text/javascript" src="https://cdn.jsdelivr.net/momentjs/latest/moment.min.js"></script>
        <script type="text/javascript" src="https://cdn.jsdelivr.net/npm/daterangepicker/daterangepicker.min.js" defer></script>
        <link rel="stylesheet" type="text/css" href="https://cdn.jsdelivr.net/npm/daterangepicker/daterangepicker.css" />
        <style>
            .table-container {
                width: 100%;
                margin: auto;
                background-color: #f9f9f9;
                padding: 20px;
                border-radius: 8px;
                min-height: 500px;
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
                table-layout: fixed;
            }

            .slider-table th, .slider-table td {
                text-align: left;
                padding: 12px;
                border-bottom: 1px solid #ddd;
            }

            .slider-table th {
                background-color: #f2f2f2;
            }

            .reservation-tabs {
                display: flex;
                justify-content: space-between;
                margin-bottom: 20px;
            }

            .tabs {
                display: flex;
                justify-content: space-around;
                border-bottom: 2px solid #f0f0f0;
                margin-bottom: 10px;
            }

            .tab-button {
                padding: 10px 20px;
                cursor: pointer;
                font-size: 16px;
                font-weight: 500;
                color: #666;
                text-decoration: none;
                border-bottom: 2px solid transparent;
                transition: color 0.3s ease, border-bottom 0.3s ease;
            }

            .tab-button.active {
                color: #e40d0d;
                border-bottom: 2px solid #e40d0d;
            }

            .tab-button:hover {
                color: #e40d0d;
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
            .nav-link.active {
                background-color: white !important;
                color: #0a58ca;
                font-weight: bold;
            }

            .nav-link {
                color: #666;
                transition: background-color 0.3s ease, color 0.3s ease;
            }

            .nav-link:hover {
                background-color: #f0f0f0;
                color: #0a58ca;
            }

            .nav-link.active:hover {
                background-color: white;
                color: #0a58ca;
            }

            .service-details {
                margin-top: 20px;
            }

            .service-price {
                font-weight: bold;
                color: #0a58ca;
            }

            .status-badge {
                padding: 5px 10px;
                border-radius: 4px;
                font-weight: bold;
            }

            .status-pending {
                color: orange;
            }
            .status-submit {
                color: blue;
            }
            .status-approved {
                color: green;
            }
            .status-success {
                color: #37F525;
            }
            .status-cancel {
                color: red;
            }

            .total-section {
                border-top: 2px solid #eee;
                padding-top: 20px;
            }

        </style>
        <!-- jQuery first -->
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
        <!-- Then Popper.js -->
        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"></script>
        <!-- Then Bootstrap CSS -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet">
        <!-- Then Bootstrap JS Bundle (includes Popper) -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
    </head>
    <body>
        <div class="page-wrapper doctris-theme toggled">
            <jsp:include page="./common/admin/side_bar_admin.jsp"></jsp:include>
                <main class="page-content bg-light">
                <jsp:include page="./common/common-homepage-header.jsp"></jsp:include>
                    <section class="container-fluid" style="padding: 20px; margin-top: 30px; margin-bottom: 30px">
                        <div class="bread_crumb">
                            <nav aria-label="breadcrumb">
                                <ol class="breadcrumb" style="background-color: white; box-shadow: 0 0 2px 2px rgba(128, 128, 128, 0.1);">
                                    <li class="breadcrumb-item"><a href="HomeServlet">Home</a></li>
                                    <li class="breadcrumb-item active" aria-current="page">My Work Schedule</li>
                                </ol>
                            </nav>
                        </div>
                        <a id="close-sidebar" class="btn btn-icon btn-pills btn-soft-primary ms-2" href="#" style="margin-bottom:20px">
                            <i class="uil uil-bars"></i>
                        </a>
                        <ul class="nav nav-pills nav-justified flex-column flex-sm-row rounded-0 shadow overflow-hidden bg-white mb-0" id="pills-tab" role="tablist">
                            <li class="nav-item">
                                <a class="nav-link rounded-0 active" id="overview-tab" data-bs-toggle="pill" href="#pills-overview" role="tab" aria-controls="pills-overview" aria-selected="false">
                                    <div class="text-center pt-1 pb-1">
                                        <h4 class="title fw-normal mb-0" style="height: 20px"></h4>
                                    </div>
                                </a><!--end nav link-->
                            </li><!--end nav item-->
                        </ul>
                        <div class="slider-list" style="background-color: white; padding: 10px;box-shadow: 0 0 2px 2px rgba(128, 128, 128, 0.1);">
                            <div class="table-container" style="background-color: white;">
                                <div class="table-header">
                                    <div class="search-box">
                                        <input type="text" placeholder="Search by first customer name" id="searchInput" onkeyup="applyFilters()">
                                        <button type="button">
                                            <i class="fa fa-search"></i>
                                        </button>
                                    </div>
                                    <div class="row">
                                        <div class="status-filter col" style="display: flex; gap: 10px" >
                                            Filter:
                                            <select id="serviceFilter" onchange="applyFilters()">
                                                <option value="" class="label">Service</option>
                                                <option value="all">All Services</option>
                                            <c:forEach var="service" items="${service.getAllManageService()}">
                                                <option value="${service.getFullname().trim()}">${service.getFullname()}</option>
                                            </c:forEach>

                                        </select>
                                        <input type="text" id="dateRangePicker" class="form-control" name="date" placeholder="Filter by Date">
                                    </div>
                                </div>
                            </div>
                            <table class="slider-table .table-striped">
                                <thead>
                                <th onclick="sortTable(0)">Reservation ID</th>
                                <th onclick="sortTable(1)">Customer Name</th> 
                                <th onclick="sortTable(2)">Time Start</th>
                                <th onclick="sortTable(3)">Time End</th>
                                <th onclick="sortTable(4)">List Service</th>
                                <th>Action</th>
                                </thead>
                                <tbody id="reservationTableBody">
                                    <c:forEach var="s" items="${schedule}">
                                        <tr style="cursor: pointer;" >
                                            <td>${s.getReservationId()}</td>
                                            <c:forEach var="user" items="${users}">
                                                <c:if test="${user.getId() == reservation.getReservationById(s.getReservationId()).getCustomer_id()}">
                                                    <td>${user.getFullName()}</td>
                                                </c:if>
                                            </c:forEach>
                                            <td>${s.getStartAt()}</td>
                                            <td>${s.getEndAt()}</td>
                                            <td>
                                                <c:forEach var="service" items="${reservation.getReservationById(s.getReservationId()).getList_service()}">
                                                    ${service.getService_name()}<br/>
                                                </c:forEach>
                                            </td>
                                            <td>
                                                <a href="staff-work-schedule?action=detail&rid=${s.getReservationId()}" class="btn btn-primary-sm">View Detail</a>
                                            </td>
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
        $(function () {
            const today = moment().startOf('day');
            const endOfDay = moment().endOf('day');

            $('input[name="date"]').daterangepicker({
                opens: 'left',
                startDate: today,
                endDate: endOfDay,
                autoUpdateInput: true,
            }, function (start, end, label) {
                let adjustedStart = start.startOf('day');
                let adjustedEnd = end.endOf('day');

                console.log("A new date selection was made: " + adjustedStart.format('YYYY-MM-DD HH:mm:ss') + ' to ' + adjustedEnd.format('YYYY-MM-DD HH:mm:ss'));

                $('input[name="date"]').val(adjustedStart.format('YYYY-MM-DD') + ' - ' + adjustedEnd.format('YYYY-MM-DD'));

                applyFilters(adjustedStart, adjustedEnd);
            });

            $('input[name="date"]').val(today.format('YYYY-MM-DD') + ' - ' + endOfDay.format('YYYY-MM-DD'));
        });
        function initializeTable() {
            const table = document.getElementById('reservationTableBody');
            allRows = Array.from(table.getElementsByTagName('tr'));
            filteredRows = allRows;
            applyFilters();
        }
        function applyFilters() {
            const searchValue = document.getElementById('searchInput').value.toLowerCase().trim();
            const serviceFilter = document.getElementById("serviceFilter").value.toLowerCase();
            const dateInput = document.getElementById('dateRangePicker').value;
            console.log(dateInput);
            let startDate = null, endDate = null;
            if (dateInput) {
                const dates = dateInput.split(' - ');
                startDate = new Date(dates[0]);
                endDate = new Date(dates[1]);
                startDate.setHours(0, 0, 0, 0);
                endDate.setHours(23, 59, 59, 999);
            }
            filteredRows = allRows.filter(row => {
                const cells = row.getElementsByTagName("td");
                const fullname = cells[1].innerText.toLowerCase();
                const serviceCell = cells[4].innerText.toLowerCase();
                const servicesList = serviceCell.split('\n');
                const serviceMatch = serviceFilter === "all" || servicesList.some(service => service.includes(serviceFilter));
                const checkupDateText = cells[2].innerText;
                const checkupDate = new Date(checkupDateText);
                 const dateCondition = (!startDate || checkupDate >= startDate) &&
                        (!endDate || checkupDate <= endDate);
                return (fullname.includes(searchValue) && serviceMatch&&dateCondition);
            });
            currentPage = 1;
            displayTable();
        }

        function displayTable() {
            const table = document.getElementById('reservationTableBody');
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
            const table = document.getElementById("reservationTableBody");
            const isAscending = table.dataset.sortOrder === "asc";

            filteredRows.sort((a, b) => {
                let aValue, bValue;

                if (columnIndex === 0) {
                    aValue = parseInt(a.cells[columnIndex].innerText);
                    bValue = parseInt(b.cells[columnIndex].innerText);
                    return isAscending ? aValue - bValue : bValue - aValue;
                } else if (columnIndex === 2 || columnIndex === 3) {
                    aValue = Date.parse(a.cells[columnIndex].innerText);
                    bValue = Date.parse(b.cells[columnIndex].innerText);
                    return isAscending ? aValue - bValue : bValue - aValue;
                } else if (columnIndex === 1 || columnIndex === 4) {
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
