<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!-- favicon -->
<link rel="shortcut icon" href="img/favicon.png">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
<!-- Bootstrap -->
<link href="${pageContext.request.contextPath}/assets/css/bootstrap.min.css" rel="stylesheet" type="text/css" />
<!-- simplebar -->
<link href="${pageContext.request.contextPath}/assets/css/simplebar.css" rel="stylesheet" type="text/css" />
<!-- Icons -->
<link href="${pageContext.request.contextPath}/assets/css/materialdesignicons.min.css" rel="stylesheet" type="text/css" />
<link href="${pageContext.request.contextPath}/assets/css/remixicon.css" rel="stylesheet" type="text/css" />
<link href="https://unicons.iconscout.com/release/v3.0.6/css/line.css"  rel="stylesheet">
<!-- Css -->
<link href="${pageContext.request.contextPath}/assets/css/style.min.css" rel="stylesheet" type="text/css" id="theme-opt" />

<style>
    .sidebar-menu li.active a {
        background-color: #F8F9FA;
        color: white !important;
    }
</style>
<nav id="sidebar" class="sidebar-wrapper" style="position: fixed; z-index: 1">
    <h3 style="padding: 15px; text-align: start;">Menu</h3> 
    <div class="sidebar-content" data-simplebar style="height: calc(100% - 60px)">
        <ul class="sidebar-menu pt-3" >
            <li><a href="profile"><i class="uil uil-users-alt me-2 d-inline-block"></i>Profile</a></li>
                <%-- Admin Side Bar --%>
                <c:if test="${sessionScope.account.roleId == 1}">
                <li><a href="admin-manage-user"><i class="uil uil-users-alt me-2 d-inline-block"></i>User List</a></li>
                <li><a href="admin-manage-settings"><i class="uil uil-setting me-2 d-inline-block"></i>Setting List</a></li>
                </c:if>

            <%--Manager Side Bar --%>
            <c:if test="${sessionScope.account.roleId == 2}">
                <li><a href="managerSliderList"><i class="uil uil-dashboard me-2 d-inline-block"></i>Manage Slider</a></li>
                <li><a href="managerFeedbackList"><i class="uil uil-dashboard me-2 d-inline-block"></i>Manage Feedback</a></li>
                <li><a href="reservation-manager"><i class="uil uil-dashboard me-2 d-inline-block"></i>Manage Reservation</a></li>
                <li><a href="service-list-admin"><i class="uil uil-dashboard me-2 d-inline-block"></i>Manage Service</a></li>
                <li class="">
                    <a href="patients"><i class="uil uil-wheelchair me-2 d-inline-block"></i>Manage Customer</a>
                </li>
                <li class="">
                    <a href="post-list-admin"><i class="uil uil-flip-h me-2 d-inline-block"></i>Manage Blogs</a>
                </li>
            </c:if>
            <%--Staff Side Bar --%>
            <c:if test="${sessionScope.account.roleId == 3}">
                <li><a href="staff-work-schedule"><i class="uil uil-users-alt me-2 d-inline-block"></i>Work Schedule</a></li>
                </c:if>
                <%--Customer Side Bar --%>
                <c:if test="${sessionScope.account.roleId == 4}">
                <li><a href="/ChildrenCare/ReservationServlet"><i class="uil uil-users-alt me-2 d-inline-block"></i>My Reservation</a></li>
                <li><a href="customer-feedback"><i class="uil uil-users-alt me-2 d-inline-block"></i>My Feedback</a></li>
            </c:if>
            <%-- Common function --%>
            <li><a href="changePw.jsp"><i class="uil uil-user me-2 d-inline-block"></i>Change password</a></li>
        </ul>
    </div>  
</nav>
<script>
    document.addEventListener('DOMContentLoaded', () => {
        const currentUrl = window.location.href;
        const menuItems = document.querySelectorAll('.sidebar-menu li a');

        menuItems.forEach(item => {
            if (currentUrl.includes(item.getAttribute('href'))) {
                item.parentElement.classList.add('active');
            }
        });
    });

</script>     
