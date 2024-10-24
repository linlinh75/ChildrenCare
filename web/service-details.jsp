<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
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
                <div class="row">
                    <!-- Main content column -->
                    <div class="col-lg-8 col-12">
                        <div class="service-details-content">
                            <h2>${service.fullname}</h2>
                            <img src="${service.thumbnailLink}" alt="${service.fullname}" class="img-fluid mb-4">
                            <p>${service.description}</p>
                            <p>Last Updated: ${service.updatedDate}</p>
                        </div>
                    </div>

                    <!-- Sidebar column -->
                    <div class="col-lg-4 col-12">
                        <div class="main-sidebar">
                            <!-- Price Widget -->
                            <div class="single-widget price-widget">
                                <h3 class="widget-title">Service Pricing</h3>
                                <div class="price-card">
                                    <div class="price-header">
                                        <h4>Standard Package</h4>
                                        <div class="price-amount">
                                            <span class="currency">$</span>
                                            <span class="amount">${service.salePrice}</span>
                                        </div>
                                    </div>
                                    <div class="price-body">
                                        <ul class="price-features">
                                            <li><i class="fa fa-check"></i> Full Consultation</li>
                                            <li><i class="fa fa-check"></i> Expert Medical Care</li>
                                            <li><i class="fa fa-check"></i> Professional Staff</li>
                                            <li><i class="fa fa-check"></i> 24/7 Support</li>
                                        </ul>
                                    </div>
                                    <div class="price-footer">
<!--                                        <form action="appointment" method="GET">
                                            <input type="hidden" name="serviceId" value="${service.id}">
                                            <button type="submit" class="btn btn-primary btn-lg btn-block">
                                                <i class="fa fa-calendar-plus"></i> Book Appointment
                                            </button>
                                        </form>-->
                                        <form action="customer-reservation-service-cart" method="POST">
                                            <input type="hidden" name="action" value="add">
                                            <input type="hidden" name="serviceId" value="${service.id}">
                                            <c:if test="${sessionScope.user.roleId==4}">
                                            <button type="submit" class="btn btn-primary btn-lg btn-block">
                                                <i class="fa fa-calendar-plus"></i> Book Appointment
                                            </button>
                                            </c:if>
                                        </form>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!-- End Service Details -->
        <!-- Add this just before closing body tag -->
        <div class="modal fade" id="appointmentModal" tabindex="-1" role="dialog" aria-labelledby="appointmentModalLabel" aria-hidden="true">
            <div class="modal-dialog modal-lg" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="appointmentModalLabel">Book Appointment</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <c:choose>
                            <c:when test="${empty sessionScope.account}">
                                <!-- Show login message if user is not logged in -->
                                <div class="alert alert-warning" role="alert">
                                    Please <a href="login.jsp" class="alert-link">login</a> to book an appointment.
                                </div>
                            </c:when>
                            <c:otherwise>
                                <!-- Show form with pre-filled data if user is logged in -->
                                <form id="appointmentForm" action="ReservationServlet?action=book-appointment" method="POST">
                                    <input type="hidden" name="serviceId" value="${service.id}">
                                    <input type="hidden" name="userId" value="${sessionScope.account.id}">

                                    <!-- Receiver Info Section -->
                                    <div class="section-title">
                                        <h4>Receiver Info</h4>
                                    </div>

                                    <div class="form-group">
                                        <label for="fullName">Full Name</label>
                                        <input type="text" class="form-control" id="fullName" name="fullName" 
                                               value="${sessionScope.account.fullName}" required>
                                    </div>

                                    <div class="form-group">
                                        <label for="gender">Gender:</label>
                                        <div class="form-check form-check-inline">
                                            <input class="form-check-input" type="radio" name="gender" id="male" 
                                                   value="male" ${!sessionScope.account.gender ? 'checked' : ''} required>
                                            <label class="form-check-label" for="male">Male</label>
                                        </div>
                                        <div class="form-check form-check-inline">
                                            <input class="form-check-input" type="radio" name="gender" id="female" 
                                                   value="female" ${sessionScope.account.gender ? 'checked' : ''} required>
                                            <label class="form-check-label" for="female">Female</label>
                                        </div>
                                    </div>

                                    <div class="row">
                                        <div class="col-md-6">
                                            <div class="form-group">
                                                <label for="email">Email</label>
                                                <input type="email" class="form-control" id="email" name="email" 
                                                       value="${sessionScope.account.email}" required>
                                            </div>
                                        </div>
                                        <div class="col-md-6">
                                            <div class="form-group">
                                                <label for="phone">Phone Number</label>
                                                <input type="tel" class="form-control" id="phone" name="phone" 
                                                       value="${sessionScope.account.mobile}" required>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="form-group">
                                        <label for="address">Address</label>
                                        <textarea class="form-control" id="address" name="address" 
                                                  rows="2" required>${sessionScope.account.address}</textarea>
                                    </div>
                                    <div class="form-group row">
                                        <label for="paymentMethod col-md-6">Payment Method</label>
                                        <select class="form-control col-md-6" id="paymentMethod" name="paymentMethod" required>
                                            <option value="" selected disabled>Select payment method</option>
                                            <option value="cash">Cash</option>
                                            <option value="bankTransfer">Bank Transfer</option>
                                            <option value="creditCard">Credit Card</option>
                                        </select>

                                        <!-- Bank Details (shown only when bank transfer is selected) -->
                                        <div class="alert alert-info mt-3" id="bankDetails" style="display: none;">
                                            <h6><strong>Bank Transfer Details:</strong></h6>
                                            <p class="mb-1">Bank: Example Bank</p>
                                            <p class="mb-1">Account Number: 1234-5678-9012</p>
                                            <p class="mb-1">Account Name: Medical Clinic</p>
                                            <p class="mb-0">Please include your name and appointment date in transfer description</p>
                                        </div>
                                    </div>

                                    <div class="form-group">
                                        <label for="checkupTime">Preferred Checkup Time</label>
                                        <input type="datetime-local" class="form-control" id="checkupTime" 
                                               name="checkupTime" required>
                                    </div>

                                    <!-- Service Info Section -->
                                    <div class="section-title mt-4">
                                        <h4>Service Info</h4>
                                        <div class="service-summary">
                                            <p><strong>Service:</strong> ${service.fullname}</p>
                                            <p><strong>Price:</strong> $${service.salePrice}</p>
                                        </div>
                                    </div>


                                    <div class="modal-footer">
                                        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                                        <button type="submit" class="btn btn-primary">Submit Booking</button>
                                    </div>
                                </form>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>
            </div>
        </div>
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

            <script>
                // Update your existing JavaScript with this version
//                document.querySelector('.price-footer form').addEventListener('submit', function (e) {
//                    e.preventDefault();
//
//                    // Check if user is logged in
//                    if (!${not empty sessionScope.account}) {
//                        // Redirect to login page if not logged in
//                        window.location.href = 'login.jsp';
//                        return;
//                    }
//
//                    $('#appointmentModal').modal('show');
//                });

                document.addEventListener('DOMContentLoaded', function () {
                    var checkupTimeInput = document.getElementById('checkupTime');
                    if (checkupTimeInput) {
                        // Set minimum date to tomorrow
                        var tomorrow = new Date();
                        tomorrow.setDate(tomorrow.getDate() + 1);
                        tomorrow.setHours(0, 0, 0, 0);
                        checkupTimeInput.min = tomorrow.toISOString().slice(0, 16);

                        // Set maximum date to 3 months from now
                        var maxDate = new Date();
                        maxDate.setMonth(maxDate.getMonth() + 3);
                        checkupTimeInput.max = maxDate.toISOString().slice(0, 16);
                    }
                });

                document.getElementById('appointmentForm')?.addEventListener('submit', function (e) {
                    e.preventDefault();

                    if (this.checkValidity()) {
                        // Add any additional validation here
                        this.submit();
                    } else {
                        this.reportValidity();
                    }
                });

                // Add this to your existing JavaScript
                document.addEventListener('DOMContentLoaded', function () {
                    // Payment method handling
                    const paymentSelect = document.getElementById('paymentMethod');
                    const bankDetails = document.getElementById('bankDetails');

                    if (paymentSelect) {
                        paymentSelect.addEventListener('change', function () {
                            // Show bank details only when bank transfer is selected
                            bankDetails.style.display = this.value === 'bankTransfer' ? 'block' : 'none';
                        });
                    }
                });
        </script>
    </body>
</html>
