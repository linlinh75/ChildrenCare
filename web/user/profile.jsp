<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="utf-8" />
        <title>Doctris - Doctor Appointment Booking System</title>
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta name="description" content="Premium Bootstrap 4 Landing Page Template" />
        <meta name="keywords" content="Appointment, Booking, System, Dashboard, Health" />
        <meta name="author" content="Shreethemes" />
        <meta name="email" content="support@shreethemes.in" />
        <meta name="website" content="../../../index.html" />
        <meta name="Version" content="v1.2.0" />
        <!-- favicon -->
        <link rel="shortcut icon" href="${pageContext.request.contextPath}/assets/images/favicon.ico.png">
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
            <nav id="sidebar" class="sidebar-wrapper">
                <div class="sidebar-content" data-simplebar style="height: calc(100% - 60px);">
                    <!--                    <div class="sidebar-brand">
                                            <a href="index.html">
                                                <img src="${pageContext.request.contextPath}/assets/images/logo-dark.png" height="24" class="logo-light-mode" alt="">
                                                <img src="${pageContext.request.contextPath}/assets/images/logo-light.png" height="24" class="logo-dark-mode" alt="">
                                            </a>
                                        </div>-->

                    <ul class="sidebar-menu pt-3" >
                        <li><a href="index.html"><i class="uil uil-dashboard me-2 d-inline-block"></i>Dashboard</a></li>
                        <li><a href="changePw.jsp"><i class="uil uil-user me-2 d-inline-block"></i>Change password</a></li>
                            <c:if test="${user.roleId == '1'}">
                            <li class="sidebar-dropdown">
                                <a href="javascript:void(0)"><i class="uil uil-user me-2 d-inline-block"></i>Doctors</a>
                                <div class="sidebar-submenu">
                                    <ul>
                                        <li><a href="doctors.html">Doctors</a></li>
                                        <li><a href="add-doctor.html">Add Doctor</a></li>
                                        <li><a href="dr-profile.html">Profile</a></li>
                                    </ul>
                                </div>
                            </li>

                            <li class="sidebar-dropdown">
                                <a href="javascript:void(0)"><i class="uil uil-wheelchair me-2 d-inline-block"></i>Patients</a>
                                <div class="sidebar-submenu">
                                    <ul>
                                        <li><a href="patients.html">All Patients</a></li>
                                        <li><a href="add-patient.html">Add Patients</a></li>
                                        <li><a href="patient-profile.html">Profile</a></li>
                                    </ul>
                                </div>
                            </li>

                            <li class="sidebar-dropdown">
                                <a href="javascript:void(0)"><i class="uil uil-apps me-2 d-inline-block"></i>Apps</a>
                                <div class="sidebar-submenu">
                                    <ul>
                                        <li><a href="chat.html">Chat</a></li>
                                        <li><a href="email.html">Email</a></li>
                                        <li><a href="calendar.html">Calendar</a></li>
                                    </ul>
                                </div>
                            </li>

                            <li class="sidebar-dropdown">
                                <a href="javascript:void(0)"><i class="uil uil-shopping-cart me-2 d-inline-block"></i>Pharmacy</a>
                                <div class="sidebar-submenu">
                                    <ul>
                                        <li><a href="shop.html">Shop</a></li>
                                        <li><a href="product-detail.html">Shop Detail</a></li>
                                        <li><a href="shopcart.html">Shopcart</a></li>
                                        <li><a href="checkout.html">Checkout</a></li>
                                    </ul>
                                </div>
                            </li>

                            <li class="sidebar-dropdown">
                                <a href="javascript:void(0)"><i class="uil uil-flip-h me-2 d-inline-block"></i>Blogs</a>
                                <div class="sidebar-submenu">
                                    <ul>
                                        <li><a href="blogs.html">Blogs</a></li>
                                        <li><a href="blog-detail.html">Blog Detail</a></li>
                                    </ul>
                                </div>
                            </li>

                            <li class="sidebar-dropdown">
                                <a href="javascript:void(0)"><i class="uil uil-file me-2 d-inline-block"></i>Pages</a>
                                <div class="sidebar-submenu">
                                    <ul>
                                        <li><a href="faqs.html">FAQs</a></li>
                                        <li><a href="review.html">Reviews</a></li>
                                        <li><a href="invoice-list.html">Invoice List</a></li>
                                        <li><a href="invoice.html">Invoice</a></li>
                                        <li><a href="terms.html">Terms & Policy</a></li>
                                        <li><a href="privacy.html">Privacy Policy</a></li>
                                        <li><a href="error.html">404 !</a></li>
                                        <li><a href="blank-page.html">Blank Page</a></li>
                                    </ul>
                                </div>
                            </li>

                            <li class="sidebar-dropdown">
                                <a href="javascript:void(0)"><i class="uil uil-sign-in-alt me-2 d-inline-block"></i>Authentication</a>
                                <div class="sidebar-submenu">
                                    <ul>
                                        <li><a href="login.html">Login</a></li>
                                        <li><a href="signup.html">Signup</a></li>
                                        <li><a href="forgot-password.html">Forgot Password</a></li>
                                        <li><a href="lock-screen.html">Lock Screen</a></li>
                                        <li><a href="thankyou.html">Thank you...!</a></li>
                                    </ul>
                                </div>
                            </li>

                            <li><a href="components.html"><i class="uil uil-cube me-2 d-inline-block"></i>Components</a></li>

                            <li><a href="${pageContext.request.contextPath}/landing/index-two.html" target="_blank"><i class="uil uil-window me-2 d-inline-block"></i>Landing page</a></li>
                            </c:if>
                    </ul>
                    
                       
                    <!-- sidebar-menu  -->
                </div>
                <!-- sidebar-content  -->
                <ul class="sidebar-footer list-unstyled mb-0">
                    <li class="list-inline-item mb-0 ms-1">
                        <a href="#" class="btn btn-icon btn-pills btn-soft-primary">
                            <i class="uil uil-comment icons"></i>
                        </a>
                    </li>
                </ul>
            </nav>
            <!-- sidebar-wrapper  -->

            <!-- Start Page Content -->
            <main class="page-content bg-light">
                <!--                <div class="top-header">
                                    <div class="header-bar d-flex justify-content-between border-bottom">
                                        <div class="d-flex align-items-center">
                                            <a href="#" class="logo-icon">
                                                <img src="${pageContext.request.contextPath}/assets/images/logo-icon.png" height="30" class="small" alt="">
                                                <span class="big">
                                                    <img src="${pageContext.request.contextPath}/assets/images/logo-dark.png" height="24" class="logo-light-mode" alt="">
                                                    <img src="${pageContext.request.contextPath}/assets/images/logo-light.png" height="24" class="logo-dark-mode" alt="">
                                                </span>
                                            </a>
                                            <div class="search-bar p-0 d-none d-lg-block ms-2">
                                                <div id="search" class="menu-search mb-0">
                                                    <form role="search" method="get" id="searchform" class="searchform">
                                                        <div>
                                                            <input type="text" class="form-control border rounded-pill" name="s" id="s" placeholder="Search Keywords...">
                                                            <input type="submit" id="searchsubmit" value="Search">
                                                        </div>
                                                    </form>
                                                </div>
                                            </div>
                                        </div>
                
                                    </div>
                                </div>-->

                <div class="container-fluid">
                    <jsp:include page="../common/common-homepage-header.jsp"></jsp:include>

                        <div class="layout-specing">
                        <c:if test="${successChange!=null}">
                            <div class="container-fluid bg-success text-center">
                                ${successChange}
                            </div></c:if>
                        <c:if test="${erChange!=null}">
                            <div class="container-fluid bg-danger text-center">
                                ${erChange}
                            </div>
                        </c:if>
                        <div class="d-md-flex justify-content-between">
                            <a id="close-sidebar" class="btn btn-icon btn-pills btn-soft-primary ms-2" href="#">
                                <i class="uil uil-bars"></i>
                            </a>
                            <h5 class="mb-0">Profile</h5>

                            <nav aria-label="breadcrumb" class="d-inline-block mt-4 mt-sm-0">
                                <ul class="breadcrumb bg-transparent rounded mb-0 p-0">
                                    <li class="breadcrumb-item"><a href="HomeServlet">Doctris</a></li>
                                    <li class="breadcrumb-item"><a href="#">Patients</a></li>
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

                    <!-- Footer Start -->
                    <!--                <footer class="bg-white shadow py-3">
                                        <div class="container-fluid">
                                            <div class="row align-items-center">
                                                <div class="col">
                                                    <div class="text-sm-start text-center">
                                                        <p class="mb-0 text-muted"><script>document.write(new Date().getFullYear())</script> © Doctris. Design with <i class="mdi mdi-heart text-danger"></i> by <a href="${pageContext.request.contextPath}/../../index.html" target="_blank" class="text-reset">Shreethemes</a>.</p>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </footer>-->
                <!-- End -->
            </main>
            <!--End page-content" -->
        </div>
        <!-- page-wrapper -->

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