<%-- 
    Document   : slider-details
    Created on : Oct 15, 2024, 3:46:10 PM
    Author     : admin
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Slider Detail</title>
    </head>
    <jsp:include page="./common/common-homepage-header.jsp"></jsp:include>
        <body>
            <section class="container-fluid" style="width: 80%">
                <div class="bread_crumb">
                    <nav aria-label="breadcrumb">
                        <ol class="breadcrumb">
                            <li class="breadcrumb-item"><a href="HomeServlet">Home</a></li>
                            <li class="breadcrumb-item"><a href="./profile">Profile</a></li>
                            <li class="breadcrumb-item"><a href="#">Dashboard</a></li>
                            <li class="breadcrumb-item"><a href="./managerSliderList">Slider List</a></li>
                            <li class="breadcrumb-item active" aria-current="page">Slider Detail</li>
                        </ol>
                    </nav>
                </div>
                <div class="slider-detail" style="width: 80%; margin: 20px auto; padding: 20px; border: 1px solid #ddd;">
                    <table style="width: 100%; border-collapse: collapse;">
                        <tbody>
                        <h2 style="text-align: center; font-size: 24px;margin-bottom: 20px;">${slider.getTitle()}</h2>
                    <tr>
                        <td colspan="2" style="text-align: center;">
                            <img src="${slider.getImageLink()}" alt="alt" style="width: 650px; height: 450px; border-radius: 5px;"/>
                        </td>
                    </tr>
                    <tr>
                        <td style="padding: 10px; font-weight: bold; border-bottom: 1px solid #ddd;">Back Link:</td>
                        <td style="padding: 10px; border-bottom: 1px solid #ddd;">${slider.getBacklink()}</td>
                    </tr>
                    <tr>
                        <td style="padding: 10px; font-weight: bold; border-bottom: 1px solid #ddd;">Status:</td>
                        <td style="padding: 10px; border-bottom: 1px solid #ddd;">
                            ${slider.status eq "1" ? "Public" : "Hidden" }
                        </td>
                    </tr>
                    <tr>
                        <td style="padding: 10px; font-weight: bold;">Notes:</td>
                        <td style="padding: 10px;">${slider.getNotes()}</td>
                    </tr>
                    </tbody>
                </table>
            </div>

        </div>
    </section>
</body>
<jsp:include page="./common/common-homepage-footer.jsp"></jsp:include>
</html>
