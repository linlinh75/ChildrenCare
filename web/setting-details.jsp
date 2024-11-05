<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <!DOCTYPE html>
    <html>

    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Setting Details</title>
        <link rel="stylesheet" href="./css/adminDashboard_style.css" />
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
        <style>
            .setting-details-form {
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
            .form-group select,
            .form-group textarea {
                width: 100%;
                padding: 10px;
                border: 1px solid #ddd;
                border-radius: 5px;
                font-size: 14px;
            }

            .form-group textarea {
                min-height: 100px;
                resize: vertical;
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
        <div class="dashboard-container">

            <div class="user-container">
                <div class="setting-details-form">
                    <div class="form-header">
                        <h1><i class="fas fa-cog"></i> Setting Details</h1>
                        <div>

                            <button onclick="history.back()" class="btn btn-secondary">
                                <i class="fas fa-arrow-left"></i> Back
                            </button>
                        </div>
                    </div>

                    <!-- Success/Error Messages -->
                    <c:if test="${not empty sessionScope.successMessage}">
                        <div class="alert alert-success">
                            <i class="fas fa-check-circle"></i> ${sessionScope.successMessage}
                            <% session.removeAttribute("successMessage"); %>
                        </div>
                    </c:if>
                    <c:if test="${not empty sessionScope.errorMessage}">
                        <div class="alert alert-danger">
                            <i class="fas fa-exclamation-circle"></i> ${sessionScope.errorMessage}
                            <% session.removeAttribute("errorMessage"); %>
                        </div>
                    </c:if>

                    <form action="edit-setting" method="POST">
                        <input type="hidden" name="id" value="${setting.id}">

                        <div class="form-group">
                            <label><i class="fas fa-tag"></i> Type</label>
                            <select name="type" required>
                                <option value="Role" ${setting.type=='Role' ? 'selected' : '' }>Role</option>
                                <option value="Post Category" ${setting.type=='Post Category' ? 'selected' : '' }>Post
                                    Category</option>
                                <option value="Service Category" ${setting.type=='Service Category' ? 'selected' : '' }>
                                    Service Category</option>
                                <option value="User Status" ${setting.type=='User Status' ? 'selected' : '' }>User
                                    Status</option>
                            </select>
                        </div>

                        <div class="form-group">
                            <label><i class="fas fa-font"></i> Name</label>
                            <input type="text" name="name" value="${setting.name}" required>
                        </div>

                        <div class="form-group">
                            <label><i class="fas fa-sort-numeric-up"></i> Value</label>
                            <input type="number" name="value" value="${setting.value}" required>
                        </div>

                        <div class="form-group">
                            <label><i class="fas fa-align-left"></i> Description</label>
                            <textarea name="description" rows="4">${setting.description}</textarea>
                        </div>

                        <div class="form-group">
                            <label><i class="fas fa-toggle-on"></i> Status</label>
                            <select name="status" required>
                                <option value="Active" ${setting.status=='Active' ? 'selected' : '' }>Active</option>
                                <option value="Inactive" ${setting.status=='Inactive' ? 'selected' : '' }>Inactive
                                </option>
                            </select>
                        </div>

                        <div class="form-actions">
                            <button type="submit" class="btn btn-primary">
                                <i class="fas fa-save"></i> Save Changes
                            </button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </body>

    </html>