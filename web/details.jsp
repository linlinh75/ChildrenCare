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
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">


        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.0.0-alpha2/css/bootstrap-grid.min.css" integrity="sha512-Jn+RkWIYxM5Cn3mfAWyV7CgxFnDFxe3EBh93974boKdhcAUE9TSr7qJTJNlzt+J2wG6a3sLYnEyRF+1/o01u9Q==" crossorigin="anonymous" referrerpolicy="no-referrer" />


        <!--<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">-->
        <link href="../assets/css/toolplate-iso.css" rel="stylesheet" type="text/css"/>
        <link rel ="stylesheet" href="../assets/css/bootstrap-iso.css">
        <link rel="stylesheet" href="../assets/css/bootstrap.min.css">
        <link rel="stylesheet" href="../assets/css/font-awesome.min.css">
        <link rel="stylesheet" href="../assets/css/animate.css">
        <link rel="stylesheet" href="../assets/css/owl.carousel.css">
        <link rel="stylesheet" href="../assets/css/owl.theme.default.min.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css" integrity="sha512-iBBXm8fW90+nuLcSKlbmrPcLa0OT92xO1BIsZ+ywDWZCvqsWgccV3gFoRBv0z+8dLJgyAHIhR35VZc2oM/gI1w==" crossorigin="anonymous" referrerpolicy="no-referrer" />
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/OwlCarousel2/2.3.4/assets/owl.theme.default.min.css" integrity="sha512-sMXtMNL1zRzolHYKEujM2AqCLUR9F2C4/05cdbxjjLSRvMQIciEPCQZo++nk7go3BtSuK9kfa/s+a4f4i5pLkw==" crossorigin="anonymous" referrerpolicy="no-referrer" />
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/OwlCarousel2/2.3.4/assets/owl.carousel.min.css" integrity="sha512-tS3S5qG0BlhnQROyJXvNjeEM4UpMXHrQfTGmbQ1gKmelCxlSEBUaxhRBj/EFTzpbP4RVSrpEikbmdJobCvhE3g==" crossorigin="anonymous" referrerpolicy="no-referrer" />
        <!-- MAIN CSS -->
        <link rel="stylesheet" href="../assets/css/tooplate-style.css">
        <link rel="stylesheet" href="../assets/css/custom.css" />
    </head>
    <body id="top" data-spy="scroll" data-target=".navbar-collapse" data-offset="50">

        <!-- PRE LOADER -->



        <!-- HEADER -->
        <header>
            <div class="container">
                <div class="row">

                    <div class="col-md-4 col-sm-5">
                        <p>Welcome to a Professional Health Care</p>
                    </div>

                    <div class="col-md-8 col-sm-7 text-align-right">
                        <span class="phone-icon"><i style="color:#4267b2" class="fa fa-phone"></i> 010-060-0160</span>
                        <span class="date-icon"><i style="color:#4267b2" class="fa fa-calendar"></i> 6:00 AM - 10:00 PM (Mon-Fri)</span>
                        <span class="email-icon"><i style="color:#4267b2" class="fa fa-envelope-o"></i> <a href="#">info@company.com</a></span>
                    </div>

                </div>
            </div>
        </header>


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
                    </div>

                    <!-- MENU LINKS -->
                    <div class="collapse navbar-collapse">

                        <a href="../home" class="navbar-brand">Children Care</a>
                        <ul class="nav navbar-nav navbar-right">
                            <li><a href="../home" class="smoothScroll dropdown">Home</a></li>
                            <li><a href="list" class="smoothScroll dropdown">Services</a></li>
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
                                    <img class="avatar" src="${sessionScope.user.imageLink}">

                                    <div class="dropdown-content">
                                        <p style="text-align: left"> <a href="../userprofile"><i style="margin-right: 5px" class="fas fa-info-circle"></i>Profile</a></p>
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


        <!-- HOME -->




        <!-- HOME -->
        <section data-stellar-background-ratio="0.5">
            <div class="container row" style="margin: 50px 0 50px 0">
                <div class="col-3" style="margin-top: 18px">

                    <div>
                        <form action="list">

                            <input style="width: 150px; display: inline-block" type="search" class="form-control rounded col-10" placeholder="Search" name="search">
                            <button class="btn btn-outline-info col-2"><i class="fas fa-search fa-lg"></i></button>

                        </form>
                    </div> 
                    <div >
                        <a href="list"><h4 style="color: #0064af;margin: 10px 0 30px 0;">Categories</h4></a>
                        <c:forEach items="${requestScope.categories}" var="c">
                            <div class="category"><a <c:if test="${c.id == requestScope.service.category.id}">class="chosen"</c:if> href="list?category=${c.id}">${c.name}</a></div>
                                <hr>
                        </c:forEach>
                    </div>
                    <div><a href="#">Static links</a></div>
                </div>
                <div class="col-9">
                    <div class="container" >
                        <div class="row">
                            <div class="col-md-6">
                                <div class="full text_align_right_img" style="margin-top: 30px">
                                    <img class="rounded" src="../${requestScope.service.thumbnailLink}" alt="#" style="width: 100%;"/>
                                </div>
                            </div>
                            <div class="col-md-6 layout_padding">
                                <div class="full paddding_left_15">
                                    <div class="heading_main text_align_left">
                                        <h2><span class="theme_color">${requestScope.service.id}. </span>${requestScope.service.fullname}</h2>	
                                    </div>
                                </div>
                                <div class="full paddding_left_15">
                                    <p>Category: ${requestScope.service.category.name}</p>
                                </div>
                                <div class="full paddding_left_15">
                                    <p>${requestScope.service.description}</p>
                                </div>

                                <div class="full paddding_left_15 price">
                                    <c:if test="${requestScope.service.originalPrice > requestScope.service.salePrice}">
                                        <span style="text-decoration: line-through; color: gray; display: block;"><fmt:formatNumber type = "number" 
                                                          pattern = "###,###,###" value = "${requestScope.service.originalPrice}" /></span>
                                        </c:if>
                                    <span style="text-decoration: white; font-size: 20px; display: block;"><fmt:formatNumber type = "number" 
                                                      pattern = "###,###,###" value = "${requestScope.service.salePrice}" />đ</span>
                                </div>
                                <div style="margin-top: 30px;">
                                    <button class="btn btn-outline-info" onclick="addToCart(${requestScope.service.id}, ${requestScope.reservation_id})" style="border-color: #17a2b8">Add to Cart</button>

                                    <button class="btn btn-outline-warning" onclick="window.location.href = '../feedback?id=${s.id}'" style="border-color:#ffc107">Feedback</button>

                                </div>
                            </div>
                        </div>


                    </div>
                    <div class="container" style="font-family: 'Roboto'; font-size: 120%;">
                        </br>
                        ${requestScope.service.details}
                    </div>  
                    <div class="container" style="margin-top: 20px;">
                    <c:if test="${sessionScope.user.role.name == 'Manager' || sessionScope.user.role.name == 'Admin'}">
                        <button onclick="window.location.href='../manager/service/edit?sid=${requestScope.service.id}'" class="btn btn-primary" style="float: right;">Edit Service</button>
                    </c:if></div>
                </div></div>
                        
        </section>


        <!-- MAKE AN APPOINTMENT -->





        <!-- FOOTER -->
        <footer data-stellar-background-ratio="5">
            <div class="container">
                <div class="row">

                    <div class="col-md-4 col-sm-4">
                        <div class="footer-thumb"> 
                            <h4 class="wow fadeInUp" data-wow-delay="0.4s">Contact Info</h4>
                            <p>Fusce at libero iaculis, venenatis augue quis, pharetra lorem. Curabitur ut dolor eu elit consequat ultricies.</p>

                            <div class="contact-info">
                                <p><i class="fa fa-phone"></i> 010-070-0170</p>
                                <p><i class="fa fa-envelope-o"></i> <a href="#">info@company.com</a></p>
                            </div>
                        </div>
                    </div>

                    <div class="col-md-4 col-sm-4"> 
                    </div>

                    <div class="col-md-4 col-sm-4"> 
                        <div class="footer-thumb">
                            <div class="opening-hours">
                                <h4 class="wow fadeInUp" data-wow-delay="0.4s">Opening Hours</h4>
                                <p>Monday - Friday <span>06:00 AM - 10:00 PM</span></p>
                                <p>Saturday <span>09:00 AM - 08:00 PM</span></p>
                                <p>Sunday <span>Closed</span></p>
                            </div> 

                            <ul class="social-icon">
                                <li><a href="#" class="fa fa-facebook-square" attr="facebook icon"></a></li>
                                <li><a href="#" class="fa fa-twitter"></a></li>
                                <li><a href="#" class="fa fa-instagram"></a></li>
                            </ul>
                        </div>
                    </div>
                    <div class="col-md-2 col-sm-2 text-align-center">
                        <div class="angle-up-btn"> 
                            <a href="#top" class="smoothScroll wow fadeInUp" data-wow-delay="1.2s"><i class="fa fa-angle-up"></i></a>
                        </div>
                    </div>


                </div>
            </div>
        </footer>

        <!-- SCRIPTS -->
        <script src="../assets/js/jquery.js"></script>
        <script src="../assets/js/bootstrap.min.js"></script>
        <script src="../assets/js/jquery.sticky.js"></script>
        <script src="../assets/js/jquery.stellar.min.js"></script>
        <script src="../assets/js/wow.min.js"></script>
        <script src="../assets/js/smoothscroll.js"></script>
        <script src="../assets/js/owl.carousel.min.js"></script>
        <script src="../assets/js/custom-new.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/OwlCarousel2/2.3.4/owl.carousel.min.js" integrity="sha512-bPs7Ae6pVvhOSiIcyUClR7/q2OAsRiovw4vAkX+zJbw3ShAeeqezq50RIIcIURq7Oa20rW2n2q+fyXBNcU9lrw==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
        <script>
                                        $('ul.nav li.dropdown').hover(function () {
                                            $(this).find('.dropdown-menu').stop(true, true).delay(200).fadeIn(500);
                                        }, function () {
                                            $(this).find('.dropdown-menu').stop(true, true).delay(200).fadeOut(500);
                                        });
                                        function addToCart(id, reservation_id) {
                                            $.ajax({
                                                url: "../cart/add",
                                                data: {service_id: id, reservation_id: reservation_id},
                                                success: function () {
                                                    setInterval('location.reload()', 100);
                                                }


                                            });

                                        }
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
        <style>
            .category{
                font-size: 21px;
            }
            .category a:hover{
                color: lightgray;
            }
            .category a.chosen{
                color: #0064af;
            }
            .price{
                color: #0064af;
                font-weight: bold;
                font-size: 17px;
                padding-top: 10px;
            }
        </style>
    </body>
</html>