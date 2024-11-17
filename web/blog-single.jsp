<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="dal.PostDAO, model.User, java.sql.SQLException" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!doctype html>
<html class="no-js" lang="zxx">
    <head>
        <!-- Meta Tags -->
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="keywords" content="Site keywords here">
        <meta name="description" content="">
        <meta name='copyright' content=''>
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

        <!-- Title -->
        <title>Mediplus</title>

        <!-- Favicon -->
        <link rel="icon" href="img/favicon.png">

        <!-- Google Fonts -->
        <link href="https://fonts.googleapis.com/css?family=Poppins:200i,300,300i,400,400i,500,500i,600,600i,700,700i,800,800i,900,900i&display=swap" rel="stylesheet">

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

        <!-- Medipro CSS -->
        <link rel="stylesheet" href="css/normalize.css">
        <link rel="stylesheet" href="css/style.css">
        <link rel="stylesheet" href="css/responsive.css">

    </head>
    <body>

        <!-- Get Pro Button -->
        <!--        <ul class="pro-features">
                    <a class="get-pro" href="#">Get Pro</a>
                    <li class="big-title">Pro Version Available on Themeforest</li>
                    <li class="title">Pro Version Features</li>
                    <li>2+ premade home pages</li>
                    <li>20+ html pages</li>
                    <li>Color Plate With 12+ Colors</li>
                    <li>Sticky Header / Sticky Filters</li>
                    <li>Working Contact Form With Google Map</li>
                    <div class="button">
                        <a href="http://preview.themeforest.net/item/mediplus-medical-and-doctor-html-template/full_screen_preview/26665910?_ga=2.145092285.888558928.1591971968-344530658.1588061879" target="_blank" class="btn">Pro Version Demo</a>
                        <a href="https://themeforest.net/item/mediplus-medical-and-doctor-html-template/26665910" target="_blank" class="btn">Buy Pro Version</a>
                    </div>
                </ul>-->

        <!-- Header Area -->
        <jsp:include page="common/common-homepage-header.jsp"></jsp:include>
            <!-- End Header Area -->

            <!-- Breadcrumbs -->
            <div class="breadcrumbs overlay">
                <div class="container">
                    <div class="bread-inner">
                        <div class="row">
                            <div class="col-12">
                                <h2>${post.title}</h2>
                            <ul class="bread-list">
                                <li><a href="HomeServlet">Home</a></li>
                                <li><i class="icofont-simple-right"></i></li>
                                <li class="active">Blog Single</li>
                            </ul>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!-- End Breadcrumbs -->

        <!-- Single News -->
        <section class="news-single section">
            <div class="container">
                <div class="row">
                    <div class="col-lg-8 col-12">
                        <div class="row">
                            <div class="col-12">
                                <div class="single-main">
                                    <!-- News Head -->
                                    <div class="news-head">
                                        <img src="${post.thumbnailLink}" alt="#">
                                    </div>
                                    <!-- News Title -->
                                    <h1 class="news-title"><a href="news-single.html">${post.title}</a></h1>
                                    <!-- Meta -->
                                    <div class="meta">
                                        <div class="meta-left">
                                            <span class="author"><a href="#"><img src="img/author1.jpg" alt="#">${authorName}</a></span>
                                            <span class="date"><i class="fa fa-clock-o"></i>${post.updatedDate}</span>
                                        </div>
                                        <!--                                        <div class="meta-right">
                                                                                    <span class="comments"><a href="#"><i class="fa fa-comments"></i>05 Comments</a></span>
                                                                                    <span class="views"><i class="fa fa-eye"></i>33K Views</span>
                                                                                </div>-->
                                    </div>
                                    <!-- News Text -->
                                    <div class="news-text">
                                        <p>${post.content}</p>
                                    </div>
                                    <!--                                    <div class="blog-bottom">
                                                                             Social Share 
                                                                            <ul class="social-share">
                                                                                <li class="facebook"><a href="#"><i class="fa fa-facebook"></i><span>Facebook</span></a></li>
                                                                                <li class="twitter"><a href="#"><i class="fa fa-twitter"></i><span>Twitter</span></a></li>
                                                                                <li class="google-plus"><a href="#"><i class="fa fa-google-plus"></i></a></li>
                                                                                <li class="linkedin"><a href="#"><i class="fa fa-linkedin"></i></a></li>
                                                                                <li class="pinterest"><a href="#"><i class="fa fa-pinterest"></i></a></li>
                                                                            </ul>
                                                                             Next Prev 
                                                                            <ul class="prev-next">
                                                                                <li class="prev"><a href="#"><i class="fa fa-angle-double-left"></i></a></li>
                                                                                <li class="next"><a href="#"><i class="fa fa-angle-double-right"></i></a></li>
                                                                            </ul>
                                                                            / End Next Prev 
                                                                        </div>-->
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-4 col-12">
                        <div class="main-sidebar">
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
                                <c:forEach var="recentPost" items="${recentPosts}">
                                    <!-- Single Post -->
                                    <div class="single-post">
                                        <div class="image">
                                            <img src="${recentPost.thumbnailLink}" alt="${recentPost.title}">
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
                            </div>
                            <!--/ End Single Widget -->
                            <!-- Single Widget -->
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