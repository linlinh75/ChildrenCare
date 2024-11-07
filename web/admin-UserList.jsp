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
    </head>

    <body>
        <jsp:include page="./common/common-homepage-header.jsp"></jsp:include>
        <jsp:include page="./common/admin/side_bar_admin.jsp"></jsp:include>

            <div class="dashboard-container">
                <!-- Sidebar -->
                <!--                <div class="side-navbar-container">
                                    <h3>Admin Dashboard</h3>
                                    <ul>
                                        <li onclick="changeLocation('${pageContext.request.contextPath}/home')">
                                        <i class="fa-solid fa-house"></i>
                                        <span>Home</span>
                                    </li>
                                    <li onclick="changeLocation('${pageContext.request.contextPath}/admin-manage-user')"
                                        class="active">
                                        <i class="fa-solid fa-users"></i>
                                        <span>User Management</span>
                                    </li>
                                    <li onclick="changeLocation('${pageContext.request.contextPath}/admin-manage-service')">
                                        <i class="fa-solid fa-stethoscope"></i>
                                        <span>Services</span>
                                    </li>
                                    <li onclick="changeLocation('${pageContext.request.contextPath}/admin-manage-reservation')">
                                        <i class="fa-solid fa-calendar-check"></i>
                                        <span>Reservations</span>
                                    </li>
                                </ul>
                            </div>-->

            <!-- Main Content -->
            <div class="user-container">
                <div class="user-list-container fade-in">
                    <h1 class="user-container-table">User Management</h1>

                    <!-- Success/Error Messages -->
                    <c:if test="${not empty successMessage}">
                        <div class="alert alert-success">
                            <i class="fas fa-check-circle"></i>
                            ${successMessage}
                        </div>
                    </c:if>
                    <c:if test="${not empty errorMessage}">
                        <div class="alert alert-danger">
                            <i class="fas fa-exclamation-circle"></i>
                            ${errorMessage}
                        </div>
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
                            <div class="filter-group">
                                <label>Gender:</label>
                                <select name="gender">
                                    <option value="">All</option>
                                    <option value="true" ${genderFilter=='true' ? 'selected' : '' }>Male
                                    </option>
                                    <option value="false" ${genderFilter=='false' ? 'selected' : '' }>Female
                                    </option>
                                </select>
                            </div>

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
                                <c:if test="${empty listUser}">
                                <div class="alert alert-info">
                                    Debug: No users found in the list
                                </div>
                            </c:if>
                            
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

                    <div class="form-group">
                        <label>Gender</label>
                        <select name="gender">
                            <option value="true">Male</option>
                            <option value="false">Female</option>
                        </select>
                    </div>

                    <div class="form-group">
                        <label>Mobile</label>
                        <input type="text" name="mobile" required>
                    </div>

                    <div class="form-group">
                        <label>Address</label>
                        <input type="text" name="address" required>
                    </div>

                    <div class="form-group">
                        <label>Role</label>
                        <select name="roleId">
                            <option value="1">Admin</option>
                            <option value="2">Manager</option>
                            <option value="3">Staff</option>
                            <option value="4">Customer</option>
                        </select>
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
                        <select name="gender" id="editGender">
                            <option value="true">Male</option>
                            <option value="false">Female</option>
                        </select>
                    </div>

                    <div class="form-group">
                        <label>Mobile</label>
                        <input type="text" name="mobile" id="editMobile" required>
                    </div>

                    <div class="form-group">
                        <label>Address</label>
                        <input type="text" name="address" id="editAddress" required>
                    </div>

                    <div class="form-group">
                        <label>Role</label>
                        <select name="roleId" id="editRole">
                            <option value="1">Admin</option>
                            <option value="2">Manager</option>
                            <option value="3">Staff</option>
                            <option value="4">Customer</option>
                        </select>
                    </div>

                    <div class="form-group">
                        <label>Status</label>
                        <select name="status" id="editStatus">
                            <option value="Active">Active</option>
                            <option value="Inactive">Inactive</option>
                        </select>
                    </div>

                    <div class="modal-footer">
                        <button type="submit" class="btn btn-primary">Save Changes</button>
                        <button type="button" class="btn btn-secondary close-modal">Cancel</button>
                    </div>
                </form>
            </div>
        </div>

        <script>
            // Define all functions first
            window.showAddModal = function () {
                document.getElementById('addUserModal').style.display = 'block';
            }

            window.showEditModal = function (userId) {
                fetch('edit-user?id=' + userId)
                        .then(response => {
                            if (!response.ok) {
                                throw new Error('Network response was not ok');
                            }
                            return response.json();
                        })
                        .then(user => {
                            document.getElementById('editUserId').value = user.id;
                            document.getElementById('editFullName').value = user.fullName;
                            document.getElementById('editEmail').value = user.email;
                            document.getElementById('editGender').value = user.gender.toString();
                            document.getElementById('editMobile').value = user.mobile;
                            document.getElementById('editAddress').value = user.address;
                            document.getElementById('editRole').value = user.roleId;
                            document.getElementById('editStatus').value = user.status;

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
            }

            window.changeLocation = function (url) {
                window.location.href = url;
            }

            // Modal handling
            document.addEventListener('DOMContentLoaded', function () {
                // Close buttons
                const closeButtons = document.getElementsByClassName('close');
                Array.from(closeButtons).forEach(button => {
                    button.onclick = function () {
                        this.closest('.modal').style.display = 'none';
                    }
                });

                // Close modal buttons
                const closeModalButtons = document.getElementsByClassName('close-modal');
                Array.from(closeModalButtons).forEach(button => {
                    button.onclick = function () {
                        this.closest('.modal').style.display = 'none';
                    }
                });

                // Close when clicking outside
                window.onclick = function (event) {
                    if (event.target.classList.contains('modal')) {
                        event.target.style.display = 'none';
                    }
                }

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
        </script>
        <jsp:include page="./common/common-homepage-footer.jsp"></jsp:include>

    </body>

</html>