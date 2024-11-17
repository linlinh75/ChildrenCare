<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
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
        <title>Blogs list</title>
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
            .post-container {
                display: flex;
                flex-wrap: wrap;
            }

            .post-card {
                display: flex;
                flex-direction: column;
            }

            .post-image {
                width: 100%;
                height: 200px; /* Adjust as needed */
                object-fit: cover;
            }

            .post-title {
                display: -webkit-box;
                -webkit-line-clamp: 2;
                -webkit-box-orient: vertical;
                overflow: hidden;
                margin-bottom: 10px;
            }

            .card-body {
                display: flex;
                flex-direction: column;
                flex-grow: 1;
            }

            .post-meta {
                margin-top: auto;
            }

            .pagination {
                display: flex !important;
                padding-left: 0;
                list-style: none;
            }
        </style>

    </head>

    <body>
        <div class="page-wrapper doctris-theme toggled">
            <jsp:include page="../common/admin/side_bar_admin.jsp"></jsp:include>

                <!-- sidebar-wrapper  -->

                <!-- Start Page Content -->
                <main class="page-content bg-light">
                    <div class="top-header">
                        <div class="header-bar d-flex justify-content-between border-bottom">
                            <div class="d-flex align-items-center">
                                <a href="#" class="logo-icon">
                                    <img src="../assets/images/logo-icon.png" height="30" class="small" alt="">
                                    <span class="big">
                                        <img src="../assets/images/logo-dark.png" height="24" class="logo-light-mode" alt="">
                                        <img src="../assets/images/logo-light.png" height="24" class="logo-dark-mode" alt="">
                                    </span>
                                </a>
                                <a id="close-sidebar" class="btn btn-icon btn-pills btn-soft-primary ms-2" href="#">
                                    <i class="uil uil-bars"></i>
                                </a>
                            </div>

                            <!--                            <ul class="list-unstyled mb-0">
                                                            <li class="list-inline-item mb-0">
                                                                <div class="dropdown dropdown-primary">
                                                                    <button type="button" class="btn btn-pills btn-soft-primary dropdown-toggle p-0" data-bs-toggle="dropdown" aria-haspopup="true" aria-expanded="false"><img src="../assets/images/language/american.png" class="avatar avatar-ex-small rounded-circle p-2" alt=""></button>
                                                                    <div class="dropdown-menu dd-menu drop-ups dropdown-menu-end bg-white shadow border-0 mt-3 p-2" data-simplebar style="height: 175px;">
                                                                        <a href="javascript:void(0)" class="d-flex align-items-center">
                                                                            <img src="../assets/images/language/chinese.png" class="avatar avatar-client rounded-circle shadow" alt="">
                                                                            <div class="flex-1 text-left ms-2 overflow-hidden">
                                                                                <small class="text-dark mb-0">Chinese</small>
                                                                            </div>
                                                                        </a>
                            
                                                                        <a href="javascript:void(0)" class="d-flex align-items-center mt-2">
                                                                            <img src="../assets/images/language/european.png" class="avatar avatar-client rounded-circle shadow" alt="">
                                                                            <div class="flex-1 text-left ms-2 overflow-hidden">
                                                                                <small class="text-dark mb-0">European</small>
                                                                            </div>
                                                                        </a>
                            
                                                                        <a href="javascript:void(0)" class="d-flex align-items-center mt-2">
                                                                            <img src="../assets/images/language/indian.png" class="avatar avatar-client rounded-circle shadow" alt="">
                                                                            <div class="flex-1 text-left ms-2 overflow-hidden">
                                                                                <small class="text-dark mb-0">Indian</small>
                                                                            </div>
                                                                        </a>
                            
                                                                        <a href="javascript:void(0)" class="d-flex align-items-center mt-2">
                                                                            <img src="../assets/images/language/japanese.png" class="avatar avatar-client rounded-circle shadow" alt="">
                                                                            <div class="flex-1 text-left ms-2 overflow-hidden">
                                                                                <small class="text-dark mb-0">Japanese</small>
                                                                            </div>
                                                                        </a>
                            
                                                                        <a href="javascript:void(0)" class="d-flex align-items-center mt-2">
                                                                            <img src="../assets/images/language/russian.png" class="avatar avatar-client rounded-circle shadow" alt="">
                                                                            <div class="flex-1 text-left ms-2 overflow-hidden">
                                                                                <small class="text-dark mb-0">Russian</small>
                                                                            </div>
                                                                        </a>
                                                                    </div>
                                                                </div>
                                                            </li>
                            
                                                            <li class="list-inline-item mb-0 ms-1">
                                                                <a href="javascript:void(0)" data-bs-toggle="offcanvas" data-bs-target="#offcanvasRight" aria-controls="offcanvasRight">
                                                                    <div class="btn btn-icon btn-pills btn-soft-primary"><i data-feather="settings" class="fea icon-sm"></i></div>
                                                                </a>
                                                            </li>
                            
                                                            <li class="list-inline-item mb-0 ms-1">
                                                                <div class="dropdown dropdown-primary">
                                                                    <button type="button" class="btn btn-icon btn-pills btn-soft-primary dropdown-toggle p-0" data-bs-toggle="dropdown" aria-haspopup="true" aria-expanded="false"><i data-feather="mail" class="fea icon-sm"></i></button>
                                                                    <span class="position-absolute top-0 start-100 translate-middle badge rounded-pill bg-danger">4 <span class="visually-hidden">unread mail</span></span>
                            
                                                                    <div class="dropdown-menu dd-menu dropdown-menu-end bg-white shadow rounded border-0 mt-3 px-2 py-2" data-simplebar style="height: 320px; width: 300px;">
                                                                        <a href="#" class="d-flex align-items-center justify-content-between py-2">
                                                                            <div class="d-inline-flex position-relative overflow-hidden">
                                                                                <img src="../assets/images/client/02.jpg" class="avatar avatar-md-sm rounded-circle shadow" alt="">
                                                                                <small class="text-dark mb-0 d-block text-truncat ms-3">You received a new email from <b>Janalia</b> <small class="text-muted fw-normal d-inline-block">1 hour ago</small></small>
                                                                            </div>
                                                                        </a>
                            
                                                                        <a href="#" class="d-flex align-items-center justify-content-between py-2 border-top">
                                                                            <div class="d-inline-flex position-relative overflow-hidden">
                                                                                <img src="../assets/images/client/Codepen.svg" class="avatar avatar-md-sm rounded-circle shadow" alt="">
                                                                                <small class="text-dark mb-0 d-block text-truncat ms-3">You received a new email from <b>codepen</b>  <small class="text-muted fw-normal d-inline-block">4 hour ago</small></small>
                                                                            </div>
                                                                        </a>
                            
                                                                        <a href="#" class="d-flex align-items-center justify-content-between py-2 border-top">
                                                                            <div class="d-inline-flex position-relative overflow-hidden">
                                                                                <img src="../assets/images/client/03.jpg" class="avatar avatar-md-sm rounded-circle shadow" alt="">
                                                                                <small class="text-dark mb-0 d-block text-truncat ms-3">You received a new email from <b>Cristina</b> <small class="text-muted fw-normal d-inline-block">5 hour ago</small></small>
                                                                            </div>
                                                                        </a>
                            
                                                                        <a href="#" class="d-flex align-items-center justify-content-between py-2 border-top">
                                                                            <div class="d-inline-flex position-relative overflow-hidden">
                                                                                <img src="../assets/images/client/dribbble.svg" class="avatar avatar-md-sm rounded-circle shadow" alt="">
                                                                                <small class="text-dark mb-0 d-block text-truncat ms-3">You received a new email from <b>Dribbble</b> <small class="text-muted fw-normal d-inline-block">24 hour ago</small></small>
                                                                            </div>
                                                                        </a>
                            
                                                                        <a href="#" class="d-flex align-items-center justify-content-between py-2 border-top">
                                                                            <div class="d-inline-flex position-relative overflow-hidden">
                                                                                <img src="../assets/images/client/06.jpg" class="avatar avatar-md-sm rounded-circle shadow" alt="">
                                                                                <small class="text-dark mb-0 d-block text-truncat ms-3">You received a new email from <b>Donald Aghori</b> <small class="text-muted fw-normal d-inline-block">1 day ago</small></small>
                                                                            </div>
                                                                        </a>
                            
                                                                        <a href="#" class="d-flex align-items-center justify-content-between py-2 border-top">
                                                                            <div class="d-inline-flex position-relative overflow-hidden">
                                                                                <img src="../assets/images/client/07.jpg" class="avatar avatar-md-sm rounded-circle shadow" alt="">
                                                                                <small class="text-dark mb-0 d-block text-truncat ms-3">You received a new email from <b>Calvin</b> <small class="text-muted fw-normal d-inline-block">2 day ago</small></small>
                                                                            </div>
                                                                        </a>
                                                                    </div>
                                                                </div>
                                                            </li>
                            
                                                            <li class="list-inline-item mb-0 ms-1">
                                                                <div class="dropdown dropdown-primary">
                                                                    <button type="button" class="btn btn-pills btn-soft-primary dropdown-toggle p-0" data-bs-toggle="dropdown" aria-haspopup="true" aria-expanded="false"><img src="../assets/images/doctors/01.jpg" class="avatar avatar-ex-small rounded-circle" alt=""></button>
                                                                    <div class="dropdown-menu dd-menu dropdown-menu-end bg-white shadow border-0 mt-3 py-3" style="min-width: 200px;">
                                                                        <a class="dropdown-item d-flex align-items-center text-dark" href="https://shreethemes.in/doctris/layouts/admin/profile.html">
                                                                            <img src="../assets/images/doctors/01.jpg" class="avatar avatar-md-sm rounded-circle border shadow" alt="">
                                                                            <div class="flex-1 ms-2">
                                                                                <span class="d-block mb-1">Calvin Carlo</span>
                                                                                <small class="text-muted">Orthopedic</small>
                                                                            </div>
                                                                        </a>
                                                                        <a class="dropdown-item text-dark" href="index.html"><span class="mb-0 d-inline-block me-1"><i class="uil uil-dashboard align-middle h6"></i></span> Dashboard</a>
                                                                        <a class="dropdown-item text-dark" href="dr-profile.html"><span class="mb-0 d-inline-block me-1"><i class="uil uil-setting align-middle h6"></i></span> Profile Settings</a>
                                                                        <div class="dropdown-divider border-top"></div>
                                                                        <a class="dropdown-item text-dark" href="lock-screen.html"><span class="mb-0 d-inline-block me-1"><i class="uil uil-sign-out-alt align-middle h6"></i></span> Logout</a>
                                                                    </div>
                                                                </div>
                                                            </li>
                                                        </ul>-->
                        </div>
                    </div>

                    <div class="container-fluid">
                    <jsp:include page="../common/common-homepage-header.jsp"></jsp:include>
                        <div class="layout-specing">
                            <div class="d-md-flex justify-content-between mb-3">
                                <div class="mt-4 mt-sm-0 ms-auto">
                                    <a href="post-list-admin?action=add" class="btn btn-primary" >Add Blog</a>
                                </div>
                            </div>
                            <div class="row mb-4">
                                <div class="col-12">
                                    <div class="d-flex align-items-center justify-content-between">
                                        <div class="btn-group" role="group">
                                            <span class="me-2">Filter by status:</span>
                                            <a href="post-list-admin?status=all" class="btn btn-sm ${param.status == null || param.status.equalsIgnoreCase('all') ? 'btn-primary' : 'btn-outline-primary'}">
                                            All
                                        </a>
                                        <a href="post-list-admin?status=Published" class="btn btn-sm ${param.status.equalsIgnoreCase('Published') ? 'btn-primary' : 'btn-outline-success'}">
                                            Published
                                        </a>
                                        <a href="post-list-admin?status=Hidden" class="btn btn-sm ${param.status.equalsIgnoreCase('Hidden') ? 'btn-primary' : 'btn-outline-secondary'}">
                                            Hidden
                                        </a>
                                    </div>
                                    <div class="search-bar p-0">
                                        <div id="search" class=" mb-0">
                                            <form method="get" id="searchform" class="searchform" action="post-list-admin">
                                                <div class="d-flex align-items-center">
                                                    <input type="text" 
                                                           class="form-control border rounded-pill me-2" 
                                                           name="searchQuery" 
                                                           id="searchQuery" 
                                                           placeholder="Search Keywords..."
                                                           value="${param.searchQuery}">
                                                    <!-- Preserve status parameter when searching -->
                                                    <input type="hidden" name="status" value="${param.status}">
                                                    <button type="submit" class="btn btn-primary">
                                                        Search
                                                    </button>
                                                </div>
                                            </form>
                                        </div>
                                    </div>

                                </div>
                            </div>
                        </div>
                        <div class="row post-container">
                            <c:forEach items="${posts}" var="post">
                                <div class="col-xl-3 col-lg-4 col-md-6 col-12 mt-4">
                                    <div class="card blog blog-primary border-0 shadow rounded overflow-hidden post-card h-100">
                                        <img src="${post.thumbnailLink}" class="post-image" alt="">
                                        <div class="card-body p-4 d-flex flex-column">
                                            <div class="mb-2">
                                                <c:choose>
                                                    <c:when test="${fn:toLowerCase(post.statusId) == 'published'}">
                                                        <span class="badge bg-soft-success rounded-pill">Published</span>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <span class="badge bg-soft-danger rounded-pill">Hidden</span>
                                                    </c:otherwise>
                                                </c:choose>
                                            </div>
                                            <ul class="list-unstyled mb-2">
                                                <li class="list-inline-item text-muted small me-3">
                                                    <i class="uil uil-calendar-alt text-dark h6 me-1"></i>${post.updatedDate}
                                                </li>
                                            </ul>
                                            <a href="post-list-admin?action=edit&id=${post.id}" class="text-dark title h5 post-title">${post.title}</a>
                                            <div class="post-meta mt-auto d-flex justify-content-between align-items-center">
                                                <a href="post-list-admin?action=remove&id=${post.id}" class="btn btn-sm btn-soft-danger">
                                                    <i class="uil uil-trash"></i> Remove
                                                </a>
                                                <a href="post-list-admin?action=edit&id=${post.id}" class="btn btn-sm btn-soft-warning">
                                                    <i class="uil uil-edit"></i> Edit
                                                </a>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </c:forEach>
                        </div><!--end row-->

                        <div class="row">
                            <div class="col-12 mt-4">
                                <nav aria-label="Page navigation">
                                    <ul class="pagination justify-content-end mb-0">
                                        <!-- Previous Button -->
                                        <li class="page-item ${currentPage == 1 ? 'disabled' : ''}">
                                            <a class="page-link" href="?page=${currentPage - 1}&status=${param.status}&searchQuery=${param.searchQuery}" aria-label="Previous">Prev</a>
                                        </li>

                                        <!-- Page Numbers -->
                                        <c:forEach begin="1" end="${totalPages}" var="i">
                                            <li class="page-item ${currentPage == i ? 'active' : ''}">
                                                <a class="page-link" href="?page=${i}&status=${param.status}&searchQuery=${param.searchQuery}">${i}</a>
                                            </li>
                                        </c:forEach>

                                        <!-- Next Button -->
                                        <li class="page-item ${currentPage == totalPages ? 'disabled' : ''}">
                                            <a class="page-link" href="?page=${currentPage + 1}&status=${param.status}&searchQuery=${param.searchQuery}" aria-label="Next">Next</a>
                                        </li>
                                    </ul>
                                </nav>
                            </div>
                        </div>

                    </div>

                    <!--Footer-->
                    <jsp:include page="../common/common-homepage-header.jsp"></jsp:include>
                    </div><!--end container-->

                </main>
                <!--End page-content" -->
            </div>
            <!-- page-wrapper -->

            <!-- Offcanvas Start -->
            <div class="offcanvas offcanvas-end bg-white shadow" tabindex="-1" id="offcanvasRight" aria-labelledby="offcanvasRightLabel">
                <div class="offcanvas-header p-4 border-bottom">
                    <h5 id="offcanvasRightLabel" class="mb-0">
                        <img src="../assets/images/logo-dark.png" height="24" class="light-version" alt="">
                        <img src="../assets/images/logo-light.png" height="24" class="dark-version" alt="">
                    </h5>
                    <button type="button" class="btn-close d-flex align-items-center text-dark" data-bs-dismiss="offcanvas" aria-label="Close"><i class="uil uil-times fs-4"></i></button>
                </div>
                <div class="offcanvas-body p-4 px-md-5">
                    <div class="row">
                        <div class="col-12">
                            <!-- Style switcher -->
                            <div id="style-switcher">
                                <div>
                                    <ul class="text-center list-unstyled mb-0">
                                        <li class="d-grid"><a href="javascript:void(0)" class="rtl-version t-rtl-light" onclick="setTheme('style-rtl')"><img src="../assets/images/layouts/light-dash-rtl.png" class="img-fluid rounded-md shadow-md d-block" alt=""><span class="text-muted mt-2 d-block">RTL Version</span></a></li>
                                        <li class="d-grid"><a href="javascript:void(0)" class="ltr-version t-ltr-light" onclick="setTheme('style')"><img src="../assets/images/layouts/light-dash.png" class="img-fluid rounded-md shadow-md d-block" alt=""><span class="text-muted mt-2 d-block">LTR Version</span></a></li>
                                        <li class="d-grid"><a href="javascript:void(0)" class="dark-rtl-version t-rtl-dark" onclick="setTheme('style-dark-rtl')"><img src="../assets/images/layouts/dark-dash-rtl.png" class="img-fluid rounded-md shadow-md d-block" alt=""><span class="text-muted mt-2 d-block">RTL Version</span></a></li>
                                        <li class="d-grid"><a href="javascript:void(0)" class="dark-ltr-version t-ltr-dark" onclick="setTheme('style-dark')"><img src="../assets/images/layouts/dark-dash.png" class="img-fluid rounded-md shadow-md d-block" alt=""><span class="text-muted mt-2 d-block">LTR Version</span></a></li>
                                        <li class="d-grid"><a href="javascript:void(0)" class="dark-version t-dark mt-4" onclick="setTheme('style-dark')"><img src="../assets/images/layouts/dark-dash.png" class="img-fluid rounded-md shadow-md d-block" alt=""><span class="text-muted mt-2 d-block">Dark Version</span></a></li>
                                        <li class="d-grid"><a href="javascript:void(0)" class="light-version t-light mt-4" onclick="setTheme('style')"><img src="../assets/images/layouts/light-dash.png" class="img-fluid rounded-md shadow-md d-block" alt=""><span class="text-muted mt-2 d-block">Light Version</span></a></li>
                                        <li class="d-grid"><a href="../landing/index.html" target="_blank" class="mt-4"><img src="../assets/images/layouts/landing-light.png" class="img-fluid rounded-md shadow-md d-block" alt=""><span class="text-muted mt-2 d-block">Landing Demos</span></a></li>
                                    </ul>
                                </div>
                            </div>
                            <!-- end Style switcher -->
                        </div><!--end col-->
                    </div><!--end row-->
                </div>

                <div class="offcanvas-footer p-4 border-top text-center">
                    <ul class="list-unstyled social-icon mb-0">
                        <li class="list-inline-item mb-0"><a href="https://1.envato.market/doctris-template" target="_blank" class="rounded"><i class="uil uil-shopping-cart align-middle" title="Buy Now"></i></a></li>
                        <li class="list-inline-item mb-0"><a href="https://dribbble.com/shreethemes" target="_blank" class="rounded"><i class="uil uil-dribbble align-middle" title="dribbble"></i></a></li>
                        <li class="list-inline-item mb-0"><a href="https://www.facebook.com/shreethemes" target="_blank" class="rounded"><i class="uil uil-facebook-f align-middle" title="facebook"></i></a></li>
                        <li class="list-inline-item mb-0"><a href="https://www.instagram.com/shreethemes/" target="_blank" class="rounded"><i class="uil uil-instagram align-middle" title="instagram"></i></a></li>
                        <li class="list-inline-item mb-0"><a href="https://twitter.com/shreethemes" target="_blank" class="rounded"><i class="uil uil-twitter align-middle" title="twitter"></i></a></li>
                        <li class="list-inline-item mb-0"><a href="mailto:support@shreethemes.in" class="rounded"><i class="uil uil-envelope align-middle" title="email"></i></a></li>
                        <li class="list-inline-item mb-0"><a href="../../../index.html" target="_blank" class="rounded"><i class="uil uil-globe align-middle" title="website"></i></a></li>
                    </ul><!--end icon-->
                </div>
            </div>
            <!-- Offcanvas End -->

            <!-- javascript -->
            <script src="${pageContext.request.contextPath}/assets/js/bootstrap.bundle.min.js"></script>
        <!-- simplebar -->
        <script src="${pageContext.request.contextPath}/assets/js/simplebar.min.js"></script>
        <!-- Icons -->
        <script src="${pageContext.request.contextPath}/assets/js/feather.min.js"></script>
        <!-- Main Js -->
        <script src="${pageContext.request.contextPath}/assets/js/app.js"></script>

        <!-- jquery Min JS -->
        <script src="js/jquery.min.js"></script>
        <!-- jquery Migrate JS -->
        <script src="js/jquery-migrate-3.0.0.js"></script>
        <!-- jquery Ui JS -->
        <script src="js/jquery-ui.min.js"></script>
        <!-- Easing JS -->
        <script src="js/easing.js"></script>
        <!-- Color JS -->
        <script src="js/colors.js"></script>
        <!-- Popper JS -->
        <script src="js/popper.min.js"></script>
        <!-- Bootstrap Datepicker JS -->
        <script src="js/bootstrap-datepicker.js"></script>
        <!-- Jquery Nav JS -->
        <script src="js/jquery.nav.js"></script>
        <!-- Slicknav JS -->
        <script src="js/slicknav.min.js"></script>
        <!-- ScrollUp JS -->
        <script src="js/jquery.scrollUp.min.js"></script>
        <!-- Niceselect JS -->
        <script src="js/niceselect.js"></script>
        <!-- Tilt Jquery JS -->
        <script src="js/tilt.jquery.min.js"></script>
        <!-- Owl Carousel JS -->
        <script src="js/owl-carousel.js"></script>
        <!-- counterup JS -->
        <script src="js/jquery.counterup.min.js"></script>
        <script src="js/waypoints.min.js"></script>
        <!-- Steller JS -->
        <script src="js/steller.js"></script>
        <!-- Wow JS -->
        <script src="js/wow.min.js"></script>
        <!-- Magnific Popup JS -->
        <script src="js/jquery.magnific-popup.min.js"></script>
        <!-- Counter Up CDN JS -->
        <script src="http://cdnjs.cloudflare.com/ajax/libs/waypoints/2.0.3/waypoints.min.js"></script>
        <!-- Bootstrap JS -->
        <script src="js/bootstrap.min.js"></script>
        <!-- Main JS -->
        <script src="js/main.js"></script>

        <script>
                                            const handleChange = () => {
                                                const fileUploader = document.querySelector('#input-file');
                                                const getFile = fileUploader.files
                                                if (getFile.length !== 0) {
                                                    const uploadedFile = getFile[0];
                                                    readFile(uploadedFile);
                                                }
                                            }

                                            const readFile = (uploadedFile) => {
                                                if (uploadedFile) {
                                                    const reader = new FileReader();
                                                    reader.onload = () => {
                                                        const parent = document.querySelector('.preview-box');
                                                        parent.innerHTML = `<img class="preview-content" src=${reader.result} />`;
                                                    };

                                                    reader.readAsDataURL(uploadedFile);
                                                }
                                            };
        </script>
    </body>

</html>