<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Feedback</title>
        <!-- favicon -->
        <link rel="shortcut icon" href="img/favicon.png">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
        <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
        <!-- Tải jQuery -->

        <script type="text/javascript" src="https://cdn.jsdelivr.net/jquery/latest/jquery.min.js"></script>
        <script type="text/javascript" src="https://cdn.jsdelivr.net/momentjs/latest/moment.min.js"></script>
        <script type="text/javascript" src="https://cdn.jsdelivr.net/npm/daterangepicker/daterangepicker.min.js" defer></script>
        <link rel="stylesheet" type="text/css" href="https://cdn.jsdelivr.net/npm/daterangepicker/daterangepicker.css" />

        <!-- Bootstrap JS -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.5.2/dist/js/bootstrap.bundle.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.9.0/js/bootstrap-datepicker.min.js"></script>

        <style>
            #noFeedback, #feedbackProvided {
                min-height: 300px;
            }
            th{
                background-color: #f2f2f2;
            }
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
            .no-feedback-message {
                text-align: center;
                font-size: 20px;
                color: #666;
                margin-top: 20px;
                align-items: center;
                margin-bottom: 20px;
            }
        </style>


    </head>

    <div class="page-wrapper doctris-theme toggled">
        <jsp:include page="./common/admin/side_bar_admin.jsp"></jsp:include>
            <main class="page-content bg-light">
            <jsp:include page="./common/common-homepage-header.jsp"></jsp:include>
                <section class="container-fluid" style="padding: 20px; margin-top: 30px; margin-bottom: 30px;">
                    <div class="bread_crumb">
                        <nav aria-label="breadcrumb">
                            <ol class="breadcrumb">
                                <li class="breadcrumb-item"><a href="HomeServlet">Home</a></li>
                                <li class="breadcrumb-item"><a href="ReservationServlet">My Reservation</a></li>
                                <li class="breadcrumb-item active" aria-current="page">My Feedback</li>
                            </ol>
                        </nav>
                    </div>
                    <a id="close-sidebar" class="btn btn-icon btn-pills btn-soft-primary ms-2" href="#" style="margin-bottom:20px">
                        <i class="uil uil-bars"></i>
                    </a>
                    <div class="feedback-list" style="background-color: white; box-shadow: 0 0 2px 2px rgba(128, 128, 128, 0.1);">
                        <div class="table-container" style="background-color: white;">
                            <div>
                                <ul class="nav nav-tabs">
                                    <li class="nav-item">
                                        <a class="nav-link active" aria-current="page" href="#feedbackProvided" data-toggle="tab">Feedback Provided</a>
                                    </li>
                                    <li class="nav-item">
                                        <a class="nav-link" href="#noFeedback" data-toggle="tab" style="position: relative;">
                                            No Feedback
                                        <c:if test="${!empty unrated}">
                                            <span class="feedback-count" style="position: absolute; top: -5px; right: -5px; background-color: red; color: white; border-radius: 50%; width: 20px; height: 20px; font-size: 12px; font-weight: bold; text-align: center; display: flex; justify-content: center; align-items: center;">
                                                ${unrated.size()}
                                            </span>
                                        </c:if>

                                    </a>
                                </li>
                            </ul>
                        </div>
                        <div class="tab-content">
                            <!-- Tab Feedback Provided -->
                            <div class="tab-pane fade show active table-container"  id="feedbackProvided">
                                <div class="table-header" style="margin-top: 30px;">
                                    <div class="search-box">
                                        <input type="text" placeholder="Search by service name" id="searchInput" onkeyup="applyFilters()">
                                        <button type="button">
                                            <i class="fa fa-search"></i>
                                        </button>
                                    </div>
                                    <div class="status-filter" style="display: flex; gap: 10px">
                                        <div>Filter:</div>
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
                                        <input type="text" id="dateRangePicker" class="form-control" name="date" placeholder="Filter by Date">
                                    </div>
                                </div>

                                <table class="slider-table" id="feedbackTable" data-order="asc">
                                    <thead>
                                        <tr>
                                            <th onclick="sortTable(0)" style="cursor: pointer;">Reservation ID</th>
                                            <th onclick="sortTable(1)" style="cursor: pointer;">Service Name</th>
                                            <th onclick="sortTable(2)" style="cursor: pointer;">Feedback Time</th>
                                            <th onclick="sortTable(3)" style="cursor: pointer;">Content</th>
                                            <th onclick="sortTable(4)" style="cursor: pointer;">Rate</th>
                                            <th>Image</th>
                                        </tr>
                                    </thead>
                                    <tbody id="feedbackTableBody">
                                        <c:forEach var="feedback" items="${rated}">
                                            <c:if test="${feedback.getStatus() == 'Processed'&&feedback.getRated_star()!=0}">
                                                <tr>
                                                    <td>${feedback.getReservation_id()}</td>
                                                    <td>${service.getServiceById(feedback.getService_id()).getFullname()}</td>
                                                    <td>${feedback.getFeedback_time()}</td>
                                                    <td>${feedback.getContent()}</td>
                                                    <td>${feedback.getRated_star()}</td>
                                                    <td><img src="${feedback.getImage_link()}" alt="#" class="img-fluid" style="max-width: 100px;"/></td>
                                                </tr>
                                            </c:if>
                                        </c:forEach>
                                    </tbody>
                                </table>
                                <div id="pagination"></div>
                            </div>
                            <!-- Tab No Feedback -->
                            <div class="tab-pane fade" id="noFeedback">
                                <div style="display: flex; flex-direction: column; justify-content: center; margin-top:50px">
                                    <c:if test="${empty unrated}">
                                        <div class="no-feedback-message">No reservation needs feedback now</div>
                                        <img src="./assets/images/feedback.png" style="width: 200px; height: 200px; margin: 0 auto;" alt="alt"/>
                                    </c:if>
                                </div>
                                <c:forEach var="unrate" items="${unrated}">
                                    <div class="card mb-3">
                                        <div class="card-body">
                                            <h5 class="card-title">Reservation ID: ${unrate.getId()}</h5>
                                            <h6 class="card-subtitle mb-2 text-muted">Checkup Time: ${unrate.getCheckup_time()}</h6>
                                            <table class="table">
                                                <thead>
                                                    <tr>
                                                        <th>Service Name</th>
                                                        <th>Quantity</th>
                                                        <th>Unit Price</th>
                                                        <th>Total Price</th>
                                                    </tr>
                                                </thead>
                                                <tbody>
                                                    <c:set var="totalPrice" value="0" />
                                                    <c:forEach var="service" items="${unrate.getList_service()}">
                                                        <tr>
                                                            <td>${service.getService_name()}</td>
                                                            <td>${service.getQuantity()}</td>
                                                            <td>${service.getUnit_price()}</td>
                                                            <td>${service.getQuantity() * service.getUnit_price()}</td>
                                                            <c:set var="totalPrice" value="${totalPrice + service.getQuantity() * service.getUnit_price()}" />
                                                        </tr>
                                                    </c:forEach>
                                                </tbody>
                                            </table>
                                            <h5>Total Price: ${totalPrice}</h5>
                                            <a href="customer-feedback?reservationId=${unrate.getId()}&&action=provide" class="btn btn-primary">Give Feedback</a>
                                        </div>
                                    </div>
                                </c:forEach>
                            </div>
                        </div>
                    </div>
                </div>
            </section>
            <!-- Include footer -->
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
        $('input[name="date"]').daterangepicker({
            opens: 'left',
            maxDate: moment(),
            autoUpdateInput: false
        }, function (start, end, label) {
            // Chuyển start về đầu ngày và end đến cuối ngày
            let adjustedStart = start.startOf('day');
            let adjustedEnd = end.endOf('day');

            console.log("A new date selection was made: " + adjustedStart.format('YYYY-MM-DD HH:mm:ss') + ' to ' + adjustedEnd.format('YYYY-MM-DD HH:mm:ss'));

            $('input[name="date"]').val(adjustedStart.format('YYYY-MM-DD') + ' - ' + adjustedEnd.format('YYYY-MM-DD'));  // Cập nhật input khi chọn ngày
            applyFilters(adjustedStart, adjustedEnd);
        });
    });

    function initializeTable() {
        const table = document.getElementById('feedbackTableBody');
        allRows = Array.from(table.getElementsByTagName('tr'));
        filteredRows = allRows;
        applyFilters();
    }

    function applyFilters(startDate = null, endDate = null) {
        const searchValue = document.getElementById('searchInput').value.toLowerCase().trim();
        const serviceFilter = document.getElementById("serviceFilter").value.toLowerCase();
        const starFilter = document.getElementById("starFilter").value;

        filteredRows = allRows.filter(row => {
            const cells = row.getElementsByTagName("td");

            const reservationId = cells[0].innerText.toLowerCase();
            const serviceName = cells[1].innerText.toLowerCase();
            const feedbackDateText = cells[2].innerText;
            const ratedStar = cells[4].innerText;

            const feedbackDate = new Date(feedbackDateText);

            const searchCondition = !searchValue || serviceName.includes(searchValue);
            const serviceCondition = (serviceFilter === "all" || serviceName.includes(serviceFilter));
            const starCondition = (starFilter === "all" || ratedStar === starFilter);
            const dateCondition = (!startDate || feedbackDate >= startDate) &&
                    (!endDate || feedbackDate <= endDate);

            return searchCondition && serviceCondition && starCondition && dateCondition;
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
            if (columnIndex === 0 || columnIndex === 4) {
                aValue = parseInt(a.cells[columnIndex].innerText);
                bValue = parseInt(b.cells[columnIndex].innerText);
                return isAscending ? aValue - bValue : bValue - aValue;
            } else if (columnIndex === 2) {
                aValue = Date.parse(a.cells[columnIndex].innerText);
                bValue = Date.parse(b.cells[columnIndex].innerText);
                return isAscending ? aValue - bValue : bValue - aValue;
            } else if (columnIndex === 1 || columnIndex === 3) {
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
