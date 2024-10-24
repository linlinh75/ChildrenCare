<%@page import="java.net.URLEncoder"%>
<%@page import="java.nio.charset.StandardCharsets"%>
<%@page import="controller.vnpay.Config"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<%@page import="java.util.Iterator"%>
<%@page import="java.util.Collections"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.Enumeration"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.HashMap"%>
<%@page import="dal.ReservationDAO"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <meta name="description" content="">
        <meta name="author" content="">
        <title>PAYMENT RESULT</title>
        <!-- Bootstrap core CSS -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
    </head>
    <body class="bg-light">
        <div class="container mt-5">
            <div class="card border-primary shadow-lg">
                <div class="card-header bg-primary text-white">
                    <h3 class="mb-0 text-center">Payment Result</h3>
                </div>
                <div class="card-body">
                    <%
                        //Begin process return from VNPAY
                        Map fields = new HashMap();
                        for (Enumeration params = request.getParameterNames(); params.hasMoreElements();) {
                            String fieldName = URLEncoder.encode((String) params.nextElement(), StandardCharsets.US_ASCII.toString());
                            String fieldValue = URLEncoder.encode(request.getParameter(fieldName), StandardCharsets.US_ASCII.toString());
                            if ((fieldValue != null) && (fieldValue.length() > 0)) {
                                fields.put(fieldName, fieldValue);
                            }
                        }

                        String vnp_SecureHash = request.getParameter("vnp_SecureHash");
                        if (fields.containsKey("vnp_SecureHashType")) {
                            fields.remove("vnp_SecureHashType");
                        }
                        if (fields.containsKey("vnp_SecureHash")) {
                            fields.remove("vnp_SecureHash");
                        }
                        String signValue = Config.hashAllFields(fields);
                    %>

                    <!-- Payment Information -->
                    <div class="table-responsive">
                        <table class="table table-bordered table-striped">
                            <tr>
                                <th>Transaction Reference:</th>
                                <td><%=request.getParameter("vnp_TxnRef")%></td>
                            </tr>
                            <tr>
                                <th>Amount:</th>
                                <td><%=request.getParameter("vnp_Amount")%></td>
                            </tr>
                            <tr>
                                <th>Transaction Description:</th>
                                <td><%=request.getParameter("vnp_OrderInfo")%></td>
                            </tr>
                            <tr>
                                <th>Response Code:</th>
                                <td><%=request.getParameter("vnp_ResponseCode")%></td>
                            </tr>
                            <tr>
                                <th>Transaction Number at VNPAY-QR:</th>
                                <td><%=request.getParameter("vnp_TransactionNo")%></td>
                            </tr>
                            <tr>
                                <th>Bank Code:</th>
                                <td><%=request.getParameter("vnp_BankCode")%></td>
                            </tr>
                            <tr>
                                <th>Payment Date:</th>
                                <td><%=request.getParameter("vnp_PayDate")%></td>
                            </tr>
                            <tr>
                                <th>Transaction Status:</th>
                                <td>
                                    <%
                                        ReservationDAO rdao = new ReservationDAO();
                                        if (signValue.equals(vnp_SecureHash)) {
                                            if ("00".equals(request.getParameter("vnp_TransactionStatus"))) {
                                                rdao.statusReservation((int)session.getAttribute("rid"), "Successful");
                                                out.print("<span class='badge bg-success'>Successful</span>");
                                            } else {
                                                rdao.statusReservation((int)session.getAttribute("rid"), "Unsuccessful");
                                                out.print("<span class='badge bg-danger'>Unsuccessful</span>");
                                            }
                                        } else {
                                            out.print("<span class='badge bg-warning'>Invalid signature</span>");
                                        }
                                    %>
                                </td>
                            </tr>
                        </table>
                    </div>

                    <!-- Footer -->
                    <div class="text-center mt-4">
                        <a href="http://localhost:8080/ChildrenCare/rscompletion.jsp?reservationId=<%=(int)session.getAttribute("rid")%>" class="btn btn-primary">Back to System</a>
                    </div>
                </div>
                <div class="card-footer text-center">
                    <p class="mb-0">&copy; VNPAY 2024</p>
                </div>
            </div>
        </div>

        <!-- Bootstrap core JavaScript -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-c8D5ew0qn7NfDxk1MApV7qXlZZ7d5zEBdJYQmLcf4jtDD0D3F+vi6Ff+W7ORbI+p" crossorigin="anonymous"></script>
    </body>
</html>
