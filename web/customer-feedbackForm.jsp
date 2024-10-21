<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Feedback Form</title>      
        <style>
            .star-rating {
                display: flex;
                flex-direction: row-reverse;
                justify-content: flex-start;
            }

            .star-rating input {
                display: none;
            }

            .star-rating label {
                font-size: 2em;
                color: #ccc;
                cursor: pointer;
                transition: color 0.2s ease-in-out;
            }

            .star-rating input:checked ~ label {
                color: #ffc700;
            }

            .star-rating label:hover,
            .star-rating label:hover ~ label {
                color: #ffc700;
            }
        </style>
    </head>
    <jsp:include page="./common/common-homepage-header.jsp"></jsp:include>
        <body>
            <section class="container-fluid" style="width: 80%">
                <div class="bread_crumb">
                    <nav aria-label="breadcrumb">
                        <ol class="breadcrumb">
                            <li class="breadcrumb-item"><a href="HomeServlet">Home</a></li>
                            <li class="breadcrumb-item"><a href="ReservationServlet">My Reservation</a></li>
                            <li class="breadcrumb-item"><a href="customer-feedback">My Feedback</a></li>
                            <li class="breadcrumb-item active" aria-current="page">Feedback Form</li>
                        </ol>
                    </nav>
                </div>

                <div class="" style="display: flex; justify-content: center; ">
                    <form action="customer-feedback" method="post" style="width: 50%; text-align: left; margin: 30px 0px;" class="form-control">
                        <h4 style="margin: 20px 0px;">Feedback</h4>

                        <div class="mb-3" style="display: flex; justify-content: space-between;">
                            <div style="flex: 1; margin-right: 10px;">
                                <label for="exampleFormControlInput1" class="form-label">Full Name</label>
                                <input type="text" class="form-control" id="exampleFormControlInput1" value="${sessionScope.account.getFullName()}" disabled>
                        </div>
                        <div style="flex: 1; margin-left: 10px;">
                            <label for="exampleFormControlInput2" class="form-label">Gender</label>
                            <input type="text" class="form-control" id="exampleFormControlInput2" value="${sessionScope.account.isGender() ? "Male" : "Female"}" disabled>
                        </div>
                    </div>

                    <div class="mb-3" style="display: flex; justify-content: space-between;">
                        <div style="flex: 1; margin-right: 10px;">
                            <label for="exampleFormControlInput3" class="form-label">Email</label>
                            <input type="text" class="form-control" id="exampleFormControlInput3" value="${sessionScope.account.getEmail()}" disabled>
                        </div>
                        <div style="flex: 1; margin-left: 10px;">
                            <label for="exampleFormControlInput4" class="form-label">Mobile</label>
                            <input type="text" class="form-control" id="exampleFormControlInput4" value="${sessionScope.account.getMobile()}" disabled>
                        </div>
                    </div>
                    <div class="mb-3" style="display: flex; justify-content: space-between;">
                        <div style="flex: 1; margin-right: 10px;">
                            <label for="exampleFormControlInput5" class="form-label">Reservation ID</label>
                            <input type="text" class="form-control" id="exampleFormControlInput3" name="id" value="${reservation.getId()}" disabled>
                        </div>
                        <div style="flex: 1; margin-left: 10px;">
                            <label for="exampleFormControlInput6" class="form-label">Checkup Time</label>
                            <input type="text" class="form-control" id="exampleFormControlInput4" value="${reservation.getCheckup_time()}" disabled>
                        </div>
                    </div>
                    <c:forEach var="service" items="${reservation.getList_service()}">
                        <div class="mb-3" style="border: 1px solid #ccc; padding: 10px; margin-bottom: 15px;">
                            <h5>${service.getService_name()}</h5>
                            <div class="mb-3">
                                <label for="feedbackContent_${service.getService_id()}" class="form-label">Feedback Content</label>
                                <textarea class="form-control" id="feedbackContent_${service.getService_id()}" name="feedbackContent_${service.getService_id()}" rows="2" required></textarea>
                            </div>

                            <div class="mb-3" style="display: flex; align-items: center;">
                                <label class="form-label" style="margin-right: 10px;">Rate:</label>
                                <div class="star-rating">
                                    <input type="radio" id="star5_${service.getService_id()}" name="rating_${service.getService_id()}" value="5" required/>
                                    <label for="star5_${service.getService_id()}" class="fa fa-star"></label>

                                    <input type="radio" id="star4_${service.getService_id()}" name="rating_${service.getService_id()}" value="4" />
                                    <label for="star4_${service.getService_id()}" class="fa fa-star"></label>

                                    <input type="radio" id="star3_${service.getService_id()}" name="rating_${service.getService_id()}" value="3" />
                                    <label for="star3_${service.getService_id()}" class="fa fa-star"></label>

                                    <input type="radio" id="star2_${service.getService_id()}" name="rating_${service.getService_id()}" value="2" />
                                    <label for="star2_${service.getService_id()}" class="fa fa-star"></label>

                                    <input type="radio" id="star1_${service.getService_id()}" name="rating_${service.getService_id()}" value="1" />
                                    <label for="star1_${service.getService_id()}" class="fa fa-star"></label>
                                </div>
                            </div>
                        </div>
                    </c:forEach>

                    <div class="mb-3">
                        <button type="submit" class="btn btn-primary" name="submit" value="submit">Submit Feedback</button>
                    </div>
                    <input type="hidden" name="reservation_id" value="${reservation.getId()}">

                </form>
            </div>
        </section>
    </body>
    <jsp:include page="./common/common-homepage-footer.jsp"></jsp:include>

</html>
