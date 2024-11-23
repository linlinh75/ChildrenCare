<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="model.User"%>
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
<%--    <link rel="stylesheet" href="css/nice-select.css">--%>
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
</head>
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
    <div class="header-inner" >
        <div class="container">
            <div class="inner">
                <div class="row">
                    <div class="col-lg-3 col-md-3 col-12">
                        <!-- Start Logo -->
                        <div class="logo" >
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
                                    <li class="${active == 'home' ? 'active' : ''}"><a href="HomeServlet">Home</i></a>
                                    </li>
                                    <li class="${active == 'service' ? 'active' : ''}">
                                        <a href="DataServlet?action=service">Services<i class="icofont-rounded-down"></i></a>
                                        <ul class="dropdown">
                                            <c:forEach var="service" items="${listServiceCategory}">
                                                <li><a href="${pageContext.request.contextPath}/service?action=category&categoryId=${service.id}">${service.getName()}</a></li>
                                                </c:forEach>
                                        </ul>
                                    </li>

                                    <li class="${active == 'post' ? 'active' : ''}">
                                        <a href="DataServlet?action=post">Blogs<i class="icofont-rounded-down"></i></a>
                                        <ul class="dropdown">
                                            <c:forEach var="post" items="${listPostCategory}">
                                                <li><a href="${pageContext.request.contextPath}/post?action=category&categoryId=${post.id}">${post.getName()}</a></li>
                                                </c:forEach>
                                        </ul>
                                    </li> 


                                    <c:if test="${sessionScope.account.roleId == 3}">
                                        <li class="${active == 'med' ? 'active' : ''}" >
                                            <a href="DataServlet?action=med">Medical Examination</i></a>
                                            <!--                                        <ul class="dropdown">
                                                                                        <li><a href=""></a></li>
                                                                                    </ul>-->
                                        </li>
                                    </c:if>
                                    <c:if test="${account.roleId == 1}">
                                        <li class="nav-item">
                                            <a class="nav-link ${active == 'dashboard' ? 'active' : ''}" 
                                               href="admin-dashboard">Dashboard</a>
                                        </li>
                                    </c:if>
                                    <c:if test="${account.roleId == 2}">
                                        <li class="nav-item">
                                            <a class="nav-link ${active == 'dashboard' ? 'active' : ''}" 
                                               href="/ChildrenCare/profile">Manager Dashboard</a>
                                        </li>
                                    </c:if>
                                </ul>
                            </nav>
                        </div>
                        <!--/ End Main Menu -->
                    </div>
                    <!-- User Avatar -->                   
                    <div class="col-lg-3 col-12">
                        <div class="get-quote">
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
                                                <c:if test="${sessionScope.account.roleId == 4}">
                                                    <a class="dropdown-item" href="/ChildrenCare/ReservationServlet">My Reservation</a>
                                                </c:if>
                                                <c:if test="${sessionScope.account.roleId == 5}">
                                                    <a class="dropdown-item" href="/ChildrenCare/cashier-reservation"> Reception</a>
                                                </c:if>
                                                <c:if test="${sessionScope.account.roleId == 3}">
                                                    <a class="dropdown-item" href="/ChildrenCare/staff-work-schedule">My Work Schedule</a>
                                                </c:if>
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
                    <!--/ End User Avatar -->
                </div>
            </div>
        </div>
    </div>
    <!--/ End Header Inner -->
</header>
