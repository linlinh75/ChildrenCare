<%-- 
    Document   : homepage
    Created on : Sep 21, 2024, 2:21:09 PM
    Author     : admin
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Children Care System</title>
        <!-- Favicon -->
        <link rel="icon" href="img/favicon.png">
        <!-- Google Fonts -->
        <link href="https://fonts.googleapis.com/css?family=Poppins:200i,300,300i,400,400i,500,500i,600,600i,700,700i,800,800i,900,900i&display=swap" rel="stylesheet">

        <!-- Bootstrap CSS -->
        <link rel="stylesheet" href="css/bootstrap.min.css">
        <!-- Nice Select CSS -->
        <link rel="stylesheet" href="css/nice-select.css">
        <!-- Font Awesome CSS -->
        <link rel="stylesheet" href="css/font-awesome.min.css">
        <!-- icofont CSS -->
        <link rel="stylesheet" href="css/icofont.css">
        <!-- Slicknav -->
        <link rel="stylesheet" href="css/slicknav.min.css">
        <!-- Owl Carousel CSS -->
        <link rel="stylesheet" href="css/owl-carousel.css">
        <!-- Datepicker CSS -->
        <link rel="stylesheet" href="css/datepicker.css">
        <!-- Animate CSS -->
        <link rel="stylesheet" href="css/animate.min.css">
        <!-- Magnific Popup CSS -->
        <link rel="stylesheet" href="css/magnific-popup.css">

        <!-- Medipro CSS -->
        <link rel="stylesheet" href="css/normalize.css">
        <link rel="stylesheet" href="./css/style.css">
        <link rel="stylesheet" href="css/responsive.css">
        <style>
            .see-more-button {
                display: inline-flex;
                background-color: white;
                color: #ff4d4d !important;
                border: 2px solid #ff4d4d;
                padding: 10px 20px;
                font-size: 16px;
                cursor: pointer;
                align-items: center;
                gap: 5px;
                text-decoration: none;
                transition: background-color 0.3s, color 0.3s;
                border-radius: 20px;
            }

            .see-more-button:hover {
                background-color: #ff4d4d;
                color: white !important;
            }
            .see-more-button i {
                font-size: 1.5em;
            }
            .sticky-cart-button {
                position: fixed;
                bottom: 100px;
                right: 20px;
                z-index: 1000;
            }
            .sticky-cart-button .btn {
                padding: 10px 20px;
                font-size: 16px;
                box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
                transition: all 0.3s ease-in-out;
            }
            .sticky-cart-button .btn:hover {
                transform: scale(1.05);
            }
        </style>
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
                    <polyline id="front" points="1 6 4 6 6 11 10 1 12 6 15 6"></polyline>
                    </svg>
                </div>
            </div>
        </div>
        <!-- End Preloader -->

        <!-- Header Area -->
        <header class="header" >
            <!-- Topbar -->
            <div class="topbar" style="background-color: #DCDCDC">
                <div class="container">
                    <div class="row">
                        <div class="col-lg-6 col-md-5 col-12">
                            <!-- Contact -->
                            <ul class="top-link">
                                <li style="margin-left: 10px;"><i class="fa fa-map-marker" style="color: #1A76D1;"></i>Address: Hoa Lac, Ha Noi, Viet Nam</li>
                            </ul>
                            <!-- End Contact -->
                        </div>
                        <div class="col-lg-6 col-md-7 col-12">
                            <!-- Top Contact -->
                            <ul class="top-contact">
                                <li><i class="fa fa-phone"></i>+880 1234 56789</li>
                                <li><i class="fa fa-envelope"></i><a href="mailto:support@yourmail.com">childrencaresystemse1874@gmail.com</a></li>
                            </ul>
                            <!-- End Top Contact -->
                        </div>
                    </div>
                </div>
            </div>
            <!-- End Topbar -->
            <!-- Header Inner -->
            <div class="header-inner">
                <div class="container">
                    <div class="inner">
                        <div class="row">
                            <div class="col-lg-3 col-md-3 col-12">
                                <!-- Start Logo -->
                                <div class="logo">
                                    <a href="HomeServlet"><img src="img/logo.png" alt="#"></a>
                                </div>
                                <!-- End Logo -->
                                <!-- Mobile Nav -->
                                <div class="mobile-nav"></div>
                            </div>
                            <div class="col-lg-6 col-md-9 col-12">
                                <!-- Main Menu -->
                                <div class="main-menu">
                                    <nav class="navigation">
                                        <ul class="nav menu">
                                            <li class="active"><a href="HomeServlet">Home</i></a>
                                            </li>
                                            <li>
                                                <a href="DataServlet?action=service">Services<i class="icofont-rounded-down"></i></a>
                                                <ul class="dropdown">
                                                    <c:forEach var="service" items="${list_sc}">
                                                        <li><a href="#">${service.getName()}</a></li>
                                                        </c:forEach>
                                                </ul>
                                            </li>

                                            <li><a href="DataServlet?action=post">Blogs<i class="icofont-rounded-down"></i></a>
                                                <ul class="dropdown">
                                                    <c:forEach var="post" items="${list_pc}">
                                                        <li><a href="#">${post.getName()}</a></li>
                                                        </c:forEach>
                                                </ul>
                                            </li>
                                            <c:if test="${sessionScope.account.roleId == 3}">
                                                <li class="${active == 'med' ? 'active' : ''}" >
                                                    <a href="DataServlet?action=med">Medical Examination</i></a>
                                                </li>
                                            </c:if>
                                            <c:if test="${sessionScope.account.roleId == 1}">
                                                <li class="${active == 'dashboard' ? 'active' : ''}">
                                                    <a href="admin-dashboard">Dashboard</a>
                                                </li>
                                            </c:if>
                                            <c:if test="${account.roleId == 2}">
                                                <li class="nav-item">
                                                    <a class="nav-link ${active == 'dashboard' ? 'active' : ''}" 
                                                       href="profile">Manager Dashboard</a>
                                                </li>
                                            </c:if>
                                        </ul>
                                    </nav>
                                </div>
                                <!--/ End Main Menu -->
                            </div>
                            <div class="col-lg-3 col-12">
                                <div class="get-quote">
                                    <c:choose>
                                        <c:when test="${not empty sessionScope.account}">
                                            <div class="parent-div" style="display: flex; justify-content: end; align-items: center;">
                                                <div class="dropdown" style="display: flex; align-items: center;">
                                                    <span style="margin-right: 10px;">${account.getFullName()}</span>
                                                    <div id="userDropdown" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false" style="display: flex; align-items: center; justify-content: center; width: 60px; height: 60px;">
                                                        <img src="./${account.getImageLink()}" alt="Avatar" class="rounded-circle" style="width: 60px; height: 50px;">
                                                    </div>
                                                    <div class="dropdown-menu dropdown-menu-right" aria-labelledby="userDropdown">
                                                        <a class="dropdown-item" href="DataServlet?action=profile">Profile</a>
                                                        <c:if test="${sessionScope.account.roleId == 4}">
                                                            <a class="dropdown-item" href="/ChildrenCare/ReservationServlet">My Reservation</a>
                                                        </c:if>   
                                                        <c:if test="${sessionScope.account.roleId == 5}">
                                                            <a class="dropdown-item" href="/ChildrenCare/cashier-reservation"> Reception</a>
                                                        </c:if>
                                                        <div class="dropdown-divider"></div>
                                                        <a class="dropdown-item" href="LogoutServlet">Logout</a>
                                                    </div>
                                                </div>
                                            </div>


                                        </c:when>
                                        <c:otherwise>
                                            <a href="DataServlet?action=register" class="btn" style="background-color: orange;">Register</a>
                                            <a href="DataServlet?action=login" class="btn">Login</a>
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                            </div>

                        </div>
                    </div>
                </div>
            </div>
            <!--/ End Header Inner -->
        </header>
        <!-- End Header Area -->

        <!-- Slider Area -->
        <section class="slider">
            <div class="hero-slider">
                <c:forEach var="slider" items="${list_sliders}">
                    <!-- Start Single Slider -->
                    <div class="single-slider" style="background-image:url('${slider.getImageLink()}')">
                        <div class="container">
                            <div class="row">
                                <div class="col-lg-7">
                                    <div class="text">
                                        <h1>${slider.getTitle()}</h1>
                                        <p>${slider.getNotes()}</p>
                                        <div class="button">
                                            <a href="${slider.getBacklink()}" class="btn primary">Learn More</a>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <!-- End Single Slider -->
                </c:forEach>
            </div>
        </section>
        <!--/ End Slider Area -->
        <!-- Start Feature -->
        <section class="Feautes section" style="margin-top: 50px;">
            <div class="container">
                <div class="row">
                    <div class="col-lg-12">
                        <div class="section-title">
                            <h2>We Are Always Ready to Help You & Your Family</h2>
                            <img src="img/section-img.png" alt="#">
                            <p>Whether you need immediate assistance or routine care, our dedicated team is here to support your family's health. Count on us for reliable and compassionate service at every stage of your child's development.</p>
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="col-lg-4 col-12">
                        <!-- Start Single features -->
                        <div class="single-features">
                            <div class="signle-icon">
                                <i class="icofont icofont-ambulance-cross"></i>
                            </div>
                            <h3>Emergency Help</h3>
                            <p>Immediate assistance when you need it most. Our dedicated team is available 24/7.</p>
                        </div>
                        <!-- End Single features -->
                    </div>
                    <div class="col-lg-4 col-12">
                        <!-- Start Single features -->
                        <div class="single-features">
                            <div class="signle-icon">
                                <i class="icofont icofont-medical-sign-alt"></i>
                            </div>
                            <h3>Enriched Pharmecy</h3>
                            <p>Offering a wide range of medications and health products to meet your needs</p>
                        </div>
                        <!-- End Single features -->
                    </div>
                    <div class="col-lg-4 col-12">
                        <!-- Start Single features -->
                        <div class="single-features last">
                            <div class="signle-icon">
                                <i class="icofont icofont-stethoscope"></i>
                            </div>
                            <h3>Medical Treatment</h3>
                            <p>Providing thorough and compassionate care for a variety of medical conditions.</p>
                        </div>
                        <!-- End Single features -->
                    </div>
                </div>
            </div>
        </section>
        <!--/ End Feautes -->

        <!-- Start Fun-facts -->
        <div id="fun-facts" class="fun-facts section overlay">
            <div class="container">
                <div class="row">
                    <div class="col-lg-3 col-md-6 col-12">
                        <!-- Start Single Fun -->
                        <div class="single-fun">
                            <i class="icofont icofont-home"></i>
                            <div class="content">
                                <span class="counter">128</span>
                                <p>Hospital Rooms</p>
                            </div>
                        </div>
                        <!-- End Single Fun -->
                    </div>
                    <div class="col-lg-3 col-md-6 col-12">
                        <!-- Start Single Fun -->
                        <div class="single-fun">
                            <i class="icofont icofont-user-alt-3"></i>
                            <div class="content">
                                <span class="counter">112</span>
                                <p>Specialist Doctors</p>
                            </div>
                        </div>
                        <!-- End Single Fun -->
                    </div>
                    <div class="col-lg-3 col-md-6 col-12">
                        <!-- Start Single Fun -->
                        <div class="single-fun">
                            <i class="icofont-simple-smile"></i>
                            <div class="content">
                                <span class="counter">4379</span>
                                <p>Happy Patients</p>
                            </div>
                        </div>
                        <!-- End Single Fun -->
                    </div>
                    <div class="col-lg-3 col-md-6 col-12">
                        <!-- Start Single Fun -->
                        <div class="single-fun">
                            <i class="icofont icofont-table"></i>
                            <div class="content">
                                <span class="counter">10</span>
                                <p>Years of Experience</p>
                            </div>
                        </div>
                        <!-- End Single Fun -->
                    </div>
                </div>
            </div>
        </div>
        <!--/ End Fun-facts -->
        <!-- Start service -->
        <section class="service section" id="service">
            <div class="container">
                <div class="row">
                    <div class="col-lg-12">
                        <div class="section-title">
                            <h2>We Offer Different Services To Improve Your Children Health</h2>
                            <img src="img/section-img.png" alt="#">
                            <p>Explore our wide range of healthcare services designed to enhance your children well-being.</p>
                        </div>
                    </div>
                </div>
                <div class="row">
                    <c:forEach var="service" items="${services}">
                        <div class="col-lg-4 col-md-6 col-12" style="margin-bottom: 30px">
                            <div class="single-service">
                                <div class="service-head">
                                    <img src="${service.getThumbnailLink()}" alt="${service.getDescription()}">
                                </div>
                                <div class="service-body">
                                    <div class="service-content">
                                        <h2><a href="./service?action=details&id=${service.getId()}">${service.getFullname()}</a></h2>
                                        <p class="text">${service.getDescription()}</p>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </div>
                <div class="row">
                    <div class="col-lg-12 text-center" style="margin-top: 20px;">
                        <a href="DataServlet?action=service" class="see-more-button">
                            See More <i class="icofont-arrow-right"></i>
                        </a>
                    </div>
                </div>
            </div>
        </section>
        <!--/ End service -->


        <!-- Start Blog Area -->
        <section class="blog section" id="blog">
            <div class="container">
                <div class="row">
                    <div class="col-lg-12">
                        <div class="section-title">
                            <h2>Keep up with Our Most Recent Medical News.</h2>
                            <img src="img/section-img.png" alt="#">
                            <p>Lorem ipsum dolor sit amet consectetur adipiscing elit praesent aliquet. pretiumts</p>
                        </div>
                    </div>
                </div>
                <div class="row">
                    <c:forEach var="post" items="${new_posts}">
                        <div class="col-lg-4 col-md-6 col-12">
                            <!-- Single Blog -->
                            <div class="single-news">
                                <div class="news-head">
                                    <img src="${post.getThumbnailLink()}" alt="#">
                                </div>
                                <div class="news-body">
                                    <div class="news-content">
                                        <div class="date">${post.updatedDate}</div> 
                                        <h2><a href="./post?action=detail&id=${post.getId()}">${post.getTitle()}</a></h2>
                                        <p class="text">${post.getDescription()}</p>
                                    </div>
                                </div>
                            </div>
                            <!-- End Single Blog -->
                        </div>
                    </c:forEach>
                </div>
            </div>
        </section>
        <!-- End Blog Area -->
        <!--Button Cart - Only show for customers -->
        <c:if test="${sessionScope.account.roleId == 4}">
            <div class="sticky-cart-button">
                <a href="./customer-reservation-service-cart" class="btn btn-primary">
                    <i class="fa fa-shopping-cart"></i> View Cart
                </a>
            </div>
        </c:if>
        <!-- Footer Area -->
        <footer id="footer" class="footer ">
            <!-- Footer Top -->
            <div class="footer-top">
                <div class="container">
                    <div class="row">
                        <div class="col-lg-4 col-md-6 col-12">
                            <div class="single-footer">
                                <h2>About Us</h2>
                                <p>Lorem ipsum dolor sit am consectetur adipisicing elit do eiusmod tempor incididunt ut labore dolore magna.</p>
                                <!-- Social -->
                                <ul class="social">
                                    <li><a href="#"><i class="icofont-facebook"></i></a></li>
                                </ul>
                                <!-- End Social -->
                            </div>
                        </div>
                        <div class="col-lg-4 col-md-6 col-12">
                            <div class="single-footer f-link">
                                <h2>Quick Links</h2>
                                <div class="row">
                                    <div class="col-lg-6 col-md-6 col-12">
                                        <ul>
                                            <li><a href="HomeServlet"><i class="fa fa-caret-right" aria-hidden="true"></i>Home</a></li>
                                            <li><a href="DataServlet?action=service"><i class="fa fa-caret-right" aria-hidden="true"></i>Services</a></li>
                                        </ul>
                                    </div>
                                    <div class="col-lg-6 col-md-6 col-12">
                                        <ul>
                                            <li><a href="DataServlet?action=post"><i class="fa fa-caret-right" aria-hidden="true"></i>Blogs</a></li>	
                                        </ul>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-lg-4 col-md-6 col-12">
                            <div class="single-footer">
                                <h2>Open Hours</h2>
                                <ul class="time-sidual">
                                    <li class="day">Monday - Friday <span>8.00-20.00</span></li>
                                    <li class="day">Saturday <span>9.00-18.30</span></li>
                                </ul>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <!--/ End Footer Top -->
            <!-- Copyright -->
            <div class="copyright">
                <div class="container">
                    <div class="row">
                        <div class="col-lg-12 col-md-12 col-12">
                            <div class="copyright-content">
                                <p>© Copyright 2018  |  All Rights Reserved by <a href="https://www.wpthemesgrid.com" target="_blank">wpthemesgrid.com</a> </p>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <!--/ End Copyright -->
        </footer>
        <!--/ End Footer Area -->

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
    </body>
</html>
