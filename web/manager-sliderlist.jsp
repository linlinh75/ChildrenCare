<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Slider List</title>
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
                min-height: 800px;
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
    <body>
        <% String message = (String) session.getAttribute("message"); %>
        <% if (message != null) { %>
        <script>
            alert("<%= message %>");
            <% session.removeAttribute("message"); %>
        </script>
        <% } %>
        <div class="page-wrapper doctris-theme toggled">
            <jsp:include page="./common/admin/side_bar_admin.jsp"></jsp:include>
                <main class="page-content bg-light">
                <jsp:include page="./common/common-homepage-header.jsp"></jsp:include>
                    <section class="container-fluid" style="padding: 20px; margin-top: 30px; margin-bottom: 30px;">
                        <div class="bread_crumb">
                            <nav aria-label="breadcrumb">
                                <ol class="breadcrumb" style="background-color: white; box-shadow: 0 0 2px 2px rgba(128, 128, 128, 0.1);">
                                    <li class="breadcrumb-item"><a href="HomeServlet">Home</a></li>
                                    <li class="breadcrumb-item"><a href="./profile">Manager DashBoard</a></li>
                                    <li class="breadcrumb-item active" aria-current="page">Slider List</li>
                                </ol>
                            </nav>
                        </div>
                        <a id="close-sidebar" class="btn btn-icon btn-pills btn-soft-primary ms-2" href="#" style="margin-bottom:20px">
                            <i class="uil uil-bars"></i>
                        </a>
                        <div class="slider-list" style="background-color: white; box-shadow: 0 0 2px 2px rgba(128, 128, 128, 0.1);">
                            <div class="table-container" style="background-color: white;">
                                <div class="table-header">
                                    <div class="search-box">
                                        <input type="text" placeholder="Search by title" id="searchInput" onkeyup="filterSliders()">
                                        <button type="button">
                                            <i class="fa fa-search"></i>
                                        </button>
                                    </div>
                                    <div class="d-flex" style="gap: 20px"> 
                                        <div class="status-filter" style="display: flex">
                                            <div>Filter by status:</div>
                                            <div class="status-filter">
                                                <select id="statusFilter" onchange="filterSliders()">
                                                    <option value="all">All</option>
                                                    <option value="1">Public</option>
                                                    <option value="0">Hidden</option>
                                                </select>
                                            </div>
                                        </div>
                                        <div >
                                            <a href="manager-addslider.jsp" type="button" class="btn btn-primary">Create Slider</a>
                                        </div>
                                    </div>
                                </div>
                                <table class="slider-table">
                                    <thead>
                                        <tr>
                                            <th onclick="sortTable(0)">Slider ID <i class="fa fa-sort"></i></th>
                                            <th onclick="sortTable(1)">Title <i class="fa fa-sort"></i></th>
                                            <th>Image</th>
                                            <th onclick="sortTable(3)">Back Link <i class="fa fa-sort"></i></th>
                                            <th >Status</th>
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
                                                    <label for="sliderTitle" style="width: 100px; font-weight: bold">Title<span style="color: red;">*</span></label>
                                                    <input style="width: 80%; height: 80px;" type="text" name="sliderTitle" id="sliderTitle" required>
                                                </div>
                                                <div style="display: flex; align-items: center; margin-bottom: 10px;">
                                                    <label for="sliderImage" style="width: 100px; font-weight: bold">Image<span style="color: red;">*</span></label>
                                                    <img id="sliderImagePreview" style="width: 200px; height: 100px; margin-right: 10px;" alt="Image Preview"/>
                                                    <input type="file" id="sliderImageInput" name="sliderImage" accept="image/*">
                                                </div>
                                                <div style="display: flex; align-items: center; margin-bottom: 10px;">
                                                    <label for="sliderBacklink" style="width: 100px; font-weight: bold">Back Link<span style="color: red;">*</span></label>
                                                    <input type="text" name="sliderBacklink" id="sliderBacklink" style="width: 200px;" required>
                                                </div>
                                                <div style="display: flex; align-items: center; margin-bottom: 10px;">
                                                    <label for="sliderNote" style="width: 100px; font-weight: bold">Notes</label>
                                                    <input style="width: 80%; height: 80px;" type="text" name="sliderNote" id="sliderNote">
                                                </div>
                                                <div style="display: flex; align-items: center; margin-bottom: 10px;">
                                                    <label for="sliderStatus" style="width: 100px; font-weight: bold">Status</label>
                                                    <select name="sliderStatus" id="sliderStatus" style="width: 80%; padding: 5px;">
                                                        <option value="1" >Public</option>
                                                        <option value="0" >Hidden</option>
                                                        <option value="deleted">Deleted</option>
                                                    </select>
                                                </div>
                                                <div style="display: flex; align-items: center; margin-bottom: 10px;">
                                                    <button style="text-align: center !important; margin-bottom: 20px;" type="submit" name="submit" value="edit" class="btn btn-edit" onclick="return confirmEdit()">Save</button>
                                                </div>
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
                <jsp:include page="./common/common-homepage-footer.jsp"></jsp:include>
            </main>
        </div>
    </body>


    <script>
        let currentPage = 1;
        const rowsPerPage = 5;
        let filteredRows = [];
        let sortDirection = true;
        function searchSlider() {
            let input = document.getElementById('searchInput').value.toLowerCase().trim();
            let table = document.getElementById('sliderTableBody');
            let tr = table.getElementsByTagName('tr');

            filteredRows = Array.from(tr).filter(function (row) {
                let title = row.getElementsByTagName('td')[1].innerText.toLowerCase();
                return title.includes(input);
            });

            currentPage = 1;
            displayTable();
        }

        function displayTable() {
            let table = document.getElementById('sliderTableBody');
            let totalRows = filteredRows.length;

            Array.from(table.children).forEach(row => row.style.display = "none");
            let startIndex = (currentPage - 1) * rowsPerPage;
            let endIndex = Math.min(startIndex + rowsPerPage, totalRows);
            for (let i = startIndex; i < endIndex; i++) {
                if (filteredRows[i]) {
                    filteredRows[i].style.display = "";
                    console.log(i);
                }
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

        window.onload = () => {
            const table = document.getElementById('sliderTableBody');
            const rows = Array.from(table.getElementsByTagName('tr'));
            filteredRows = rows;
            displayTable();
        };
        function sortTable(columnIndex) {
            const table = document.getElementById("sliderTableBody");
            const isAscending = table.dataset.sortOrder === "asc";
            filteredRows.sort((a, b) => {
                let aValue, bValue;
                if (columnIndex === 0) {
                    aValue = parseInt(a.cells[columnIndex].innerText);
                    bValue = parseInt(b.cells[columnIndex].innerText);
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

        function filterSliders() {
            const searchValue = document.getElementById('searchInput').value.toLowerCase().trim();
            const statusFilter = document.getElementById("statusFilter").value;
            const table = document.getElementById("sliderTableBody");
            const rows = Array.from(table.getElementsByTagName("tr"));

            filteredRows = rows.filter(function (row) {
                const title = row.getElementsByTagName('td')[1].innerText.toLowerCase();
                const status = row.getElementsByTagName("td")[4].innerText.trim().toLowerCase();

                const matchesSearch = title.includes(searchValue);
                const matchesStatus = (statusFilter === "all") ||
                        (statusFilter === "1" && status === "public") ||
                        (statusFilter === "0" && status === "hidden");

                return matchesSearch && matchesStatus;
            });

            currentPage = 1;
            displayTable();
        }
        function openPopup(sliderJson) {
            const slider = JSON.parse(sliderJson);

            document.getElementById('sliderId').value = slider.id;
            document.getElementById('sliderTitle').value = slider.title;
            document.getElementById('sliderBacklink').value = slider.backlink;
            document.getElementById('sliderImagePreview').src = slider.imageLink;
            document.getElementById('sliderNote').value = slider.note;
            document.getElementById('sliderStatus').value = slider.status;
            console.log(slider);
            document.getElementById('editPopup').style.display = 'block';
            document.getElementById("sliderTitle").addEventListener("input", validateTitle);
            document.getElementById("sliderImageInput").addEventListener("change", validateImage);
            document.getElementById("sliderBacklink").addEventListener("input", validateBacklink);
        }


        function closePopup() {
            document.getElementById('editPopup').style.display = 'none';
        }
        function validateTitle() {
            const titleField = document.getElementById("sliderTitle");
            const titleError = document.getElementById("titleError");
            const titleValue = titleField.value.trim();

            if (titleValue === "" || /\s/.test(titleValue)) {
                titleError.style.display = "block";
                titleError.innerText = "Please enter a valid title without spaces.";
                return false;
            } else {
                titleError.style.display = "none";
                return true;
            }
        }

        function validateImage() {
            const imageField = document.getElementById("sliderImageInput");
            const imageError = document.getElementById("imageError");

            if (imageField.value === "") {
                imageError.style.display = "block";
                imageError.innerText = "Please select an image file.";
                return false;
            } else {
                imageError.style.display = "none";
                return true;
            }
        }

        function validateBacklink() {
            const backlinkField = document.getElementById("sliderBacklink");
            const backlinkError = document.getElementById("backlinkError");
            const backlinkValue = backlinkField.value.trim();

            const urlPattern = /^(http|https):\/\/[^\s$.?#].[^\s]*$/gm;

            if (!urlPattern.test(backlinkValue)) {
                backlinkError.style.display = "block";
                backlinkError.innerText = "Please enter a valid URL.";
                return false;
            } else {
                backlinkError.style.display = "none";
                return true;
            }
        }

        function confirmEdit() {
            const isTitleValid = validateTitle();
            const isImageValid = validateImage();
            const isBacklinkValid = validateBacklink();

            if (!isTitleValid || !isImageValid || !isBacklinkValid) {
                alert("Please input correct information in the form.");
                return false;
            }

            return confirm("Are you sure you want to edit this slider?");
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
