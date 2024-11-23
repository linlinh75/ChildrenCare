<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:if test="${empty sessionScope.account}">
    <c:redirect url="login.jsp"/>
</c:if>

<c:if test="${not empty sessionScope.account}">
    <c:choose>
        <c:when test="${sessionScope.account.roleId != '2'}">
            <c:redirect url="404.html"/>
        </c:when>
    </c:choose>
</c:if>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8" />
    <title>Edit Blog Post - Doctris</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <!-- Include the same CSS files as in add_post_admin.jsp -->
    <link rel="shortcut icon" href="${pageContext.request.contextPath}/assets/images/favicon.ico.png">
    <link href="${pageContext.request.contextPath}/assets/css/bootstrap.min.css" rel="stylesheet" type="text/css" />
    <link href="${pageContext.request.contextPath}/assets/css/simplebar.css" rel="stylesheet" type="text/css" />
    <link href="${pageContext.request.contextPath}/assets/css/materialdesignicons.min.css" rel="stylesheet" type="text/css" />
    <link href="${pageContext.request.contextPath}/assets/css/remixicon.css" rel="stylesheet" type="text/css" />
    <link href="https://unicons.iconscout.com/release/v3.0.6/css/line.css"  rel="stylesheet">
    <link href="${pageContext.request.contextPath}/assets/css/style.min.css" rel="stylesheet" type="text/css" id="theme-opt" />
    <style>
        .error {
            display: block;
        }
    </style>
</head>

<body>
<!-- Loader -->
<div id="preloader">
    <div id="status">
        <div class="spinner">
            <div class="double-bounce1"></div>
            <div class="double-bounce2"></div>
        </div>
    </div>
</div>
<!-- Loader -->

<div class="page-wrapper doctris-theme toggled">
    <jsp:include page="../common/admin/side_bar_admin.jsp"></jsp:include>

    <!-- Start Page Content -->
    <main class="page-content bg-light">
        <div class="container-fluid">
            <div class="layout-specing">
                <div class="d-md-flex justify-content-between">
                    <h5 class="mb-0">Edit Blog Post</h5>

                    <nav aria-label="breadcrumb" class="d-inline-block mt-4 mt-sm-0">
                        <ul class="breadcrumb bg-transparent rounded mb-0 p-0">
                            <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/HomeServlet">ChildrenCare</a></li>
                            <li class="breadcrumb-item"><a href="post-list-admin">Blogs</a></li>
                            <li class="breadcrumb-item active" aria-current="page">Edit Post</li>
                        </ul>
                    </nav>
                </div>

                <div class="row">
                    <div class="col-lg-12 mt-4">
                        <div class="card border-0 p-4 rounded shadow">
                            <div class="card-body">
                                <form action="post-list-admin?action=update" method="post" enctype="multipart/form-data" id="blogPostForm">
                                    <input type="hidden" name="id" value="${post.id}">
                                    <div class="row">
                                        <div class="col-12 mb-3">
                                            <label class="form-label">Post Title <span class="text-danger">*</span></label>
                                            <input name="title" id="title" type="text" class="form-control" style="display: block" value="${post.title}" required>
                                        </div>

                                        <div class="col-12 mb-3">
                                            <label class="form-label">Description <span class="text-danger">*</span></label>
                                            <textarea name="description" id="description" rows="3" class="form-control tinymce" required>${post.description}</textarea>
                                        </div>

                                        <div class="col-12 mb-3">
                                            <label class="form-label">Content <span class="text-danger">*</span></label>
                                            <textarea name="content" id="content" rows="10" class="form-control tinymce" required>${post.content}</textarea>
                                        </div>

                                        <div class="col-md-6 mb-3">
                                            <label class="form-label">Category <span class="text-danger">*</span></label>
                                            <select class="form-control department-name select2input" name="category" id="category" required>
                                                <c:forEach items="${listPostCategorys}" var="obj">
                                                    <option value="${obj.id}" ${post.categoryId == obj.id ? 'selected' : ''}>${obj.name}</option>
                                                </c:forEach>
                                            </select>
                                        </div>

                                        <div class="col-md-6 mb-3">
                                            <label class="form-label">Current Image</label>
                                            <img src="${post.thumbnailLink}" alt="Current thumbnail" style="max-width: 200px; display: block; margin-bottom: 10px;">
                                            <label class="form-label">Upload New Image (leave empty to keep current image)</label>
                                            <input name="image" id="image" type="file" class="form-control">
                                        </div>

                                        <div class="col-md-6 mb-3">
                                            <label class="form-label">Status <span class="text-danger">*</span></label>
                                            <select class="form-control" name="status" id="status" required>
                                                <option value="published" ${post.statusId == 'published' ? 'selected' : ''}>Published</option>
                                                <option value="hidden" ${post.statusId == 'hidden' ? 'selected' : ''}>Hidden</option>
                                            </select>
                                        </div>

                                        <div class="col-12">
                                            <button type="submit" class="btn btn-primary">Update Post</button>
                                        </div>
                                    </div>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </main>
</div>

<!-- Include the same JavaScript files and TinyMCE initialization as in add_post_admin.jsp -->
<script src="https://cdn.tiny.cloud/1/y94nqpbwrk79akc3uj95ndt98wboci9arz3j4e3os3jnnwm4/tinymce/7/tinymce.min.js" referrerpolicy="origin"></script>
<script>
    tinymce.init({
        selector: '.tinymce',
        plugins: [
            'anchor', 'autolink', 'charmap', 'codesample', 'emoticons', 'image', 'link', 'lists', 'media', 'searchreplace', 'table', 'visualblocks', 'wordcount',
        ],
        toolbar: 'undo redo | blocks fontfamily fontsize | bold italic underline strikethrough | link image media table mergetags | align lineheight | checklist numlist bullist indent outdent | emoticons charmap | removeformat'
    });
</script>
<script>
    document.addEventListener('DOMContentLoaded', function () {
        var form = document.getElementById('blogPostForm');
        var submitButton = document.getElementById('submitButton');
        var errorMessages = new Map();

        // Only validate title for edit form
        var fields = [
            {id: 'title', name: 'Title'}
        ];

        // Add error message element for title
        fields.forEach(function (field) {
            var element = document.getElementById(field.id);
            if (element) {
                var errorDiv = document.createElement('div');
                errorDiv.className = 'invalid-feedback error';
                errorDiv.id = field.id + '-error';
                element.parentNode.insertBefore(errorDiv, element.nextSibling);

                element.addEventListener('input', function () {
                    validateField(field.id);
                    checkAllValidations();
                });

                element.addEventListener('blur', function () {
                    validateField(field.id);
                    checkAllValidations();
                });
            }
        });

        function validateField(fieldId) {
            var element = document.getElementById(fieldId);
            var errorElement = document.getElementById(fieldId + '-error');
            var isValid = true;
            var errorMessage = '';

            if (!element.value.trim()) {
                isValid = false;
                errorMessage = 'Title cannot be empty';
            }

            if (!isValid) {
                element.classList.add('error');
                errorElement.textContent = errorMessage;
                errorElement.style.display = 'block';
                errorMessages.set(fieldId, errorMessage);
            } else {
                element.classList.remove('error');
                errorElement.style.display = 'none';
                errorMessages.delete(fieldId);
            }

            return isValid;
        }

        function validateFileInput() {
            var fileInput = document.getElementById('image');
            var errorElement = document.getElementById('image-error');

            // Image is optional in edit form - always return true if no file selected
            if (!fileInput.files || fileInput.files.length === 0) {
                if (errorElement) {
                    errorElement.style.display = 'none';
                }
                return true;
            }

            // If a file is selected, perform basic validation (you can add more specific validation if needed)
            var file = fileInput.files[0];
            var validTypes = ['image/jpeg', 'image/png', 'image/gif', 'image/webp'];

            if (!validTypes.includes(file.type)) {
                if (errorElement) {
                    fileInput.classList.add('error');
                    errorElement.textContent = 'Please select a valid image file (JPEG, PNG, GIF, WEBP)';
                    errorElement.style.display = 'block';
                }
                return false;
            }

            if (errorElement) {
                fileInput.classList.remove('error');
                errorElement.style.display = 'none';
            }
            return true;
        }

        function performValidation() {
            errorMessages.clear();
            var isValid = true;

            // Validate title
            if (!validateField('title')) {
                isValid = false;
            }

            // Validate file input only if a file is selected
            if (!validateFileInput()) {
                isValid = false;
            }

            return isValid;
        }

        function checkAllValidations() {
            var isValid = performValidation();
            // Note: We don't disable the submit button here since it's an edit form
            // and we want to allow updates even without changing the image
        }

        // Prevent form submission on Enter key
        form.addEventListener('keypress', function (e) {
            if (e.key === 'Enter') {
                e.preventDefault();
                return false;
            }
        });

        // Handle form submission
        form.addEventListener('submit', function (e) {
            e.preventDefault();
            if (performValidation()) {
                this.submit();
            }
        });

        // Initial validation check
        checkAllValidations();
    });
</script>
<script src="${pageContext.request.contextPath}/assets/js/bootstrap.bundle.min.js"></script>
<script src="${pageContext.request.contextPath}/assets/js/simplebar.min.js"></script>
<script src="${pageContext.request.contextPath}/assets/js/feather.min.js"></script>
<script src="${pageContext.request.contextPath}/assets/js/app.js"></script>
</body>
</html>