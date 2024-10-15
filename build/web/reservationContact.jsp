<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>

        <title>Children Care</title>

        <meta charset="UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=Edge">
        <meta name="description" content="">
        <meta name="keywords" content="">
        <meta name="author" content="Tooplate">
        <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
        <script src="https://kit.fontawesome.com/561d0dd876.js" crossorigin="anonymous"></script>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
        <link href="../assets/css/toolplate-iso.css" rel="stylesheet" type="text/css"/>
        <link rel ="stylesheet" href="../assets/css/bootstrap-iso.css">
        <link rel="stylesheet" href="../assets/css/bootstrap.min.css">
        <link rel="stylesheet" href="../assets/css/font-awesome.min.css">
        <link rel="stylesheet" href="../assets/css/animate.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.9.0/css/bootstrap-datepicker.min.css" integrity="sha512-mSYUmp1HYZDFaVKK//63EcZq4iFWFjxSL+Z3T/aCt4IO9Cejm03q3NKKYN6pFQzY0SBOr8h+eCIAZHPXcpZaNw==" crossorigin="anonymous" referrerpolicy="no-referrer" />
        <!-- MAIN CSS -->
        <link rel="stylesheet" href="../assets/css/tooplate-style.css">
        <link rel="stylesheet" href="../assets/css/custom.css" />

    </head>
    <body id="top" data-spy="scroll" data-target=".navbar-collapse" data-offset="50">

        <jsp:include page="./common/common-homepage-header.jsp"></jsp:include>


        <!-- MENU -->
        <div  class="toolplate-iso bootstrap-iso">
            <section class="navbar navbar-default navbar-static-top" role="navigation">
                <div class="container">

                    <div class="navbar-header">
                        <button class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
                            <span class="icon icon-bar"></span>
                            <span class="icon icon-bar"></span>
                            <span class="icon icon-bar"></span>
                        </button>

                        <!-- lOGO TEXT HERE -->
                        <a href="../home" class="navbar-brand">Children Care</a>
                    </div>

                    <!-- MENU LINKS -->
                    <div class="collapse navbar-collapse">
                        <ul class="nav navbar-nav navbar-right">
                            <li><a href="../home" class="smoothScroll dropdown">Home</a></li>
                            <li><a href="../service/list" class="smoothScroll dropdown">Services</a></li>
                            <li><a href="../blog/list" class="smoothScroll dropdown">Blog</a></li>
                                <c:if test="${ empty sessionScope.user}">
                                <li><a style="font-size: 25px;color: #00aeef" href="../cart/list" class="smoothScroll"><i class="fa fa-shopping-cart"></i></a></li>
                                <li class="appointment-btn"><a class="login-trigger" href="../login">Login</a></li>
                                <li class="appointment-btn"><a class="login-trigger" href="../register">Sign up</a></li>

                            </c:if>
                            <c:if test="${not empty sessionScope.user}">
                                <li class="dropdown">
                                    <a href="#" class="dropdown-toggle"  data-toggle="dropdown">Personal</a>
                                    <div class="dropdown-menu">
                                        <p class="dropdown-link dropdown-item"> <a href="../customer/reservation/my" class="smoothScroll">My Reservation</a></p>
                                        <p class="dropdown-link dropdown-item"> <a href="../customer/myprescription/exams" class="smoothScroll">My Prescriptions</a></p>
                                    </div>
                                </li>
                                <c:if test="${sessionScope.user.role.name == 'Manager' || sessionScope.user.role.name == 'Admin'}">

                                    <li class="dropdown">
                                        <a href="#" class="dropdown-toggle"  data-toggle="dropdown">Manage</a>
                                        <div class="dropdown-menu">
                                            <p class="dropdown-link dropdown-item"> <a href="../manager/customer/list">Customers</a></p>
                                            <p class="dropdown-link dropdown-item"> <a href="../manager/reservation/list">Reservations</a></p>
                                            <p class="dropdown-link dropdown-item"> <a href="../manager/feedback/list">Feedbacks</a></p>
                                            <p class="dropdown-link dropdown-item"> <a href="../manager/post/list">Posts</a></p>
                                            <p class="dropdown-link dropdown-item"> <a href="../manager/slider/list">Sliders</a></p>
                                            <p class="dropdown-link dropdown-item"> <a href="../manager/service/list">Services</a></p>
                                        </div>
                                    </li>
                                    <c:if test="${sessionScope.user.role.name == 'Admin'}">
                                        <li class="dropdown"><a href="../admin/dashboard/view" class="smoothScroll">Dashboard</a></li>
                                        </c:if>
                                    </c:if>
                                    <c:if test="${sessionScope.user.role.name == 'Staff'}">

                                    <li class="dropdown">
                                    <li><a href="../staff/reservation/list" class="smoothScroll dropdown">Reservations list</a></li>
                                    </li>
                                </c:if>
                                <li><a style="font-size: 25px;color: #00aeef" href="../cart/list" class="smoothScroll"><i class="fa fa-shopping-cart"></i></a></li>
                                <div class="dropdown ">
                                    <img class="avatar" src="../${sessionScope.user.imageLink}">

                                    <div class="dropdown-content">
                                        <p style="text-align: left"> <a href="../customer/userprofile"><i style="margin-right: 5px" class="fas fa-info-circle"></i>Profile</a></p>
                                        <p style="text-align: left; margin-bottom: 0"> <a href="../logout"><i style="margin-right: 5px" class="fas fa-sign-out-alt"></i>Log Out</a></p>
                                    </div>
                                </div>
                                <p class="dropdown-name" style="margin:auto; color: black">${sessionScope.user.fullName}</p>
                            </c:if>
                        </ul>
                    </div>
                </div>
            </section>
        </div>
        <!-- End Banner -->
        <!-- section -->
        <div class="container" style="margin-top: 70px; margin-bottom: 70px">
            <h3 style="text-align: center">Receiver info</h3>
            <div class="row">
                <div class="col-md-2"></div>
                <div class="col-md-8">
                    <form action="contact/addreceiver" class="needs-validation" novalidate method="POST" id="receiver-info">
                        <input type="text" name="rid" value="${requestScope.reservation.id}" hidden>
                        <div class="form-group">
                            <label for="name">Full name</label>
                            <input type="text" class="form-control" id="name" name="name" value="${requestScope.user.fullName}" required>
                            <div class="invalid-feedback">
                                Please enter your name.
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="gender">Gender:    </label>
                            <div class="form-check form-check-inline">
                                <input class="form-check-input" type="radio" name="gender" id="male" value="male" <c:if test="${requestScope.user.gender eq true}">checked</c:if> required>
                                    <label class="form-check-label" for="male">Male</label>
                                    <div class="invalid-feedback">
                                        Please choose a gender.
                                    </div>
                                </div>
                                <div class="form-check form-check-inline">
                                    <input class="form-check-input" type="radio" name="gender" id="female" value="female" <c:if test="${requestScope.user.gender eq false}">checked</c:if> required>
                                    <label class="form-check-label" for="female">Female</label>
                                    
                                </div>

                            </div>
                            <div class="row">
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <label for="email">Email</label>
                                        <input type="email" class="form-control" name="email" id="email" value="${requestScope.user.email}" onchange="checkExistingEmail()" required>
                                    <div class="invalid-feedback">
                                        Please enter your email.
                                    </div>
                                    <div id="email-notify" style="display: none">
                                        Email already exists in DB
                                    </div>
                                </div>

                            </div>
                            <div class="col-md-6">
                                <div class="form-group">
                                    <label for="phone">Phone Number</label>
                                    <input type="tel" class="form-control" id="phone" name="phone" value="${requestScope.user.mobile}" pattern="[0-9]{10}">
                                    <div class="invalid-feedback">
                                        Please enter a valid phone number.
                                    </div>
                                </div>

                            </div>
                        </div>
                        <div class="form-group">
                            <label for="address">Address</label>
                            <input type="text" class="form-control" id="address" name="address" value="${requestScope.user.address}" required>
                            <div class="invalid-feedback">
                                Please enter your address.
                            </div>
                        </div>

                        <div class="form-group">
                            <label for="checkup-time">Checkup time</label>
                            <input type="text" data-date-format="dd/mm/yyyy" class="form-control" name="checkup-time" id="datepicker" autocomplete="off" required/>
                            <div class="invalid-feedback">
                                Please enter your preferred checkup time.
                            </div>
                        </div>
                        <input id="submit_handle" type="submit" style="display: none">
                    </form>
                </div>
            </div>
            <br>
            <h3 style="text-align: center">Service info</h3>
            <c:if test="${not empty requestScope.services}">

                <table class="table" id="reservation-detail">
                    <thead  class="thead-dark">
                        <tr >
                            <td >Id</td>
                            <td >Title</td>
                            <td >Unit price</td>
                            <td >Quantity</td>
                            <td>Cost</td>

                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="list" items="${requestScope.services}">
                            <tr >
                                <td>${list.service.id}</td>
                                <td>${list.service.fullname}</td>
                                <td><fmt:formatNumber type = "number" 
                                      pattern = "###,###,###" value = "${list.unitPrice}" />đ</td>
                                <td>${list.quantity}</td>
                                <td><fmt:formatNumber type = "number" 
                                         pattern = "###,###,###" value = "${list.unitPrice * list.quantity}" />đ</td>

                            </tr>
                        </c:forEach>
                        <tr>
                            <td colspan="4" style="text-align: right">Total cost</td>
                            <td style="font-size: 18px"><fmt:formatNumber type = "number" 
                                      pattern = "###,###,###" value = "${requestScope.totalCost}" />đ</td>
                        </tr>
                    </tbody>
                </table>


            </c:if>
            <c:if test="${empty requestScope.services}">

                <h1>You have nothing in cart!</h1>
                <button type="button" class="button btn btn-outline-primary"><a href="/service">More Service</a>
                </c:if>
                <button type="button" class="btn btn-primary pull-left" onclick="window.location.href = '../cart/list?rid=${requestScope.reservation.id}'">Change</button>

                <button type="button" class="btn btn-primary pull-right" onclick="submitReceiver()">Submit</button>

        </div>


        <jsp:include page="./common/common-homepage-footer.jsp"></jsp:include> 

        <!-- SCRIPTS -->
        <script src="../assets/js/jquery.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/5.0.2/js/bootstrap.min.js" integrity="sha512-a6ctI6w1kg3J4dSjknHj3aWLEbjitAXAjLDRUxo2wyYmDFRcz2RJuQr5M3Kt8O/TtUSp8n2rAyaXYy1sjoKmrQ==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
        <script src="../assets/js/bootstrap.min.js"></script>
        <script src="../assets/js/jquery.sticky.js"></script>
        <script src="../assets/js/jquery.stellar.min.js"></script>
        <script src="../assets/js/wow.min.js"></script>
        <script src="../assets/js/smoothscroll.js"></script>
        <script src="../assets/js/owl.carousel.min.js"></script>
        <script src="../assets/js/custom-new.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.9.0/js/bootstrap-datepicker.min.js" integrity="sha512-T/tUfKSV1bihCnd+MxKD0Hm1uBBroVYBOYSk1knyvQ9VyZJpc/ALb4P0r6ubwVPSGB2GvjeoMAJJImBG12TiaQ==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
        <script>
                    $('ul.nav li.dropdown').hover(function () {
                        $(this).find('.dropdown-menu').stop(true, true).delay(200).fadeIn(500);
                    }, function () {
                        $(this).find('.dropdown-menu').stop(true, true).delay(200).fadeOut(500);
                    });
                    
                    $('.datepicker').datepicker({
                        format: 'dd/mm/yyyy'
                    });

        </script>
        <c:if test="${empty sessionScope.mess}">
            <c:if test="${ not empty sessionScope.alert}">
                <script>
                    $(document).ready(function () {
                        let note = "${sessionScope.alert}"
                        alert(note);
                    });
                </script>
                <c:remove var="alert" scope="session" />

            </c:if>
        </c:if>
        <c:if test="${ not empty sessionScope.mess}">
            <script>
                $(document).ready(function () {
                    let mess = "${sessionScope.mess}"
                    alert(mess);
                });
            </script>
            <c:remove var="mess" scope="session" />
        </c:if>
        <script>
            $('#datepicker').datepicker();
        </script>
        <style>
            #reservation-detail{
                width:80%; 
                margin-top: 50px; 
                margin-left: 10%;
                margin-right: 10%;
            }
            .modal-backdrop.in{
                opacity: 0 !important;
            }
            .modal-backdrop {
                z-index: 0;
            }
        </style>
        <script>
            
            function submitReceiver() {
                $('#submit_handle').click();
            }
//            function checkExistingEmail() {
//                $.ajax({
//                   url: "contact/checkemail" ,
//                   method: "post",
//                   data: { email : $("#email").val()},
//                   success: function(data) {
//                       $.each(data, function(index, item) { // Iterate over the JSON array.
//                            if (item === "true"){
//                                document.getElementById("email-notify").style.display = "block";
//                            } else {
//                                document.getElementById("email-notify").style.display = "none";
//                            }
//    });
//                }
//                });
//            }
        </script>
        <script>
            $(document).ready(function (){
                $("#male").prop("checked", true);
            });
            
// Example starter JavaScript for disabling form submissions if there are invalid fields
// Example starter JavaScript for disabling form submissions if there are invalid fields
            (function () {
                'use strict'

                // Fetch all the forms we want to apply custom Bootstrap validation styles to
                var forms = document.querySelectorAll('.needs-validation')

                // Loop over them and prevent submission
                Array.prototype.slice.call(forms)
                        .forEach(function (form) {
                            form.addEventListener('submit', function (event) {
                                if (!form.checkValidity()) {
                                    event.preventDefault()
                                    event.stopPropagation()
                                }

                                form.classList.add('was-validated')
                            }, false)
                        })
            })()
        </script>
    </body>
</html> 