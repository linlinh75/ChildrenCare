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
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </div>
        </section>
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
    </body>
</html>
