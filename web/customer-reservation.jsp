<%-- 
    Document   : customer-reservation
    Created on : Oct 17, 2024, 3:51:46 PM
    Author     : admin
--%>
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
                        </div>
                        <table class="slider-table">
                            <thead>
                                <tr>
                                    <th>Reservation ID</th>
                                    <th>Reservation Date</th>
                                    <th>First Service</th>
                                    <th>CheckUp Time</th>
                                    <th>Status</th>
                                    <th>Total Cost</th>
                                </tr>
                            </thead>
                            <tbody id="reservationTableBody">
                            <c:forEach var="res" items="${reservation}">
                                <tr style="cursor: pointer;" onclick="window.location.href='./ReservationServlet?action=information&id=${res.getId()}'">
                                    <td>${res.getId()}</td>
                                    <td>${res.getReservation_date()}</td>
                                    <td>${res.getList_service().get(0).getService_name()}</td>
                                    <td>${res.getCheckup_time()}</td>
                                    <td  style="font-weight: bold">
                                        <c:choose>
                                            <c:when test="${res.status == 'Pending'}">
                                                <span style="color: orange;">${res.getStatus()}</span>
                                            </c:when>
                                            <c:when test="${res.status == 'Submit'}">
                                                <span style="color: blue;">${res.getStatus()}</span>
                                            </c:when>
                                            <c:when test="${res.status == 'Approved'}">
                                                <span style="color: green;">${res.getStatus()}</span>
                                            </c:when>
                                            <c:when test="${res.status == 'Success'}">
                                                <span style="color: #37F525;">${res.getStatus()}</span>
                                            </c:when>
                                            <c:when test="${res.status == 'Cancel'}">
                                                <span style="color: red;">${res.getStatus()}</span>
                                            </c:when>
                                            <c:otherwise>
                                                <span>${res.getStatus()}</span>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td> <c:set var="totalCost" value="0" />
                                        <c:forEach var="service" items="${res.getList_service()}">
                                            <c:set var="itemCost" value="${service.getQuantity() * service.getUnit_price()}" />
                                            <c:set var="totalCost" value="${totalCost + itemCost}" />
                                        </c:forEach>
                                        <c:out value="${totalCost}" /></td>
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
        let filteredRows = [];

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
    </script>
</html>
