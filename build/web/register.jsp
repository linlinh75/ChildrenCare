<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
            .error{
                color: gray;
                font-size: 10px;
                display: none;
                position: absolute;
            }
            .form-outline {
                position: relative;
                margin-bottom: 15px;
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
                                            <form id="registerForm" action="RegisterServlet" method="post">
                                                <div class="text-center mb-3 pb-1">
                                                    <span class="h1 fw-bold">Register now</span>
                                                </div>

                                                <h5 class="text-center fw-normal mb-3 pb-3" style="letter-spacing: 1px;">Enter information to book appointment</h5>

                                                <div class="row mb-4">
                                                    <div class="col-md-6">
                                                        <div class="form-outline">
                                                            <label class="form-label" for="fullname" >Full Name</label>
                                                            <input type="text" id="fullname" name="fullname" class="form-control form-control-lg" value="${not empty requestScope.fullname ? requestScope.fullname : ''}" required/>
                                                        <span id="nameError" class="error">Please enter a name without special characters or accents.</span>
                                                    </div>
                                                </div>
                                                <div class="col-md-6">
                                                    <div class="form-outline">
                                                        <label class="form-label" for="address">Address</label>
                                                        <input type="text" id="address" name="address" class="form-control form-control-lg" value="${not empty requestScope.address ? requestScope.address : ''}" required />
                                                        <span id="addressError" class="error" >Please enter an address without special characters or accents.</span>
                                                    </div>
                                                </div>
                                            </div>

                                            <div class="row mb-4">
                                                <div class="col-md-6">
                                                    <label class="form-label">Gender</label><br>
                                                    <c:choose>
                                                        <c:when test="${requestScope.gender != null && requestScope.gender}">
                                                            <div>
                                                                <div class="form-check form-check-inline">
                                                                    <input class="form-check-input" type="radio" name="gender" id="genderMale" value="true" checked required>
                                                                    <label class="form-check-label" for="genderMale">Male</label>
                                                                </div>
                                                                <div class="form-check form-check-inline">
                                                                    <input class="form-check-input" type="radio" name="gender" id="genderFemale" value="false">
                                                                    <label class="form-check-label" for="genderFemale">Female</label>
                                                                </div>
                                                            </div>
                                                        </c:when>

                                                        <c:when test="${requestScope.gender != null && !requestScope.gender}">
                                                            <div>
                                                                <div class="form-check form-check-inline">
                                                                    <input class="form-check-input" type="radio" name="gender" id="genderMale1" value="true">
                                                                    <label class="form-check-label" for="genderMale1">Male</label>
                                                                </div>
                                                                <div class="form-check form-check-inline">
                                                                    <input class="form-check-input" type="radio" name="gender" id="genderFemale1" value="false" checked required>
                                                                    <label class="form-check-label" for="genderFemale1">Female</label>
                                                                </div>
                                                            </div>
                                                        </c:when>

                                                        <c:otherwise>
                                                            <div>
                                                                <div class="form-check form-check-inline">
                                                                    <input class="form-check-input" type="radio" name="gender" id="genderMale2" value="true" required>
                                                                    <label class="form-check-label" for="genderMale2">Male</label>
                                                                </div>
                                                                <div class="form-check form-check-inline">
                                                                    <input class="form-check-input" type="radio" name="gender" id="genderFemale2" value="false">
                                                                    <label class="form-check-label" for="genderFemale2">Female</label>
                                                                </div>
                                                            </div>
                                                        </c:otherwise>
                                                    </c:choose>
                                                </div>
                                                <div class="col-md-6">
                                                    <div class="form-outline">
                                                        <label class="form-label" for="phone">Phone Number</label>
                                                        <input type="tel" id="phone" name="phone" class="form-control form-control-lg" value="${not empty requestScope.mobile ? requestScope.mobile : ''}" required />
                                                        <span id="phoneError" style="color:red; display: none; font-size: 10px; position: absolute">Phone must have between 10-11 numbers and start with '0'.</span>
                                                    </div>
                                                </div>
                                            </div>

                                            <div class="row mb-4">
                                                <div class="col-md-6">
                                                    <div class="form-outline">
                                                        <label class="form-label" for="formGmail">Email</label>
                                                        <input type="email" id="formGmail" name="email" class="form-control form-control-lg" value="${not empty requestScope.email ? requestScope.email : ''}" required />
                                                        <span id="emailError" style="color: red; display: none; font-size: 10px; position: absolute">Please enter a gmail with domain @gmail.com .</span>
                                                    </div>
                                                </div>
                                                <div class="col-md-6">
                                                    <div class="form-outline">
                                                        <label class="form-label" for="formPassword">Password</label>
                                                        <input type="password" id="formPassword" name="password" class="form-control form-control-lg" value="${not empty requestScope.password ? requestScope.password : ''}" required />
                                                        <span id="passwordError" style="color: red; display: none; font-size: 10px; position: absolute">Password must be between 8-24 characters, include at least one uppercase letter and one number.</span>
                                                    </div>
                                                </div>
                                            </div>

                                            <div class="pt-1 mb-4" style="display: flex; justify-content: center; align-items: center; height: 100%;">
                                                <button class="btn btn-custom btn-lg" type="submit" id="submitButton" name="submit" value="submit">Register</button>
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
                <% if (request.getAttribute("error") != null) { %>
                <script>alert("<%= request.getAttribute("error") %>");</script>
                <% } %>
        </section>
    </body>
    <jsp:include page="./common/common-homepage-footer.jsp"></jsp:include>
    <script>
        function hasDiacritics(str) {
            return /[à-ỹ]/i.test(str);
        }
        let isFormValid = true;
        //Fullname check
        document.getElementById('fullname').addEventListener('input', function () {
            const fullnameInput = this;
            const fullnameError = document.getElementById('nameError');

            if (hasDiacritics(fullnameInput.value)) {
                fullnameError.style.display = 'block';
                fullnameInput.style.borderColor = 'red';
                isFormValid = false;
            } else {
                fullnameError.style.display = 'none';
                fullnameInput.style.borderColor = 'green';
                isFormValid = true;
            }
            submitButton.disabled = !isFormValid;
        });
        //Address check
        document.getElementById('address').addEventListener('input', function () {
            const addressInput = this;
            const addressError = document.getElementById('addressError');

            if (hasDiacritics(addressInput.value)) {
                addressError.style.display = 'block';
                addressInput.style.borderColor = 'red';
                isFormValid = false;
            } else {
                addressError.style.display = 'none';
                addressInput.style.borderColor = 'green';
                isFormValid = true;
            }
            submitButton.disabled = !isFormValid;
        });
        //Email check
        document.getElementById('formGmail').addEventListener('input', function () {
            const emailInput = this;
            const emailError = document.getElementById('emailError');

            if (!emailInput.value.endsWith('@gmail.com')) {
                emailError.style.display = 'block';
                emailInput.style.borderColor = 'red';
                isFormValid = false;
            } else {
                emailError.style.display = 'none';
                emailInput.style.borderColor = 'green';
                isFormValid = true;
            }
            submitButton.disabled = !isFormValid;
        });
        //Password check
        document.getElementById('formPassword').addEventListener('input', function () {
            const passwordInput = this;
            const passwordError = document.getElementById('passwordError');
            const password = passwordInput.value;
            const isValidLength = password.length >= 8 && password.length <= 24;
            const hasUpperCase = /[A-Z]/.test(password);
            const hasNumber = /\d/.test(password);

            if (!isValidLength || !hasUpperCase || !hasNumber) {
                passwordError.style.display = 'block';
                passwordInput.style.borderColor = 'red';
                isFormValid = false;
            } else {
                passwordError.style.display = 'none';
                passwordInput.style.borderColor = 'green';
                isFormValid = true;
            }
            submitButton.disabled = !isFormValid;
        });
        //Phone number check
        document.getElementById("phone").addEventListener('input', function () {
            const phoneInput = this;
            const phoneError = document.getElementById('phoneError');
            const phone = phoneInput.value;
            const isValidLength = phone.length >= 10 && phone.length <= 11;
            const isNumeric = /^\d+$/.test(phone);
            if (!phoneInput.value.startsWith('0') || !isValidLength || !isNumeric) {
                phoneError.style.display = 'block';
                phoneInput.style.borderColor = 'red';
                isFormValid = false;
            } else {
                phoneError.style.display = 'none';
                phoneInput.style.borderColor = 'green';
                isFormValid = true;
            }
            submitButton.disabled = !isFormValid;
        });
    </script>
</html>
