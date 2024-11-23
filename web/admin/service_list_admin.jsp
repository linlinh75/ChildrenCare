<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:if test="${empty sessionScope.account}">
    <c:redirect url="login.jsp"/>
</c:if>

<c:if test="${not empty sessionScope.account}">
    <c:choose>
        <c:when test="${sessionScope.account.roleId != '2'}">
            <c:redirect url="404.html"/>
        </c:when>
    </c:choose>
</c:if>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8"/>
    <title>Services Management</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="Premium Bootstrap 4 Landing Page Template"/>
    <meta name="keywords" content="Appointment, Booking, System, Dashboard, Health"/>
    <meta name="author" content="Shreethemes"/>
    <meta name="email" content="support@shreethemes.in"/>
    <meta name="website" content="../../../index.html"/>
    <meta name="Version" content="v1.2.0"/>
    <!-- favicon -->
    <link rel="shortcut icon" href="${pageContext.request.contextPath}/assets/images/favicon.ico.png">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <!-- Bootstrap -->
    <link href="${pageContext.request.contextPath}/assets/css/bootstrap.min.css" rel="stylesheet" type="text/css"/>
    <!-- simplebar -->
    <link href="${pageContext.request.contextPath}/assets/css/simplebar.css" rel="stylesheet" type="text/css"/>
    <!-- Icons -->
    <link href="${pageContext.request.contextPath}/assets/css/materialdesignicons.min.css" rel="stylesheet"
          type="text/css"/>
    <link href="${pageContext.request.contextPath}/assets/css/remixicon.css" rel="stylesheet" type="text/css"/>
    <link href="https://unicons.iconscout.com/release/v3.0.6/css/line.css" rel="stylesheet">
    <!-- Css -->
    <link href="${pageContext.request.contextPath}/assets/css/style.min.css" rel="stylesheet" type="text/css"
          id="theme-opt"/>

    <style>
        .service-container {
            display: flex;
            flex-wrap: wrap;
        }

        .service-card {
            display: flex;
            flex-direction: column;
        }

        .service-image {
            width: 100%;
            height: 200px;
            object-fit: cover;
        }

        .service-title {
            display: -webkit-box;
            -webkit-line-clamp: 2;
            -webkit-box-orient: vertical;
            overflow: hidden;
            margin-bottom: 10px;
        }

        .price-info {
            display: flex;
            gap: 10px;
            align-items: center;
        }

        .original-price {
            text-decoration: line-through;
            color: #666;
        }

        .sale-price {
            color: #ff4444;
            font-weight: bold;
        }

        .pagination {
            display: flex !important;
            padding-left: 0;
            list-style: none;
        }
    </style>
</head>

<body>
<div class="page-wrapper doctris-theme toggled">
    <!-- Sidebar -->
    <jsp:include page="../common/admin/side_bar_admin.jsp"></jsp:include>

    <!-- Start Page Content -->
    <main class="page-content bg-light">
        <div class="top-header">
            <div class="header-bar d-flex justify-content-between border-bottom">
                <div class="d-flex align-items-center">
                    <a href="#" class="logo-icon">
                        <img src="../assets/images/logo-icon.png" height="30" class="small" alt="">
                        <span class="big">
                                        <img src="../assets/images/logo-dark.png" height="24" class="logo-light-mode"
                                             alt="">
                                        <img src="../assets/images/logo-light.png" height="24" class="logo-dark-mode"
                                             alt="">
                                    </span>
                    </a>
                    <a id="close-sidebar" class="btn btn-icon btn-pills btn-soft-primary ms-2" href="#">
                        <i class="uil uil-bars"></i>
                    </a>
                    <div class="search-bar p-0 d-none d-lg-block ms-2">
                        <div id="search" class="menu-search mb-0">
                            <form role="search" method="get" id="searchform" class="searchform">
                                <div>
                                    <input type="text" class="form-control border rounded-pill" name="s" id="s"
                                           placeholder="Search Keywords...">
                                    <input type="submit" id="searchsubmit" value="Search">
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <div class="container-fluid">
            <jsp:include page="../common/common-homepage-header.jsp"></jsp:include>
            <div class="layout-specing">
                <div class="d-md-flex justify-content-between mb-3">
                    <div class="mt-4 mt-sm-0 ms-auto">
                        <a href="service-list-admin?action=add" class="btn btn-primary">Add Service</a>
                    </div>
                </div>

                <!-- Filter Section -->
                <!-- Combined Search and Filter Section -->
                <div class="row mb-4">
                    <div class="col-12">
                        <div class="d-flex align-items-center justify-content-between">
                            <!-- Filter Section -->
                            <div class="d-flex align-items-center">
                                <span class="me-2">Filter by status:</span>
                                <div class="btn-group" role="group">
                                    <a href="service-list-admin?status=all"
                                       class="btn btn-sm ${param.status == null || param.status == 'all' ? 'btn-primary' : 'btn-outline-primary'}">
                                        All
                                    </a>
                                    <a href="service-list-admin?status=active"
                                       class="btn btn-sm ${param.status == 'active' ? 'btn-primary' : 'btn-outline-success'}">
                                        Active
                                    </a>
                                    <a href="service-list-admin?status=inactive"
                                       class="btn btn-sm ${param.status == 'inactive' ? 'btn-primary' : 'btn-outline-secondary'}">
                                        Inactive
                                    </a>
                                </div>
                            </div>

                            <!-- Search Section -->
                            <div class="search-bar p-0">
                                <div id="search" class=" mb-0">
                                    <form method="get" action="${pageContext.request.contextPath}/service-list-admin" id="searchform" class="searchform">
                                        <input type="hidden" name="action" value="search">
                                        <div class="d-flex align-items-center">
                                            <input type="text" class="form-control border rounded-pill me-2"
                                                   name="searchQuery"
                                                   id="searchQuery"
                                                   placeholder="Search Keywords..."
                                                   value="${param.searchQuery}">
                                            <button type="submit" class="btn btn-primary">
                                                Search
                                            </button>
                                        </div>
                                        <!-- Preserve status filter when searching -->
                                        <input type="hidden" name="status" value="${param.status}">
                                    </form>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Services Grid -->
                <div class="row service-container">
                    <c:forEach items="${services}" var="service">
                        <div class="col-xl-3 col-lg-4 col-md-6 col-12 mt-4">
                            <div class="card service-card border-0 shadow rounded overflow-hidden h-100">
                                <img src="${service.thumbnailLink}" class="service-image" alt="">
                                <div class="card-body p-4">
                                    <div class="mb-2">
                                        <c:choose>
                                            <c:when test="${service.status}">
                                                <span class="badge bg-soft-success rounded-pill">Active</span>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="badge bg-soft-danger rounded-pill">Inactive</span>
                                            </c:otherwise>
                                        </c:choose>
                                        <c:if test="${service.featured}">
                                            <span class="badge bg-soft-warning rounded-pill">Featured</span>
                                        </c:if>
                                    </div>
                                    <a href="service-list-admin?action=edit&id=${service.id}"
                                       class="text-dark title h5 post-title">
                                            ${service.fullname}
                                    </a>
                                    <!-- <h5 class="service-title"></h5> -->

                                    <div class="price-info mb-2">
                                        <span class="original-price">$${service.originalPrice}</span>
                                        <span class="sale-price">$${service.salePrice}</span>
                                    </div>

                                    <div class="mb-2">
                                        <small class="text-muted">Last Updated: ${service.updatedDate}</small>
                                    </div>

                                    <div class="mt-3 d-flex justify-content-between">
                                        <a href="service-list-admin?action=edit&id=${service.id}"
                                           class="btn btn-sm btn-soft-warning">
                                            <i class="uil uil-edit"></i> Edit
                                        </a>
                                        <a href="service-list-admin?action=toggle&id=${service.id}"
                                           class="btn btn-sm ${service.status ? 'btn-soft-danger' : 'btn-soft-success'}">
                                            <i class="uil ${service.status ? 'uil-times' : 'uil-check'}"></i>
                                                ${service.status ? 'Deactivate' : 'Activate'}
                                        </a>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </div>

                <c:choose>
                    <c:when test="${not empty param.searchQuery}">
                        <c:set var="paginationUrl" value="service-list-admin?action=search&searchQuery=${param.searchQuery}" />
                    </c:when>
                    <c:otherwise>
                        <c:set var="paginationUrl" value="service-list-admin?action=list" />
                    </c:otherwise>
                </c:choose>
                <!-- Pagination -->
                <div class="row">
                    <div class="col-12 mt-4">
                        <nav aria-label="Page navigation">
                            <ul class="pagination justify-content-end mb-0">
                                <li class="page-item ${currentPage == 1 ? 'disabled' : ''}">
                                    <a class="page-link"
                                       href="${paginationUrl}&page=${currentPage - 1}${not empty param.status ? '&status='.concat(param.status) : ''}"
                                       aria-label="Previous" ${currentPage == 1 ? 'tabindex="-1"' : ''}>
                                        Prev
                                    </a>
                                </li>

                                <c:forEach begin="1" end="${totalPages}" var="i">
                                    <li class="page-item ${currentPage == i ? 'active' : ''}">
                                        <a class="page-link"
                                           href="${paginationUrl}&page=${i}${not empty param.status ? '&status='.concat(param.status) : ''}">${i}</a>
                                    </li>
                                </c:forEach>

                                <li class="page-item ${currentPage == totalPages ? 'disabled' : ''}">
                                    <a class="page-link"
                                       href="${paginationUrl}&page=${currentPage + 1}${not empty param.status ? '&status='.concat(param.status) : ''}"
                                       aria-label="Next" ${currentPage == totalPages ? 'tabindex="-1"' : ''}>
                                        Next
                                    </a>
                                </li>
                            </ul>
                        </nav>
                    </div>
                </div>
            </div>

            <!-- Footer -->
            <jsp:include page="../common/common-homepage-footer.jsp"></jsp:include>
        </div>
    </main>
</div>

<!-- JavaScript -->
<script src="${pageContext.request.contextPath}/assets/js/bootstrap.bundle.min.js"></script>
<script src="${pageContext.request.contextPath}/assets/js/simplebar.min.js"></script>
<script src="${pageContext.request.contextPath}/assets/js/feather.min.js"></script>
<script src="${pageContext.request.contextPath}/assets/js/app.js"></script>
</body>
</html>