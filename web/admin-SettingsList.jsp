<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>

    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Settings Management</title>
        <link rel="stylesheet" href="./css/adminDashboard_style.css" />
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
        <!-- favicon -->
        <link rel="shortcut icon" href="img/favicon.png">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
        <!-- Bootstrap -->
        <link href="${pageContext.request.contextPath}/assets/css/bootstrap.min.css" rel="stylesheet" type="text/css" />
        <!-- simplebar -->
        <link href="${pageContext.request.contextPath}/assets/css/simplebar.css" rel="stylesheet" type="text/css" />
        <!-- Icons -->
        <link href="${pageContext.request.contextPath}/assets/css/materialdesignicons.min.css" rel="stylesheet" type="text/css" />
        <link href="${pageContext.request.contextPath}/assets/css/remixicon.css" rel="stylesheet" type="text/css" />
        <link href="https://unicons.iconscout.com/release/v3.0.6/css/line.css"  rel="stylesheet">
        <!-- Css -->
        <link href="${pageContext.request.contextPath}/assets/css/style.min.css" rel="stylesheet" type="text/css" id="theme-opt" />
        <style>
            .logo img {
                width: 80%;
            }

        </style>
        <style>
            /* Pagination styling */
            .pagination-wrapper {
                display: flex;
                justify-content: center;
                margin: 20px 0;
            }

            .pagination {
                display: flex;
                flex-direction: row; /* Ensure horizontal layout */
                list-style: none;
                padding: 0;
                margin: 0;
                gap: 5px; /* Space between buttons */
            }

            .pagination .page-item {
                margin: 0;
                display: inline-block; /* Make items display inline */
            }

            .pagination .page-link {
                display: flex;
                align-items: center;
                justify-content: center;
                min-width: 40px; /* Fixed width for square shape */
                height: 40px; /* Same as width for perfect square */
                padding: 0;
                margin: 0;
                border: 1px solid #dee2e6;
                color: #007bff;
                text-decoration: none;
                background-color: #fff;
                transition: all 0.3s ease;
            }

            .pagination .page-item.active .page-link {
                background-color: #007bff;
                border-color: #007bff;
                color: white;
            }

            .pagination .page-link:hover {
                background-color: #e9ecef;
                border-color: #dee2e6;
                color: #0056b3;
            }

            /* Style for Previous/Next buttons */
            .pagination .page-item:first-child .page-link,
            .pagination .page-item:last-child .page-link {
                width: auto;
                padding: 0 15px;
            }

            /* Force horizontal layout */
            .pagination li {
                float: left; /* Make list items float left */
            }

            /* Clear the float */
            .pagination::after {
                content: "";
                display: table;
                clear: both;
            }

            /* Existing styles... */

            .form-group textarea {
                width: 100%;
                padding: 8px;
                border: 1px solid #ddd;
                border-radius: 4px;
                resize: vertical;
                min-height: 80px;
            }

            /* Add max-width for description column */
            .table td:nth-child(5) {
                max-width: 200px;
                white-space: normal;
                word-wrap: break-word;
            }

            .radio-group {
                display: flex;
                gap: 20px;
                margin-top: 8px;
            }

            .radio-label {
                display: flex;
                align-items: center;
                cursor: pointer;
                user-select: none;
            }

            .radio-label input[type="radio"] {
                width: auto;
                margin-right: 8px;
                cursor: pointer;
            }

            .radio-label span {
                font-size: 14px;
                color: #333;
            }

            /* Custom radio button styling */
            .radio-label input[type="radio"] {
                -webkit-appearance: none;
                -moz-appearance: none;
                appearance: none;
                width: 20px;
                height: 20px;
                border: 2px solid #ddd;
                border-radius: 50%;
                outline: none;
                margin-right: 8px;
                position: relative;
                cursor: pointer;
            }

            .radio-label input[type="radio"]:checked {
                border-color: #007bff;
            }

            .radio-label input[type="radio"]:checked::before {
                content: '';
                position: absolute;
                width: 12px;
                height: 12px;
                background-color: #007bff;
                border-radius: 50%;
                top: 50%;
                left: 50%;
                transform: translate(-50%, -50%);
            }

            .radio-label:hover input[type="radio"] {
                border-color: #007bff;
            }

            .radio-label:hover span {
                color: #007bff;
            }

            /* Add scrollable modal styles */
            .modal-content {
                max-height: 90vh; /* Maximum height is 90% of viewport height */
                overflow-y: auto; /* Enable vertical scrolling */
                display: flex;
                flex-direction: column;
            }

            .modal-header {
                position: sticky;
                top: 0;
                background: white;
                z-index: 1000;
                padding: 15px 20px;
                margin: -20px -20px 20px -20px; /* Negative margin to align with modal content */
                border-bottom: 1px solid #ddd;
            }

            .modal-footer {
                position: sticky;
                bottom: 0;
                background: white;
                z-index: 1000;
                padding: 15px 20px;
                margin: 20px -20px -20px -20px; /* Negative margin to align with modal content */
                border-top: 1px solid #ddd;
            }

            .modal-body {
                flex: 1;
                padding: 0 20px;
                overflow-y: auto;
            }

            /* Custom scrollbar styling */
            .modal-content::-webkit-scrollbar {
                width: 8px;
            }

            .modal-content::-webkit-scrollbar-track {
                background: #f1f1f1;
                border-radius: 4px;
            }

            .modal-content::-webkit-scrollbar-thumb {
                background: #888;
                border-radius: 4px;
            }

            .modal-content::-webkit-scrollbar-thumb:hover {
                background: #555;
            }

            /* Add some spacing between form groups */
            .modal-body .form-group {
                margin-bottom: 25px;
            }

            /* Make sure the modal doesn't get too tall on smaller screens */
            @media (max-height: 768px) {
                .modal-content {
                    max-height: 85vh;
                }
            }

            /* Make sure the modal doesn't get too wide on smaller screens */
            @media (max-width: 768px) {
                .modal-content {
                    width: 95%;
                    margin: 10px auto;
                }
            }

            /* Table header styling */
            .thead-dark {
                background-color: #343a40;
                color: white;
            }

            .thead-dark th {
                padding: 15px;
                font-weight: 500;
                text-align: left;
                border-bottom: 2px solid #454d55;
            }

            .sortable {
                cursor: pointer;
                position: relative;
                padding-right: 20px !important;
            }

            .sortable i {
                position: absolute;
                right: 5px;
                top: 50%;
                transform: translateY(-50%);
                opacity: 0.3;
                transition: opacity 0.2s;
            }

            .sortable:hover i {
                opacity: 1;
            }

            /* Responsive table */
            .table-responsive-wrapper {
                overflow-x: auto;
                margin: 0 -20px;
                padding: 0 20px;
            }

            .table {
                width: 100%;
                border-collapse: collapse;
                background: white;
                border-radius: 8px;
                overflow: hidden;
                box-shadow: 0 2px 4px rgba(0,0,0,0.1);
            }

            .table td, .table th {
                padding: 12px 15px;
                border-bottom: 1px solid #e9ecef;
            }

            .table tbody tr:hover {
                background-color: #f8f9fa;
            }

            /* Column width control */
            .table th, .table td {
                white-space: nowrap;
                overflow: hidden;
                text-overflow: ellipsis;
            }

            /* Description column special handling */
            .table td:nth-child(5) {
                white-space: normal;
                min-width: 200px;
                max-width: 300px;
            }
        </style>
    </head>

    <body>

        <div class="page-wrapper doctris-theme toggled">
            <jsp:include page="./common/admin/side_bar_admin.jsp"></jsp:include>
                <main class="page-content bg-light">
                <jsp:include page="./common/common-homepage-header.jsp"></jsp:include>
                    <div class="dashboard-container container-fluid" style="padding: 20px; margin-top: 30px; margin-bottom: 30px;">
                        <!--Sidebar-->


                        <div class="user-container container-fluid">
                            <div class="user-list-container fade-in container-fluid">
                                <h1 class="user-container-table">Settings Management</h1>

                                <!-- Success/Error Messages - Only show when needed -->
                            <c:if test="${not empty sessionScope.successMessage}">
                                <div class="alert alert-success">
                                    ${sessionScope.successMessage}
                                    <% session.removeAttribute("successMessage"); %>
                                </div>
                            </c:if>
                            <c:if test="${not empty sessionScope.errorMessage}">
                                <div class="alert alert-danger">
                                    ${sessionScope.errorMessage}
                                    <% session.removeAttribute("errorMessage"); %>
                                </div>
                            </c:if>

                            <!-- Search and Add Setting -->
                            <div class="top-option">
                                <form action="${pageContext.request.contextPath}/admin-manage-settings" method="get"
                                      class="search-name-form">
                                    <input type="text" name="search" placeholder="Search by name or value..."
                                           value="${searchKeyword}">
                                    <button type="submit">
                                        <i class="fa-solid fa-magnifying-glass"></i> Search
                                    </button>
                                </form>
                                <button onclick="showAddModal()" class="btn btn-primary">
                                    <i class="fa-solid fa-plus"></i> Add New Setting
                                </button>
                            </div>

                            <!-- Filter section -->
                            <div class="filter-section">
                                <form action="${pageContext.request.contextPath}/admin-manage-settings" method="get"
                                      class="filter-form">
                                    <div class="filter-group">
                                        <label>Type:</label>
                                        <select name="type">
                                            <option value="">All</option>
                                            <c:forEach items="${settingTypes}" var="type">
                                                <option value="${type}" ${typeFilter==type ? 'selected' : '' }>${type}</option>
                                            </c:forEach>
                                        </select>
                                    </div>

                                    <div class="filter-group">
                                        <label>Status:</label>
                                        <select name="status">
                                            <option value="">All</option>
                                            <option value="Active" ${statusFilter=='Active' ? 'selected' : '' }>Active</option>
                                            <option value="Inactive" ${statusFilter=='Inactive' ? 'selected' : '' }>Inactive
                                            </option>
                                        </select>
                                    </div>

                                    <button type="submit" class="btn btn-primary">Apply Filters</button>
                                </form>
                            </div>

                            <!-- Settings Table -->
                            <div class="table-responsive-wrapper">
                                <table class="table">
                                    <thead class="thead-dark">
                                        <tr>
                                            <th onclick="sortTable('id')" class="sortable" style="width: 5%;">
                                                ID <i class="fas fa-sort"></i>
                                            </th>
                                            <th onclick="sortTable('type')" class="sortable" style="width: 15%;">
                                                Type <i class="fas fa-sort"></i>
                                            </th>
                                            <th onclick="sortTable('name')" class="sortable" style="width: 20%;">
                                                Name <i class="fas fa-sort"></i>
                                            </th>
                                            <th onclick="sortTable('value')" class="sortable" style="width: 10%;">
                                                Value <i class="fas fa-sort"></i>
                                            </th>
                                            <th onclick="sortTable('description')" class="sortable" style="width: 30%;">
                                                Description <i class="fas fa-sort"></i>
                                            </th>
                                            <th onclick="sortTable('status')" class="sortable" style="width: 10%;">
                                                Status <i class="fas fa-sort"></i>
                                            </th>
                                            <th style="width: 10%;">Actions</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:choose>
                                            <c:when test="${empty settingList}">
                                                <tr>
                                                    <td colspan="6" class="text-center">No settings found</td>
                                                </tr>
                                            </c:when>
                                            <c:otherwise>
                                                <c:set var="count" value="1"/>
                                                <c:forEach items="${settingList}" var="setting">
                                                    <tr>
                                                        <td>${count}</td>
                                                        <td>${setting.type}</td>
                                                        <td>${setting.name}</td>
                                                        <td>${setting.value}</td>
                                                        <td>${setting.description}</td>
                                                        <td>
                                                            <span
                                                                class="status-badge ${setting.status == 1 ? 'active' : 'inactive'}">
                                                                ${setting.status == 1 ? 'Active' : 'Inactive'}
                                                            </span>
                                                        </td>
                                                        <td>
                                                            <button
                                                                onclick="window.location.href = 'setting-details?id=${setting.value}'"
                                                                class="btn btn-info">
                                                                <i class="fa-solid fa-eye"></i>
                                                            </button>
                                                            <button
                                                                onclick="showEditModalWithData('${setting.value}', '${setting.type}',
                                                                                '${setting.name}', '${setting.description}',
                                                                                '${setting.status}')"
                                                                class="btn btn-primary">
                                                                <i class="fa-solid fa-pen"></i>
                                                            </button>
                                                        </td>
                                                    </tr>
                                                    <c:set var="count" value="${count + 1}"/>
                                                </c:forEach>
                                            </c:otherwise>
                                        </c:choose>
                                    </tbody>
                                </table>
                            </div>

                            <!-- Pagination -->
                            <c:if test="${totalPages > 1}">
                                <div class="pagination-wrapper">
                                    <ul class="pagination">
                                        <c:if test="${currentPage > 1}">
                                            <li class="page-item">
                                                <a class="page-link" href="admin-manage-settings?page=${currentPage - 1}&sortBy=${sortBy}&sortOrder=${sortOrder}&type=${typeFilter}&status=${statusFilter}&search=${searchKeyword}">Previous</a>
                                            </li>
                                        </c:if>

                                        <c:forEach begin="1" end="${totalPages}" var="i">
                                            <li class="page-item ${currentPage == i ? 'active' : ''}">
                                                <a class="page-link" href="admin-manage-settings?page=${i}&sortBy=${sortBy}&sortOrder=${sortOrder}&type=${typeFilter}&status=${statusFilter}&search=${searchKeyword}">${i}</a>
                                            </li>
                                        </c:forEach>

                                        <c:if test="${currentPage < totalPages}">
                                            <li class="page-item">
                                                <a class="page-link" href="admin-manage-settings?page=${currentPage + 1}&sortBy=${sortBy}&sortOrder=${sortOrder}&type=${typeFilter}&status=${statusFilter}&search=${searchKeyword}">Next</a>
                                            </li>
                                        </c:if>
                                    </ul>
                                </div>
                            </c:if>
                        </div>
                    </div>
                </div>

                <!-- Add Setting Modal -->
                <div id="addSettingModal" class="modal">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h2><i class="fas fa-plus"></i> Add New Setting</h2>
                            <span class="close">&times;</span>
                        </div>
                        <form id="addSettingForm" action="add-setting" method="post">
                            <div class="modal-body">
                                <div class="form-group">
                                    <label class="required-field">Type</label>
                                    <select name="type" required>
                                        <option value="Post Category">Post Category</option>
                                        <option value="Service Category">Service Category</option>
                                    </select>
                                </div>
                                <br><br>
                                <div class="form-group">
                                    <label class="required-field">Name</label>
                                    <input type="text" name="name" required>
                                </div>

                                <div class="form-group">
                                    <label class="required-field">Status</label>
                                    <select name="status" required>
                                        <option value="1">Active</option>
                                        <option value="0">Inactive</option>
                                    </select>
                                </div>
                                <br><br>
                                <div class="form-group">
                                    <label class="required-field">Description</label>
                                    <textarea name="description" rows="3" required></textarea>
                                </div>
                            </div>
                            <div class="modal-footer">
                                <button type="submit" class="btn btn-success">
                                    <i class="fas fa-save"></i> Add Setting
                                </button>
                                <button type="button" class="btn btn-secondary close-modal">
                                    <i class="fas fa-times"></i> Cancel
                                </button>
                            </div>
                        </form>
                    </div>
                </div>

                <!-- Edit Setting Modal -->
                <div id="editSettingModal" class="modal">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h2><i class="fas fa-edit"></i> Edit Setting</h2>
                            <span class="close">&times;</span>
                        </div>
                        <form id="editSettingForm" action="edit-setting" method="post">
                            <input type="hidden" name="id" id="editSettingId">
                            <div class="modal-body">
                                <div class="form-group">
                                    <label class="required-field">Type</label>
                                    <div class="radio-group">
                                        <label class="radio-label">
                                            <input type="radio" name="type" value="Post Category" required>
                                            <span>Post Category</span>
                                        </label>
                                        <label class="radio-label">
                                            <input type="radio" name="type" value="Service Category" required>
                                            <span>Service Category</span>
                                        </label>
                                    </div>
                                </div>

                                <div class="form-group">
                                    <label class="required-field">Name</label>
                                    <input type="text" name="name" id="editName" required>
                                </div>

                                <input type="hidden" name="value" id="editValue">

                                <div class="form-group">
                                    <label class="required-field">Status</label>
                                    <div class="radio-group">
                                        <label class="radio-label">
                                            <input type="radio" name="status" value="1" required>
                                            <span>Active</span>
                                        </label>
                                        <label class="radio-label">
                                            <input type="radio" name="status" value="0" required>
                                            <span>Inactive</span>
                                        </label>
                                    </div>
                                </div>

                                <div class="form-group">
                                    <label class="required-field">Description</label>
                                    <textarea name="description" id="editDescription" rows="3" required></textarea>
                                </div>
                            </div>
                            <div class="modal-footer">
                                <button type="submit" class="btn btn-primary">
                                    <i class="fas fa-save"></i> Save Changes
                                </button>
                                <button type="button" class="btn btn-secondary close-modal">
                                    <i class="fas fa-times"></i> Cancel
                                </button>
                            </div>
                        </form>
                    </div>
                </div>
                <jsp:include page="./common/common-homepage-footer.jsp"></jsp:include>
            </main>
        </div>
    </body>
    <script>
        function sortTable(column) {
            const currentUrl = new URL(window.location.href);
            const params = new URLSearchParams(currentUrl.search);

            // Get current sort parameters
            const currentSortBy = params.get('sortBy');
            const currentSortOrder = params.get('sortOrder');

            // Determine new sort order
            let newSortOrder = 'asc';
            if (column === currentSortBy && currentSortOrder === 'asc') {
                newSortOrder = 'desc';
            }

            // Update sort parameters
            params.set('sortBy', column);
            params.set('sortOrder', newSortOrder);

            // Reset to first page when sorting changes
            params.set('page', '1');

            // Maintain other parameters (type, status, search)
            const type = params.get('type');
            const status = params.get('status');
            const search = params.get('search');

            if (type)
                params.set('type', type);
            if (status)
                params.set('status', status);
            if (search)
                params.set('search', search);

            // Redirect with all parameters
            window.location.href = 'admin-manage-settings?' + params.toString();
        }

        function changeLocation(url) {
            window.location.href = url;
        }

        function showAddModal() {
            document.getElementById('addSettingModal').style.display = 'block';
        }

        function showEditModalWithData(value, type, name, description, status) {
            document.getElementById('editSettingId').value = value;
            document.getElementById('editName').value = name;
            document.getElementById('editDescription').value = description || '';
            document.getElementById('editValue').value = value;

            // Set radio buttons for type
            const typeRadios = document.querySelectorAll('#editSettingForm input[name="type"]');
            typeRadios.forEach(radio => {
                radio.checked = radio.value === type;
            });

            // Set radio buttons for status
            const statusRadios = document.querySelectorAll('#editSettingForm input[name="status"]');
            statusRadios.forEach(radio => {
                radio.checked = radio.value === status.toString();
            });

            document.getElementById('editSettingModal').style.display = 'block';
        }

        // Close modal handlers
        document.querySelectorAll('.close, .close-modal').forEach(element => {
            element.onclick = function () {
                this.closest('.modal').style.display = 'none';
            }
        });

        window.onclick = function (event) {
            if (event.target.classList.contains('modal')) {
                event.target.style.display = 'none';
            }
        }

        // Form validation
        document.getElementById('addSettingForm').onsubmit = validateForm;
        document.getElementById('editSettingForm').onsubmit = validateForm;

        function validateForm(e) {
            const form = e.target;
            const name = form.querySelector('[name="name"]').value.trim();
            const value = form.querySelector('[name="value"]').value;

            if (name.length < 2) {
                alert('Name must be at least 2 characters long');
                return false;
            }

            if (isNaN(value) || value < 0) {
                alert('Value must be a positive number');
                return false;
            }

            return true;
        }

        document.getElementById('editSettingForm').onsubmit = function (e) {
            e.preventDefault();
            const formData = new FormData(this);

            const name = formData.get('name').trim();
            const description = formData.get('description').trim();

            if (name.length < 2) {
                alert('Name must be at least 2 characters long');
                return false;
            }

            if (description.length < 10) {
                alert('Description must be at least 10 characters long');
                return false;
            }

            fetch('edit-setting', {
                method: 'POST',
                body: new URLSearchParams(formData)
            })
                    .then(response => {
                        if (response.ok) {
                            document.getElementById('editSettingModal').style.display = 'none';
                            window.location.reload();
                        } else {
                            throw new Error('Failed to update setting');
                        }
                    })
                    .catch(error => {
                        console.error('Error:', error);
                        alert('Error updating setting: ' + error.message);
                    });
        };

        document.querySelectorAll('.modal textarea').forEach(textarea => {
            textarea.style.minHeight = '100px';
            textarea.style.resize = 'vertical';
        });
    </script>

    <style>
        .modal {
            display: none;
            position: fixed;
            z-index: 1000;
            left: 0;
            top: 0;
            width: 100%;
            height: 100%;
            background-color: rgba(0, 0, 0, 0.5);
        }

        .modal-content {
            background-color: #fefefe;
            margin: 5% auto;
            padding: 20px;
            border: 1px solid #888;
            width: 80%;
            max-width: 600px;
            border-radius: 8px;
        }

        .modal-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
            padding-bottom: 10px;
            border-bottom: 1px solid #ddd;
        }

        .close {
            color: #aaa;
            font-size: 28px;
            font-weight: bold;
            cursor: pointer;
        }

        .close:hover {
            color: black;
        }

        .form-group {
            margin-bottom: 15px;
        }

        .form-group label {
            display: block;
            margin-bottom: 5px;
            font-weight: 500;
        }

        .form-group input,
        .form-group select,
        .form-group textarea {
            width: 100%;
            padding: 8px;
            border: 1px solid #ddd;
            border-radius: 4px;
        }

        .required-field::after {
            content: "*";
            color: red;
            margin-left: 4px;
        }

        .modal-footer {
            margin-top: 20px;
            padding-top: 15px;
            border-top: 1px solid #ddd;
            text-align: right;
        }

        /* Button styling in table rows */
        .table td .btn {
            padding: 6px 12px;
            margin: 0 3px;
            border-radius: 4px;
            transition: all 0.3s ease;
        }

        .table td .btn-info {
            background-color: #17a2b8;
            border-color: #17a2b8;
            color: white;
        }

        .table td .btn-primary {
            background-color: #007bff;
            border-color: #007bff;
            color: white;
        }

        .table td .btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 2px 5px rgba(0,0,0,0.2);
        }

        .table td .btn-info:hover {
            background-color: #138496;
            border-color: #117a8b;
        }

        .table td .btn-primary:hover {
            background-color: #0069d9;
            border-color: #0062cc;
        }

        /* Action buttons container */
        .table td {
            white-space: nowrap;
        }

        /* Icon styling inside buttons */
        .table td .btn i {
            font-size: 14px;
            margin-right: 0;
        }

        /* Status badge styling */
        .status-badge {
            padding: 5px 10px;
            border-radius: 15px;
            font-size: 12px;
            font-weight: 500;
        }

        .status-badge.active {
            background-color: #28a745;
            color: white;
        }

        .status-badge.inactive {
            background-color: #dc3545;
            color: white;
        }

        .modal textarea {
            width: 100%;
            padding: 8px;
            border: 1px solid #ddd;
            border-radius: 4px;
            font-family: inherit;
            font-size: 14px;
            line-height: 1.5;
        }

        .modal textarea:focus {
            border-color: #007bff;
            outline: none;
            box-shadow: 0 0 0 0.2rem rgba(0,123,255,.25);
        }

        .form-error {
            color: #dc3545;
            font-size: 12px;
            margin-top: 4px;
            display: none;
        }

        .form-group.has-error .form-error {
            display: block;
        }

        .form-group.has-error input,
        .form-group.has-error textarea,
        .form-group.has-error select {
            border-color: #dc3545;
        }
    </style>

</html>