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
            .form-group select {
                width: 100%;
                padding: 10px;
                border: 1px solid #ddd;
                border-radius: 5px;
                font-size: 14px;
            }

            .form-group textarea {
                width: 100%;
                padding: 10px;
                border: 1px solid #ddd;
                border-radius: 5px;
                font-size: 14px;
                min-height: 120px;
                resize: vertical;
            }

            .form-group input:focus,
            .form-group select:focus,
            .form-group textarea:focus {
                outline: none;
                border-color: #4CAF50;
                box-shadow: 0 0 5px rgba(76, 175, 80, 0.2);
            }

            .form-actions {
                margin-top: 30px;
                padding-top: 20px;
                border-top: 1px solid #eee;
                text-align: right;
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
                margin-right: 10px;
            }

            .btn:hover {
                transform: translateY(-2px);
                box-shadow: 0 2px 5px rgba(0, 0, 0, 0.2);
            }

            .alert {
                padding: 15px;
                margin-bottom: 20px;
                border: 1px solid transparent;
                border-radius: 4px;
            }

            .alert-success {
                color: #155724;
                background-color: #d4edda;
                border-color: #c3e6cb;
            }

            .alert-danger {
                color: #721c24;
                background-color: #f8d7da;
                border-color: #f5c6cb;
            }

            .required-field::after {
                content: "*";
                color: red;
                margin-left: 4px;
            }

        </style>
    </head>

    <body>
        <jsp:include page="./common/common-homepage-header.jsp"></jsp:include>

        <div class="dashboard-container">
            <div class="user-container">
                <div class="setting-details-form">
                    <div class="form-header">
                        <h1><i class="fas fa-cog"></i> Setting Details</h1>
                        <div>
                            <a href="${pageContext.request.contextPath}/admin-manage-settings" class="btn btn-secondary">
                                <i class="fas fa-arrow-left"></i> Back to Settings List
                            </a>
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

                    <form action="edit-setting" method="POST" id="settingForm">
                        <input type="hidden" name="id" value="${setting.value}">

                        <div class="form-group">
                            <label><i class="fas fa-tag"></i> Type</label>
                            <select name="type" required>
                                <option value="Post Category" ${setting.type=='Post Category' ? 'selected' : ''}>Post Category</option>
                                <option value="Service Category" ${setting.type=='Service Category' ? 'selected' : ''}>Service Category</option>
                            </select>
                        </div>
                            <br><br><br>
                        <div class="form-group">
                            <label><i class="fas fa-font"></i> Name</label>
                            <input type="text" name="name" value="${setting.name}" required>
                        </div>

                        <div class="form-group">
                            <label><i class="fas fa-sort-numeric-up"></i> Value</label>
                            <input type="number" name="value" value="${setting.value}" readonly>
                        </div>

                        <div class="form-group">
                            <label><i class="fas fa-align-left"></i> Description</label>
                            <textarea name="description" required minlength="10">${setting.description}</textarea>
                        </div>

                        <div class="form-group">
                            <label><i class="fas fa-toggle-on"></i> Status</label>
                            <select name="status" required>
                                <option value="1" ${setting.status == 1 ? 'selected' : ''}>Active</option>
                                <option value="0" ${setting.status == 0 ? 'selected' : ''}>Inactive</option>
                            </select>
                        </div>
                            <br>

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
            document.getElementById('settingForm').onsubmit = function(e) {
                const name = this.querySelector('[name="name"]').value.trim();
                const description = this.querySelector('[name="description"]').value.trim();
                
                if (name.length < 2) {
                    e.preventDefault();
                    alert('Name must be at least 2 characters long');
                    return false;
                }
                
                if (description.length < 10) {
                    e.preventDefault();
                    alert('Description must be at least 10 characters long');
                    return false;
                }
                
                return true;
            };
        </script>

        <jsp:include page="./common/common-homepage-footer.jsp"></jsp:include>
    </body>
</html>