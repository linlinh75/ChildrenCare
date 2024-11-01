<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Feedback</title>
        <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
        <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.5.2/dist/js/bootstrap.bundle.min.js"></script>

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

        <script>
            function sortTable(tableId, colIndex) {
                let table = document.getElementById(tableId);
                let rows = Array.from(table.getElementsByTagName('tr'));
                let header = rows.shift();
                let isAsc = table.getAttribute('data-order') === 'asc';

                rows.sort((row1, row2) => {
                    let cell1 = row1.getElementsByTagName('td')[colIndex].innerText.toLowerCase();
                    let cell2 = row2.getElementsByTagName('td')[colIndex].innerText.toLowerCase();
                    if (cell1 < cell2)
                        return isAsc ? -1 : 1;
                    if (cell1 > cell2)
                        return isAsc ? 1 : -1;
                    return 0;
                });

                table.setAttribute('data-order', isAsc ? 'desc' : 'asc');
                rows.unshift(header);
                table.innerHTML = '';
                rows.forEach(row => table.appendChild(row));
            }
            function searchFeedback() {
                let input = document.getElementById('searchInput');
                let filter = input.value.toLowerCase();
                let table = document.getElementById('feedbackTableBody');
                let rows = Array.from(table.getElementsByTagName('tr'));

                rows.forEach(row => {
                    let serviceCell = row.cells[1];
                    if (serviceCell && serviceCell.innerText.toLowerCase().includes(filter)) {
                        row.style.display = '';
                    } else {
                        row.style.display = 'none';
                    }
                });
            }

            let currentPage = 1;
            const rowsPerPage = 5;
            let feedbackRows = [];

            window.onload = () => {
                const table = document.getElementById('feedbackTableBody');
                const rows = table.getElementsByTagName('tr');
                feedbackRows = Array.from(rows);
                displayTable();
            };

            function displayTable() {
                let table = document.getElementById('feedbackTableBody');
                let totalRows = feedbackRows.length;

                for (let i = 0; i < table.children.length; i++) {
                    table.children[i].style.display = "none";
                }

                let startIndex = (currentPage - 1) * rowsPerPage;
                let endIndex = Math.min(startIndex + rowsPerPage, totalRows);

                for (let i = startIndex; i < endIndex; i++) {
                    feedbackRows[i].style.display = "";
                }

                createPagination(Math.ceil(totalRows / rowsPerPage), currentPage);
            }

            function createPagination(totalPages, currentPage) {
                let paginationStr = '<ul>';
                let active;

                if (currentPage > 1) {
                    paginationStr += '<li class="page-item previous"><a onclick="goToPage(' + (currentPage - 1) + ')">Previous</a></li>';
                }

                let maxVisiblePages = 6;
                let startPage = Math.max(1, currentPage - 2);
                let endPage = Math.min(totalPages, currentPage + 2);

                if (totalPages > maxVisiblePages) {
                    if (startPage > 1) {
                        paginationStr += '<li><a onclick="goToPage(1)">1</a></li>';
                        if (startPage > 2) {
                            paginationStr += '<li style="color: black; padding: 5px 10px;">...</li>';
                        }
                    }

                    for (let p = startPage; p <= endPage; p++) {
                        active = currentPage === p ? "active" : "";
                        paginationStr += '<li class="' + active + '"><a onclick="goToPage(' + p + ')">' + p + '</a></li>';
                    }

                    if (endPage < totalPages - 1) {
                        paginationStr += '<li style="color: black; padding: 5px 10px;">...</li>';
                    }

                    if (endPage < totalPages) {
                        paginationStr += '<li><a onclick="goToPage(' + totalPages + ')">' + totalPages + '</a></li>';
                    }
                } else {
                    for (let p = 1; p <= totalPages; p++) {
                        active = currentPage === p ? "active" : "";
                        paginationStr += '<li class="' + active + '"><a onclick="goToPage(' + p + ')">' + p + '</a></li>';
                    }
                }

                if (currentPage < totalPages) {
                    paginationStr += '<li class="page-item next"><a onclick="goToPage(' + (currentPage + 1) + ')">Next</a></li>';
                }

                paginationStr += '</ul>';
                document.getElementById('pagination').innerHTML = paginationStr;
            }

            function goToPage(pageNumber) {
                currentPage = pageNumber;
                displayTable();
            }
        </script>
    </head>

    <jsp:include page="./common/common-homepage-header.jsp"></jsp:include>

        <body>
            <section class="container-fluid" style="width: 80%">
                <div class="bread_crumb">
                    <nav aria-label="breadcrumb">
                        <ol class="breadcrumb">
                            <li class="breadcrumb-item"><a href="HomeServlet">Home</a></li>
                            <li class="breadcrumb-item"><a href="ReservationServlet">My Reservation</a></li>
                            <li class="breadcrumb-item active" aria-current="page">My Feedback</li>
                        </ol>
                    </nav>
                </div>
                <div class="feedback-list">
                    <div class="table-container">
                        <div>
                            <ul class="nav nav-tabs">
                                <li class="nav-item">
                                    <a class="nav-link active" aria-current="page" href="#feedbackProvided" data-toggle="tab">Feedback Provided</a>
                                </li>
                                <li class="nav-item">
                                    <a class="nav-link" href="#noFeedback" data-toggle="tab">No Feedback</a>
                                </li>
                            </ul>
                        </div>
                        <div class="tab-content">
                            <!-- Tab Feedback Provided -->
                            <div class="tab-pane fade show active table-container"  id="feedbackProvided">
                                <div class="table-header" style="margin-top: 30px;">
                                    <div class="table-header">
                                        <div class="search-box">
                                            <input type="text" placeholder="Search by service name" id="searchInput" onkeyup="searchFeedback()">
                                            <button type="button">
                                                <i class="fa fa-search"></i>
                                            </button>
                                        </div>
                                    </div>
                                </div>

                                <table class="table .table-striped" id="feedbackTable" data-order="asc">
                                    <thead>
                                        <tr>
                                            <th onclick="sortTable('feedbackTable', 0)" style="cursor: pointer;">Reservation ID</th>
                                            <th onclick="sortTable('feedbackTable', 1)" style="cursor: pointer;">Service Name</th>
                                            <th onclick="sortTable('feedbackTable', 2)" style="cursor: pointer;">Feedback Time</th>
                                            <th onclick="sortTable('feedbackTable', 3)" style="cursor: pointer;">Content</th>
                                            <th onclick="sortTable('feedbackTable', 4)" style="cursor: pointer;">Rate</th>
                                            <th>Image</th>
                                        </tr>
                                    </thead>
                                    <tbody id="feedbackTableBody">
                                    <c:forEach var="feedback" items="${rated}">
                                        <c:if test="${feedback.getStatus() == 'Processed'}">
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
    </body>
</html>
