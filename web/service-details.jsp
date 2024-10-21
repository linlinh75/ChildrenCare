<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="zxx">
    <head>
        <!-- Meta Tag -->
        <meta charset="utf-8" />
        <meta http-equiv="X-UA-Compatible" content="IE=edge" />
        <meta name="copyright" content="pavilan" />
        <meta http-equiv="X-UA-Compatible" content="IE=edge" />
        <meta
            name="viewport"
            content="width=device-width, initial-scale=1, shrink-to-fit=no"
            />

        <!-- Title -->
        <title>Mediplus - Medical and Doctor HTML Template.</title>

        <!-- Favicon -->
        <link rel="icon" href="img/favicon.png" />

        <!-- Google Fonts -->
        <link
            href="css?family=Poppins:200i,300,300i,400,400i,500,500i,600,600i,700,700i,800,800i,900,900i&display=swap"
            rel="stylesheet"
            />

        <!-- Bootstrap CSS -->
        <link rel="stylesheet" href="css/bootstrap.min.css" />
        <!-- Nice Select CSS -->
        <link rel="stylesheet" href="css/nice-select.css" />
        <!-- Font Awesome CSS -->
        <link rel="stylesheet" href="css/font-awesome.min.css" />
        <!-- icofont CSS -->
        <link rel="stylesheet" href="css/icofont.css" />
        <!-- Slicknav -->
        <link rel="stylesheet" href="css/slicknav.min.css" />
        <!-- Owl Carousel CSS -->
        <link rel="stylesheet" href="css/owl-carousel.css" />
        <!-- Datepicker CSS -->
        <link rel="stylesheet" href="css/datepicker.css" />
        <!-- Animate CSS -->
        <link rel="stylesheet" href="css/animate.min.css" />
        <!-- Magnific Popup CSS -->
        <link rel="stylesheet" href="css/magnific-popup.css" />

        <!-- Mediplus CSS -->
        <link rel="stylesheet" href="css/normalize.css" />
        <link rel="stylesheet" href="css/style.css" />
        <link rel="stylesheet" href="css/responsive.css" />

        <!-- Color CSS -->
        <link rel="stylesheet" href="css/color/color1.css" />

        <link rel="stylesheet" id="colors" />
    </head>
    <body>
        <!-- Preloader -->
        <div class="preloader">
            <div class="loader">
                <div class="loader-outter"></div>
                <div class="loader-inner"></div>

                <div class="indicator">
                    <svg width="16px" height="12px">
                    <polyline id="back" points="1 6 4 6 6 11 10 1 12 6 15 6"></polyline>
                    <polyline
                        id="front"
                        points="1 6 4 6 6 11 10 1 12 6 15 6"
                        ></polyline>
                    </svg>
                </div>
            </div>
        </div>
        <!-- End Preloader -->

        <!-- Mediplus Color Plate -->
        <div class="color-plate">
            <a class="color-plate-icon"><i class="fa fa-cog fa-spin"></i></a>
            <h4>Mediplus</h4>
            <p>Here is some awesome color's available on Mediplus Template.</p>
            <span class="color1"></span>
            <span class="color2"></span>
            <span class="color3"></span>
            <span class="color4"></span>
            <span class="color5"></span>
            <span class="color6"></span>
            <span class="color7"></span>
            <span class="color8"></span>
            <span class="color9"></span>
            <span class="color10"></span>
            <span class="color11"></span>
            <span class="color12"></span>
            <div class="rtl-version">
                <h4>RTL Version</h4>
                <ul class="option-box">
                    <li class="rtl-btn">RTL Version</li>
                    <li class="ltr-btn active">LTR Version</li>
                </ul>
            </div>
        </div>
        <!-- /End Color Plate -->

        <!-- Header Area -->
        <jsp:include page="common/common-homepage-header.jsp"></jsp:include>
        <!-- End Header Area -->

        <!-- Breadcrumbs -->
        <div class="breadcrumbs overlay">
            <div class="container">
                <div class="bread-inner">
                    <div class="row">
                        <div class="col-12">
                            <h2>${service.fullname}</h2>
                            <ul class="bread-list">
                                <li><a href="index.jsp">Home</a></li>
                                <li><i class="icofont-simple-right"></i></li>
                                <li><a href="service">Services</a></li>
                                <li><i class="icofont-simple-right"></i></li>
                                <li class="active">${service.fullname}</li>
                            </ul>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!-- End Breadcrumbs -->

        <!-- Service Details -->
        <div class="service-details-area section">
            <div class="container">
                <div class="service-details-content">
                    <h2>${service.fullname}</h2>
                    <img src="${service.thumbnailLink}" alt="${service.fullname}" class="img-fluid mb-4">
                    <p>${service.description}</p>
                    <p>Last Updated: ${service.updatedDate}</p>
                </div>
            </div>
        </div>
        <!-- End Service Details -->

        <!-- Footer Area -->
        <jsp:include page="common/common-homepage-footer.jsp"></jsp:include>
        <!--/ End Footer Area -->

        <!-- jquery Min JS -->
        <script src="js/jquery.min.js"></script>
        <!-- jquery Migrate JS -->
        <script src="js/jquery-migrate.js"></script>
        <!-- Easing JS -->
        <script src="js/easing.js"></script>
        <!-- Color JS -->
        <script src="js/colors.js"></script>
        <!-- Popper JS -->
        <script src="js/popper.min.js"></script>
        <!-- Bootstrap JS -->
        <script src="js/bootstrap.min.js"></script>
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
        <!-- Main JS -->
        <script src="js/main.js"></script>
    </body>
</html>
