<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="utf-8" />
        <title>Add New Blog Post - Doctris</title>
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta name="description" content="Premium Bootstrap 4 Landing Page Template" />
        <meta name="keywords" content="Appointment, Booking, System, Dashboard, Health" />
        <meta name="author" content="Shreethemes" />
        <meta name="email" content="support@shreethemes.in" />
        <meta name="website" content="../../../index.html" />
        <meta name="Version" content="v1.2.0" />
        <!-- favicon -->
        <link rel="shortcut icon" href="${pageContext.request.contextPath}/assets/images/favicon.ico.png">
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
                                                        <input name="title" id="title" type="text" class="form-control" placeholder="Title:" required>
                                                    </div><!--end col-->

                                                    <div class="col-12 mb-3">
                                                        <label class="form-label">Description <span class="text-danger">*</span></label>
                                                        <textarea name="description" id="description" rows="3" class="form-control tinymce" placeholder="Description:" required></textarea>
                                                    </div><!--end col-->

                                                    <div class="col-12 mb-3">
                                                        <label class="form-label">Content <span class="text-danger">*</span></label>
                                                        <textarea name="content" id="content" rows="10" class="form-control tinymce" placeholder="Blog content here" required></textarea>
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
                                                    <input name="image" id="image" type="file" class="form-control" required>
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
        <script src="https://cdn.tiny.cloud/1/xj9owi87s6jlcm4kuhjjrbmgmkuc5iml198grpm1obgvw7r1/tinymce/7/tinymce.min.js" referrerpolicy="origin"></script>
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
                const form = document.getElementById('blogPostForm');
                const submitButton = document.getElementById('submitButton');

                submitButton.addEventListener('click', function (e) {
                    e.preventDefault();
                    if (validateForm()) {
                        form.submit();
                    }
                });

                function validateForm() {
                    const fields = [
                        {id: 'title', name: 'Title'},
                        {id: 'description', name: 'Description', isTinyMCE: true},
                        {id: 'content', name: 'Content', isTinyMCE: true},
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