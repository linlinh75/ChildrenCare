<%@page contentType="text/html" pageEncoding="UTF-8"%>
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
        <meta charset="utf-8" />
        <title>Customer List</title>
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta name="description" content="Premium Bootstrap 4 Landing Page Template" />
        <meta name="keywords" content="Appointment, Booking, System, Dashboard, Health" />
        <meta name="author" content="Shreethemes" />
        <meta name="email" content="support@shreethemes.in" />
        <meta name="website" content="../../../index.html" />
        <meta name="Version" content="v1.2.0" />
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
            .pagination {
                display: flex !important;
            }
        </style>
    </head>

    <body>
        <div class="page-wrapper doctris-theme toggled">
            <jsp:include page="../common/admin/side_bar_admin.jsp"></jsp:include>
                <!-- sidebar-wrapper  -->

                <!-- Start Page Content -->
                <main class="page-content bg-light">
                    <div class="top-header">
                        <div class="header-bar d-flex justify-content-between border-bottom">
                            <div class="d-flex align-items-center">
                                <a href="#" class="logo-icon">
                                    <img src="../assets/images/logo-icon.png" height="30" class="small" alt="">
                                    <span class="big">
                                        <img src="../assets/images/logo-dark.png" height="24" class="logo-light-mode" alt="">
                                        <img src="../assets/images/logo-light.png" height="24" class="logo-dark-mode" alt="">
                                    </span>
                                </a>
                                <a id="close-sidebar" class="btn btn-icon btn-pills btn-soft-primary ms-2" href="#">
                                    <i class="uil uil-bars"></i>
                                </a>
                                <div class="search-bar p-0 d-none d-lg-block ms-2">
                                </div>
                            </div>

                        </div>
                    </div>

                    <div class="container-fluid">
                    <jsp:include page="../common/common-homepage-header.jsp"></jsp:include>
                        <div class="layout-specing">
                            <div class="d-md-flex justify-content-between">
                                <h5 class="mb-0">Patients List Test</h5>

                                <nav aria-label="breadcrumb" class="d-inline-block mt-4 mt-sm-0">
                                    <ul class="breadcrumb bg-transparent rounded mb-0 p-0">
                                        <li class="breadcrumb-item"><a href="HomeServlet">Home</a></li>
                                        <li class="breadcrumb-item active" aria-current="page">Customer List</li>
                                    </ul>
                                </nav>
                            </div>

                            <div class="row">
                                <div class="col-12 mt-4">
                                    <div class="table-responsive shadow rounded">
                                        <table class="table table-center bg-white mb-0">
                                            <thead>
                                                <tr>
                                                    <th class="border-bottom p-3" style="min-width: 50px;">Id</th>
                                                    <th class="border-bottom p-3" style="min-width: 180px;">Name</th>
                                                    <th class="border-bottom p-3">Gender</th>
                                                    <th class="border-bottom p-3">Address</th>
                                                    <th class="border-bottom p-3">Mobile No.</th>
                                                    <th class="border-bottom p-3">Email</th>
                                                    <th class="border-bottom p-3">Status</th>
                                                    <th class="border-bottom p-3" style="min-width: 100px;"></th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                            <c:forEach var="customer" items="${customers}">
                                                <tr>
                                                    <td class="p-3">${customer.id}</td>

                                                    <td class="p-3">
                                                        <div class="d-flex align-items-center">
                                                            <img src="${pageContext.request.contextPath}/${customer.imageLink}" 
                                                                 class="avatar avatar-md-sm rounded-circle shadow" alt="">
                                                            <span class="ms-2">${customer.fullName}</span>
                                                        </div>
                                                    </td>
                                                    <td class="p-3">${customer.gender ? 'Male' : 'Female'}</td>
                                                    <td class="p-3">${customer.address}</td>
                                                    <td class="p-3">${customer.mobile}</td>
                                                    <td class="p-3">${customer.email}</td>
                                                    <td class="p-3">
                                                        <a href="#" class="btn btn-icon btn-pills btn-soft-primary" 
                                                           onclick="viewProfile(${customer.id})" 
                                                           data-bs-toggle="modal" 
                                                           data-bs-target="#viewprofile">
                                                            <i class="uil uil-eye"></i>
                                                        </a>
                                                        <a href="#" class="btn btn-icon btn-pills btn-soft-success" 
                                                           onclick="editProfile(${customer.id})" 
                                                           data-bs-toggle="modal" 
                                                           data-bs-target="#editprofile">
                                                            <i class="uil uil-pen"></i>
                                                        </a>
                                                    </td>
                                                </tr>
                                            </c:forEach>

                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </div><!--end row-->

                        <div class="row">
                            <!-- PAGINATION START -->
                            <div class="col-12 mt-4">
                                <div class="d-md-flex align-items-center text-center justify-content-between">
                                    <span class="text-muted me-3">
                                        Showing ${(currentPage-1)*recordsPerPage + 1} - 
                                        ${Math.min(currentPage*recordsPerPage * 1.0, totalCustomers * 1.0).intValue()} 
                                        out of ${totalCustomers}
                                    </span>
                                    <ul class="pagination justify-content-center mb-0 mt-3 mt-sm-0">
                                        <!-- Previous Page -->
                                        <c:if test="${currentPage != 1}">
                                            <li class="page-item">
                                                <a class="page-link" href="${pageContext.request.contextPath}/patients?page=${currentPage - 1}">Previous</a>
                                            </li>
                                        </c:if>

                                        <!-- Page Numbers -->
                                        <c:forEach begin="1" end="${totalPages}" var="i">
                                            <li class="page-item ${currentPage == i ? 'active' : ''}">
                                                <a class="page-link" href="${pageContext.request.contextPath}/patients?page=${i}">${i}</a>
                                            </li>
                                        </c:forEach>

                                        <!-- Next Page -->
                                        <c:if test="${currentPage lt totalPages}">
                                            <li class="page-item">
                                                <a class="page-link" href="${pageContext.request.contextPath}/patients?page=${currentPage + 1}">Next</a>
                                            </li>
                                        </c:if>
                                    </ul>
                                </div>
                            </div>
                            <!-- PAGINATION END -->
                        </div><!--end row-->
                    </div>

                    <jsp:include page="../common/common-homepage-footer.jsp"></jsp:include>
                    </div><!--end container-->

                </main>
                <!--End page-content" -->
            </div>
            <!-- page-wrapper -->

            <!-- Profile View Modal -->
            <div class="modal fade" id="viewprofile" tabindex="-1" aria-labelledby="exampleModalLabel1" aria-hidden="true">
                <div class="modal-dialog modal-dialog-centered modal-lg">
                    <div class="modal-content">
                        <div class="modal-header border-bottom p-3">
                            <h5 class="modal-title" id="exampleModalLabel1">Customer Profile</h5>
                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                        </div>
                        <div class="modal-body p-3 pt-4">
                            <div class="d-flex align-items-center">
                                <img id="viewProfileImage" src="" class="avatar avatar-small rounded-pill" alt="">
                                <h5 id="viewProfileName" class="mb-0 ms-3"></h5>
                            </div>
                            <ul class="list-unstyled mb-0 d-md-flex justify-content-between mt-4">
                                <li>
                                    <ul class="list-unstyled mb-0">
                                        <li class="d-flex">
                                            <h6>Email:</h6>
                                            <p id="viewProfileEmail" class="text-muted ms-2"></p>
                                        </li>
                                        <li class="d-flex">
                                            <h6>Gender:</h6>
                                            <p id="viewProfileGender" class="text-muted ms-2"></p>
                                        </li>
                                        <li class="d-flex">
                                            <h6>Mobile:</h6>
                                            <p id="viewProfileMobile" class="text-muted ms-2"></p>
                                        </li>
                                    </ul>
                                </li>
                                <li>
                                    <ul class="list-unstyled mb-0">
                                        <li class="d-flex">
                                            <h6>Address:</h6>
                                            <p id="viewProfileAddress" class="text-muted ms-2"></p>
                                        </li>
                                    </ul>
                                </li>
                            </ul>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Edit Profile Modal -->
            <!-- Update the Edit Profile Modal form -->
            <div class="modal fade" id="editprofile" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
                <div class="modal-dialog modal-lg modal-dialog-centered">
                    <div class="modal-content">
                        <div class="modal-header border-bottom p-3">
                            <h5 class="modal-title" id="exampleModalLabel">Edit Customer Profile</h5>
                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                        </div>
                        <div class="modal-body p-3 pt-4">
                            <form action="${pageContext.request.contextPath}/patients" method="POST">
                            <input type="hidden" name="action" value="update">
                            <input type="hidden" name="id" id="editProfileId">

                            <div class="row">
                                <div class="col-md-6">
                                    <div class="mb-3">
                                        <label class="form-label">Full Name</label>
                                        <input name="fullName" id="editProfileFullName" type="text" class="form-control" required>
                                    </div>
                                </div>

                                <div class="col-md-6">
                                    <div class="mb-3">
                                        <label class="form-label">Email</label>
                                        <input name="email" id="editProfileEmail" type="email" class="form-control" readonly>
                                    </div>
                                </div>

                                <div class="col-md-6">
                                    <div class="mb-3">
                                        <label class="">Gender</label>
                                        <select name="gender" id="editProfileGender" class="">
                                            <option value="true">Male</option>
                                            <option value="false">Female</option>
                                        </select>
                                    </div>
                                </div>

                                <div class="col-md-6">
                                    <div class="mb-3">
                                        <label class="form-label">Mobile</label>
                                        <input name="mobile" id="editProfileMobile" type="text" class="form-control" required>
                                    </div>
                                </div>

                                <div class="col-md-12">
                                    <div class="mb-3">
                                        <label class="form-label">Address</label>
                                        <textarea name="address" id="editProfileAddress" class="form-control" rows="3" required></textarea>
                                    </div>
                                </div>
                            </div>

                            <div class="text-end">
                                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                                <button type="submit" class="btn btn-primary">Update Profile</button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>


        <script>
            function viewProfile(customerId) {
                fetch('${pageContext.request.contextPath}/patients?action=getCustomer&id=' + customerId)
                        .then(response => {
                            if (!response.ok) {
                                throw new Error('Network response was not ok');
                            }
                            return response.json();
                        })
                        .then(customer => {
                            document.getElementById('viewProfileImage').src = '${pageContext.request.contextPath}/' + customer.imageLink;
                            document.getElementById('viewProfileName').textContent = customer.fullName;
                            document.getElementById('viewProfileEmail').textContent = customer.email;
                            document.getElementById('viewProfileGender').textContent = customer.gender ? 'Male' : 'Female';
                            document.getElementById('viewProfileMobile').textContent = customer.mobile;
                            document.getElementById('viewProfileAddress').textContent = customer.address;
                        })
                        .catch(error => {
                            console.error('View Error:', error);
                            console.error('Error:', error);
                            alert('Error loading customer data');
                        });
            }

            function editProfile(customerId) {
                fetch('${pageContext.request.contextPath}/patients?action=getCustomer&id=' + customerId)
                        .then(response => {
                            if (!response.ok) {
                                throw new Error('Network response was not ok');
                            }
                            return response.json();
                        })
                        .then(customer => {
                            document.getElementById('editProfileId').value = customer.id;
                            document.getElementById('editProfileFullName').value = customer.fullName;
                            document.getElementById('editProfileEmail').value = customer.email;
                            const genderSelect = document.getElementById('editProfileGender');
                            const maleOption = genderSelect.querySelector('option[value="true"]');
                            const femaleOption = genderSelect.querySelector('option[value="false"]');
                            if (customer.gender) {
                                maleOption.selected = true;
                                femaleOption.selected = false;
                            } else {
                                maleOption.selected = false;
                                femaleOption.selected = true;
                            }
                            document.getElementById('editProfileMobile').value = customer.mobile;
                            document.getElementById('editProfileAddress').value = customer.address;
                        })
                        .catch(error => {
                            console.error('Edit Error:', error);
                            console.error('Error:', error);
                            alert('Error loading customer data');
                        });
            }
        </script>
    </body>

</html>