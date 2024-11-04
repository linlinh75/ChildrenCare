<%@ page contentType="text/html" pageEncoding="UTF-8" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
        <!DOCTYPE html>
        <html>

        <head>
            <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
            <title>Edit User</title>
            <link rel="stylesheet" href="./css/adminDashboard_style.css" />
            <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
        </head>

        <body>
            <div class="dashboard-container">
                <!-- Include your sidebar here -->

                <div class="user-container">
                    <div class="user-list-container">
                        <h1 class="user-container-table">Edit User</h1>

                        <form action="edit-user" method="post" class="edit-form">
                            <input type="hidden" name="id" value="${user.id}">

                            <div class="form-group">
                                <label>Full Name</label>
                                <input type="text" name="fullName" value="${user.fullName}" required>
                            </div>

                            <div class="form-group">
                                <label>Email</label>
                                <input type="email" name="email" value="${user.email}" required>
                            </div>

                            <div class="form-group">
                                <label>Gender</label>
                                <select name="gender">
                                    <option value="true" ${user.gender ? 'selected' : '' }>Male</option>
                                    <option value="false" ${!user.gender ? 'selected' : '' }>Female</option>
                                </select>
                            </div>

                            <div class="form-group">
                                <label>Mobile</label>
                                <input type="text" name="mobile" value="${user.mobile}" required>
                            </div>

                            <div class="form-group">
                                <label>Address</label>
                                <input type="text" name="address" value="${user.address}" required>
                            </div>

                            <div class="form-group">
                                <label>Role</label>
                                <select name="roleId">
                                    <option value="1" ${user.roleId==1 ? 'selected' : '' }>Admin</option>
                                    <option value="2" ${user.roleId==2 ? 'selected' : '' }>Manager</option>
                                    <option value="3" ${user.roleId==3 ? 'selected' : '' }>Staff</option>
                                    <option value="4" ${user.roleId==4 ? 'selected' : '' }>Customer</option>
                                </select>
                            </div>

                            <div class="form-group">
                                <label>Status</label>
                                <select name="status">
                                    <option value="Active" ${user.status=='Active' ? 'selected' : '' }>Active</option>
                                    <option value="Inactive" ${user.status=='Inactive' ? 'selected' : '' }>Inactive
                                    </option>
                                </select>
                            </div>

                            <div class="form-actions">
                                <button type="submit" class="btn btn-primary">Save Changes</button>
                                <button type="button" class="btn btn-secondary"
                                    onclick="window.location.href='admin-manage-user'">Cancel</button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </body>

        </html>