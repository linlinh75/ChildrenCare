<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>

        <title>${requestScope.user.fullName}</title>

        <meta charset="UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=Edge">
        <meta name="description" content="">
        <meta name="keywords" content="">
        <meta name="author" content="Tooplate">
        <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
        <script src="https://kit.fontawesome.com/561d0dd876.js" crossorigin="anonymous"></script>
        <link rel="stylesheet" href="https://cdn.datatables.net/1.10.25/css/jquery.dataTables.min.css">
        
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
        <link href="../assets/css/toolplate-iso.css" rel="stylesheet" type="text/css"/>
        <link rel ="stylesheet" href="../assets/css/bootstrap-iso.css">
        <link rel="stylesheet" href="../assets/css/bootstrap.min.css">
        <link rel="stylesheet" href="../assets/css/font-awesome.min.css">
        <link rel="stylesheet" href="../assets/css/animate.css">
        <link rel="stylesheet" href="../assets/css/owl.carousel.css">
        <link rel="stylesheet" href="../assets/css/owl.theme.default.min.css">
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

                    <!-- MENU LINKS -->
                    <div class="collapse navbar-collapse">
                        <ul class="nav navbar-nav navbar-right" >
                            <li><a href="../home" class="smoothScroll dropdown">Home</a></li>
                            <li><a href="./service" class="smoothScroll dropdown">Services</a></li>
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



        <!-- ABOUT -->


        <!-- TEAM -->
        <div class="container" style="height: 1000px;">

            <c:if test="${not empty requestScope.list}">
                <form id="form" action="edit" method="POST">
                    <table class="table">
                        <thead  class="thead-dark">
                            <tr >
                                <td >Id</td>
                                <td >Title</td>
                                <td >Price</td>

                                <td > Quantity</td>
                                <td>Cost</td>
                                <td ></td>

                                <td class="total-cost" rowspan="${requestScope.number}"><h3 id="total" >Total Cost: <fmt:formatNumber type = "number" 
                                                                                                      pattern = "###,###,###" value = "${requestScope.totalcost}" /></h3></td>

                                <td class="total-cost" rowspan="${requestScope.number}"><button type="button" class="btn btn-primary"><a href="./service">More Service</a></button>
                                    <button type="button" class="btn btn-primary" onclick="window.location.href='../reservation/contact?reservation_id=${requestScope.list[0].reservation.id}'">Check Out</button></td>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="list" items="${requestScope.list}">
                                <tr >
                                    <td>${list.service.id}</td>
                                    <td>${list.service.fullname}</td>
                                    <td ><fmt:formatNumber type = "number" 
                                                      pattern = "###,###,###" value = "${list.unitPrice}" /></td>

                                    <td> <input onchange="ResetCart(this)" min="1" style="text-align: center;" name="${list.service.id}" type="number" value="${list.quantity}"></td>

                                    <td id =${list.service.id}><fmt:formatNumber type = "number" 
                                                                         pattern = "###,###,###" value = "${list.unitPrice * list.quantity}" /> </td>
                                    <td id =${list.service.id}><a href="delete?sid=${list.service.id}&rid=${list.reservation.id}"><i class="fas fa-trash-alt"></i></a></td>

                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </form>

            </c:if>
            <c:if test="${empty requestScope.list}">

                <h2>You have nothing in cart!</h2>
                <button type="button" class="btn btn-primary" onclick="window.location.href='./service'">More Service</button>
                </c:if>

                <!--            <h2>Total Cost:</h2>-->
        </div>




        <jsp:include page="./common/common-homepage-footer.jsp"></jsp:include>

        <!-- SCRIPTS -->
        <script src="../assets/js/jquery.js"></script>
        <script src="../assets/js/bootstrap.min.js"></script>
        <script src="../assets/js/jquery.sticky.js"></script>
        <script src="../assets/js/jquery.stellar.min.js"></script>
        <script src="../assets/js/wow.min.js"></script>
        <script src="../assets/js/smoothscroll.js"></script>
        <script src="../assets/js/owl.carousel.min.js"></script>
        <script src="../assets/js/custom-new.js"></script>
        <script>
                                        function ResetCart(param) {
                                            var value = param.value;
                                            var querry = param.name;

                                            $.ajax({
                                                url: "edit",
                                                type: "GET",
                                                data: {rid:${requestScope.list[0].reservation.id}, sid: querry, quantity: value},
                                                success:
                                                        function (data) {
                                                            var b = JSON.parse(JSON.stringify(data));
                                                            console.log(b)
                                                            var c = querry.toString();
                                                            document.getElementById(c).innerHTML = new Intl.NumberFormat().format(b["price"]);
                                                            document.getElementById("total").innerHTML = "Total Cost: " + new Intl.NumberFormat().format(b['total'])

                                                        }

                                            });

                                        }


        </script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/OwlCarousel2/2.3.4/owl.carousel.min.js" integrity="sha512-bPs7Ae6pVvhOSiIcyUClR7/q2OAsRiovw4vAkX+zJbw3ShAeeqezq50RIIcIURq7Oa20rW2n2q+fyXBNcU9lrw==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
        <script>
                                        $('ul.nav li.dropdown').hover(function () {
                                            $(this).find('.dropdown-menu').stop(true, true).delay(200).fadeIn(500);
                                        }, function () {
                                            $(this).find('.dropdown-menu').stop(true, true).delay(200).fadeOut(500);
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
        <style>
            .btn-outline-primary{
                border: #337ab7;
            }
        </style>

    </body>
</html> 