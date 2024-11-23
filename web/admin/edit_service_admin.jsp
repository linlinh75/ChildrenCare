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
        <title>Edit Service</title>
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <!-- Include CSS files -->
        <link rel="shortcut icon" href="img/favicon.png">
        <link href="${pageContext.request.contextPath}/assets/css/bootstrap.min.css" rel="stylesheet" type="text/css" />
        <link href="${pageContext.request.contextPath}/assets/css/simplebar.css" rel="stylesheet" type="text/css" />
        <link href="${pageContext.request.contextPath}/assets/css/materialdesignicons.min.css" rel="stylesheet" type="text/css" />
        <link href="${pageContext.request.contextPath}/assets/css/remixicon.css" rel="stylesheet" type="text/css" />
        <link href="https://unicons.iconscout.com/release/v3.0.6/css/line.css"  rel="stylesheet">
        <link href="${pageContext.request.contextPath}/assets/css/style.min.css" rel="stylesheet" type="text/css" id="theme-opt" />
        <style>
            .invalid-feedback.error {
                display: none;
                margin-top: 0.25rem;
                color: #dc3545;
                font-size: 0.875em;
            }

            .form-control.error {
                border-color: #dc3545;
                padding-right: calc(1.5em + 0.75rem);
                background-image: url("data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 12 12' width='12' height='12' fill='none' stroke='%23dc3545'%3e%3ccircle cx='6' cy='6' r='4.5'/%3e%3cpath stroke-linejoin='round' d='M5.8 3.6h.4L6 6.5z'/%3e%3ccircle cx='6' cy='8.2' r='.6' fill='%23dc3545' stroke='none'/%3e%3c/svg%3e");
                background-repeat: no-repeat;
                background-position: right calc(0.375em + 0.1875rem) center;
                background-size: calc(0.75em + 0.375rem) calc(0.75em + 0.375rem);
            }

            .form-control.error + .invalid-feedback.error {
                display: block;
            }

            .tox-tinymce.error {
                border: 1px solid #dc3545 !important;
            }

            .error-message {
                display: none;
                color: #dc3545;
                font-size: 0.875em;
                margin-top: 0.25rem;
            }

            .error-message.show {
                display: block;
            }
            
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
                            <h5 class="mb-0">Edit Service</h5>

                            <nav aria-label="breadcrumb" class="d-inline-block mt-4 mt-sm-0">
                                <ul class="breadcrumb bg-transparent rounded mb-0 p-0">
                                    <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/HomeServlet">ChildrenCare</a></li>
                                    <li class="breadcrumb-item"><a href="service-list-admin">Services</a></li>
                                    <li class="breadcrumb-item active" aria-current="page">Edit Service</li>
                                </ul>
                            </nav>
                        </div>

                        <div class="row">
                            <div class="col-lg-12 mt-4">
                                <div class="card border-0 p-4 rounded shadow">
                                    <div class="card-body">
                                        <form action="service-list-admin?action=update" method="post" enctype="multipart/form-data" id="serviceForm">
                                            <input type="hidden" name="id" value="${service.id}">
                                            <div class="row">
                                                <div class="col-12 mb-3">
                                                    <label class="form-label">Service Name <span class="text-danger">*</span></label>
                                                    <input name="fullname" id="fullname" type="text" class="form-control" style="display: block"  value="${service.fullname}" required>
                                                </div>

                                                <div class="col-md-6 mb-3">
                                                    <label class="form-label">Original Price <span class="text-danger">*</span></label>
                                                    <input name="originalPrice" id="originalPrice" type="number" step="0.01" class="form-control" style="display: block" value="${service.originalPrice}" required>
                                                </div>

                                                <div class="col-md-6 mb-3">
                                                    <label class="form-label">Sale Price <span class="text-danger">*</span></label>
                                                    <input name="salePrice" id="salePrice" type="number" step="0.01" class="form-control" style="display: block" value="${service.salePrice}" required>
                                                </div>

                                                <div class="col-12 mb-3">
                                                    <label class="form-label">Description <span class="text-danger">*</span></label>
                                                    <textarea name="description" id="description" rows="3" class="form-control tinymce" required>${service.description}</textarea>
                                                </div>

                                                <div class="col-12 mb-3">
                                                    <label class="form-label">Details <span class="text-danger">*</span></label>
                                                    <textarea name="details" id="details" rows="5" class="form-control tinymce" required>${service.details}</textarea>
                                                </div>

                                                <div class="col-md-6 mb-3">
                                                    <label class="form-label">Category <span class="text-danger">*</span></label>
                                                    <select class="form-control department-name select2input" name="category" id="category" required>
                                                        <c:forEach items="${listServiceCategories}" var="obj">
                                                            <option value="${obj.id}" ${service.categoryId == obj.id ? 'selected' : ''}>${obj.name}</option>
                                                        </c:forEach>
                                                    </select>
                                                </div>

                                                <div class="col-md-6 mb-3">
                                                    <label class="form-label">Current Image</label>
                                                    <img src="${service.thumbnailLink}" alt="Current thumbnail" style="max-width: 200px; display: block; margin-bottom: 10px;">
                                                    <label class="form-label">Upload New Image (leave empty to keep current image)</label>
                                                    <input name="image" id="image" type="file" class="form-control">
                                                </div>

                                                <div class="col-md-6 mb-3">
                                                    <div class="row">
                                                        <div class="col-md-6">
                                                            <div class="form-check">
                                                                <input class="form-check-input" type="checkbox" name="featured" id="featured" ${service.featured ? 'checked' : ''}>
                                                                <label class="form-check-label" for="featured">
                                                                    Featured Service
                                                                </label>
                                                            </div>
                                                        </div>
                                                        <div class="col-md-6">
                                                            <div class="form-check">
                                                                <input class="form-check-input" type="checkbox" name="status" id="status" ${service.status ? 'checked' : ''}>
                                                                <label class="form-check-label" for="status">
                                                                    Active Status
                                                                </label>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>

                                                <div class="col-12">
                                                    <button type="submit" class="btn btn-primary" id="submitButton">Update Service</button>
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

        <!-- TinyMCE Script -->
        <script src="https://cdn.tiny.cloud/1/y94nqpbwrk79akc3uj95ndt98wboci9arz3j4e3os3jnnwm4/tinymce/7/tinymce.min.js" referrerpolicy="origin"></script>
        
        <!-- JavaScript Libraries -->
        <script src="${pageContext.request.contextPath}/assets/js/bootstrap.bundle.min.js"></script>
        <script src="${pageContext.request.contextPath}/assets/js/simplebar.min.js"></script>
        <script src="${pageContext.request.contextPath}/assets/js/feather.min.js"></script>
        <script src="${pageContext.request.contextPath}/assets/js/app.js"></script>

        <!-- Validation Script -->
        <script>
            document.addEventListener('DOMContentLoaded', function () {
                var form = document.getElementById('serviceForm');
                var submitButton = document.getElementById('submitButton');
                var errorMessages = new Map();

                // Define fields
                var fields = [
                    {id: 'fullname', name: 'Service Name'},
                    {id: 'originalPrice', name: 'Original Price'},
                    {id: 'salePrice', name: 'Sale Price'},
                    {id: 'category', name: 'Category'}
                ];

                // Add error message elements
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
                        for (var i = 0; i < fields.length; i++) {
                            if (fields[i].id === fieldId) {
                                errorMessage = fields[i].name + ' cannot be empty';
                                break;
                            }
                        }
                    } else if (fieldId === 'originalPrice' || fieldId === 'salePrice') {
                        var value = parseFloat(element.value);
                        if (isNaN(value) || value <= 0) {
                            isValid = false;
                            for (var i = 0; i < fields.length; i++) {
                                if (fields[i].id === fieldId) {
                                    errorMessage = fields[i].name + ' must be greater than 0';
                                    break;
                                }
                            }
                        }
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

                function validateTinyMCE(editorId) {
                    var editor = tinymce.get(editorId);
                    var content = editor.getContent().trim();
                    var editorElement = document.getElementById(editorId);
                    var errorElement = document.getElementById(editorId + '-error');

                    if (!content) {
                        editorElement.classList.add('error');
                        errorElement.textContent = editorId.charAt(0).toUpperCase() +
                                editorId.slice(1) + ' cannot be empty';
                        errorElement.style.display = 'block';
                        errorMessages.set(editorId, errorElement.textContent);
                        return false;
                    }

                    editorElement.classList.remove('error');
                    errorElement.style.display = 'none';
                    errorMessages.delete(editorId);
                    return true;
                }

                function validatePrices() {
                    var originalPrice = parseFloat(document.getElementById('originalPrice').value);
                    var salePrice = parseFloat(document.getElementById('salePrice').value);
                    var salePriceError = document.getElementById('salePrice-error');

                    if (!isNaN(originalPrice) && !isNaN(salePrice) && salePrice > originalPrice) {
                        salePriceError.textContent = 'Sale price cannot be greater than original price';
                        salePriceError.style.display = 'block';
                        document.getElementById('salePrice').classList.add('error');
                        errorMessages.set('price-comparison', 'Sale price cannot be greater than original price');return false;
                    }
                    return true;
                }

                function performValidation() {
                    errorMessages.clear();
                    var isValid = true;

                    // Validate all fields
                    fields.forEach(function (field) {
                        if (!validateField(field.id)) {
                            isValid = false;
                        }
                    });

                    // Price comparison validation
                    if (!validatePrices()) {
                        isValid = false;
                    }

                    return isValid;
                }

                function checkAllValidations() {
                    var isValid = performValidation();
                    submitButton.disabled = !isValid;
                }

                // Initialize TinyMCE
                tinymce.init({
                    selector: '.tinymce',
                    setup: function(editor) {
                        editor.on('change', function() {
                            validateTinyMCE(editor.id);
                            checkAllValidations();
                        });
                    },
                    plugins: [ 
                        'anchor', 'autolink', 'charmap', 'codesample', 'emoticons', 'image', 
                        'link', 'lists', 'media', 'searchreplace', 'table', 'visualblocks', 'wordcount'
                    ],
                    toolbar: 'undo redo | blocks fontfamily fontsize | bold italic underline strikethrough | ' +
                            'link image media table mergetags | align lineheight | checklist numlist bullist indent outdent | ' +
                            'emoticons charmap | removeformat'
                });

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
    </body>
</html>