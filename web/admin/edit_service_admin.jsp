<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8" />
        <title>Edit Service - Doctris</title>
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <!-- Include CSS files -->
        <link rel="shortcut icon" href="${pageContext.request.contextPath}/assets/images/favicon.ico.png">
        <link href="${pageContext.request.contextPath}/assets/css/bootstrap.min.css" rel="stylesheet" type="text/css" />
        <link href="${pageContext.request.contextPath}/assets/css/simplebar.css" rel="stylesheet" type="text/css" />
        <link href="${pageContext.request.contextPath}/assets/css/materialdesignicons.min.css" rel="stylesheet" type="text/css" />
        <link href="${pageContext.request.contextPath}/assets/css/remixicon.css" rel="stylesheet" type="text/css" />
        <link href="https://unicons.iconscout.com/release/v3.0.6/css/line.css"  rel="stylesheet">
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
                                                    <input name="fullname" id="fullname" type="text" class="form-control" value="${service.fullname}" required>
                                                </div>

                                                <div class="col-md-6 mb-3">
                                                    <label class="form-label">Original Price <span class="text-danger">*</span></label>
                                                    <input name="originalPrice" id="originalPrice" type="number" step="0.01" class="form-control" value="${service.originalPrice}" required>
                                                </div>

                                                <div class="col-md-6 mb-3">
                                                    <label class="form-label">Sale Price <span class="text-danger">*</span></label>
                                                    <input name="salePrice" id="salePrice" type="number" step="0.01" class="form-control" value="${service.salePrice}" required>
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
        <script src="https://cdn.tiny.cloud/1/xj9owi87s6jlcm4kuhjjrbmgmkuc5iml198grpm1obgvw7r1/tinymce/7/tinymce.min.js" referrerpolicy="origin"></script>
        <script>
            tinymce.init({
                selector: '.tinymce',
                plugins: [
                    'anchor', 'autolink', 'charmap', 'codesample', 'emoticons', 'image', 'link', 'lists', 'media', 'searchreplace', 'table', 'visualblocks', 'wordcount',
                ],
                toolbar: 'undo redo | blocks fontfamily fontsize | bold italic underline strikethrough | link image media table mergetags | align lineheight | checklist numlist bullist indent outdent | emoticons charmap | removeformat'
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

        <!-- Other JavaScript includes -->
        <script src="${pageContext.request.contextPath}/assets/js/bootstrap.bundle.min.js"></script>
        <script src="${pageContext.request.contextPath}/assets/js/simplebar.min.js"></script>
        <script src="${pageContext.request.contextPath}/assets/js/feather.min.js"></script>
        <script src="${pageContext.request.contextPath}/assets/js/app.js"></script>
    </body>
</html>