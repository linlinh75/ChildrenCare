<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
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
                        <li><i class="fa fa-envelope"></i><a href="mailto:support@yourmail.com">support@yourmail.com</a></li>
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
                        <!-- End Mobile Nav -->
                    </div>
                    <div class="col-lg-6 col-md-9 col-12">
                        <!-- Main Menu -->
                        <div class="main-menu">
                            <nav class="navigation">
                                <ul class="nav menu">
                                    <li class="active"><a href="HomeServlet">Home</i></a>
                                    </li>
                                    <li>
                                        <a href="#">Services<i class="icofont-rounded-down"></i></a>
                                        <ul class="dropdown">
                                            <c:forEach var="service" items="${list_sc}">
                                                <li><a href="#">${service.getName()}</a></li>
                                            </c:forEach>
                                        </ul>
                                    </li>

                                    <li><a href="#">Blogs<i class="icofont-rounded-down"></i></a>
                                        <ul class="dropdown">
                                            <c:forEach var="post" items="${list_pc}">
                                                <li><a href="#">${post.getName()}</a></li>
                                            </c:forEach>
                                        </ul>
                                    </li>
                                </ul>
                            </nav>
                        </div>
                        <!--/ End Main Menu -->
                    </div>
                    <div class="col-lg-3 col-12">
                        <div class="get-quote">
                            <a href="register.jsp" class="btn" style="background-color: orange;">Register</a>
                            <a href="login.jsp" class="btn">Login</a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!--/ End Header Inner -->
</header>