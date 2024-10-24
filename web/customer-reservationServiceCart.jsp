<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <!-- Meta Tag -->
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

        <!-- Title -->
        <title>Reservation Cart - Medical and Doctor HTML Template</title>

        <!-- Favicon -->
        <link rel="icon" href="img/favicon.png">

        <!-- Google Fonts -->
        <link href="https://fonts.googleapis.com/css?family=Poppins:200i,300,300i,400,400i,500,500i,600,600i,700,700i,800,800i,900,900i&display=swap" rel="stylesheet">

        <!-- Bootstrap CSS -->
        <link rel="stylesheet" href="css/bootstrap.min.css">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
        <!-- Nice Select CSS -->
        <!--<link rel="stylesheet" href="css/nice-select.css">-->
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
        <link rel="stylesheet" href="css/style.css">
        <link rel="stylesheet" href="css/responsive.css">

        <style>
            .modal {
                overflow-y: auto !important;
            }

            .modal-body {
                overflow: visible !important;
            }

            .form-select {
                position: relative;
                z-index: 1056 !important;
            }
        </style>
    </head>
    <body>
        <!-- Header Area -->
        <jsp:include page="common/common-homepage-header.jsp"></jsp:include>

            <!-- Breadcrumbs -->
            <div class="breadcrumbs overlay">
                <div class="container">
                    <div class="bread-inner">
                        <div class="row">
                            <div class="col-12">
                                <h2>Reservation Cart</h2>
                                <ul class="bread-list">
                                    <li><a href="index.jsp">Home</a></li>
                                    <li><i class="icofont-simple-right"></i></li>
                                    <li class="active">Cart</li>
                                </ul>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <!-- End Breadcrumbs -->

            <!-- Start Cart Area -->
            <section class="shop-cart section">
                <div class="container">
                    <div class="row">
                        <div class="col-12">
                            <!-- Shopping Summery -->
                        <c:if test="${empty sessionScope.cart.reservation.list_service}">
                            <div class="alert alert-info text-center">
                                <h4>Your cart is empty</h4>
                                <p>Please add some services to your cart.</p>
                                <a href="service" class="btn btn-primary">Browse Services</a>
                            </div>
                        </c:if>

                        <c:if test="${not empty sessionScope.cart.reservation.list_service}">
                            <!-- Cart Summary -->
                            <div class="table-responsive">
                                <table class="table table-bordered table-hover">
                                    <thead>
                                        <tr>
                                            <th>Service</th>
                                            <th>Price</th>
                                            <th>Action</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach items="${sessionScope.cart.reservation.list_service}" var="service">
                                            <tr>
                                                <td>
                                                    <h5>${service.service_name}</h5>
                                                </td>
                                                <td>$${service.unit_price}</td>
                                                <td>
                                                    <form action="customer-reservation-service-cart" method="post" style="display: inline;">
                                                        <input type="hidden" name="action" value="remove">
                                                        <input type="hidden" name="serviceId" value="${service.service_id}">
                                                        <button type="submit" class="btn btn-danger btn-sm">
                                                            <i class="fa fa-trash"></i> Remove
                                                        </button>
                                                    </form>
                                                </td>
                                            </tr>
                                        </c:forEach>
                                    </tbody>
                                </table>
                            </div>
                            <center style="margin: 10px">
                                <a href="service" class="btn btn-primary">Browse More Services</a>
                            </center>
                            <!-- Cart Summary -->
                            <div class="cart-summary">
                                <div class="row">
                                    <div class="col-12">
                                        <div class="card">
                                            <div class="card-body">
                                                <div class="row">
                                                    <div class="col-lg-8 col-md-7 col-12">
                                                        <div class="cart-customer-info">
                                                            <h4>Customer Information</h4>
                                                            <p><strong>Name:</strong> ${sessionScope.cart.reservation.customer_name}</p>
                                                        </div>
                                                    </div>
                                                    <div class="col-lg-4 col-md-5 col-12">
                                                        <div class="cart-total">
                                                            <h4>Cart Total</h4>
                                                            <div class="total-amount">
                                                                <p><strong>Total:</strong> $${sessionScope.cart.totalPrice}</p>
                                                            </div>
                                                            <div class="button row">
                                                                <form class="col-md-6" action="customer-reservation-service-cart" method="post" style="display: inline;">
                                                                    <input type="hidden" name="action" value="clear">
                                                                    <button type="submit" class="btn btn-warning">
                                                                        <i class="fa fa-trash"></i> Clear Cart
                                                                    </button>
                                                                </form>
                                                                <button type="button" class="btn btn-primary col-md-6" data-toggle="modal" data-target="#appointmentModal">
                                                                    <i class="fa fa-calendar"></i> Book Appointment
                                                                </button>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </c:if>
                        <!--/ End Shopping Summery -->
                    </div>
                </div>
            </div>
        </section>
        <!--/ End Cart Area -->
        <!-- Add the modal at the bottom of the page, before the footer: -->
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
                                    Please <a href="login" class="alert-link">login</a> to book an appointment.
                                </div>
                            </c:when>
                            <c:otherwise>
                                <!-- Show form with pre-filled data if user is logged in -->
                                <form id="appointmentForm" action="customer-reservation-service-cart?action=book-appointment" method="POST">
                                    <input type="hidden" name="userId" value="${sessionScope.account.id}">

                                    <!-- Service Summary Section -->
                                    <div class="section-title mb-4">
                                        <h4>Selected Services</h4>
                                        <div class="table-responsive">
                                            <table class="table table-bordered">
                                                <thead>
                                                    <tr>
                                                        <th>Service Name</th>
                                                        <th>Price</th>
                                                    </tr>
                                                </thead>
                                                <tbody>
                                                    <c:forEach items="${sessionScope.cart.reservation.list_service}" var="service">
                                                        <tr>
                                                            <td>${service.service_name}</td>
                                                            <td>$${service.unit_price}</td>
                                                        </tr>
                                                    </c:forEach>
                                                </tbody>
                                                <tfoot>
                                                    <tr>
                                                        <th>Total Amount:</th>
                                                        <th>$${sessionScope.cart.totalPrice}</th>
                                                    </tr>
                                                </tfoot>
                                            </table>
                                        </div>
                                    </div>

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

                                    <div class="form-group">
                                        <label for="paymentMethod" class="form-label">Payment Method</label>
                                        <div class="position-relative">
                                            <select class="form-control" name="paymentMethod" required>
                                                <option value="" selected disabled>Select payment method</option>
                                                <option value="cash">Cash</option>
                                                <option value="vnpay">VNPAY</option>
                                            </select>
                                        </div>
                                    </div>

                                    <div class="form-group">
                                        <label for="checkupTime">Preferred Checkup Time</label>
                                        <input type="datetime-local" class="form-control" id="checkupTime" 
                                               name="checkupTime" required>
                                    </div>

                                    <div class="modal-footer">
                                        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                                        <button type="submit" class="btn btn-primary">Confirm Booking</button>
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
        <!--<script src="js/niceselect.js"></script>-->
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
            // Hiển thị thông báo
            if(<%= request.getAttribute("message")!=null %>){
                alert("<%= request.getAttribute("message") %>");
            }
            
        </script>
        <script>
            document.addEventListener('DOMContentLoaded', function () {

                // Set minimum date to tomorrow for checkup time
                var checkupTimeInput = document.getElementById('checkupTime');
                if (checkupTimeInput) {
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
        </script>
    </body>
</html>