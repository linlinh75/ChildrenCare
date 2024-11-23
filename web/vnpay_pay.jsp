<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->
        <meta name="description" content="">
        <meta name="author" content="">
        <title>Tạo mới đơn hàng</title>
        <!-- Bootstrap core CSS -->
        <link href="assets/bootstrap.min.css" rel="stylesheet"/>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
        <!-- Custom styles for this template -->
        <link href="assets/jumbotron-narrow.css" rel="stylesheet">      
        <script src="assets/jquery-1.11.3.min.js"></script>
    </head>
    <%

    session.setAttribute("rid", request.getParameter("rid"));

    %>
    <jsp:include page="/common/common-homepage-header.jsp"></jsp:include>
    <body>
         <div class="container ">
           <div class="header clearfix">

                <h3 class="text-muted">VNPAY DEMO</h3>
            </div>
            <h3>Payment for Chidren Care System</h3>
            <div class="table-responsive">
                <form action="vnpayajax" id="frmCreateOrder" method="post">        
                    <div class="form-group">
                        <label for="amount">Amount</label>
                        <input class="form-control" data-val="true" data-val-number="The field Amount must be a number." data-val-required="The Amount field is required." id="amount" max="100000000" min="1" name="amount" type="number" value="${param.amount}" readonly />
                    </div>
                     <h4>Choose payment method</h4>
                    <div class="form-group">                 
                       <h5>Separate method at the site of the connecting entity</h5>                   
                       <input type="radio" id="bankCode" name="bankCode" value="NCB" checked readonly>
                       <label for="bankCode">Payment via ATM card/domestic account</label><br>      
                    </div>
                    <div class="form-group">
                        <h5>Choose payment interface language: </h5>
                         <input type="radio" id="language" Checked="True" name="language" value="vn">
                         <label for="language">Tiếng việt</label><br>
                         <input type="radio" id="language" name="language" value="en">
                         <label for="language">English</label><br>
                         
                    </div>
                    <button type="submit" class="btn btn-primary" href>Pay</button>
                </form>
            </div>
            <p>
                &nbsp;
            </p>
            
        </div>
          
        <link href="https://pay.vnpay.vn/lib/vnpay/vnpay.css" rel="stylesheet" />
        <script src="https://pay.vnpay.vn/lib/vnpay/vnpay.min.js"></script>
        <script type="text/javascript">
            $("#frmCreateOrder").submit(function () {
    var postData = $("#frmCreateOrder").serialize();
    var submitUrl = $("#frmCreateOrder").attr("action");

    // Debugging logs
    console.log("Submit URL: ", submitUrl);
    console.log("Post Data: ", postData);

    $.ajax({
        type: "POST",
        url: submitUrl,
        data: postData,
        dataType: 'json', // Ensure correct parsing
        success: function (x) {
            console.log("Response: ", x); // Log the response
            if (x.code === '00') {
                if (window.vnpay) {
                    vnpay.open({width: 768, height: 600, url: x.data});
                } else {
                    location.href = x.data;
                }
                return false;
            } else {
                alert(x.Message);
            }
        },
        error: function (xhr, status, error) {
            console.log("AJAX Error: ", status, error); // Log AJAX errors
            alert("Payment request failed.");
        }
    });
    return false;
});

        </script>       
    </body>
    <jsp:include page="./common/common-homepage-footer.jsp"></jsp:include>
</html>