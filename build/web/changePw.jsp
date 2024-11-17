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
      <div class="col col-xl-8">
        <div class="card" style="border-radius: 1rem;">
            <div class=" d-flex align-items-center">
              <div class="card-body p-4 p-lg-5 text-black">
                <form action = "change" method="post">
                   
                  <div class="d-flex align-items-center mb-3 pb-1">
                    <span class="h1 fw-bold mb-0">Change Password</span>
                  </div>
                    
                        <c:if test="${erChange!=null}">
                            <div class="alert alert-danger mb-3" role="alert">
                                ${erChange}
                            </div>
                        </c:if>
                    <div data-mdb-input-init class="form-outline mb-4">
                    <input type="password" name="Old password" id="oldPassword"  class="form-control form-control-lg" required/>
                    <label class="form-label" for="oldPassword">Old Password</label>
                  </div>
                  <div data-mdb-input-init class="form-outline mb-4">
                    <input type="password" name="New password" id="newPassword"  class="form-control form-control-lg" required />
                    <label class="form-label" for="newPassword">New Password</label>
                  </div>
                    <div data-mdb-input-init class="form-outline mb-4">
                    <input type="password" name="confPassword" id="confirmPassword"  class="form-control form-control-lg" required />
                    <label class="form-label" for="confirmPassword">Re-Enter Password</label>
                  </div>
                    <div class="row d-flex">
                  <div class="pt-1 mb-4 col-md-6">
                      <button data-mdb-button-init data-mdb-ripple-init class="btn btn-dark btn-lg btn-block" type="submit" name="submit" value="submit" id="changePasswordButton">Change Password</button>
                  </div>
                    <div class="pt-1 mb-4 col-md-6">
                        <button data-mdb-button-init data-mdb-ripple-init class="btn btn-dark btn-lg btn-block" type="button" name="undo" value="undo">
                            <a href="profile">Un-do Change Password</a>
                        </button>
                  </div>
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
