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
        <title>Blog Grid - Medical and Doctor HTML Template</title>

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
                            <c:if test="${not empty searchQuery}">
                                <div class="col-12">
                                    <h2>Search Results for: ${searchQuery}</h2>
                                </div>
                            </c:if>
                            <c:forEach items="${listPost}" var="post">
                                <div class="col-lg-6 col-md-6 col-12">
                                    <!-- Single Blog -->
                                    <div class="single-news">
                                        <div class="news-head">
                                            <img src="${post.thumbnailLink}" alt="#">
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
                        <!-- Pagination -->
                        <c:if test="${totalPages >= 1}">
                            <div class="row">
                                <div class="col-12">
                                    <div class="pagination">
                                        <ul class="pagination-list">
                                            <c:forEach begin="1" end="${totalPages}" var="i">
                                                <li class="${currentPage eq i ? 'active' : ''}">
                                                    <c:choose>
                                                        <c:when test="${not empty searchQuery}">
                                                            <a href="post?action=search&query=${searchQuery}&page=${i}">${i}</a>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <a href="post?page=${i}">${i}</a>
                                                        </c:otherwise>
                                                    </c:choose>
                                                </li>
                                            </c:forEach>
                                        </ul>
                                    </div>
                                </div>
                            </div>
                        </c:if>
                        <!-- End Pagination -->
                    </div>
                    <div class="col-lg-4 col-12">
                        <div class="main-sidebar">
                            <!-- Single Widget -->
                            <div class="single-widget search">
                                <form action="post" method="get">
                                    <input type="hidden" name="action" value="search">
                                    <input type="text" name="query" placeholder="Search Here..." value="${searchQuery}">
                                    <button type="submit" class="button"><i class="fa fa-search"></i></button>
                                </form>
                            </div>
                            <!--/ End Single Widget -->

                            <!-- Single Widget -->
<!--                            <div class="single-widget category">
                                <h3 class="title">Blog Categories</h3>
                                <ul class="categor-list">
                                    <c:forEach items="${categories}" var="category">
                                        <li><a href="#">${category}</a></li>
                                        </c:forEach>
                                </ul>
                            </div>-->
                            <!--/ End Single Widget -->

                            <!-- Single Widget -->
                            <div class="single-widget recent-post">
                                <h3 class="title">Recent Posts</h3>
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
                                            </ul>
                                        </div>
                                    </div>
                                    <!-- End Single Post -->
                                </c:forEach>
                            </div>
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
