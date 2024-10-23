<%@page contentType="text/html" pageEncoding="UTF-8"%>
<nav id="sidebar" class="sidebar-wrapper">
    <div class="sidebar-content" data-simplebar style="height: calc(100% - 60px);">
        <ul class="sidebar-menu pt-3" >
            <li><a href="admin-dashboard.jsp"><i class="uil uil-dashboard me-2 d-inline-block"></i>Dashboard</a></li>
            <c:if test="${user.roleId == '2'}">
                            <li><a href="managerSliderList"><i class="uil uil-dashboard me-2 d-inline-block"></i>Manage Slider</a></li>
                            </c:if>
            <li><a href="changePw.jsp"><i class="uil uil-user me-2 d-inline-block"></i>Change password</a></li>
            <c:if test="${user.roleId == '1'}">
                <li class="sidebar-dropdown">
                    <a href="javascript:void(0)"><i class="uil uil-user me-2 d-inline-block"></i>Doctors</a>
                    <div class="sidebar-submenu">
                        <ul>
                            <li><a href="doctors.html">Doctors</a></li>
                            <li><a href="add-doctor.html">Add Doctor</a></li>
                            <li><a href="dr-profile.html">Profile</a></li>
                        </ul>
                    </div>
                </li>

                <li class="sidebar-dropdown">
                    <a href="javascript:void(0)"><i class="uil uil-wheelchair me-2 d-inline-block"></i>Patients</a>
                    <div class="sidebar-submenu">
                        <ul>
                            <li><a href="patients.html">All Patients</a></li>
                            <li><a href="add-patient.html">Add Patients</a></li>
                            <li><a href="patient-profile.html">Profile</a></li>
                        </ul>
                    </div>
                </li>

                <li class="sidebar-dropdown">
                    <a href="javascript:void(0)"><i class="uil uil-apps me-2 d-inline-block"></i>Apps</a>
                    <div class="sidebar-submenu">
                        <ul>
                            <li><a href="chat.html">Chat</a></li>
                            <li><a href="email.html">Email</a></li>
                            <li><a href="calendar.html">Calendar</a></li>
                        </ul>
                    </div>
                </li>

                <li class="sidebar-dropdown">
                    <a href="javascript:void(0)"><i class="uil uil-shopping-cart me-2 d-inline-block"></i>Pharmacy</a>
                    <div class="sidebar-submenu">
                        <ul>
                            <li><a href="shop.html">Shop</a></li>
                            <li><a href="product-detail.html">Shop Detail</a></li>
                            <li><a href="shopcart.html">Shopcart</a></li>
                            <li><a href="checkout.html">Checkout</a></li>
                        </ul>
                    </div>
                </li>

                <li class="sidebar-dropdown">
                    <a href="javascript:void(0)"><i class="uil uil-flip-h me-2 d-inline-block"></i>Blogs</a>
                    <div class="sidebar-submenu">
                        <ul>
                            <li><a href="post-list-admin">Blogs</a></li>
                            <li><a href="blog-detail.html">Blog Detail</a></li>
                        </ul>
                    </div>
                </li>

                <li class="sidebar-dropdown">
                    <a href="javascript:void(0)"><i class="uil uil-file me-2 d-inline-block"></i>Pages</a>
                    <div class="sidebar-submenu">
                        <ul>
                            <li><a href="faqs.html">FAQs</a></li>
                            <li><a href="review.html">Reviews</a></li>
                            <li><a href="invoice-list.html">Invoice List</a></li>
                            <li><a href="invoice.html">Invoice</a></li>
                            <li><a href="terms.html">Terms & Policy</a></li>
                            <li><a href="privacy.html">Privacy Policy</a></li>
                            <li><a href="error.html">404 !</a></li>
                            <li><a href="blank-page.html">Blank Page</a></li>
                        </ul>
                    </div>
                </li>

                <li class="sidebar-dropdown">
                    <a href="javascript:void(0)"><i class="uil uil-sign-in-alt me-2 d-inline-block"></i>Authentication</a>
                    <div class="sidebar-submenu">
                        <ul>
                            <li><a href="login.html">Login</a></li>
                            <li><a href="signup.html">Signup</a></li>
                            <li><a href="forgot-password.html">Forgot Password</a></li>
                            <li><a href="lock-screen.html">Lock Screen</a></li>
                            <li><a href="thankyou.html">Thank you...!</a></li>
                        </ul>
                    </div>
                </li>

                <li><a href="components.html"><i class="uil uil-cube me-2 d-inline-block"></i>Components</a></li>

                <li><a href="${pageContext.request.contextPath}/landing/index-two.html" target="_blank"><i class="uil uil-window me-2 d-inline-block"></i>Landing page</a></li>
            </c:if>
        </ul>


        <!-- sidebar-menu  -->
    </div>
    <!-- sidebar-content  -->
    <ul class="sidebar-footer list-unstyled mb-0">
        <li class="list-inline-item mb-0 ms-1">
            <a href="#" class="btn btn-icon btn-pills btn-soft-primary">
                <i class="uil uil-comment icons"></i>
            </a>
        </li>
    </ul>
</nav>
