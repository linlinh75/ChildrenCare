<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="utf-8" />
        <title>Profile</title>
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta name="description" content="Premium Bootstrap 4 Landing Page Template" />
        <meta name="keywords" content="Appointment, Booking, System, Dashboard, Health" />
        <meta name="author" content="Shreethemes" />
        <meta name="email" content="support@shreethemes.in" />
        <meta name="website" content="../../../index.html" />
        <meta name="Version" content="v1.2.0" />
        <!-- favicon -->
        <link rel="shortcut icon" href="img/favicon.png">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
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
            .logo img {
                width: 80%;
            }

        </style>
    </head>

    <body>
        <div class="page-wrapper doctris-theme toggled">
            <jsp:include page="../common/admin/side_bar_admin.jsp"></jsp:include>
                <!-- sidebar-wrapper  -->

                <!-- Start Page Content -->
                <main class="page-content bg-light">
                    <div class="container-fluid">
                    <jsp:include page="../common/common-homepage-header.jsp"></jsp:include>

                        <div class="layout-specing">
                        <c:if test="${successChange!=null}">
                            <div class="alert alert-success text-center" >
                                ${successChange}
                            </div></c:if>
                        <c:if test="${not empty error}">
                            <div class="alert alert-danger text-center">
                                ${error}
                            </div>
                        </c:if>
                        <c:if test="${not empty message}">
                            <div class="alert alert-success text-center">
                                ${message}
                            </div>
                        </c:if>
                        <div class="d-md-flex justify-content-between">
                            <a id="close-sidebar" class="btn btn-icon btn-pills btn-soft-primary ms-2" href="#">
                                <i class="uil uil-bars"></i>
                            </a>
                            <h5 class="mb-0">Profile</h5>

                            <nav aria-label="breadcrumb" class="d-inline-block mt-4 mt-sm-0">
                                <ul class="breadcrumb bg-transparent rounded mb-0 p-0">
                                    <li class="breadcrumb-item"><a href="HomeServlet">Home</a></li>
                                    <li class="breadcrumb-item active" aria-current="page">Profile</li>
                                </ul>
                            </nav>
                        </div>

                        <div class="row">
                            <div class="mt-4">
                                <div class="card border-0 shadow overflow-hidden">
                                    <ul class="nav nav-pills nav-justified flex-column flex-sm-row rounded-0 shadow overflow-hidden bg-white mb-0" id="pills-tab" role="tablist">
                                        <li class="nav-item">
                                            <a class="nav-link rounded-0 active" id="overview-tab" data-bs-toggle="pill" href="#pills-overview" role="tab" aria-controls="pills-overview" aria-selected="false">
                                                <div class="text-center pt-1 pb-1">
                                                    <h4 class="title fw-normal mb-0">Profile</h4>
                                                </div>
                                            </a><!--end nav link-->
                                        </li><!--end nav item-->
                                    </ul>

                                    <div class="tab-content p-4" id="pills-tabContent">
                                        <div class="tab-pane show active fade" id="pills-experience" role="tabpanel" aria-labelledby="experience-tab">
                                            <h5 class="mb-0">Personal Information :</h5>
                                            <div class="row align-items-center mt-4">
                                                <div class="col-lg-2 col-md-4">
                                                    <img src="${pageContext.request.contextPath}${account.imageLink}" class="avatar avatar-md-md rounded-pill shadow mx-auto d-block" alt="">
                                                </div><!--end col-->

                                                <div class="col-lg-5 col-md-8 text-center text-md-start mt-4 mt-sm-0">
                                                    <!--<h6 class="">Upload your picture</h6>-->
                                                    <p class="text-muted mb-0"></p>
                                                </div><!--end col-->
                                                <form id="imageUploadForm" action="${pageContext.request.contextPath}/profile" method="POST" enctype="multipart/form-data" style="display: none;">
                                                    <input type="file" id="profileImageInput" name="profileImage" accept="image/*">
                                                </form>
                                                <div class="col-lg-5 col-md-12 text-lg-right text-center mt-4 mt-lg-0">
                                                    <a href="#" class="btn btn-primary" id="uploadButton">Upload</a>
                                                    <!--<a href="#" class="btn btn-soft-primary ms-2" id="removeButton">Remove</a>-->
                                                </div><!--end col-->
                                            </div><!--end row-->

                                            <form class="mt-4" action="${pageContext.request.contextPath}/profile" enctype="multipart/form-data" method="POST">
                                                <div class="row">
                                                    <div class="col-lg-6">
                                                        <div class="mb-3">
                                                            <label class="form-label">Full Name</label>
                                                            <input name="fullName" id="fullName" type="text" class="form-control" value="${user.fullName}" >
                                                        </div>
                                                    </div>
                                                    <div class="col-lg-6">
                                                        <div class="mb-3">
                                                            <label class="form-label">Email</label>
                                                            <input name="email" id="email" type="email" class="form-control" value="${user.email}" readonly>
                                                        </div> 
                                                    </div>
                                                    <div class="col-lg-6">
                                                        <div class="mb-3">
                                                            <label class="form-label">Phone no.</label>
                                                            <input name="mobile" id="mobile" type="text" class="form-control" value="${user.mobile}" >
                                                        </div>                                                                               
                                                    </div>
                                                    <div class="col-lg-6">
                                                        <div class="mb-3">
                                                            <label class="form-label">Gender</label>
                                                            <input name="gender" id="gender" type="text" class="form-control" value="${user.gender ? 'Male' : 'Female'}" >
                                                        </div>
                                                    </div>
                                                    <div class="col-md-6">
                                                        <div class="mb-3">
                                                            <label class="form-label">Address</label>
                                                            <textarea name="address" id="address" rows="4" class="form-control" >${user.address}</textarea>
                                                        </div>
                                                    </div>
                                                    <div class="col-md-6">
                                                        <div class="mb-3">
                                                            <label class="form-label">Role</label>
                                                            <input name="role" id="role" type="text" class="form-control" value="${role}" readonly >
                                                        </div>
                                                    </div>
                                                </div>

                                                <div class="row">
                                                    <div class="col-sm-12">
                                                        <input type="submit" id="submit" name="send" class="btn btn-primary" value="Save changes">
                                                    </div><!--end col-->
                                                </div><!--end row-->
                                            </form><!--end form-->
                                        </div>
                                    </div>                     
                                </div>
                            </div><!--end col-->
                        </div><!--end row-->
                    </div>
                    <jsp:include page="../common/common-homepage-footer.jsp"></jsp:include>
                </div><!--end container-->

            </main>
            <!--End page-content" -->
        </div>
        <!-- page-wrapper -->

        <!-- javascript -->

        <script>
            document.getElementById('uploadButton').addEventListener('click', function (e) {
                e.preventDefault();
                document.getElementById('profileImageInput').click();
            });

            document.getElementById('profileImageInput').addEventListener('change', function () {
                if (this.files && this.files[0]) {
                    document.getElementById('imageUploadForm').submit();
                }
            });
        </script>
    </body>

</html>