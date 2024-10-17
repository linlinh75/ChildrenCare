<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Slider List</title>
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
            /* Popup Styles */
            .popup {
                display: none;
                position: fixed;
                z-index: 1;
                left: 0;
                top: 0;
                width: 100%;
                height: 100%;
                overflow: auto;
                background-color: rgb(0,0,0);
                background-color: rgba(0,0,0,0.4);
                padding-top: 60px;
            }

            .popup-content {
                background-color: #fefefe;
                margin: 5% auto;
                padding: 20px;
                border: 1px solid #888;
                width: 60%;
                border-radius: 8px;
            }

            .close {
                color: #aaa;
                float: right;
                font-size: 28px;
                font-weight: bold;
            }

            .close:hover,
            .close:focus {
                color: black;
                text-decoration: none;
                cursor: pointer;
            }

            /* Style for form */
            #editForm div {
                margin-bottom: 15px;
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
                            <li class="breadcrumb-item"><a href="#">Dashboard</a></li>
                            <li class="breadcrumb-item active" aria-current="page">Slider List</li>
                        </ol>
                    </nav>
                </div>
                <div class="slider-list">
                    <div class="table-container">
                        <div class="table-header">
                            <div class="search-box">
                                <input type="text" placeholder="Search..." id="searchInput" onkeyup="searchSlider()">
                                <button type="button">
                                    <i class="fa fa-search"></i>
                                </button>
                            </div>
                        </div>
                        <table class="slider-table">
                            <thead>
                                <tr>
                                    <th>Slider ID</th>
                                    <th>Title</th>
                                    <th>Image</th>
                                    <th>Back Link</th>
                                    <th>Status</th>
                                    <th>Action</th>
                                </tr>
                            </thead>
                            <tbody id="sliderTableBody">
                            <c:forEach var="slider" items="${slider}">
                                <tr>
                                    <td>${slider.getId()}</td>
                                    <td>${slider.getTitle()}</td>
                                    <td><img style="width: 200px; height: 100px;" src="${slider.getImageLink()}" alt="alt"/></td>
                                    <td>${slider.getBacklink()}</td>
                                    <td class="actions">
                                        <form action="managerSliderList" method="post" style="display: flex; flex-direction: column; ">
                                            <c:choose>
                                                <c:when test="${slider.getStatus() == 1}">
                                                    <button type="submit" class="btn-public" name="submit" value="1">Public</button>
                                                </c:when>
                                                <c:otherwise>
                                                    <button type="submit" class="btn-hidden" name="submit" value="0">Hidden</button>
                                                </c:otherwise>
                                            </c:choose>
                                            <input type="hidden" name="sliderId" value="${slider.getId()}">
                                        </form>
                                    </td>
                                    <td class="actions">
                                        <form action="managerSliderList" method="post" style="display: flex; flex-direction: column; ">
                                            <a style="margin-bottom: 5px; width: 70px; border-radius: 4px; color: #fff; text-align: center" class="btn-view" href="managerSliderList?action=detail&id=${slider.getId()}">View</a>
                                            <button style="margin-bottom: 5px; " type="button" class="btn-edit" onclick="openPopup(JSON.stringify({
                                                        id: '${slider.getId()}',
                                                        title: '${slider.getTitle()}',
                                                        backlink: '${slider.getBacklink()}',
                                                        imageLink: '${slider.getImageLink()}',
                                                        status: '${slider.getStatus()}',
                                                        note: '${slider.getNotes()}'
                                                    }))">Edit</button>
                                            <a style="margin-bottom: 5px; width: 70px; border-radius: 4px; color: #fff; text-align: center" class="btn-delete" href="managerSliderList?action=delete&id=${slider.getId()}"  onclick="return confirmDelete()">Delete</a>
                                            <input type="hidden" name="sliderId" value="${slider.getId()}">
                                        </form>
                                    </td>
                                    <!-- Popup Edit -->
                            <div id="editPopup" class="popup">
                                <div class="popup-content">
                                    <span class="close" onclick="closePopup()">&times;</span>
                                    <h2 style="text-align: center; margin-bottom: 20px;">Edit Slider</h2>
                                    <form id="editForm" method="post" action="managerSliderList" enctype="multipart/form-data">
                                        <input type="hidden" name="sliderId" id="sliderId">
                                        <div style="margin-bottom: 10px;">
                                            <label for="sliderTitle" style="width: 100px; font-weight: bold">Title</label>
                                            <input style="width: 80%; height: 80px;" type="text" name="sliderTitle" id="sliderTitle" required>
                                        </div>
                                        <div style="display: flex; align-items: center; margin-bottom: 10px;">
                                            <label for="sliderImage" style="width: 100px; font-weight: bold">Image</label>
                                            <img id="sliderImagePreview" style="width: 200px; height: 100px; margin-right: 10px;" alt="Image Preview"/>
                                            <input type="file" id="sliderImageInput" name="sliderImage" accept="image/*" >
                                        </div>
                                        <div style="display: flex; align-items: center; margin-bottom: 10px;">
                                            <label for="sliderBacklink" style="width: 100px; font-weight: bold">Back Link</label>
                                            <input type="text" name="sliderBacklink" id="sliderBacklink" required>
                                        </div>
                                        <div style="display: flex; align-items: center; margin-bottom: 10px;">
                                            <label for="sliderNote" style="width: 100px; font-weight: bold">Notes</label>
                                            <input style="width: 80%; height: 80px;" type="text" name="sliderNote" id="sliderNote" required>
                                        </div>
                                        <div style="display: flex; align-items: center; margin-bottom: 10px;">
                                            <label for="sliderStatus" style="width: 100px; font-weight: bold">Status</label>
                                            <select name="sliderStatus" id="sliderStatus" required>
                                                <option value="1" <c:if test="${slider.getStatus() == 1}">selected</c:if>>Public</option>
                                                <option value="0" <c:if test="${slider.getStatus() == 0}">selected</c:if>>Hidden</option>
                                                </select>
                                            </div>
                                            <button style="text-align: center !important; margin-bottom: 20px;" type="submit" name="submit" value="edit" class="btn btn-edit" onclick="return confirmEdit()">Save</button>
                                        </form>
                                    </div>
                                </div>
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

        function searchSlider() {
            let input, filter, table, tr, td, i, txtValue;
            input = document.getElementById('searchInput');
            filter = input.value.toLowerCase().trim();
            table = document.getElementById('sliderTableBody');
            tr = table.getElementsByTagName('tr');

            if (filter === "") {
                currentPage = 1;
                filteredRows = Array.from(tr);
            } else {
                filteredRows = [];
                for (i = 0; i < tr.length; i++) {
                    td = tr[i].getElementsByTagName('td')[1];
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
            let table = document.getElementById('sliderTableBody');
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
            const table = document.getElementById('sliderTableBody');
            const rows = table.getElementsByTagName('tr');
            filteredRows = Array.from(rows);
            displayTable();
        };
        function openPopup(sliderJson) {
            const slider = JSON.parse(sliderJson);
            document.getElementById('sliderId').value = slider.id;
            document.getElementById('sliderTitle').value = slider.title;
            document.getElementById('sliderBacklink').value = slider.backlink;
            document.getElementById('sliderImagePreview').src = slider.imageLink;
            document.getElementById('sliderStatus').value = slider.status;
            document.getElementById('sliderNote').value = slider.note;
            console.log("Slider Status:", slider.status);
            document.getElementById('editPopup').style.display = 'block';
        }

        function closePopup() {
            document.getElementById('editPopup').style.display = 'none';
        }

        window.onclick = function (event) {
            const popup = document.getElementById('editPopup');
            if (event.target === popup) {
                closePopup();
            }
        };
        function confirmDelete() {
            return confirm("Are you sure you want to delete this slider?");
        }


        function confirmEdit() {
            return confirm("Are you sure you want to fix this sliders?");
        }
    </script>
</html>
