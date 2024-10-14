<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

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
                            <h2>Blog Grid</h2>
                            <ul class="bread-list">
                                <li><a href="HomeServlet">Home</a></li>
                                <li><i class="icofont-simple-right"></i></li>
                                <li class="active">Blog Grid</li>
                            </ul>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!-- End Breadcrumbs -->

        <!-- Single News -->
        <section class="blog grid section">
            <div class="container">
                <div class="row">
                    <div class="col-lg-8 col-12">
                        <div class="row">
                            <c:forEach items="${listPost}" var="post">
                                <div class="col-lg-6 col-md-6 col-12">
                                    <!-- Single Blog -->
                                    <div class="single-news">
                                        <div class="news-head">
                                            <img src="${pageContext.request.contextPath}/${post.thumbnailLink}" alt="#">
                                        </div>
                                        <div class="news-body">
                                            <div class="news-content">
                                                <div class="date">${post.updatedDate}</div>
                                                <h2><a href="post?action=detail&id=${post.id}">${post.title}</a></h2>
                                                <p class="text">${post.description}</p>
                                            </div>
                                        </div>
                                    </div>
                                    <!-- End Single Blog -->
                                </div>
                            </c:forEach>
                        </div>
                    </div>
                    <div class="col-lg-4 col-12">
                        <div class="main-sidebar">
                            <!-- Single Widget -->
<!--                            <div class="single-widget search">
                                <div class="form">
                                    <input type="email" placeholder="Search Here...">
                                    <a class="button" href="#"><i class="fa fa-search"></i></a>
                                </div>
                            </div>-->
                            <!--/ End Single Widget -->
                            <!-- Single Widget -->
<!--                            <div class="single-widget category">
                                <h3 class="title">Blog Categories</h3>
                                <ul class="categor-list">
                                    <li><a href="#">Men's Apparel</a></li>
                                    <li><a href="#">Women's Apparel</a></li>
                                    <li><a href="#">Bags Collection</a></li>
                                    <li><a href="#">Accessories</a></li>
                                    <li><a href="#">Sun Glasses</a></li>
                                </ul>
                            </div>-->
                            <!--/ End Single Widget -->
                            <!-- Single Widget -->
                            <div class="single-widget recent-post">
                                <h3 class="title">Recent post</h3>
                                <!-- Single Post -->
                                <c:forEach var="recentPost" items="${recentPosts}">
                                    <!-- Single Post -->
                                    <div class="single-post">
                                        <div class="image">
                                            <img src="${pageContext.request.contextPath}/${recentPost.thumbnailLink}" alt="${recentPost.title}">
                                        </div>
                                        <div class="content">
                                            <h5><a href="post?action=detail&id=${recentPost.id}">${recentPost.title}</a></h5>
                                            <ul class="comment">
                                                <li><i class="fa fa-calendar" aria-hidden="true"></i>${recentPost.updatedDate}</li>
                                                <!--<li><i class="fa fa-user" aria-hidden="true"></i>${recentPost.authorId}</li>-->
                                            </ul>
                                        </div>
                                    </div>
                                    <!-- End Single Post -->
                                </c:forEach>
                                <!-- End Single Post -->
                            </div>
                            <!--/ End Single Widget -->
                            <!-- Single Widget -->
<!--                            <div class="single-widget side-tags">
                                <h3 class="title">Tags</h3>
                                <ul class="tag">
                                    <li><a href="#">business</a></li>
                                    <li><a href="#">wordpress</a></li>
                                    <li><a href="#">html</a></li>
                                    <li><a href="#">multipurpose</a></li>
                                    <li><a href="#">education</a></li>
                                    <li><a href="#">template</a></li>
                                    <li><a href="#">Ecommerce</a></li>
                                </ul>
                            </div>-->
                            <!--/ End Single Widget -->
                        </div>
                    </div>
                </div>
            </div>
        </section>
        <!--/ End Single News -->

        <!-- Footer Area -->
       <jsp:include page="common/common-homepage-footer.jsp"></jsp:include>
        <!--/ End Footer Area -->

        
    </body>
</html>
