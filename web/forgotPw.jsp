<%-- 
    Document   : newPw
    Created on : Sep 24, 2024, 11:42:59 AM
    Author     : Admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Change Password</title>
    </head>
    <body>
        <section class="vh-100" style="background-color: #1A76D1;">
  <div class="container py-5 h-100">
    <div class="row d-flex justify-content-center align-items-center h-100">
      <div class="col col-xl-10">
        <div class="card" style="border-radius: 1rem;">
            <div class="col-md-6 col-lg-7 d-flex align-items-center">
              <div class="card-body p-4 p-lg-5 text-black">
                <form action = "newPassword" method="post">
                  <div class="d-flex align-items-center mb-3 pb-1">
                    <i class="fas fa-cubes fa-2x me-3" style="color: #ff6219;"></i>
                    <span class="h1 fw-bold mb-0">Enter New Password</span>
                  </div>
                    <div data-mdb-input-init class="form-outline mb-4">
                    <input type="password" name="Old password" id="form2Example17"  class="form-control form-control-lg" />
                    <label class="form-label" for="form2Example17">Old Password</label>
                  </div>
                  <div data-mdb-input-init class="form-outline mb-4">
                    <input type="password" name="New password" id="form2Example17"  class="form-control form-control-lg" />
                    <label class="form-label" for="form2Example17">New Password</label>
                  </div>
                    <div data-mdb-input-init class="form-outline mb-4">
                    <input type="password" name="confPassword" id="form2Example17"  class="form-control form-control-lg" />
                    <label class="form-label" for="form2Example17">Re-Enter Password</label>
                  </div>
                  <div class="pt-1 mb-4 row">
                      <button data-mdb-button-init data-mdb-ripple-init class="btn btn-dark btn-lg btn-block" type="submit" name="submit" value="submit">Change Password</button>
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
</html>