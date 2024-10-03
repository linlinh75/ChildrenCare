<%-- 
    Document   : newPw
    Created on : Sep 24, 2024, 11:42:59 AM
    Author     : Admin
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Change Password</title>
    </head>
     <jsp:include page="./common/common-homepage-header.jsp"></jsp:include>
    <body>
        <section class="vh-100" style="background-color: #1A76D1;">
  <div class="container py-5 h-100">
    <div class="row d-flex justify-content-center align-items-center h-100">
      <div class="col col-xl-10">
        <div class="card" style="border-radius: 1rem;">
            <div class="col-md-6 col-lg-7 d-flex align-items-center">
              <div class="card-body p-4 p-lg-5 text-black">
                <form action = "forgot" method="post">
                  <div class="d-flex align-items-center mb-3 pb-1">
                    <span class="h1 fw-bold mb-0">Reset Password</span>
                  </div>
                    <c:if test="${message!=null}">
                    <div class="alert alert-success" role="alert">
                        ${message}
                    </div>
                  </c:if>
                    <c:if test="${error!=null}">
                    <div class="alert alert-danger" role="alert">
                        ${error}
                    </div>
                  </c:if>
                  <h5 class="fw-normal mb-3 pb-3" style="letter-spacing: 1px;">Enter email to let us help you out</h5>

                    <div data-mdb-input-init class="form-outline mb-4">
                    <input type="email" name="email" id="form2Example17"  class="form-control form-control-lg" />
                    <label class="form-label" for="form2Example17">Email</label>
                  </div>
                  <div class="pt-1 mb-4 row">
                      <button data-mdb-button-init data-mdb-ripple-init class="btn btn-dark btn-lg btn-block" type="submit" name="submit" value="submit">Send Email!</button>
                  </div>
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

</html>

