<%-- Document : admin_Dashboard_ListUser Created on : Oct 7, 2023, 1:46:28 PM Author : dmx --%>

<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>

    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>User Management</title>
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

            /* Modal styling for scrollable content */
            .modal {
                display: none;
                position: fixed;
                z-index: 1000;
                left: 0;
                top: 0;
                width: 100%;
                height: 100%;
                background-color: rgba(0, 0, 0, 0.5);
                overflow-y: auto; /* Enable vertical scrolling for the modal */
            }

            .modal-content {
                background-color: #fefefe;
                margin: 20px auto; /* Reduced top margin */
                padding: 20px;
                border: 1px solid #888;
                width: 80%;
                max-width: 600px;
                border-radius: 8px;
                max-height: 90vh; /* Maximum height of 90% of viewport height */
                overflow-y: auto; /* Enable scrolling for long content */
                position: relative; /* For sticky header and footer */
            }

            .modal-header {
                position: sticky;
                top: 0;
                background-color: #fff;
                padding: 15px 0;
                border-bottom: 1px solid #ddd;
                margin-bottom: 20px;
                z-index: 1;
            }

            .modal-body {
                padding: 15px 0;
            }

            .modal-footer {
                position: sticky;
                bottom: 0;
                background-color: #fff;
                padding: 15px 0;
                border-top: 1px solid #ddd;
                margin-top: 20px;
                text-align: right;
            }

            /* Smooth scrolling */
            .modal-content {
                scroll-behavior: smooth;
            }

            /* Style scrollbar */
            .modal-content::-webkit-scrollbar {
                width: 8px;
            }

            .modal-content::-webkit-scrollbar-track {
                background: #f1f1f1;
            }

            .modal-content::-webkit-scrollbar-thumb {
                background: #888;
                border-radius: 4px;
            }

            .modal-content::-webkit-scrollbar-thumb:hover {
                background: #555;
            }

            /* Animation for modal */
            @keyframes fadeIn {
                from {
                    opacity: 0;
                }
                to {
                    opacity: 1;
                }
            }

            .fade-in {
                animation: fadeIn 0.3s ease-in;
            }

            /* Smooth transition for modal display */
            .modal {
                transition: opacity 0.3s ease-in-out;
            }

            /* Style for form fields */
            .modal input:disabled,
            .modal select:disabled {
                background-color: #e9ecef;
                cursor: not-allowed;
            }

            .modal input:focus,
            .modal select:focus {
                border-color: #80bdff;
                box-shadow: 0 0 0 0.2rem rgba(0,123,255,.25);
            }

            .radio-group {
                display: flex;
                gap: 20px;
                margin-top: 8px;
                flex-wrap: wrap; /* Cho phép xuống dòng khi không đủ chỗ */
            }

            .radio-label {
                display: flex;
                align-items: center;
                cursor: pointer;
                user-select: none;
                min-width: 100px; /* Đảm bảo độ rộng tối thiểu */
            }

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

            .radio-label span {
                font-size: 14px;
                color: #333;
            }

            .form-row {
                display: flex;
                gap: 20px;
                margin-bottom: 20px;
            }

            .form-row .form-group {
                flex: 1;
                margin-bottom: 0;
            }

            /* Adjust radio group layout */
            .radio-group {
                margin-top: 8px;
                display: flex;
                gap: 15px;
            }

            /* Make sure inputs align properly */
            .form-row input[type="text"],
            .form-row input[type="email"],
            .form-row input[type="password"] {
                margin-top: 8px;
            }

            input[name="mobile"]:invalid {
                border-color: #dc3545;
            }

            input[name="mobile"]:valid {
                border-color: #28a745;
            }

            /* Thêm tooltip cho input mobile */
            input[name="mobile"] {
                position: relative;
            }

            input[name="mobile"]::after {
                content: "Phone number must be 10 digits and start with 0";
                position: absolute;
                bottom: -20px;
                left: 0;
                font-size: 12px;
                color: #dc3545;
                display: none;
            }

            input[name="mobile"]:invalid::after {
                display: block;
            }

            .btn-primary:disabled {
                opacity: 0.5;
                cursor: not-allowed;
                pointer-events: none;
            }

            @keyframes slideIn {
                from {
                    transform: translateX(100%);
                    opacity: 0;
                }
                to {
                    transform: translateX(0);
                    opacity: 1;
                }
            }

            @keyframes slideOut {
                from {
                    transform: translateX(0);
                    opacity: 1;
                }
                to {
                    transform: translateX(100%);
                    opacity: 0;
                }
            }

            .message-popup {
                box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
            }

            .alert-success {
                background-color: #d4edda;
                color: #155724;
                border-color: #c3e6cb;
            }

            .alert-danger {
                background-color: #f8d7da;
                color: #721c24;
                border-color: #f5c6cb;
            }

            .alert {
                padding: 15px 20px;
                margin-bottom: 20px;
                border: 1px solid transparent;
                border-radius: 4px;
                display: flex;
                align-items: center;
                font-size: 14px;
                opacity: 1;
                transition: opacity 0.5s ease-in-out;
            }

            .alert i {
                margin-right: 10px;
                font-size: 18px;
            }

            .alert-success {
                color: #0a6d1b;
                background-color: #c3ffd3;
                border-color: #7ae495;
            }

            .alert-success i {
                color: #0a6d1b;
            }

            .alert-danger {
                color: #842029;
                background-color: #f8d7da;
                border-color: #f5c2c7;
            }

            .alert.fade-out {
                opacity: 0;
            }

            .alert-success:hover {
                background-color: #b0ffc5;
                border-color: #69d384;
            }
        </style>
    </head>

    <body>
        <div class="page-wrapper doctris-theme toggled">
            <jsp:include page="./common/admin/side_bar_admin.jsp"></jsp:include>
                <main class="page-content bg-light">
                <jsp:include page="./common/common-homepage-header.jsp"></jsp:include>
                    <div class="dashboard-container container-fluid" style="padding: 20px; margin-top: 30px; margin-bottom: 30px;">
                        <!-- Sidebar -->

                        <!-- Main Content -->
                        <div class="user-container container-fluid">
                            <div class="user-list-container fade-in">
                                <h1 class="user-container-table">User Management</h1>
                                <!-- Success/Error Messages -->
                            <c:if test="${not empty sessionScope.successMessage}">
                                <div class="alert alert-success">
                                    <i class="fas fa-check-circle"></i>
                                    ${sessionScope.successMessage}
                                </div>
                                <%-- Remove message from session immediately after displaying --%>
                                <% session.removeAttribute("successMessage"); %>
                            </c:if>
                            <c:if test="${not empty sessionScope.errorMessage}">
                                <div class="alert alert-danger">
                                    <i class="fas fa-exclamation-circle"></i>
                                    ${sessionScope.errorMessage}
                                </div>
                                <%-- Remove message from session immediately after displaying --%>
                                <% session.removeAttribute("errorMessage"); %>
                            </c:if>

                            <!-- Search and Add User -->
                            <div class="top-option">
                                <form action="${pageContext.request.contextPath}/admin-manage-user" method="post"
                                      class="search-name-form">
                                    <input type="text" name="search" placeholder="Search by name, email or phone..."
                                           value="${searchKeyword}">
                                    <button type="submit">
                                        <i class="fa-solid fa-magnifying-glass"></i> Search
                                    </button>
                                </form>
                                <button onclick="showAddModal()" class="btn btn-primary">
                                    <i class="fa-solid fa-user-plus"></i> Add New User
                                </button>
                            </div>

                            <!-- Add filter section -->
                            <div class="filter-section">
                                <form action="${pageContext.request.contextPath}/admin-manage-user" method="get"
                                      class="filter-form">
                                    <!--                            <div class="filter-group">
                                                                    <label>Gender:</label>
                                                                    <select name="gender">
                                                                        <option value="">All</option>
                                                                        <option value="true" ${genderFilter=='true' ? 'selected' : '' }>Male
                                                                        </option>
                                                                        <option value="false" ${genderFilter=='false' ? 'selected' : '' }>Female
                                                                        </option>
                                                                    </select>
                                                                </div>-->

                                    <div class="filter-group">
                                        <label>Role:</label>
                                        <select name="role">
                                            <option value="">All</option>
                                            <option value="1" ${roleFilter=='1' ? 'selected' : '' }>Admin</option>
                                            <option value="2" ${roleFilter=='2' ? 'selected' : '' }>Manager</option>
                                            <option value="3" ${roleFilter=='3' ? 'selected' : '' }>Staff</option>
                                            <option value="4" ${roleFilter=='4' ? 'selected' : '' }>Customer</option>
                                        </select>
                                    </div>

                                    <div class="filter-group">
                                        <label>Status:</label>
                                        <select name="status">
                                            <option value="">All</option>
                                            <option value="Active" ${statusFilter=='Active' ? 'selected' : '' }>Active
                                            </option>
                                            <option value="Inactive" ${statusFilter=='Inactive' ? 'selected' : '' }>
                                                Inactive</option>
                                        </select>
                                    </div>

                                    <button type="submit" class="btn btn-primary">Apply Filters</button>
                                </form>
                            </div>

                            <!-- User Table -->
                            <div class="table-responsive-wrapper">
                                <table class="table">
                                    <thead class="thead-dark">
                                        <tr>
                                            <th onclick="sortTable('id')" class="sortable">
                                                ID <i class="fas fa-sort"></i>
                                            </th>
                                            <th onclick="sortTable('full_name')" class="sortable">
                                                Full Name <i class="fas fa-sort"></i>
                                            </th>
                                            <th onclick="sortTable('gender')" class="sortable">
                                                Gender <i class="fas fa-sort"></i>
                                            </th>
                                            <th onclick="sortTable('email')" class="sortable">
                                                Email <i class="fas fa-sort"></i>
                                            </th>
                                            <th onclick="sortTable('mobile')" class="sortable">
                                                Mobile <i class="fas fa-sort"></i>
                                            </th>
                                            <th onclick="sortTable('role_id')" class="sortable">
                                                Role <i class="fas fa-sort"></i>
                                            </th>
                                            <th onclick="sortTable('status')" class="sortable">
                                                Status <i class="fas fa-sort"></i>
                                            </th>
                                            <th>Actions</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:choose>
                                            <c:when test="${empty listUser}">
                                                <tr>
                                                    <td colspan="8" class="text-center">No users found</td>
                                                </tr>
                                            </c:when>
                                            <c:otherwise>
                                                <c:forEach items="${listUser}" var="user">
                                                    <tr>
                                                        <td>${user.id}</td>
                                                        <td>${user.fullName}</td>
                                                        <td>${user.gender ? 'Male' : 'Female'}</td>
                                                        <td>${user.email}</td>
                                                        <td>${user.mobile}</td>
                                                        <td>
                                                            <c:choose>
                                                                <c:when test="${user.roleId == 1}">Admin</c:when>
                                                                <c:when test="${user.roleId == 2}">Manager</c:when>
                                                                <c:when test="${user.roleId == 3}">Staff</c:when>
                                                                <c:otherwise>Customer</c:otherwise>
                                                            </c:choose>
                                                        </td>
                                                        <td>
                                                            <span
                                                                class="status-badge ${user.status == 'Active' ? 'active' : 'inactive'}">
                                                                ${user.status}
                                                            </span>
                                                        </td>
                                                        <td>
                                                            <button
                                                                onclick="window.location.href = 'user-details?id=${user.id}'"
                                                                class="btn btn-info">
                                                                <i class="fa-solid fa-eye"></i>
                                                            </button>
                                                            <button onclick='showEditModal("${user.id}")'
                                                                    class="btn btn-primary">
                                                                <i class="fa-solid fa-pen"></i>
                                                            </button>

                                                            <c:if test="${sessionScope.account.id ne user.id}">
                                                                <button
                                                                    onclick='deleteUser("${user.id}", "${user.fullName}")'
                                                                    class="btn btn-danger">
                                                                    <i class="fa-solid fa-trash"></i>
                                                                </button>
                                                            </c:if>
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
                                        <!-- Previous page -->
                                        <c:if test="${currentPage > 1}">
                                            <li class="page-item">
                                                <a class="page-link" href="admin-manage-user?page=${currentPage - 1}&sortBy=${sortBy}&sortOrder=${sortOrder}&gender=${genderFilter}&role=${roleFilter}&status=${statusFilter}&search=${searchKeyword}">Previous</a>
                                            </li>
                                        </c:if>

                                        <!-- Page numbers -->
                                        <c:forEach begin="1" end="${totalPages}" var="i">
                                            <li class="page-item ${currentPage == i ? 'active' : ''}">
                                                <a class="page-link" href="admin-manage-user?page=${i}&sortBy=${sortBy}&sortOrder=${sortOrder}&gender=${genderFilter}&role=${roleFilter}&status=${statusFilter}&search=${searchKeyword}">${i}</a>
                                            </li>
                                        </c:forEach>

                                        <!-- Next page -->
                                        <c:if test="${currentPage < totalPages}">
                                            <li class="page-item">
                                                <a class="page-link" href="admin-manage-user?page=${currentPage + 1}&sortBy=${sortBy}&sortOrder=${sortOrder}&gender=${genderFilter}&role=${roleFilter}&status=${statusFilter}&search=${searchKeyword}">Next</a>
                                            </li>
                                        </c:if>
                                    </ul>
                                </div>

                                <!-- Records info -->
                                <div class="records-info text-center mt-2">
                                    <c:set var="startRecord" value="${(currentPage-1)*recordsPerPage + 1}" />
                                    <c:set var="endRecord" value="${currentPage*recordsPerPage}" />
                                    <c:if test="${endRecord > totalRecords}">
                                        <c:set var="endRecord" value="${totalRecords}" />
                                    </c:if>
                                    Showing ${startRecord} to ${endRecord} of ${totalRecords} records
                                </div>
                            </c:if>
                        </div>
                    </div>
                </div>

                <!-- Add User Modal -->
                <div id="addUserModal" class="modal">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h2>Add New User</h2>
                            <span class="close">&times;</span>
                        </div>
                        <form id="addUserForm" action="add-user" method="post">
                            <div class="form-group">
                                <label>Full Name</label>
                                <input type="text" name="fullName" required>
                            </div>

                            <div class="form-group">
                                <label>Email</label>
                                <input type="email" name="email" required>
                            </div>

                            <div class="form-group">
                                <label>Password</label>
                                <input type="password" name="password" required>
                            </div>

                            <div class="form-row" style="display: flex; gap: 20px;">
                                <div class="form-group" style="flex: 1;">
                                    <label>Gender</label>
                                    <div class="radio-group">
                                        <label class="radio-label">
                                            <input type="radio" name="gender" value="true" required>
                                            <span>Male</span>
                                        </label>
                                        <label class="radio-label">
                                            <input type="radio" name="gender" value="false" required>
                                            <span>Female</span>
                                        </label>
                                    </div>
                                </div>

                                <div class="form-group" style="flex: 1;">
                                    <label>Mobile</label>
                                    <input type="text" name="mobile" required>
                                </div>
                            </div>

                            <div class="form-group">
                                <label>Address</label>
                                <input type="text" name="address" required>
                            </div>

                            <div class="form-group">
                                <label>Role</label>
                                <div class="radio-group">
                                    <label class="radio-label">
                                        <input type="radio" name="roleId" value="1" required>
                                        <span>Admin</span>
                                    </label>
                                    <label class="radio-label">
                                        <input type="radio" name="roleId" value="2" required>
                                        <span>Manager</span>
                                    </label>
                                    <label class="radio-label">
                                        <input type="radio" name="roleId" value="3" required>
                                        <span>Staff</span>
                                    </label>
                                    <label class="radio-label">
                                        <input type="radio" name="roleId" value="4" required checked>
                                        <span>Customer</span>
                                    </label>
                                </div>
                            </div>

                            <div class="modal-footer">
                                <button type="submit" class="btn btn-primary">Add User</button>
                                <button type="button" class="btn btn-secondary close-modal">Cancel</button>
                            </div>
                        </form>
                    </div>
                </div>

                <!-- Edit User Modal -->
                <div id="editUserModal" class="modal">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h2>Edit User</h2>
                            <span class="close">&times;</span>
                        </div>
                        <form id="editUserForm" action="edit-user" method="post">
                            <input type="hidden" name="id" id="editUserId">

                            <div class="form-group">
                                <label>Full Name</label>
                                <input type="text" name="fullName" id="editFullName" required>
                            </div>

                            <div class="form-group">
                                <label>Email</label>
                                <input type="email" name="email" id="editEmail" required>
                            </div>

                            <div class="form-group">
                                <label>Gender</label>
                                <div class="radio-group">
                                    <label class="radio-label">
                                        <input type="radio" name="gender" id="editGenderMale" value="true">
                                        <span>Male</span>
                                    </label>
                                    <label class="radio-label">
                                        <input type="radio" name="gender" id="editGenderFemale" value="false">
                                        <span>Female</span>
                                    </label>
                                </div>
                            </div>

                            <div class="form-group">
                                <label>Mobile</label>
                                <input type="text" name="mobile" id="editMobile" required>
                            </div>

                            <div class="form-group">
                                <label>Address</label>
                                <input type="text" name="address" id="editAddress" required>
                            </div>

                            <!-- Role and Status in one line -->
                            <div class="form-row" style="display: flex; gap: 20px;">
                                <div class="form-group" style="flex: 1;">
                                    <label>Role</label>
                                    <select name="roleId" id="editRole">
                                        <option value="1">Admin</option>
                                        <option value="2">Manager</option>
                                        <option value="3">Staff</option>
                                        <option value="4">Customer</option>
                                    </select>
                                </div>

                                <div class="form-group" style="flex: 1;">
                                    <label>Status</label>
                                    <select name="status" id="editStatus">
                                        <option value="Active">Active</option>
                                        <option value="Inactive">Inactive</option>
                                    </select>
                                </div>
                            </div>

                            <div class="modal-footer">
                                <button type="submit" class="btn btn-primary">Save Changes</button>
                                <button type="button" class="btn btn-secondary close-modal">Cancel</button>
                            </div>
                        </form>
                    </div>
                </div>
                <jsp:include page="./common/common-homepage-footer.jsp"></jsp:include>
                </main>
            </div>
        </body>
        <script>
            // Define all functions first
            window.showAddModal = function () {
                document.getElementById('addUserModal').style.display = 'block';
            };

            window.showEditModal = function (userId) {
                // Fetch user data
                fetch('get-user-data?id=' + userId)
                        .then(response => response.json())
                        .then(user => {
                            // Populate form fields
                            document.getElementById('editUserId').value = user.id;
                            document.getElementById('editFullName').value = user.fullName;
                            document.getElementById('editEmail').value = user.email;
                            // Set gender radio button
                            if (user.gender) {
                                document.getElementById('editGenderMale').checked = true;
                            } else {
                                document.getElementById('editGenderFemale').checked = true;
                            }
                            document.getElementById('editMobile').value = user.mobile;
                            document.getElementById('editAddress').value = user.address;
                            document.getElementById('editRole').value = user.roleId;
                            document.getElementById('editStatus').value = user.status;

                            // Show modal
                            document.getElementById('editUserModal').style.display = 'block';
                        })
                        .catch(error => {
                            console.error('Error:', error);
                            alert('Error loading user data');
                        });
            }

            window.deleteUser = function (userId, userName) {
                // Check if trying to delete logged-in admin
                if (userId === '${sessionScope.account.id}') {
                    alert('Cannot delete your own admin account!');
                    return;
                }

                if (confirm('Are you sure you want to delete user: ' + userName + '?')) {
                    const form = document.createElement('form');
                    form.method = 'POST';
                    form.action = 'delete-user';

                    const input = document.createElement('input');
                    input.type = 'hidden';
                    input.name = 'id';
                    input.value = userId;

                    form.appendChild(input);
                    document.body.appendChild(form);
                    form.submit();
                }
            };

            window.changeLocation = function (url) {
                window.location.href = url;
            };

            // Modal handling
            document.addEventListener('DOMContentLoaded', function () {
                // Close buttons
                const closeButtons = document.getElementsByClassName('close');
                Array.from(closeButtons).forEach(button => {
                    button.onclick = function () {
                        this.closest('.modal').style.display = 'none';
                    };
                });

                // Close modal buttons
                const closeModalButtons = document.getElementsByClassName('close-modal');
                Array.from(closeModalButtons).forEach(button => {
                    button.onclick = function () {
                        this.closest('.modal').style.display = 'none';
                    };
                });

                // Close when clicking outside
                window.onclick = function (event) {
                    if (event.target.classList.contains('modal')) {
                        event.target.style.display = 'none';
                    }
                };

                // Debug log
                console.log('Modal handlers initialized');
            });

            // Sorting function
            function sortTable(column) {
                const currentUrl = new URL(window.location.href);
                const currentSortBy = currentUrl.searchParams.get('sortBy');
                const currentSortOrder = currentUrl.searchParams.get('sortOrder');

                let newSortOrder = 'asc';
                if (column === currentSortBy && currentSortOrder === 'asc') {
                    newSortOrder = 'desc';
                }

                currentUrl.searchParams.set('sortBy', column);
                currentUrl.searchParams.set('sortOrder', newSortOrder);

                window.location.href = currentUrl.toString();
            }

            // Thêm hàm validate phone number
            function validatePhoneNumber(phone) {
                const phoneRegex = /^0\d{9}$/;  // Bắt đầu bằng 0 và theo sau bởi 9 chữ số
                return phoneRegex.test(phone);
            }

            // Cập nhật validation cho form add user
            document.getElementById('addUserForm').onsubmit = function (e) {
                const mobile = this.querySelector('[name="mobile"]').value.trim();

                if (!validatePhoneNumber(mobile)) {
                    e.preventDefault();
                    alert('Phone number must be 10 digits and start with 0');
                    return false;
                }
                return true;
            };

            // Cập nhật validation cho form edit user
            document.getElementById('editUserForm').onsubmit = function (e) {
                const mobile = this.querySelector('[name="mobile"]').value.trim();

                if (!validatePhoneNumber(mobile)) {
                    e.preventDefault();
                    alert('Phone number must be 10 digits and start with 0');
                    return false;
                }
                return true;
            };

            // Thêm real-time validation cho input mobile
            document.querySelectorAll('input[name="mobile"]').forEach(input => {
                input.addEventListener('input', function () {
                    const mobile = this.value.trim();
                    if (mobile && !validatePhoneNumber(mobile)) {
                        this.style.borderColor = '#dc3545';
                        this.setCustomValidity('Phone number must be 10 digits and start with 0');
                    } else {
                        this.style.borderColor = '#28a745';
                        this.setCustomValidity('');
                    }
                });
            });

            // Thêm hàm hiển thị message
            function showMessage(message, isSuccess) {
                // Xóa message cũ nếu có
                const existingMessage = document.querySelector('.alert');
                if (existingMessage) {
                    existingMessage.remove();
                }

                // Tạo element cho message
                const messageDiv = document.createElement('div');
                messageDiv.className = `alert ${isSuccess ? 'alert-success' : 'alert-danger'}`;

                // Tùy chỉnh icon và message dựa trên loại thông báo
                if (isSuccess) {
                    messageDiv.innerHTML = `
                        <i class="fas fa-check-circle"></i>
                        <span><strong>Success!</strong> User has been updated successfully.</span>
                    `;
                } else {
                    messageDiv.innerHTML = `
                        <i class="fas fa-exclamation-circle"></i>
                        <span><strong>Error!</strong> ${message}</span>
                    `;
                }

                // Thêm vào đầu container
                const container = document.querySelector('.user-list-container');
                container.insertBefore(messageDiv, container.firstChild);

                // Scroll to top với animation mượt mà
                window.scrollTo({
                    top: 0,
                    behavior: 'smooth'
                });

                // Tự động ẩn sau 3 giây
                setTimeout(() => {
                    messageDiv.style.opacity = '0';
                    messageDiv.style.transition = 'opacity 0.5s';
                    setTimeout(() => {
                        if (messageDiv.parentNode) {
                            messageDiv.parentNode.removeChild(messageDiv);
                        }
                    }, 500);
                }, 3000);
            }

            // Sửa lại phần xử lý response trong form submit
            document.getElementById('editUserForm').addEventListener('submit', function (e) {
                e.preventDefault();

                const formData = {
                    id: document.getElementById('editUserId').value,
                    fullName: document.getElementById('editFullName').value,
                    email: document.getElementById('editEmail').value,
                    gender: document.querySelector('input[name="gender"]:checked').value,
                    mobile: document.getElementById('editMobile').value,
                    address: document.getElementById('editAddress').value,
                    roleId: document.getElementById('editRole').value,
                    status: document.getElementById('editStatus').value
                };

                fetch('edit-user', {
                    method: 'POST',
                    headers: {
                        'Content-Type': 'application/x-www-form-urlencoded',
                    },
                    body: new URLSearchParams(formData).toString()
                })
                        .then(response => response.json())
                        .then(data => {
                            // Đóng modal trước
                            document.getElementById('editUserModal').style.display = 'none';

                            if (data.success) {
                                // Hiển thị message thành công
                                showMessage(data.message, true);
                                // Reload page sau 1.5 giây
                                setTimeout(() => {
                                    location.reload();
                                }, 1500);
                            } else {
                                // Hiển thị message lỗi
                                showMessage(data.message, false);
                            }
                        })
                        .catch(error => {
                            console.error('Error:', error);
                            showMessage('Error updating user', false);
                        });
            });

            document.addEventListener('DOMContentLoaded', function () {
                let originalFormData = {};

                // Hàm kiểm tra có thay đổi nào không
                function hasFormChanged() {
                    const form = document.getElementById('editUserForm');
                    const currentValues = {
                        fullName: form.querySelector('#editFullName').value,
                        email: form.querySelector('#editEmail').value,
                        gender: form.querySelector('input[name="gender"]:checked').value,
                        mobile: form.querySelector('#editMobile').value,
                        address: form.querySelector('#editAddress').value,
                        roleId: form.querySelector('#editRole').value,
                        status: form.querySelector('#editStatus').value
                    };

                    // So sánh từng trường
                    return Object.keys(currentValues).some(key =>
                        currentValues[key] !== originalFormData[key]
                    );
                }

                // Cập nhật trạng thái nút Save Changes
                function updateSaveButton() {
                    const saveButton = document.querySelector('#editUserForm button[type="submit"]');
                    const changed = hasFormChanged();
                    saveButton.disabled = !changed;
                    saveButton.style.opacity = changed ? '1' : '0.5';
                    saveButton.style.cursor = changed ? 'pointer' : 'not-allowed';
                }

                // Sửa lại hàm showEditModal
                window.showEditModal = function (userId) {
                    fetch('get-user-data?id=' + userId)
                            .then(response => response.json())
                            .then(user => {
                                const form = document.getElementById('editUserForm');

                                // Populate form fields
                                form.querySelector('#editUserId').value = user.id;
                                form.querySelector('#editFullName').value = user.fullName;
                                form.querySelector('#editEmail').value = user.email;

                                // Set gender radio button
                                if (user.gender) {
                                    form.querySelector('#editGenderMale').checked = true;
                                } else {
                                    form.querySelector('#editGenderFemale').checked = true;
                                }

                                form.querySelector('#editMobile').value = user.mobile;
                                form.querySelector('#editAddress').value = user.address;
                                form.querySelector('#editRole').value = user.roleId;
                                form.querySelector('#editStatus').value = user.status;

                                // Lưu trữ dữ liệu ban đầu
                                originalFormData = {
                                    fullName: user.fullName,
                                    email: user.email,
                                    gender: user.gender.toString(),
                                    mobile: user.mobile,
                                    address: user.address,
                                    roleId: user.roleId.toString(),
                                    status: user.status
                                };

                                // Disable nút Save Changes ban đầu
                                updateSaveButton();

                                // Show modal
                                document.getElementById('editUserModal').style.display = 'block';
                            })
                            .catch(error => {
                                console.error('Error:', error);
                                alert('Error loading user data');
                            });
                }

                // Thêm event listeners cho tất cả các input trong form
                const editForm = document.getElementById('editUserForm');
                editForm.querySelectorAll('input, select').forEach(input => {
                    ['change', 'input', 'keyup'].forEach(eventType => {
                        input.addEventListener(eventType, updateSaveButton);
                    });
                });

                // Thêm event listener cho radio buttons
                editForm.querySelectorAll('input[type="radio"]').forEach(radio => {
                    radio.addEventListener('change', updateSaveButton);
                });

                // Reset form và originalFormData khi đóng modal
                const closeButtons = document.querySelectorAll('#editUserModal .close, #editUserModal .close-modal');
                closeButtons.forEach(button => {
                    button.addEventListener('click', () => {
                        originalFormData = {};
                        editForm.reset();
                        updateSaveButton();
                    });
                });
            });
    </script>


</html>