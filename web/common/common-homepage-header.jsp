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
                                        <a href="${pageContext.request.contextPath}/service">Services<i class="icofont-rounded-down"></i></a>
                                    </li>

                                    <li><a href="${pageContext.request.contextPath}/post">Blogs<i class="icofont-rounded-down"></i></a>
                                    </li>
                                </ul>
                            </nav>
                        </div>
                        <!--/ End Main Menu -->
                    </div>
                    <div class="col-lg-3 col-12">
                        <c:choose>
                            <c:when test="${not empty sessionScope.account}">
                                <div class="parent-div" style="display: flex; justify-content: end; align-items: center;">
                                    <div class="dropdown" style="display: flex; align-items: center;">
                                        <span style="margin-right: 10px;">${sessionScope.account.getFullName()}</span>
                                        <div id="userDropdown" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false" style="display: flex; align-items: center; justify-content: center; width: 60px; height: 60px;">
                                            <img src="./${sessionScope.account.getImageLink()}" alt="Avatar" class="rounded-circle" style="width: 60px; height: 50px;">
                                        </div>
                                        <div class="dropdown-menu dropdown-menu-right" aria-labelledby="userDropdown">
                                            <a class="dropdown-item" href="/ChildrenCare/profile">Profile</a>
                                            <a class="dropdown-item" href="#">Reservation</a>
                                            <div class="dropdown-divider"></div>
                                            <a class="dropdown-item" href="LogoutServlet">Logout</a>
                                        </div>
                                    </div>
                                </div>


                            </c:when>
                            <c:otherwise>
                                <a href="register.jsp" class="btn" style="background-color: orange;">Register</a>
                                <a href="login.jsp" class="btn">Login</a>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!--/ End Header Inner -->
</header>