
<%-- 
    Document   : login
    Created on : Sep 19, 2024, 8:37:52 AM
    Author     : Admin
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="dal.ReservationDAO"%>
<%@page import="model.Reservation"%>
<!DOCTYPE html>
<html>
    <head>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Reservation Completion</title>
    </head>
     <jsp:include page="/common/common-homepage-header.jsp"></jsp:include>
     <%
         ReservationDAO rdao = new ReservationDAO();
     Reservation res =  rdao.getReservationById(Integer.parseInt(request.getParameter("reservationId")));
     request.setAttribute("res", res);
     %>
    <body>
        <section class="vh-100" >

  <div class="container-fluid h-100 py-5 " style="background-color: #1A76D1;">
    <div class="row d-flex justify-content-center align-items-center h-100">
      <div class="col col-xl-10">
        <div class="card" style="border-radius: 1rem;">
          <div class="row g-0">
            <div class="col-md-12 col-lg-12 d-flex align-items-center">
              <div class="card-body p-3 text-black">
                  <div class="d-flex align-items-center mb-3 pb-1">
                    <span class="h1 fw-bold mb-0">Your Reservation Completion</span>
                  </div>
                   <div class="row">
                       <div class="table-responsive">
                                <table class="table table-bordered table-hover">
                                    <thead>
                                        <tr>
                                            <th>Service</th>
                                            <th>Price</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach items="${res.getList_service()}" var="service">
                                            <tr>
                                                <td>
                                                    <h5>${service.service_name}</h5>
                                                </td>
                                                <td>${service.unit_price}</td>

                                            </tr>
                                        </c:forEach>
                                    </tbody>
                                </table>
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
