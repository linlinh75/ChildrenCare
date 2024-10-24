<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Notification</title>
        <script>
            // Hiển thị thông báo
            alert("<%= request.getAttribute("message") %>");
        </script>
    </head>
    <body>
        <!-- Trang trắng -->
    </body>
</html>