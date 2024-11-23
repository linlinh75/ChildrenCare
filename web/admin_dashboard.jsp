
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <jsp:include page="common/common-homepage-header.jsp"/>
    <body>
        <div class="container mt-5">
            <h2 class="mb-5">Admin Dashboard</h2>
            <form method="admin-dashboard"
                >
                <label>
          Start Date:
          <input type="date" name="startDate" value="${startDate}"/>
        </label>
        <label>
          End Date:
          <input type="date" name="endDate" value="${endDate}"/>
        </label>
                <button onClick={} class="btn btn-sucess">Update</button>
            </form>
            <!-- Statistics Cards -->
            <div class="row mt-4">
                <!-- Reservation Stats -->
                <div class="col-md-3">
                    <div class="card bg-primary text-white">
                        <div class="card-body">
                            <h5 class="card-title">Reservations</h5>
                            <h2>${stats.newReservations}</h2>
                        </div>
                    </div>
                </div>
                <div class="col-md-3">
                    <div class="card bg-success text-white">
                        <div class="card-body">
                            <h5 class="card-title">Completed</h5>
                            <h2>${stats.successfulReservations}</h2>
                        </div>
                    </div>
                </div>
                <div class="col-md-3">
                    <div class="card bg-danger text-white">
                        <div class="card-body">
                            <h5 class="card-title">Cancelled</h5>
                            <h2>${stats.cancelledReservations}</h2>
                        </div>
                    </div>
                </div>
                <div class="col-md-3">
                    <div class="card bg-warning text-white">
                        <div class="card-body">
                            <h5 class="card-title">Pending</h5>
                            <h2>${stats.submittedReservations}</h2>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Revenue Stats -->
            <div class="row mt-4">
                <div class="col-md-6">
                    <div class="card">
                        <div class="card-body">
                            <h5 class="card-title">Total Revenue</h5>
                            <h2>$<fmt:formatNumber value="${stats.totalRevenue}" pattern="#,##0.00"/></h2>
                        </div>
                    </div>
                </div>
                <div class="col-md-6">
                    <div class="card">
                        <div class="card-body">
                            <h5 class="card-title">Revenue by Category</h5>
                            <table class="table">
                                <c:forEach items="${stats.revenueByCategory}" var="entry">
                                    <tr>
                                        <td>${entry.key}</td>
                                        <td>$<fmt:formatNumber value="${entry.value}" pattern="#,##0.00"/></td>
                                    </tr>
                                </c:forEach>
                            </table>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Customer Stats -->
            <div class="row mt-4">
                <div class="col-md-6">
                    <div class="card">
                        <div class="card-body">
                            <h5 class="card-title">New Customers </h5>
                            <h2>${stats.newCustomers}</h2>
                        </div>
                    </div>
                </div>
                <div class="col-md-6">
                    <div class="card">
                        <div class="card-body">
                            <h5 class="card-title">New Reserving Customers </h5>
                            <h2>${stats.newReservingCustomers}</h2>
                        </div>
                    </div>
                </div>
            </div>
            
            <!-- Existing Chart Section -->
            <div class="row mt-4">
                <div class="col-12">
                    <div class="card">
                        <div class="card-body">
                            <h5 class="card-title">Reservation Trends</h5>
                            <div id="chart-container">
                                <iframe 
                                    src="http://localhost:3000/react/chart" 
                                    style="width: 100%; height: 600px; border: none;"
                                    title="Reservation Statistics">
                                </iframe>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        
        <script>
            // Adjust iframe height based on content
            window.addEventListener('message', function(e) {
                if (e.data.type === 'setHeight') {
                    document.querySelector('iframe').style.height = e.data.height + 'px';
                }
            });
        </script>
    </body>
    <jsp:include page="./common/common-homepage-footer.jsp"></jsp:include>
</html>