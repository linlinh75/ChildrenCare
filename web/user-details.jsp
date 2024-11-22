<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>

    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>User Details</title>
        <link rel="stylesheet" href="./css/adminDashboard_style.css" />
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
        <style>
            .user-details-form {
                background: white;
                padding: 30px;
                border-radius: 10px;
                box-shadow: 0 0 15px rgba(0, 0, 0, 0.1);
                max-width: 800px;
                margin: 20px auto;
            }

            .form-header {
                display: flex;
                justify-content: space-between;
                align-items: center;
                margin-bottom: 30px;
                padding-bottom: 15px;
                border-bottom: 2px solid #eee;
            }

            .form-header h1 {
                color: #333;
                font-size: 24px;
                margin: 0;
            }

            .form-row {
                display: grid;
                grid-template-columns: repeat(2, 1fr);
                gap: 20px;
                margin-bottom: 20px;
            }

            .form-group {
                margin-bottom: 20px;
            }

            .form-group label {
                display: block;
                margin-bottom: 8px;
                color: #555;
                font-weight: 500;
            }

            .form-group input,
            .form-group select {
                width: 100%;
                padding: 10px;
                border: 1px solid #ddd;
                border-radius: 5px;
                font-size: 14px;
                transition: border-color 0.3s;
            }

            .form-group input:focus,
            .form-group select:focus {
                border-color: #4CAF50;
                outline: none;
                box-shadow: 0 0 5px rgba(76, 175, 80, 0.2);
            }

            .form-group input[readonly],
            .form-group select[disabled] {
                background-color: #f5f5f5;
                cursor: not-allowed;
            }

            .image-upload {
                text-align: center;
                margin-bottom: 20px;
            }

            .image-upload img {
                width: 150px;
                height: 150px;
                border-radius: 50%;
                object-fit: cover;
                margin-bottom: 10px;
                border: 3px solid #fff;
                box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            }

            .image-upload input[type="file"] {
                display: none;
            }

            .image-upload label {
                display: inline-block;
                padding: 8px 16px;
                background-color: #4CAF50;
                color: white;
                border-radius: 5px;
                cursor: pointer;
                transition: background-color 0.3s;
            }

            .image-upload label:hover {
                background-color: #45a049;
            }

            .form-actions {
                display: flex;
                justify-content: flex-end;
                gap: 10px;
                margin-top: 30px;
                padding-top: 20px;
                border-top: 1px solid #eee;
            }

            .btn {
                padding: 10px 20px;
                border: none;
                border-radius: 5px;
                cursor: pointer;
                font-weight: 500;
                transition: all 0.3s;
            }

            .btn-primary {
                background-color: #4CAF50;
                color: white;
            }

            .btn-secondary {
                background-color: #6c757d;
                color: white;
            }

            .btn:hover {
                transform: translateY(-2px);
                box-shadow: 0 2px 5px rgba(0, 0, 0, 0.2);
            }

            .alert {
                padding: 15px;
                margin-bottom: 20px;
                border-radius: 5px;
                font-weight: 500;
            }

            .alert-success {
                background-color: #d4edda;
                color: #155724;
                border: 1px solid #c3e6cb;
            }

            .alert-danger {
                background-color: #f8d7da;
                color: #721c24;
                border: 1px solid #f5c6cb;
            }

            .status-badge {
                display: inline-block;
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

            .user-container {
                margin-left: 0px;
            }
        </style>
    </head>

    <body>
        <jsp:include page="./common/common-homepage-header.jsp"></jsp:include>

            <div class="dashboard-container">
                <div class="user-container">
                    <div class="user-details-form">
                        <div class="form-header">
                            <h1><i class="fas fa-user-circle"></i> User Details</h1>
                            <div>
                                <a href="${pageContext.request.contextPath}/admin-manage-user" class="btn btn-secondary">
                                <i class="fas fa-arrow-left"></i> Back to Users List
                            </a>
                        </div>
                    </div>

                    <!-- Success/Error Messages -->
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

                    <!-- Separate image upload form -->


                    <!-- Main form for user details -->
                    <form id="userDetailsForm" action="user-details" method="POST" >
                        <input type="hidden" name="id" value="${user.id}">

                        <table class="table" style="height: 580px;">
                            <tr>
                                <td><label><i class="fas fa-user"></i> Full Name</label></td>
                                <td><input type="text" name="fullName" value="${user.fullName}" ${sessionScope.account.roleId==1 ? '' : 'readonly' }></td>
                                <td><label><i class="fas fa-envelope"></i> Email</label></td>
                                <td><input type="email" name="email" value="${user.email}" readonly></td>
                            </tr>
                            <tr>
                                <td><label><i class="fas fa-venus-mars"></i> Gender</label></td>
                                <td>
                                    <select name="gender" ${sessionScope.account.roleId==1 ? '' : 'disabled' }>
                                        <option value="true" ${user.gender ? 'selected' : '' }>Male</option>
                                        <option value="false" ${!user.gender ? 'selected' : '' }>Female</option>
                                    </select>
                                </td>
                                <td><label><i class="fas fa-phone"></i> Mobile</label></td>
                                <td><input type="text" name="mobile" value="${user.mobile}" ${sessionScope.account.roleId==1 ? '' : 'readonly' }></td>
                            </tr>
                            <tr>
                                <td><label><i class="fas fa-map-marker-alt"></i> Address</label></td>
                                <td><input type="text" name="address" value="${user.address}" ${sessionScope.account.roleId==1 ? '' : 'readonly' }></td>
                                <td><label><i class="fas fa-user-tag"></i> Role</label></td>
                                <td>
                                    <select name="roleId" ${(sessionScope.account.roleId==1 && user.roleId !=1) ? '' : 'disabled' }>

                                        <option value="1" ${user.roleId==1 ? 'selected' : '' }>Admin</option>
                                        <option value="2" ${user.roleId==2 ? 'selected' : '' }>Manager</option>

                                        <option value="3" ${user.roleId==3 ? 'selected' : '' }>Staff</option>
                                        <option value="4" ${user.roleId==4 ? 'selected' : '' }>Customer</option>
                                    </select>
                                    <c:if test="${user.roleId == 1}">
                                        <small class="text-muted">Admin role cannot be modified</small>
                                    </c:if>
                                </td>
                            </tr>
                            <tr>
                                <td><label><i class="fas fa-toggle-on"></i> Status</label></td>
                                <td>
                                    <select name="status" ${sessionScope.account.roleId==1 ? '' : 'disabled' }>
                                        <option value="Active" ${user.status=='Active' ? 'selected' : '' }>Active</option>
                                        <option value="Inactive" ${user.status=='Inactive' ? 'selected' : '' }>Inactive</option>
                                    </select>
                                </td>
                            </tr>
                        </table>

                        <div class="form-actions">
                            <button type="submit" class="btn btn-primary">
                                <i class="fas fa-save"></i> Save Changes
                            </button>
                        </div>
                    </form>

                </div>
            </div>
        </div>

        <script>
            document.getElementById('profileImage').addEventListener('change', function (e) {
                if (e.target.files && e.target.files[0]) {
                    // Show image preview
                    const reader = new FileReader();
                    reader.onload = function (e) {
                        document.querySelector('.image-upload img').src = e.target.result;
                    }
                    reader.readAsDataURL(e.target.files[0]);

                    // Submit image form
                    document.getElementById('imageUploadForm').submit();
                }
            });

            // Add form submission handling
            document.getElementById('userDetailsForm').addEventListener('submit', function (e) {
                e.preventDefault();

                // Log form data for debugging
                const formData = new FormData(this);
                console.log('Submitting form with data:');
                for (let pair of formData.entries()) {
                    console.log(pair[0] + ': ' + pair[1]);
                }

                // Submit the form
                this.submit();
            });
        </script>
        <jsp:include page="./common/common-homepage-footer.jsp"></jsp:include>

    </body>

</html>