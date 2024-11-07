<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>

    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Settings Management</title>
        <link rel="stylesheet" href="./css/adminDashboard_style.css" />
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
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
        </style>
    </head>

    <body>
        <jsp:include page="./common/common-homepage-header.jsp"></jsp:include>
            <div class="dashboard-container">
                <!-- Sidebar -->
                <!--            <div class="side-navbar-container">
                                <h3>Admin Dashboard</h3>
                                <ul>
                                    <li onclick="changeLocation('${pageContext.request.contextPath}/home')">
                                        <i class="fa-solid fa-house"></i>
                                        <span>Home</span>
                                    </li>
                                    <li onclick="changeLocation('${pageContext.request.contextPath}/admin-manage-user')">
                                        <i class="fa-solid fa-users"></i>
                                        <span>User Management</span>
                                    </li>
                                    <li onclick="changeLocation('${pageContext.request.contextPath}/admin-manage-service')">
                                        <i class="fa-solid fa-stethoscope"></i>
                                        <span>Services</span>
                                    </li>
                                    <li onclick="changeLocation('${pageContext.request.contextPath}/admin-manage-settings')"
                                        class="active">
                                        <i class="fa-solid fa-gear"></i>
                                        <span>Settings</span>
                                    </li>
                                    <li onclick="changeLocation('${pageContext.request.contextPath}/admin-manage-reservation')">
                                        <i class="fa-solid fa-calendar-check"></i>
                                        <span>Reservations</span>
                                    </li>
                                </ul>
                            </div>-->
            <div class="user-container">
                <div class="user-list-container fade-in">
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
                                    <th onclick="sortTable('id')" class="sortable">
                                        ID <i class="fas fa-sort"></i>
                                    </th>
                                    <th onclick="sortTable('type')" class="sortable">
                                        Type <i class="fas fa-sort"></i>
                                    </th>
                                    <th onclick="sortTable('name')" class="sortable">
                                        Name <i class="fas fa-sort"></i>
                                    </th>
                                    <th onclick="sortTable('value')" class="sortable">
                                        Value <i class="fas fa-sort"></i>
                                    </th>
                                    <th onclick="sortTable('status')" class="sortable">
                                        Status <i class="fas fa-sort"></i>
                                    </th>
                                    <th>Actions</th>
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
                                        <c:forEach items="${settingList}" var="setting">
                                            <tr>
                                                <td>${setting.id}</td>
                                                <td>${setting.type}</td>
                                                <td>${setting.name}</td>
                                                <td>${setting.value}</td>
                                                <td>
                                                    <span
                                                        class="status-badge ${setting.status == 'Active' ? 'active' : 'inactive'}">
                                                        ${setting.status}
                                                    </span>
                                                </td>
                                                <td>
                                                    <button
                                                        onclick="window.location.href = 'setting-details?id=${setting.id}'"
                                                        class="btn btn-info">
                                                        <i class="fa-solid fa-eye"></i>
                                                    </button>
                                                    <button
                                                        onclick="showEditModalWithData('${setting.id}', '${setting.type}', '${setting.name}',
                                                                        '${setting.value}', '${setting.description}', '${setting.status}')"
                                                        class="btn btn-primary">
                                                        <i class="fa-solid fa-pen"></i>
                                                    </button>
                                                </td>
                                            </tr>
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
                                <option value="Role">Role</option>
                                <option value="Post Category">Post Category</option>
                                <option value="Service Category">Service Category</option>
                                <option value="User Status">User Status</option>
                            </select>
                        </div>

                        <div class="form-group">
                            <label class="required-field">Name</label>
                            <input type="text" name="name" required>
                        </div>

                        <div class="form-group">
                            <label class="required-field">Value</label>
                            <input type="number" name="value" required>
                        </div>

                        <div class="form-group">
                            <label>Description</label>
                            <textarea name="description" rows="3"></textarea>
                        </div>

                        <div class="form-group">
                            <label class="required-field">Status</label>
                            <select name="status" required>
                                <option value="Active">Active</option>
                                <option value="Inactive">Inactive</option>
                            </select>
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
                            <select name="type" id="editType" required>
                                <option value="Role">Role</option>
                                <option value="Post Category">Post Category</option>
                                <option value="Service Category">Service Category</option>
                                <option value="User Status">User Status</option>
                            </select>
                        </div>

                        <div class="form-group">
                            <label class="required-field">Name</label>
                            <input type="text" name="name" id="editName" required>
                        </div>

                        <div class="form-group">
                            <label class="required-field">Value</label>
                            <input type="number" name="value" id="editValue" required>
                        </div>

                        <div class="form-group">
                            <label>Description</label>
                            <textarea name="description" id="editDescription" rows="3"></textarea>
                        </div>

                        <div class="form-group">
                            <label class="required-field">Status</label>
                            <select name="status" id="editStatus" required>
                                <option value="Active">Active</option>
                                <option value="Inactive">Inactive</option>
                            </select>
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
                
                if (type) params.set('type', type);
                if (status) params.set('status', status);
                if (search) params.set('search', search);
                
                // Redirect with all parameters
                window.location.href = 'admin-manage-settings?' + params.toString();
            }

            function changeLocation(url) {
                window.location.href = url;
            }

            function showAddModal() {
                document.getElementById('addSettingModal').style.display = 'block';
            }

            function showEditModalWithData(id, type, name, value, description, status) {
                document.getElementById('editSettingId').value = id;
                document.getElementById('editType').value = type;
                document.getElementById('editName').value = name;
                document.getElementById('editValue').value = value;
                document.getElementById('editDescription').value = description;
                document.getElementById('editStatus').value = status;

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
        </style>
        <jsp:include page="./common/common-homepage-footer.jsp"></jsp:include>
    </body>

</html>