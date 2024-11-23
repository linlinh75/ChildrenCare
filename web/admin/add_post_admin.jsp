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
        <title>Add New Blog Post </title>
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta name="description" content="Premium Bootstrap 4 Landing Page Template" />
        <meta name="keywords" content="Appointment, Booking, System, Dashboard, Health" />
        <meta name="author" content="Shreethemes" />
        <meta name="email" content="support@shreethemes.in" />
        <meta name="website" content="../../../index.html" />
        <meta name="Version" content="v1.2.0" />
        <!-- favicon -->
        <link rel="shortcut icon" href="img/favicon.png">
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
                                <h5 class="mb-0">Add New Blog Post</h5>

                                <nav aria-label="breadcrumb" class="d-inline-block mt-4 mt-sm-0">
                                    <ul class="breadcrumb bg-transparent rounded mb-0 p-0">
                                        <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/HomeServlet">ChildrenCare</a></li>
                                    <li class="breadcrumb-item"><a href="post-list-admin">Blogs</a></li>
                                    <li class="breadcrumb-item active" aria-current="page">Add Post</li>
                                </ul>
                            </nav>
                        </div>

                        <div class="row">
                            <div class="col-lg-12 mt-4">
                                <div class="card border-0 p-4 rounded shadow">
                                    <div class="card-body">
                                        <form action="post-list-admin?action=add" method="post" enctype="multipart/form-data" id="blogPostForm">
                                            <div class="row">
                                                <div class="col-12 mb-3">
                                                    <label class="form-label">Post Title <span class="text-danger">*</span></label>
                                                    <input name="title" id="title" type="text" class="form-control" style="display: block" placeholder="Title:" required>
                                                </div><!--end col-->

                                                <div class="col-12 mb-3">
                                                    <label class="form-label">Description</label>
                                                    <textarea name="description" id="description" rows="3" class="form-control tinymce" placeholder="Description:"></textarea>
                                                </div><!--end col-->

                                                <div class="col-12 mb-3">
                                                    <label class="form-label">Content</label>
                                                    <textarea name="content" id="content" rows="10" class="form-control tinymce" placeholder="Blog content here"></textarea>
                                                </div><!--end col-->

                                                <div class="col-md-6 mb-3">
                                                    <label class="form-label">Category <span class="text-danger">*</span></label>
                                                    <select class="form-control department-name select2input" name="category" id="category" required>
                                                        <c:forEach items="${listPostCategorys}" var="obj">
                                                            <option value="${obj.id}">${obj.name}</option>
                                                        </c:forEach>
                                                    </select>
                                                </div><!--end col-->

                                                <div class="col-md-6 mb-3">
                                                    <label class="form-label">Upload Image <span class="text-danger">*</span></label>
                                                    <input name="image" id="image" style="display: block" type="file" class="form-control" required>
                                                </div><!--end col-->

                                                <div class="col-md-6 mb-3">
                                                    <label class="form-label">Status <span class="text-danger">*</span></label>
                                                    <select class="form-control" name="status" id="status" required>
                                                        <option value="published">Published</option>
                                                        <option value="hidden">Hidden</option>
                                                    </select>
                                                </div><!--end col-->

                                                <div class="col-12">
                                                    <button type="submit" class="btn btn-primary" id="submitButton">Create Post</button>
                                                </div><!--end col-->
                                            </div><!--end row-->
                                        </form>

                                    </div>
                                </div>
                            </div><!--end col-->
                        </div><!--end row-->
                    </div>
                </div><!--end container-->
            </main><!--End page-content" -->
        </div>
        <!-- page-wrapper -->
        <!-- TinyMCE Script -->
        <script src="https://cdn.tiny.cloud/1/y94nqpbwrk79akc3uj95ndt98wboci9arz3j4e3os3jnnwm4/tinymce/7/tinymce.min.js" referrerpolicy="origin"></script>
        <script>
            tinymce.init({
                selector: '.tinymce',
                plugins: [
                    'anchor', 'autolink', 'charmap', 'codesample', 'emoticons', 'image', 'link', 'lists', 'media', 'searchreplace', 'table', 'visualblocks', 'wordcount',
                    'checklist', 'mediaembed', 'casechange', 'export', 'formatpainter', 'pageembed', 'permanentpen', 'footnotes', 'advtemplate', 'mentions', 'tinymcespellchecker', 'a11ychecker', 'tinydrive', 'tableofcontents', 'autocorrect', 'typography', 'inlinecss', 'markdown'
                ],
                toolbar: 'undo redo | blocks fontfamily fontsize | bold italic underline strikethrough | link image media table mergetags | align lineheight | checklist numlist bullist indent outdent | emoticons charmap | removeformat',
                tinycomments_mode: 'embedded',
                tinycomments_author: 'Author name',
                mergetags_list: [
                    {value: 'First.Name', title: 'First Name'},
                    {value: 'Email', title: 'Email'},
                ]
            });
        </script>
        <script>
            document.addEventListener('DOMContentLoaded', function () {
                var form = document.getElementById('blogPostForm');
                var submitButton = document.getElementById('submitButton');
                var errorMessages = new Map();

                // Define only title and image fields for validation
                var fields = [
                    {id: 'title', name: 'Title'},
                    {id: 'image', name: 'Image'}
                ];

                // Add error message elements for title and image
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

                    if (!fileInput.files || fileInput.files.length === 0) {
                        fileInput.classList.add('error');
                        errorElement.textContent = 'Please select an image';
                        errorElement.style.display = 'block';
                        errorMessages.set('image', 'Please select an image');
                        return false;
                    }

                    fileInput.classList.remove('error');
                    errorElement.style.display = 'none';
                    errorMessages.delete('image');
                    return true;
                }

                function performValidation() {
                    errorMessages.clear();
                    var isValid = true;

                    // Validate title
                    if (!validateField('title')) {
                        isValid = false;
                    }

                    // Validate file input
                    if (!validateFileInput()) {
                        isValid = false;
                    }

                    return isValid;
                }

                function checkAllValidations() {
                    var isValid = performValidation();
                    submitButton.disabled = !isValid;
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
//                checkAllValidations();
            });
        </script>

        <!-- javascript -->
        <script src="${pageContext.request.contextPath}/assets/js/bootstrap.bundle.min.js"></script>
        <!-- simplebar -->
        <script src="${pageContext.request.contextPath}/assets/js/simplebar.min.js"></script>
        <!-- Icons -->
        <script src="${pageContext.request.contextPath}/assets/js/feather.min.js"></script>
        <!-- Main Js -->
        <script src="${pageContext.request.contextPath}/assets/js/app.js"></script>

    </body>

</html>