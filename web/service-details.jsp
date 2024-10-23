<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="zxx">
    <head>
        <!-- Meta Tag -->
        <meta charset="utf-8" />
        <meta http-equiv="X-UA-Compatible" content="IE=edge" />
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />

        <!-- Title -->
        <title>Mediplus - Medical and Doctor HTML Template</title>

        <!-- Favicon -->
        <link rel="icon" href="img/favicon.png" />

        <!-- Google Fonts -->
        <link href="https://fonts.googleapis.com/css?family=Poppins:200,300,400,500,600,700&display=swap" rel="stylesheet">

        <!-- Bootstrap CSS -->
        <link rel="stylesheet" href="css/bootstrap.min.css" />
        <!-- Nice Select CSS -->
        <link rel="stylesheet" href="css/nice-select.css" />
        <!-- Font Awesome CSS -->
        <link rel="stylesheet" href="css/font-awesome.min.css" />
        <!-- Slicknav -->
        <link rel="stylesheet" href="css/slicknav.min.css" />
        <!-- Custom CSS -->
        <link rel="stylesheet" href="css/style.css" />
        <link rel="stylesheet" href="css/responsive.css" />

        <!-- Mediplus CSS -->
        <link rel="stylesheet" href="css/color/color1.css" />

        <!-- Inline CSS for Sticky Cart Button -->
        <style>
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
    </head>
    <body>
        <!-- Preloader -->
        <div class="preloader">
            <div class="loader">
                <div class="loader-outter"></div>
                <div class="loader-inner"></div>
            </div>
        </div>
        <!-- End Preloader -->

        <!-- Mediplus Color Plate -->
        <div class="color-plate">
            <a class="color-plate-icon"><i class="fa fa-cog fa-spin"></i></a>
            <h4>Mediplus</h4>
            <p>Choose from awesome colors available.</p>
            <!-- Color Options -->
        </div>
        <!-- /End Color Plate -->

        <!-- Header Area -->
        <jsp:include page="common/common-homepage-header.jsp"></jsp:include>
            <!-- End Header Area -->

            <!-- Breadcrumbs -->
            <div class="breadcrumbs overlay">
                <div class="container">
                    <div class="bread-inner">
                        <div class="row">
                            <div class="col-12">
                                <h2>${service.fullname}</h2>
                            <ul class="bread-list">
                                <li><a href="index.jsp">Home</a></li>
                                <li><i class="icofont-simple-right"></i></li>
                                <li><a href="service">Services</a></li>
                                <li><i class="icofont-simple-right"></i></li>
                                <li class="active">${service.fullname}</li>
                            </ul>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!-- End Breadcrumbs -->

        <!-- Service Details -->
        <div class="service-details-area section">
            <div class="container">
                <div class="service-details-content">
                    <h2>${service.fullname}</h2>
                    <img src="${service.thumbnailLink}" alt="${service.fullname}" class="img-fluid mb-4">
                    <p>${service.description}</p>
                    <p>Last Updated: ${service.updatedDate}</p>
                </div>
            </div>
        </div>

        <!-- Buttons for Cart and Feedback -->
    <center>
        <div style="margin: 30px;">
            <button class="btn btn-outline-info" onclick="addToCart(${service.id}, ${reservation_id})" style="border-color: #17a2b8">Add to Cart</button>
            <button class="btn btn-outline-warning" onclick="window.location.href = '../feedback?id=${service.id}'" style="border-color: #ffc107;">Feedback</button>
        </div>
    </center>

    <!-- Sticky Cart Button -->
    <div class="sticky-cart-button">
        <a href="./customer-cart" class="btn btn-primary">
            <i class="fa fa-shopping-cart"></i> View Cart
        </a>
    </div>

    <!-- Footer Area -->
    <jsp:include page="common/common-homepage-footer.jsp"></jsp:include>
    <!--/ End Footer Area -->

    <!-- JavaScript Files -->
    <script src="js/jquery.min.js"></script>
    <script src="js/bootstrap.min.js"></script>

    <!-- Main JS -->
    <script src="js/main.js"></script>
    <script>
                function addToCart(serviceId, reservationId) {
                    $.ajax({
                        url: "./customer-addcart",
                        data: {service_id: serviceId, reservation_id: reservationId},
                        success: function () {
                            alert('Sản phẩm đã được thêm vào giỏ hàng.');
//                            location.reload();
                        },
                        error: function () {
                            alert('Có lỗi xảy ra khi thêm vào giỏ hàng. Vui lòng thử lại.');
                        }
                    });
                }

    </script>
</body>
</html>
