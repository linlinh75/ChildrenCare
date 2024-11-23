<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Reservation Detail</title>
        <link rel="shortcut icon" href="img/favicon.png">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
        <!-- jQuery first -->
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
        <!-- Then Popper.js -->
        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"></script>
        <!-- Then Bootstrap CSS -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet">
        <!-- Then Bootstrap JS Bundle (includes Popper) -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
    </head>
    <body>
        <jsp:include page="./common/common-homepage-header.jsp"></jsp:include>
            <section class="container" style="padding: 20px; margin-top: 30px; margin-bottom: 30px">
                <div class="bread_crumb">
                    <nav aria-label="breadcrumb">
                        <ol class="breadcrumb" style="background-color: white; box-shadow: 0 0 2px 2px rgba(128, 128, 128, 0.1);">
                            <li class="breadcrumb-item"><a href="HomeServlet">Home</a></li>
                            <li class="breadcrumb-item"><a href="staff-work-schedule">My Work Schedule</a></li>
                            <li class="breadcrumb-item active" aria-current="page">Reservation Detail</li>
                        </ol>
                    </nav>
                </div>
                <form>
                    <table class="table">
                        <tr>
                            <td><b>Reservation Id:</b></td>
                            <td>${res.getId()}</td>
                        <td><b>Customer Name:</b></td>
                        <td>
                            <c:forEach var="user" items="${users}">
                                <c:if test="${user.getId() == res.getCustomer_id()}">
                                    ${user.getFullName()}
                                </c:if>
                            </c:forEach>
                        </td>
                    </tr>
                    <tr>
                        <td><b>Checkup Time:</b></td>
                        <td>${res.getCheckup_time()}</td>
                        <td><b>Status:</b></td>
                        <td>${res.getStatus()}</td>
                    </tr>
                    <tr>
                        <td><b>List of Services:</b></td>
                        <td>
                            <c:forEach var="service" items="${res.getList_service()}">
                                ${service.getService_name()}<br/>
                            </c:forEach>
                        </td>
                        <td><b>Reservation Time:</b></td>
                        <td>1 hour</td>
                    </tr>
                    <tr>
                        <td>
                            <a href="staff-work-schedule?action=start&rid=${res.getId()}" class="btn btn-primary-sm" id="startExaminingBtn">Start Examining</a>
                        </td>
                        <td></td>
                        <td>
                            <a href="#" class="btn btn-primary-sm" id="addServiceBtn" data-bs-toggle="modal" data-bs-target="#serviceModal">Add Service</a>
                        </td>
                        <td></td>
                    </tr>
                </table>
            </form>
        </section>
        <jsp:include page="./common/common-homepage-footer.jsp"></jsp:include>

            <!-- Modal for adding services -->
            <div class="modal fade" id="serviceModal" tabindex="-1" aria-labelledby="serviceModalLabel" aria-hidden="true">
                <div class="modal-dialog modal-lg">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title" id="serviceModalLabel">Select Services</h5>
                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                        </div>
                        <div class="modal-body">
                            <div class="row">
                                <div class="col-md-6">
                                    <h5>Available Services</h5>
                                <c:forEach var="service" items="${allservice}">
                                    <c:choose>
                                        <c:when test="${fn:contains(res.getList_service(), service)}">
                                        </c:when>
                                        <c:otherwise>
                                            <div>
                                                <input type="checkbox" class="service-checkbox" data-service-id="${service.id}" data-service-name="${service.fullname}" /> ${service.fullname}
                                            </div>
                                        </c:otherwise>
                                    </c:choose>
                                </c:forEach>
                            </div>
                            <div class="col-md-6">
                                <h5>Selected Services</h5>
                                <div id="selectedServices">
                                    <!-- Prepopulate selected services -->
                                    <c:forEach var="service" items="${res.getList_service()}">
                                        <div>${service.getService_name()}</div>
                                    </c:forEach>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                        <form id="selectedServicesForm" method="POST" action="staff-work-schedule">
                            <input type="hidden" id="resid" name="resid" value="${res.getId()}" />
                            <input type="hidden" id="selectedServiceIds" name="selectedServiceIds" value="" />
                            <button type="submit" id="saveSelectedServicesBtn" class="btn btn-primary">Save</button>
                        </form>

                    </div>

                </div>
            </div>
        </div>

        <script>
            $(document).ready(function () {
                const checkupTimeStr = "${res.getCheckup_time()}";
                const checkupTime = new Date(checkupTimeStr);
                const currentTime = new Date();

                const checkupEndTime = new Date(checkupTime);
                checkupEndTime.setHours(checkupTime.getHours() + 1);

                const status = "${res.getStatus()}";

                if (currentTime >= checkupTime && currentTime <= checkupEndTime && status === 'Arrived') {
                    $('#startExaminingBtn').show();
                    $('#addServiceBtn').hide();
                } else if (status === 'Examining') {
                    $('#startExaminingBtn').hide();
                    $('#addServiceBtn').show();
                } else {
                    $('#startExaminingBtn').hide();
                    $('#addServiceBtn').hide();
                }

                $(".service-checkbox").change(function () {
                    let selectedServiceName = $(this).parent().text().trim();
                    let serviceId = $(this).data("service-id");

                    if ($(this).prop('checked')) {
                        $("#selectedServices").append('<div id="service-' + serviceId + '">' + selectedServiceName + ' <span class="remove-service" data-service-id="' + serviceId + '" style="cursor: pointer; color: red; font-weight: bold;">&times;</span></div>');
                    } else {
                        $("#service-" + serviceId).remove();
                    }
                });

                $(document).on('click', '.remove-service', function () {
                    let serviceId = $(this).data("service-id");
                    $(this).parent().remove();
                    $(".service-checkbox[data-service-id='" + serviceId + "']").prop('checked', false);
                });

                $("#saveSelectedServicesBtn").click(function (e) {
                    e.preventDefault();

                    let selectedServiceIds = [];
                    $(".service-checkbox:checked").each(function () {
                        selectedServiceIds.push($(this).data("service-id"));
                    });
                    $("#selectedServiceIds").val(selectedServiceIds.join(","));
                    console.log("Selected Service IDs:", $("#selectedServiceIds").val());
                    $("#selectedServicesForm").submit();
                });

            });
        </script>

    </body>
</html>
