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
        <title>Add New Service</title>
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
                                <h5 class="mb-0">Add New Service</h5>

                                <nav aria-label="breadcrumb" class="d-inline-block mt-4 mt-sm-0">
                                    <ul class="breadcrumb bg-transparent rounded mb-0 p-0">
                                        <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/HomeServlet">ChildrenCare</a></li>
                                    <li class="breadcrumb-item"><a href="service-list-admin">Services</a></li>
                                    <li class="breadcrumb-item active" aria-current="page">Add Service</li>
                                </ul>
                            </nav>
                        </div>

                        <div class="row">
                            <div class="col-lg-12 mt-4">
                                <div class="card border-0 p-4 rounded shadow">
                                    <div class="card-body">
                                        <form action="service-list-admin?action=add" method="post" enctype="multipart/form-data" id="serviceForm">
                                            <div class="row">
                                                <div class="col-12 mb-3">
                                                    <label class="form-label">Service Name <span class="text-danger">*</span></label>
                                                    <input name="fullname" id="fullname" type="text" class="form-control" placeholder="Service name:" required>
                                                </div><!--end col-->

                                                <div class="col-md-6 mb-3">
                                                    <label class="form-label">Original Price <span class="text-danger">*</span></label>
                                                    <input name="originalPrice" id="originalPrice" type="number" step="0.01" class="form-control" placeholder="Original price:" required>
                                                </div><!--end col-->

                                                <div class="col-md-6 mb-3">
                                                    <label class="form-label">Sale Price <span class="text-danger">*</span></label>
                                                    <input name="salePrice" id="salePrice" type="number" step="0.01" class="form-control" placeholder="Sale price:" required>
                                                </div><!--end col-->

                                                <div class="col-12 mb-3">
                                                    <label class="form-label">Description <span class="text-danger">*</span></label>
                                                    <textarea name="description" id="description" rows="3" class="form-control tinymce" placeholder="Description:" required></textarea>
                                                </div><!--end col-->

                                                <div class="col-12 mb-3">
                                                    <label class="form-label">Details <span class="text-danger">*</span></label>
                                                    <textarea name="details" id="details" rows="5" class="form-control tinymce" placeholder="Service details here" required></textarea>
                                                </div><!--end col-->

                                                <div class="col-md-6 mb-3">
                                                    <label class="form-label">Category <span class="text-danger">*</span></label>
                                                    <select class="form-control department-name select2input" name="category" id="category" required>
                                                        <c:forEach items="${listServiceCategories}" var="obj">
                                                            <option value="${obj.id}">${obj.name}</option>
                                                        </c:forEach>
                                                    </select>
                                                </div><!--end col-->

                                                <div class="col-md-6 mb-3">
                                                    <label class="form-label">Upload Image <span class="text-danger">*</span></label>
                                                    <input name="image" id="image" type="file" class="form-control" required>
                                                </div><!--end col-->

                                                <div class="col-md-6 mb-3">
                                                    <div class="row">
                                                        <div class="col-md-6">
                                                            <div class="form-check">
                                                                <input class="form-check-input" type="checkbox" name="featured" id="featured">
                                                                <label class="form-check-label" for="featured">
                                                                    Featured Service
                                                                </label>
                                                            </div>
                                                        </div>
                                                        <div class="col-md-6">
                                                            <div class="form-check">
                                                                <input class="form-check-input" type="checkbox" name="status" id="status" checked>
                                                                <label class="form-check-label" for="status">
                                                                    Active Status
                                                                </label>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div><!--end col-->

                                                <div class="col-12">
                                                    <button type="submit" class="btn btn-primary" id="submitButton">Create Service</button>
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

        <!-- Form Validation Script -->
        <script>
            document.addEventListener('DOMContentLoaded', function () {
                const form = document.getElementById('serviceForm');
                const submitButton = document.getElementById('submitButton');

                submitButton.addEventListener('click', function (e) {
                    e.preventDefault();
                    if (validateForm()) {
                        form.submit();
                    }
                });

                function validateForm() {
                    const fields = [
                        {id: 'fullname', name: 'Service Name'},
                        {id: 'originalPrice', name: 'Original Price'},
                        {id: 'salePrice', name: 'Sale Price'},
                        {id: 'description', name: 'Description', isTinyMCE: true},
                        {id: 'details', name: 'Details', isTinyMCE: true},
                        {id: 'category', name: 'Category'},
                        {id: 'image', name: 'Image'}
                    ];

                    let isValid = true;
                    let emptyFields = [];

                    fields.forEach(field => {
                        let value = field.isTinyMCE
                                ? tinymce.get(field.id).getContent().trim()
                                : document.getElementById(field.id).value.trim();

                        if (!value) {
                            isValid = false;
                            emptyFields.push(field.name);
                        }
                    });

                    if (!isValid) {
                        alert('Please fill in the following required fields: ' + emptyFields.join(', '));
                        return false;
                    }

                    // Additional price validation
                    const originalPrice = parseFloat(document.getElementById('originalPrice').value);
                    const salePrice = parseFloat(document.getElementById('salePrice').value);

                    if (originalPrice <= 0) {
                        alert('Original price must be greater than 0');
                        return false;
                    }

                    if (salePrice <= 0) {
                        alert('Sale price must be greater than 0');
                        return false;
                    }

                    if (salePrice > originalPrice) {
                        alert('Sale price cannot be greater than original price');
                        return false;
                    }

                    return true;
                }
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