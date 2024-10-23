<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="zxx">
    <head>
        <!-- Meta Tag -->
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="copyright" content="pavilan">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

        <!-- Title -->
        <title>Mediplus - Medical and Doctor HTML Template.</title>

        <!-- Favicon -->
        <link rel="icon" href="img/favicon.png">

        <!-- Google Fonts -->
        <link href="css?family=Poppins:200i,300,300i,400,400i,500,500i,600,600i,700,700i,800,800i,900,900i&display=swap" rel="stylesheet">

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

        <!-- Mediplus CSS -->
        <link rel="stylesheet" href="css/normalize.css">
        <link rel="stylesheet" href="css/style.css">
        <link rel="stylesheet" href="css/responsive.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
        
        <style>
            .star-rating {
                color: #ffc107; /* Màu vàng cho sao */
            }
        </style>
        <!-- Color CSS -->
        <link rel="stylesheet" href="css/color/color1.css">
        <link rel="stylesheet" id="colors">
        <style>
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
<<<<<<< HEAD

                <div class="indicator">
=======
                <div class="indicator"> 
>>>>>>> fb60e0629eb478e95712b4076716d6079506691c
                    <svg width="16px" height="12px">
                    <polyline id="back" points="1 6 4 6 6 11 10 1 12 6 15 6"></polyline>
                    <polyline id="front" points="1 6 4 6 6 11 10 1 12 6 15 6"></polyline>
                    </svg>
                </div>
            </div>
        </div>
        <!-- End Preloader -->
        <!-- Header Area -->
        <jsp:include page="common/common-homepage-header.jsp"></jsp:include>
            <!-- End Header Area -->

            <!-- Breadcrumbs -->
            <div class="breadcrumbs overlay">
                <div class="container">
                    <div class="bread-inner">
                        <div class="row">
                            <div class="col-12">
                                <h2>Service</h2>
                                <ul class="bread-list">
                                    <li><a href="index.html">Home</a></li>
                                    <li><i class="icofont-simple-right"></i></li>
                                    <li class="active">Service</li>
                                </ul>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <!-- End Breadcrumbs -->

<<<<<<< HEAD
            <!-- Start service -->
            <section class="services section">
                <div class="container">
                    <div class="row">
                    <c:forEach var="service" items="${serviceList}">
                        <div class="col-lg-4 col-md-6 col-12">
                            <div class="single-service">
                                <i class="icofont icofont-prescription"></i>
                                <h4><a href="service?action=details&id=${service.id}">${service.fullname}</a></h4>
                                <img src="${service.thumbnailLink}" width="50%">
                                <p>Price: ${service.originalPrice} $</p>
                                <p>Sale price: ${service.salePrice} $</p>
                                <p>${service.description}</p>
=======
            <!-- Start Service -->
            <section class="blog section">
                <div class="container">
                    <div class="row">
                        <div class="col-lg-8 col-12">
                            <div class="row">
                            <c:forEach var="service" items="${serviceList}">
                                <div class="col-lg-4 col-md-6 col-12">
                                    <div class="single-news">
                                        <div class="news-head">
                                            <img src="${pageContext.request.contextPath}/${service.thumbnailLink}" alt="#">
                                        </div>
                                        <div class="news-body">
                                            <div class="news-content">
                                                <div class="date">${service.updatedDate}</div>
                                                <h2><a href="service?action=details&id=${service.id}&page=${currentPage}">${service.fullname}</a></h2>
                                                <p>${service.description}</p>
                                                <div class="star-rating">
                                                    <c:set var="averageRating" value="${serviceservlet.getAverageRating(service.id)}" />
                                                    <c:choose>
        <c:when test="${averageRating > 0}">
            <c:forEach begin="1" end="5" var="i">
                <c:choose>
                    <c:when test="${i <= averageRating}">
                        <i class="fas fa-star"></i>
                    </c:when>
                    <c:when test="${i > averageRating && i - 1 < averageRating}">
                        <i class="fas fa-star-half-alt"></i>
                    </c:when>
                    <c:otherwise>
                        <i class="far fa-star"></i>
                    </c:otherwise>
                </c:choose>
            </c:forEach>
            <span><fmt:formatNumber value="${averageRating}" maxFractionDigits="1" /></span>
        </c:when>
        <c:otherwise>
    <c:forEach begin="1" end="5">
        <i class="far fa-star"></i>
    </c:forEach>
</c:otherwise>
    </c:choose>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </c:forEach>
                        </div>
                    </div>
                    <div class="col-lg-4 col-12">
                        <div class="main-sidebar">
                            <!-- Single Widget -->
                            <div class="single-widget search">
                                <form action="service" method="get">
                                    <input type="hidden" name="action" value="search">
                                    <input type="text" name="query" placeholder="Search Services..." value="${searchQuery}">
                                    <button type="submit" class="button"><i class="fa fa-search"></i></button>
                                </form>
                            </div>
                            <!--/ End Single Widget -->

                            <!-- You can add more widgets here, such as recent services or categories -->
                        </div>
                    </div>
                </div>

                <!-- Pagination -->
                <c:if test="${noOfPages > 1}">
                    <div class="row">
                        <div class="col-12">
                            <div class="pagination">
                                <ul class="pagination-list">
                                    <c:forEach begin="1" end="${noOfPages}" var="i">
                                        <li class="${currentPage eq i ? 'active' : ''}">
                                            <a href="service?page=${i}">${i}</a>
                                        </li>
                                    </c:forEach>
                                </ul>
>>>>>>> fb60e0629eb478e95712b4076716d6079506691c
                            </div>
                        </div>
                    </div>
                </c:if>
                <!-- End Pagination -->
            </div>
        </section>
<<<<<<< HEAD
        <!--/ End service -->

        <!-- clients -->
        <div class="clients overlay">
            <div class="container">
                <div class="row">
                    <div class="col-lg-12 col-md-12 col-12">
                        <div class="owl-carousel clients-slider">
                            <div class="single-clients">
                                <img src="img/client1.png" alt="#">
                            </div>
                            <div class="single-clients">
                                <img src="img/client2.png" alt="#">
                            </div>
                            <div class="single-clients">
                                <img src="img/client3.png" alt="#">
                            </div>
                            <div class="single-clients">
                                <img src="img/client4.png" alt="#">
                            </div>
                            <div class="single-clients">
                                <img src="img/client5.png" alt="#">
                            </div>
                            <div class="single-clients">
                                <img src="img/client1.png" alt="#">
                            </div>
                            <div class="single-clients">
                                <img src="img/client2.png" alt="#">
                            </div>
                            <div class="single-clients">
                                <img src="img/client3.png" alt="#">
                            </div>
                            <div class="single-clients">
                                <img src="img/client4.png" alt="#">
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!--/Ens clients -->

        <!-- Start Appointment -->
        <!--        <section class="appointment">
                    <div class="container">
                        <div class="row">
                            <div class="col-lg-12">
                                <div class="section-title">
                                    <h2>We Are Always Ready to Help You. Book An Appointment</h2>
                                    <img src="img/section-img.png" alt="#">
                                    <p>
                                        Lorem ipsum dolor sit amet consectetur adipiscing elit praesent
                                        aliquet. pretiumts
                                    </p>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-lg-6 col-md-12 col-12">
                                <form class="form" action="#">
                                    <div class="row">
                                        <div class="col-lg-6">
                                            <div class="form-group">
                                                <input name="name" type="text" placeholder="Name">
                                            </div>
                                        </div>
                                        <div class="col-lg-6">
                                            <div class="form-group">
                                                <input name="email" type="email" placeholder="Email">
                                            </div>
                                        </div>
                                        <div class="col-lg-6">
                                            <div class="form-group">
                                                <input name="phone" type="text" placeholder="Phone">
                                            </div>
                                        </div>
                                        <div class="col-lg-6">
                                            <div class="form-group">
                                                <div class="nice-select form-control wide" tabindex="0">
                                                    <span class="current">Department</span>
                                                    <ul class="list">
                                                        <li data-value="1" class="option selected">
                                                            Department
                                                        </li>
                                                        <li data-value="2" class="option">Cardiac Clinic</li>
                                                        <li data-value="3" class="option">Neurology</li>
                                                        <li data-value="4" class="option">Dentistry</li>
                                                        <li data-value="5" class="option">Gastroenterology</li>
                                                    </ul>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-lg-6">
                                            <div class="form-group">
                                                <div class="nice-select form-control wide" tabindex="0">
                                                    <span class="current">Doctor</span>
                                                    <ul class="list">
                                                        <li data-value="1" class="option selected">Doctor</li>
                                                        <li data-value="2" class="option">
                                                            Dr. Akther Hossain
                                                        </li>
                                                        <li data-value="3" class="option">Dr. Dery Alex</li>
                                                        <li data-value="4" class="option">Dr. Jovis Karon</li>
                                                    </ul>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-lg-6">
                                            <div class="form-group">
                                                <input type="text" placeholder="Date" id="datepicker">
                                            </div>
                                        </div>
                                        <div class="col-lg-12">
                                            <div class="form-group">
                                                <textarea name="message" placeholder="Write Your Message Here....."></textarea>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-lg-5">
                                            <div class="form-group">
                                                <div class="button">
                                                    <button type="submit" class="btn">
                                                        Book An Appointment
                                                    </button>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-lg-7">
                                            <p>( We will be confirm by an Text Message )</p>
                                        </div>
                                    </div>
                                </form>
                            </div>
                            <div class="col-lg-6 col-md-12">
                                <div class="appointment-image">
                                    <img src="img/contact-img.png" alt="#">
                                </div>
                            </div>
                        </div>
                    </div>
                </section>
                /End Appointment 
        
                 Start Newsletter Area 
                <section class="newsletter section">
                    <div class="container">
                        <div class="row align-items-center">
                            <div class="col-lg-6 col-12">
                                 Start Newsletter Form 
                                <div class="subscribe-text">
                                    <h6>Sign up for newsletter</h6>
                                    <p class="">
                                        Cu qui soleat partiendo urbanitas. Eum aperiri indoctum eu,<br>
                                        homero alterum.
                                    </p>
                                </div>
                                 End Newsletter Form 
                            </div>
                            <div class="col-lg-6 col-12">
                                 Start Newsletter Form 
                                <div class="subscribe-form">
                                    <form action="mail/mail.php" method="get" class="newsletter-inner">
                                        <input name="EMAIL" placeholder="Your email address" class="common-input" onfocus="this.placeholder = ''" onblur="this.placeholder = 'Your email address'" required="" type="email">
                                        <button class="btn">Subscribe</button>
                                    </form>
                                </div>
                                 End Newsletter Form 
                            </div>
                        </div>
                    </div>
                </section>-->
        <!-- /End Newsletter Area -->
        <div class="sticky-cart-button">
            <a href="./customer-cart" class="btn btn-primary">
                <i class="fa fa-shopping-cart"></i> View Cart
            </a>
        </div>
        <!-- Footer Area -->
        <jsp:include page="common/common-homepage-footer.jsp"></jsp:include>
        <!--/ End Footer Area -->
        <script src="js/jquery.min.js"></script>
        <script src="js/bootstrap.min.js"></script>
=======
        <!-- End Blog Posts -->

        <!-- Footer Area -->
        <jsp:include page="common/common-homepage-footer.jsp"></jsp:include>
        <!-- End Footer Area -->

        <!-- jquery Min JS -->
        <script src="js/jquery.min.js"></script>
        <!-- jquery Migrate JS -->
        <script src="js/jquery-migrate.js"></script>
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
>>>>>>> fb60e0629eb478e95712b4076716d6079506691c
    </body>
</html>
