
<%-- 
    Document   : login
    Created on : Sep 19, 2024, 8:37:52 AM
    Author     : Admin
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Login</title>
    </head>
     <jsp:include page="/common/common-homepage-header.jsp"></jsp:include>
    <body>
        <section class="vh-100" >

  <div class="container-fluid h-100 py-5 " style="background-color: #1A76D1;">
    <div class="row d-flex justify-content-center align-items-center h-100">
      <div class="col col-xl-10">
        <div class="card" style="border-radius: 1rem;">
          <div class="row g-0">
            <div class="col-md-6 col-lg-5 d-none d-md-block">
                <img src="https://img.freepik.com/free-photo/beautiful-young-female-doctor-looking-camera-office_1301-7807.jpg?size=626&ext=jpg&ga=GA1.1.2008272138.1726617600&semt=ais_hybrid"
                alt="login form" class="img-fluid" style="border-radius: 1rem 0 0 1rem;" />
            </div>
            <div class="col-md-6 col-lg-7 d-flex align-items-center">
              <div class="card-body p-3 text-black">
                <form action = "login" method="post">
                  <div class="d-flex align-items-center mb-3 pb-1">
                    <span class="h1 fw-bold mb-0">Login</span>
                  </div>

                  <h5 class="fw-normal mb-3 pb-3" style="letter-spacing: 1px;">Sign into your account</h5>
                  <div data-mdb-input-init class="form-outline mb-4">
                    <input type="email" name="email" id="email"  class="form-control form-control-lg" required />
                    <label class="form-label" for="email">Email</label>
                  </div>

                  <div data-mdb-input-init class="form-outline mb-4">
                    <input type="password" name="password" id="password"  class="form-control form-control-lg" required/>
                    <label class="form-label" for="password">Password</label>
                  </div>
                   <c:if test="${ms!=null}">
            <div class="alert alert-danger" role="alert">
                Invalid email or password!
            </div>
                     </c:if>
                  <c:if test="${statusFailed!=null}">
                    <div class="alert alert-danger" role="alert">
                        ${statusFailed}
                    </div>
                  </c:if>
                  <c:if test="${statusSuccess!=null}">
                    <div class="alert alert-success" role="alert">
                        ${statusSuccess}
                    </div>
                  </c:if>
                  <div class="pt-1 mb-4">
                      <button data-mdb-button-init data-mdb-ripple-init class="btn btn-dark  btn-block" id="loginButtonId" type="submit" name="submit" value="submit">Login</button>
                      </div>
                   <div class="row">
            <div class="col-12">
              <p class="mt-3 mb-2">Or sign in with</p>
              <div class="d-flex gap-3 flex-column flex-md-row mb-5">
               <a href="https://accounts.google.com/o/oauth2/auth?scope=email profile openid

&redirect_uri=http://localhost:8080/ChildrenCare/login

&response_type=code

&client_id=482309192444-jsk60e8k958nfcgcljhjtjhd6c77huul.apps.googleusercontent.com

&approval_prompt=force" class="btn bsb-btn-xl btn-outline-primary">
                  <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-google" viewBox="0 0 16 16">
                    <path d="M15.545 6.558a9.42 9.42 0 0 1 .139 1.626c0 2.434-.87 4.492-2.384 5.885h.002C11.978 15.292 10.158 16 8 16A8 8 0 1 1 8 0a7.689 7.689 0 0 1 5.352 2.082l-2.284 2.284A4.347 4.347 0 0 0 8 3.166c-2.087 0-3.86 1.408-4.492 3.304a4.792 4.792 0 0 0 0 3.063h.003c.635 1.893 2.405 3.301 4.492 3.301 1.078 0 2.004-.276 2.722-.764h-.003a3.702 3.702 0 0 0 1.599-2.431H8v-3.08h7.545z" />
                  </svg>
                  <span class="ms-2 fs-6">Google</span>
                </a>
               
              </div>
                  <a class="text-muted" href="forgotPw.jsp">Forgot password?</a>
                  <p class=" pb-lg-2" style="color: #393f81;">Don't have an account? <a href="register.jsp"
                      style="color: #393f81;">Register here</a></p>
                </form>

              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</section>
    </body>
    <jsp:include page="./common/common-homepage-footer.jsp"></jsp:include>
    <% 
                    String activationMessage = (String) session.getAttribute("activationMessage");
                    if (activationMessage != null) { 
                    %>
                    <script>
                        alert("<%= activationMessage %>");
                    </script>
                    <% 
                    } 
                    %>
</html>
