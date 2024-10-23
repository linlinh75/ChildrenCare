<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>My Reservation</title>
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
<jsp:include page="./common/common-homepage-header.jsp"></jsp:include>
    <body>
        <section class="container-fluid" style="width: 80%">
            <div class="bread_crumb">
                <nav aria-label="breadcrumb">
                    <ol class="breadcrumb">
                        <li class="breadcrumb-item"><a href="HomeServlet">Home</a></li>
                        <li class="breadcrumb-item active" aria-current="page">My Reservation</li>
                    </ol>
                </nav>
            </div>
            <div class="slider-list">
                <div class="table-container">
                    <div class="table-header">
                        <div class="search-box">
                            <input type="text" placeholder="Search by first service name" id="searchInput" onkeyup="searchReservation()">
                            <button type="button">
                                <i class="fa fa-search"></i>
                            </button>
                        </div>
                        <div class="btn">
                            <a href="customer-feedback" type="button">My Feedback</a>
                        </div>
                    </div>

                    <!-- Tabs for filtering reservations -->
                    <ul class="nav nav-tabs reservation-tabs">
                        <li class="nav-item">
                            <a class="nav-link active" id="tab-all" href="javascript:void(0)" onclick="filterReservations('All')">All</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" id="tab-pending" href="javascript:void(0)" onclick="filterReservations('Pending')">Pending</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" id="tab-submitted" href="javascript:void(0)" onclick="filterReservations('Submitted')">Submitted</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" id="tab-approved" href="javascript:void(0)" onclick="filterReservations('Approved')">Approved</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" id="tab-success" href="javascript:void(0)" onclick="filterReservations('Success')">Success</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" id="tab-cancel" href="javascript:void(0)" onclick="filterReservations('Cancel')">Cancel</a>
                        </li>
                    </ul>



                    <table class="slider-table .table-striped">
                        <thead>
                        <th onclick="sortTableByField('reservationId')">Reservation ID</th>
                        <th onclick="sortTableByField('reservationDate')">Reservation Date</th>
                        <th onclick="sortTableByField('firstService')">First Service</th>
                        <th onclick="sortTableByField('checkupTime')">Checkup Time</th>
                        <th>Status</th>
                        <th onclick="sortTableByField('totalCost')">Total Cost</th>
                        <th>Action</th>
                        </thead>
                        <tbody id="reservationTableBody">
                        <c:forEach var="res" items="${reservation}">
                            <tr style="cursor: pointer;" onclick="window.location.href = './ReservationServlet?action=information&id=${res.getId()}'">
                                <td>${res.getId()}</td>
                                <td>${res.getReservation_date()}</td>
                                <td>${res.getList_service().get(0).getService_name()}</td>
                                <td>${res.getCheckup_time()}</td>
                                <td  style="font-weight: bold">
                                    <c:choose>
                                        <c:when test="${res.status == 'Pending'}">
                                            <span style="color: orange;">Pending</span>
                                        </c:when>
                                        <c:when test="${res.status == 'Submit'}">
                                            <span style="color: blue;">Submitted</span>
                                        </c:when>
                                        <c:when test="${res.status == 'Approved'}">
                                            <span style="color: green;">Approved</span>
                                        </c:when>
                                        <c:when test="${res.status == 'Success'}">
                                            <span style="color: #37F525;">Success</span>
                                        </c:when>
                                        <c:when test="${res.status == 'Cancel'}">
                                            <span style="color: red;">Cancel</span>
                                        </c:when>
                                        <c:otherwise>
                                            <span>${res.getStatus()}</span>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                                <td>
                                    <c:set var="totalCost" value="0" />
                                    <c:forEach var="service" items="${res.getList_service()}">
                                        <c:set var="itemCost" value="${service.getQuantity() * service.getUnit_price()}" />
                                        <c:set var="totalCost" value="${totalCost + itemCost}" />
                                    </c:forEach>
                                    <c:out value="${totalCost}" />
                                </td>
                                <td>
                                    <button type="button" 
                                            class="btn btn-primary btn-sm" 
                                            onclick="event.stopPropagation(); viewReservationDetails(${res.getId()})" 
                                            data-bs-toggle="modal" 
                                            data-bs-target="#reservationModal">
                                        View Details
                                    </button>
                                </td>
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
    <!-- Bootstrap Modal -->
    <!-- Update your modal HTML -->
    <div class="modal fade" id="reservationModal" tabindex="-1" data-bs-backdrop="static" aria-labelledby="modalLabel" aria-hidden="true">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="modalLabel">Reservation Details</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body" id="modalContent">
                    <div class="spinner-border text-primary" role="status">
                        <span class="visually-hidden">Loading...</span>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                </div>
            </div>
        </div>
    </div>
    <!-- JavaScript for filtering reservations -->
    <script>
        let currentPage = 1;
        const rowsPerPage = 5;
        let filteredRows = [];

        // Search reservation by first service name
        function searchReservation() {
            let input, filter, table, tr, td, i, txtValue;
            input = document.getElementById('searchInput');
            filter = input.value.toLowerCase().trim();
            table = document.getElementById('reservationTableBody');
            tr = table.getElementsByTagName('tr');

            if (filter === "") {
                currentPage = 1;
                filteredRows = Array.from(tr);
            } else {
                filteredRows = [];
                for (i = 0; i < tr.length; i++) {
                    td = tr[i].getElementsByTagName('td')[2];
                    if (td) {
                        txtValue = td.textContent || td.innerText;
                        if (txtValue.toLowerCase().includes(filter)) {
                            tr[i].style.display = "";
                            filteredRows.push(tr[i]);
                        } else {
                            tr[i].style.display = "none";
                        }
                    }
                }
            }
            displayTable();
        }

        // Filter reservations by status
        function filterReservations(status) {
            let table, tr, td, i;
            table = document.getElementById('reservationTableBody');
            tr = table.getElementsByTagName('tr');

            filteredRows = [];
            for (i = 0; i < tr.length; i++) {
                td = tr[i].getElementsByTagName('td')[4];
                if (td) {
                    if (status === 'All' || td.textContent.includes(status)) {
                        tr[i].style.display = "";
                        filteredRows.push(tr[i]);
                    } else {
                        tr[i].style.display = "none";
                    }
                }
            }

            currentPage = 1;
            displayTable();

            let tabs = document.querySelectorAll('.nav-link');
            tabs.forEach(tab => {
                tab.classList.remove('active');
            });

            document.getElementById(`tab-${status.toLowerCase()}`).classList.add('active');
        }



        // Display the table with pagination
        function displayTable() {
            let table = document.getElementById('reservationTableBody');
            let totalRows = filteredRows.length;

            for (let i = 0; i < table.children.length; i++) {
                table.children[i].style.display = "none";
            }

            let startIndex = (currentPage - 1) * rowsPerPage;
            let endIndex = Math.min(startIndex + rowsPerPage, totalRows);

            for (let i = startIndex; i < endIndex; i++) {
                if (filteredRows[i]) {
                    filteredRows[i].style.display = "";
                }
            }
            createPagination(Math.ceil(totalRows / rowsPerPage), currentPage);
        }

        // Create pagination
        function createPagination(totalPages, currentPage) {
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

            document.getElementById('pagination').innerHTML = str;
        }

        function goToPage(pageNumber) {
            currentPage = pageNumber;
            displayTable();
        }

        window.onload = () => {
            const table = document.getElementById('reservationTableBody');
            const rows = table.getElementsByTagName('tr');
            filteredRows = Array.from(rows);
            displayTable();
        };
        let sortOrder = {
            reservationId: 'asc',
            reservationDate: 'asc',
            firstService: 'asc',
            checkupTime: 'asc',
            totalCost: 'asc'
        };

        function sortTableByField(field) {
            let table, rows, switching, i, x, y, shouldSwitch, direction, switchcount = 0;
            table = document.getElementById("reservationTableBody");
            switching = true;
            direction = sortOrder[field];

            sortOrder[field] = (sortOrder[field] === 'asc') ? 'desc' : 'asc';

            while (switching) {
                switching = false;
                rows = table.getElementsByTagName("tr");

                for (i = 0; i < (rows.length - 1); i++) {
                    shouldSwitch = false;

                    if (field === 'reservationId') {
                        x = rows[i].getElementsByTagName("td")[0];  //Reservation ID
                        y = rows[i + 1].getElementsByTagName("td")[0];
                    } else if (field === 'reservationDate') {
                        x = rows[i].getElementsByTagName("td")[1];  //Reservation Date
                        y = rows[i + 1].getElementsByTagName("td")[1];
                    } else if (field === 'firstService') {
                        x = rows[i].getElementsByTagName("td")[2];  //First Service
                        y = rows[i + 1].getElementsByTagName("td")[2];
                    } else if (field === 'checkupTime') {
                        x = rows[i].getElementsByTagName("td")[3];  //Checkup Time
                        y = rows[i + 1].getElementsByTagName("td")[3];
                    } else if (field === 'totalCost') {
                        x = rows[i].getElementsByTagName("td")[5];  //Total Cost
                        y = rows[i + 1].getElementsByTagName("td")[5];
                    }

                    let comparison = 0;
                    if (field === 'reservationDate' || field === 'checkupTime') {
                        comparison = new Date(x.innerHTML) - new Date(y.innerHTML);
                    } else if (field === 'totalCost' || field === 'reservationId') {
                        comparison = Number(x.innerHTML) - Number(y.innerHTML);
                    } else {
                        comparison = x.innerHTML.toLowerCase().localeCompare(y.innerHTML.toLowerCase());
                    }

                    if (comparison === 0) {
                        let idX = rows[i].getElementsByTagName("td")[0];
                        let idY = rows[i + 1].getElementsByTagName("td")[0];
                        comparison = Number(idX.innerHTML) - Number(idY.innerHTML);
                    }

                    if (direction === 'asc' && comparison > 0) {
                        shouldSwitch = true;
                        break;
                    } else if (direction === 'desc' && comparison < 0) {
                        shouldSwitch = true;
                        break;
                    }
                }

                if (shouldSwitch) {
                    rows[i].parentNode.insertBefore(rows[i + 1], rows[i]);
                    switching = true;
                    switchcount++;
                } else {
                    if (switchcount === 0 && direction === 'asc') {
                        direction = 'desc';
                        switching = true;
                    }
                }
            }
        }

</script>
<script>
    // Add this after your modal HTML
    document.getElementById('reservationModal').addEventListener('hidden.bs.modal', function () {
        document.body.classList.remove('modal-open');
        document.querySelector('.modal-backdrop').remove();
    });

    // Update your viewReservationDetails function
    function viewReservationDetails(reservationId) {
        event.preventDefault();
        event.stopPropagation();

        const modalContent = document.getElementById("modalContent");
        modalContent.innerHTML = `
    <div class="text-center">
        <div class="spinner-border text-primary" role="status">
            <span class="visually-hidden">Loading...</span>
        </div>
    </div>`;

        const modal = new bootstrap.Modal(document.getElementById('reservationModal'));
        modal.show();

        $.ajax({
            url: 'ReservationServlet',
            type: 'POST',
            data: {
                action: 'getDetails',
                id: reservationId
            },
            success: function (response) {
                modalContent.innerHTML = response;
            },
            error: function (xhr, status, error) {
                modalContent.innerHTML = `
            <div class="alert alert-danger" role="alert">
                Error loading reservation details. Please try again later.
            </div>`;
            }
        });
    }
    function cancelReservation(reservationId) {
        if (!confirm("Are you sure you want to cancel this appointment?")) {
            return;
        }
        
        $.ajax({
            url: 'ReservationServlet',
            type: 'POST',
            data: {
                action: 'cancelReservation',
                id: reservationId
            },
            success: function(response) {
                if (response.success) {
                    alert(response.message);
                    // Close modal
                    $('#reservationModal').modal('hide');
                    // Reload page to update reservation list
                    location.reload();
                } else {
                    alert(response.message);
                }
            },
            error: function(xhr, status, error) {
                alert('Error cancelling reservation: ' + error);
            }
        });
    }
</script>
</html>
