<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Verify Email</title>
    </head>
    <jsp:include page="./common/common-homepage-header.jsp"></jsp:include>

        <body>
            <section class="verify-page section">
                <div class="container-fluid">
                    <div class="row">
                        <div class="col-lg-6 offset-lg-3 col-12">
                            <div class="verify-inner" style="display: flex; flex-direction: column; align-items: center; justify-content: center; text-align: center;">
                                <h1 style="color: #0044cc; font-weight: bold; margin-bottom: 20px; text-shadow: 2px 2px 4px rgba(0, 0, 0, 0.3);">Verify Your Email</h1>
                                <span style="color: #808080;">Please check your email for a link to verify your email address</span> <br>
                                <span style="color: #808080;">Once verified, you can log in to the system</span> <br>
                                <img src="./img/emailsend.png" alt="Email sent"/>

                            <%
    String resendMessage = (String) session.getAttribute("resendMessage");
    if (resendMessage != null) {
        out.println("<span style='color: green;'>" + resendMessage + "</span><br>");
        session.removeAttribute("resendMessage"); 
    }
                            %>

                            <span style="color: #808080;">Didn't receive an email? Check your spam or junk email or 
                                <form action="RegisterServlet" method="post" style="display: inline;">
                                    <input type="hidden" name="action" value="resend">
                                    <button type="submit" style="background: none; border: none; color: #007bff; cursor: pointer;">Resend</button>
                                </form>.
                            </span>
                        </div>
                    </div>
                </div>
            </div>
        </section>	
    </body>
    <jsp:include page="./common/common-homepage-footer.jsp"></jsp:include>
</html>
