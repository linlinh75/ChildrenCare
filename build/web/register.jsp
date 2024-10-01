
<%-- 
    Document   : register
    Created on : Sep 19, 2024, 8:37:52 AM
    Author     : Admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
        <link rel="icon" href="img/favicon.png">
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Register</title>
        <style>
            .btn-custom {
                background-color: #ff6219;
                color: white;
                transition: background-color 0.4s ease;
            }

            .btn-custom:hover {
                background-color: #2C2D3F;
                color: floralwhite;
            }
        </style>
    </head>
    <jsp:include page="./common/common-homepage-header.jsp"></jsp:include>
        <body>
            <section class="vh-100" style="background: linear-gradient(to bottom, #A4D7E1, #1E90FF);">
                <div class="container-fluid py-5 h-100">
                    <div class="row d-flex justify-content-center align-items-center h-100">
                        <div class="col col-xl-10">
                            <div class="card" style="border-radius: 1rem;">
                                <div class="row g-0">
                                    <div class="col-md-6 col-lg-5 d-none d-md-block">
                                        <img src="./img/contact-img.png" alt="register form" class="img-fluid" style="border-radius: 1rem 0 0 1rem; height: 100%;" />
                                    </div>
                                    <div class="col-md-6 col-lg-7 d-flex align-items-center">
                                        <div class="card-body p-4 p-lg-5 text-black">
                                            <form action="RegisterServlet" method="post">
                                                <div class="text-center mb-3 pb-1">
                                                    <i class="fas fa-cubes fa-2x me-3" style="color: #ff6219;"></i>
                                                    <span class="h1 fw-bold">Register now</span>
                                                </div>

                                                <h5 class="text-center fw-normal mb-3 pb-3" style="letter-spacing: 1px;">Enter information to book appointment</h5>

                                                <div class="row mb-4">
                                                    <div class="col-md-6">
                                                        <div class="form-outline">
                                                            <label class="form-label" for="fullname">Full Name</label>
                                                            <input type="text" id="fullname" name="fullname" class="form-control form-control-lg" required />
                                                        </div>
                                                    </div>
                                                    <div class="col-md-6">
                                                        <div class="form-outline">
                                                            <label class="form-label" for="address">Address</label>
                                                            <input type="text" id="address" name="address" class="form-control form-control-lg" required />
                                                        </div>
                                                    </div>
                                                </div>

                                                <div class="row mb-4">
                                                    <div class="col-md-6">
                                                        <label class="form-label">Gender</label><br>
                                                        <div class="form-check form-check-inline">
                                                            <input class="form-check-input" type="radio" name="gender" id="genderMale" value="true" required>
                                                            <label class="form-check-label" for="genderMale">Male</label>
                                                        </div>
                                                        <div class="form-check form-check-inline">
                                                            <input class="form-check-input" type="radio" name="gender" id="genderFemale" value="false">
                                                            <label class="form-check-label" for="genderFemale">Female</label>
                                                        </div>
                                                    </div>
                                                    <div class="col-md-6">
                                                        <div class="form-outline">
                                                            <label class="form-label" for="phone">Phone Number</label>
                                                            <input type="tel" id="phone" name="phone" class="form-control form-control-lg" required />
                                                        </div>
                                                    </div>
                                                </div>

                                                <div class="row mb-4">
                                                    <div class="col-md-6">
                                                        <div class="form-outline">
                                                            <label class="form-label" for="form2Example17">Email</label>
                                                            <input type="email" id="form2Example17" name="email" class="form-control form-control-lg" required />
                                                        </div>
                                                    </div>
                                                    <div class="col-md-6">
                                                        <div class="form-outline">
                                                            <label class="form-label" for="form2Example27">Password</label>
                                                            <input type="password" id="form2Example27" name="password" class="form-control form-control-lg" required />
                                                        </div>
                                                    </div>
                                                </div>

                                                <div class="pt-1 mb-4" style="display: flex; justify-content: center; align-items: center; height: 100%;">
                                                    <button class="btn btn-custom btn-lg" type="submit" name="submit" value="submit">Register</button>
                                                </div>

                                                <a href="#!" class="small text-muted">Terms of use.</a>
                                                <a href="#!" class="small text-muted">Privacy policy</a>
                                            </form>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            <% if (request.getAttribute("error") != null) { %>
            <script>alert("<%= request.getAttribute("error") %>");</script>
            <% } %>
        </section>
    </body>
    <jsp:include page="./common/common-homepage-footer.jsp"></jsp:include>

</html>
