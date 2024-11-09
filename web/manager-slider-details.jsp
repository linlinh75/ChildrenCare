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
    <body>
        <div class="page-wrapper doctris-theme toggled">
            <jsp:include page="./common/admin/side_bar_admin.jsp"></jsp:include>
                <main class="page-content bg-light">
                <jsp:include page="./common/common-homepage-header.jsp"></jsp:include>
                    <section class="container-fluid" style="padding: 20px; margin-top: 30px; margin-bottom: 30px;">
                        <div class="bread_crumb">
                            <nav aria-label="breadcrumb">
                                <ol class="breadcrumb" style="background-color: white; box-shadow: 0 0 2px 2px rgba(128, 128, 128, 0.1);">
                                    <li class="breadcrumb-item"><a href="HomeServlet">Home</a></li>
                                    <li class="breadcrumb-item"><a href="./profile">Manager Dashboard</a></li>
                                    <li class="breadcrumb-item"><a href="./managerSliderList">Slider List</a></li>
                                    <li class="breadcrumb-item active" aria-current="page">Slider Detail</li>
                                </ol>
                            </nav>
                        </div>
                        <a id="close-sidebar" class="btn btn-icon btn-pills btn-soft-primary ms-2" href="#" style="margin-bottom:20px">
                            <i class="uil uil-bars"></i>
                        </a>
                        <div class="slider-detail" style="background-color: white; box-shadow: 0 0 2px 2px rgba(128, 128, 128, 0.1); padding-top: 20px">
                            <table style="background-color: white;">
                                <tbody>
                                <h2 style="text-align: center; font-size: 24px;margin-bottom: 20px;">${slider.getTitle()}</h2>
                            <tr>
                                <td colspan="2" style="text-align: center;">
                                    <img src="${slider.getImageLink()}" alt="alt" style="width: 650px; height: 450px; border-radius: 5px;"/>
                                </td>
                            </tr>
                            <tr>
                                <td style="padding: 10px; font-weight: bold; border-bottom: 1px solid #ddd;">Back Link:</td>
                                <td style="padding: 10px; border-bottom: 1px solid #ddd;">
                                    <a href="http://localhost:8080/ChildrenCare/${slider.getBacklink()}" target="_blank" style="color: #0044cc">
                                        http://localhost:8080/ChildrenCare/${slider.getBacklink()}
                                    </a>
                                </td>
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
                </section>
                <jsp:include page="./common/common-homepage-footer.jsp"></jsp:include>
            </main>
        </div>
    </body>
</html>
