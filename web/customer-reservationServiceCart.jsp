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
                                                    <form action="customer-reservation-service-cart" method="post" style="display: inline;" onsubmit="return confirm('Are you sure you want to remove this service?');">
                                                        <input type="hidden" name="action" value="remove">
                                                        <input type="hidden" name="serviceId" value="${service.service_id}">
                                                        <button type="submit" class="btn btn-danger btn-sm" style="background-color: #dc3545">
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
                                                                <form class="col-md-6" action="customer-reservation-service-cart" method="post" style="display: inline;" onsubmit="return confirm('Are you sure you want to clear all services?');">
                                                                    <input type="hidden" name="action" value="clear">
                                                                    <button type="submit" class="btn btn-warning" style="background-color: #ffc107">
                                                                        <i class="fa fa-trash"></i> Clear Cart
                                                                    </button>
                                                                </form>
                                                                <c:if test="${sessionScope.account.roleId == 4}">
                                                                    <button type="button" class="btn btn-primary col-md-6" data-toggle="modal" data-target="#appointmentModal">
                                                                        <i class="fa fa-calendar"></i> Book Appointment
                                                                    </button>
                                                                </c:if>
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
                                                   value="true" ${sessionScope.account.gender ? 'checked' : ''} required>
                                            <label class="form-check-label" for="male">Male</label>
                                        </div>
                                        <div class="form-check form-check-inline">
                                            <input class="form-check-input" type="radio" name="gender" id="female" 
                                                   value="false" ${!sessionScope.account.gender ? 'checked' : ''} required>
                                            <label class="form-check-label" for="female">Female</label>
                                        </div>
                                    </div>

                                    <div class="row">
                                        <div class="col-md-6">
                                            <div class="form-group">
                                                <label for="email">Email</label>
                                                <input type="email" class="form-control" id="email" name="email" 
                                                       value="${sessionScope.account.email}" readonly>
                                            </div>
                                        </div>
                                        <div class="col-md-6">
                                            <div class="form-group">
                                                <label for="phone">Phone Number</label>
                                                <input type="tel" class="form-control" id="phone" name="phone" 
                                                       value="${sessionScope.account.mobile}" required>
                                                <small id="phoneError" class="text-danger" style="display: none;">
                                                    Phone number must be 10 digits and start with 0
                                                </small>
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
                                        <div>
                                            <input type="radio" id="paymentDirect" name="paymentMethod" value="DIRECT" checked>
                                            <label for="paymentDirect">Direct Payment</label>
                                        </div>
                                        <div>
                                            <input type="radio" id="paymentVNPAY" name="paymentMethod" value="VNPAY">
                                            <label for="paymentVNPAY">VNPAY</label>
                                        </div>
                                    </div>

                                    <div class="form-group">
                                        <label for="checkupDate">Preferred Checkup Date</label>
                                        <input type="date" class="form-control" id="checkupDate" name="checkupDate" required >
                                    </div>

                                    <div class="form-group mt-3">
                                        <label>Available Shifts</label>
                                        <div id="shiftButtons" class="d-flex flex-wrap gap-2">
                                        </div>
                                        <input type="hidden" id="selectedShift" name="checkupShift" required>
                                        <input type="hidden" id="checkupTime" name="checkupTime">
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
        </body>
        <script>
            // Hiển thị thông báo
            if (<%= request.getAttribute("message")!=null %>) {
                alert("<%= request.getAttribute("message") %>");
            }
    </script>
    <script>
        document.addEventListener('DOMContentLoaded', function () {
            // Phone validation
            const phoneInput = document.getElementById('phone');
            const phoneError = document.getElementById('phoneError');
            const form = document.getElementById('appointmentForm');

            // Function to validate phone number
            function validatePhone(phone) {
                return /^0\d{9}$/.test(phone);
            }

            // Phone input validation
            phoneInput.addEventListener('input', function () {
                const isValid = validatePhone(this.value);
                if (!isValid) {
                    phoneError.style.display = 'block';
                    this.classList.add('is-invalid');
                    this.classList.remove('is-valid');
                } else {
                    phoneError.style.display = 'none';
                    this.classList.remove('is-invalid');
                    this.classList.add('is-valid');
                }
            });

            // Checkup time validation
            const checkupTimeInput = document.getElementById('checkupTime');
            if (checkupTimeInput) {
                // Set minimum date to tomorrow (without time)
                const today = new Date();
                today.setHours(0, 0, 0, 0);  // Remove time part for today

                const tomorrow = new Date(today);
                tomorrow.setDate(today.getDate() + 1);  // Set tomorrow's date

                // Set maximum date to 3 months from now
                const maxDate = new Date(today);
                maxDate.setMonth(today.getMonth() + 3);  // Set maxDate 3 months from today

                // Log for debugging
                console.log("Today:", today);
                console.log("Tomorrow:", tomorrow);
                console.log("Max Date:", maxDate);

                checkupTimeInput.addEventListener('input', function () {
                    const selectedDate = new Date(this.value);
                    // Log the selected date for debugging
                    console.log("Selected Date:", selectedDate);

                    const isValidDate = selectedDate >= tomorrow && selectedDate <= maxDate;

                    if (!isValidDate) {
                        alert('Please select a date between tomorrow and 3 months from now');
                        this.value = '';  // Clear input if invalid
                    }
                });
            }

            // Form submission validation
            form.addEventListener('submit', function (event) {
                // Phone validation
                const isValidPhone = validatePhone(phoneInput.value);
                if (!isValidPhone) {
                    event.preventDefault();
                    phoneError.style.display = 'block';
                    phoneInput.classList.add('is-invalid');
                    phoneInput.focus();
                    return false;
                }

                // Checkup time validation
                const selectedDate = new Date(checkupTimeInput.value);
                const today = new Date();
                today.setHours(0, 0, 0, 0);  // Remove time part for today

                const tomorrow = new Date(today);
                tomorrow.setDate(today.getDate() + 1);  // Set tomorrow's date

                const maxDate = new Date(today);
                maxDate.setMonth(today.getMonth() + 3);  // Set maxDate 3 months from today

                console.log("Today:", today);
                console.log("Tomorrow:", tomorrow);
                console.log("Max Date:", maxDate);

                const isValidDate = selectedDate >= tomorrow && selectedDate <= maxDate;
                if (!isValidDate) {
                    event.preventDefault();
                    alert('Please select a valid appointment date (between tomorrow and 3 months from now)');
                    checkupTimeInput.focus();
                    return false;
                }
            });

            // Shift update logic (no changes needed here)
            function updateShifts() {
                const dateInput = document.getElementById("checkupDate").value;
                const shiftContainer = document.getElementById("shiftButtons");
                const selectedShiftInput = document.getElementById("selectedShift");
                const checkupTimeInput = document.getElementById("checkupTime");
                const day = new Date(dateInput).getDay();
                shiftContainer.innerHTML = "";
                selectedShiftInput.value = "";

                const morningShifts = ["08:00-9:00", "09:00-10:00", "10:00-11:00", "11:00-12:00"];
                const afternoonShifts = ["13:00-14:00", "14:00-15:00", "15:00-16:00", "16:00-17:00",
                    "17:00-18:00", "18:00-19:00", "19:00-20:00"];
                const sundayShifts = ["09:00-10:00", "10:00-11:00", "11:00-12:00",
                    "13:00-14:00", "14:00-15:00", "15:00-16:00", "16:00-17:00", "17:00-18:00"];

                let shiftsToDisplay = [];
                if (day === 0) {
                    shiftsToDisplay = sundayShifts;
                } else {
                    shiftsToDisplay = [...morningShifts, ...afternoonShifts];
                }

                shiftsToDisplay.forEach(shift => {
                    const button = document.createElement("button");
                    button.type = "button";
                    button.className = "btn btn-outline-primary";
                    button.textContent = shift;
                    button.onclick = () => selectShift(shift);
                    shiftContainer.appendChild(button);
                });
            }

            function selectShift(shift) {
                const buttons = document.querySelectorAll("#shiftButtons button");
                buttons.forEach(button => button.classList.remove("btn-primary"));
                buttons.forEach(button => button.classList.add("btn-outline-primary"));

                const selectedButton = Array.from(buttons).find(button => button.textContent === shift);
                selectedButton.classList.remove("btn-outline-primary");
                selectedButton.classList.add("btn-primary");

                document.getElementById("selectedShift").value = shift;

                const checkupDate = document.getElementById('checkupDate').value;
                const shiftStart = shift.split('-')[0].trim();
                const formattedCheckupTime = checkupDate + " " + shiftStart;

                document.getElementById("checkupTime").value = formattedCheckupTime;
            }

            const dateInput = document.getElementById("checkupDate");
            dateInput.addEventListener("change", updateShifts);
        });
        const paymentMethodRadios = document.getElementsByName('paymentMethod');

        paymentMethodRadios.forEach(radio => {
            radio.addEventListener('change', function () {
                const selectedPaymentMethod = document.querySelector('input[name="paymentMethod"]:checked').value;
                console.log(selectedPaymentMethod); 
            });
        });
    </script>
</html>