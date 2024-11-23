<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8" %>
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
    <title>Service</title>

    <!-- Favicon -->
    <link rel="icon" href="img/favicon.png">

    <!-- Google Fonts -->
    <link href="css?family=Poppins:200i,300,300i,400,400i,500,500i,600,600i,700,700i,800,800i,900,900i&display=swap"
          rel="stylesheet">

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
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">

    <style>
        .star-rating {
            color: #ffc107; /* Màu vàng cho sao */
        }

        .sticky-cart-button {
            position: fixed;
            bottom: 100px;
            right: 20px;
            z-index: 1000;
        }

        .sticky-cart-button .btn {
            padding: 10px 20px;
            font-size: 16px;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
            transition: all 0.3s ease-in-out;
        }

        .sticky-cart-button .btn:hover {
            transform: scale(1.05);
        }
    </style>
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
                    <h2>Service</h2>
                    <ul class="bread-list">
                        <li><a href="HomeServlet">Home</a></li>
                        <li><i class="icofont-simple-right"></i></li>
                        <li class="active">Service</li>
                    </ul>
                </div>
            </div>
        </div>
    </div>
</div>
<!-- End Breadcrumbs -->

<!-- Start Service -->
<section class="blog section">
    <div class="container">
        <div class="row">
            <div class="col-lg-8 col-12">
                <div class="row">
                    <c:forEach var="service" items="${serviceList}">
                        <div class="col-lg-4 col-md-6 col-12">
                            <div class="single-news">
                                <div class="news-head">
                                    <img src="${service.thumbnailLink}" alt="#">
                                </div>
                                <div class="news-body">
                                    <div class="news-content">
                                        <div class="date">${service.updatedDate}</div>
                                        <h2>
                                            <a href="service?action=details&id=${service.id}&page=${currentPage}">${service.fullname}</a>
                                        </h2>
                                        <p>${service.description}</p>
                                        <div class="star-rating">
                                            <c:set var="averageRating"
                                                   value="${serviceservlet.getAverageRating(service.id)}"/>
                                            <c:choose>
                                                <c:when test="${averageRating > 0}">
                                                    <c:forEach begin="1" end="5" var="i">
                                                        <c:choose>
                                                            <c:when test="${i <= averageRating}">
                                                                <i class="fas fa-star"></i>
                                                            </c:when>
                                                            <c:when test="${i > averageRating && i - 1 < averageRating}">
                                                                <i class="fas fa-star-half-alt"></i>
                                                            </c:when>
                                                            <c:otherwise>
                                                                <i class="far fa-star"></i>
                                                            </c:otherwise>
                                                        </c:choose>
                                                    </c:forEach>
                                                    <span><fmt:formatNumber value="${averageRating}"
                                                                            maxFractionDigits="1"/></span>
                                                </c:when>
                                                <c:otherwise>
                                                    <c:forEach begin="1" end="5">
                                                        <i class="far fa-star"></i>
                                                    </c:forEach>
                                                </c:otherwise>
                                            </c:choose>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </div>
            <div class="col-lg-4 col-12">
                <div class="main-sidebar">
                    <!-- Single Widget -->
                    <div class="single-widget search">
                        <form action="service" method="get">
                            <input type="hidden" name="action" value="search">
                            <input type="text" name="query" placeholder="Search Services..." value="${searchQuery}">
                            <button type="submit" class="button"><i class="fa fa-search"></i></button>
                        </form>
                    </div>
                    <!--/ End Single Widget -->

                    <!-- You can add more widgets here, such as recent services or categories -->
                </div>
            </div>
        </div>

        <!-- Pagination -->
        <c:choose>
            <c:when test="${pageType eq 'category'}">
                <c:set var="paginationUrl" value="service?action=category&categoryId=${categoryId}&page="/>
            </c:when>
            <c:when test="${pageType eq 'search'}">
                <c:set var="paginationUrl" value="service?action=search&query=${searchQuery}&page="/>
            </c:when>
            <c:otherwise>
                <c:set var="paginationUrl" value="service?page="/>
            </c:otherwise>
        </c:choose>
        <c:if test="${noOfPages > 1}">
            <div class="row">
                <div class="col-12">
                    <div class="pagination">
                        <ul class="pagination-list">
                            <c:if test="${currentPage > 1}">
                                <li><a href="${paginationUrl}${currentPage - 1}">Prev</a></li>
                            </c:if>
                            <c:forEach begin="1" end="${noOfPages}" var="i">
                                <li class="${currentPage eq i ? 'active' : ''}">
                                    <a href="${paginationUrl}${i}">${i}</a>
                                </li>
                            </c:forEach>
                            <c:if test="${currentPage < noOfPages}">
                                <li><a href="${paginationUrl}${currentPage + 1}">Next</a></li>
                            </c:if>
                        </ul>
                    </div>
                </div>
            </div>
        </c:if>
        <!-- End Paginatio
<!-- End Pagination -->
    </div>
</section>
<!-- End Blog Posts -->
<!-- Button Cart - Only show for customers -->
<c:if test="${sessionScope.account.roleId == 4}">
    <!--Button Cart -->
    <div class="sticky-cart-button">
        <a href="./customer-reservation-service-cart" class="btn btn-primary">
            <i class="fa fa-shopping-cart"></i> View Cart
        </a>
    </div>
</c:if>

<!-- Footer Area -->
<jsp:include page="common/common-homepage-footer.jsp"></jsp:include>
<!-- End Footer Area -->

</body>
</html>
