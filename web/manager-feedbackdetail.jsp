<%-- 
    Document   : manager-feedbackdetail
    Created on : Nov 4, 2024, 1:17:55 AM
    Author     : admin
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Feedback Detail</title>
        <style>
            body {
                font-family: Arial, sans-serif;
                background-color: #f2f2f2;
                margin: 0;
                padding: 0;
                color: #333;
            }

            .container-fluid {
                width: 85%;
                max-width: 1000px;
                margin: 20px auto;
                background-color: #fff;
                padding: 30px;
                box-shadow: 0px 4px 8px rgba(0, 0, 0, 0.1);
                border-radius: 10px;
            }

            .feedback-detail {
                padding: 20px;
                border-radius: 10px;
                background-color: #f9f9f9;
            }

            h2 {
                font-size: 2em;
                color: #333;
                border-bottom: 2px solid #4CAF50;
                padding-bottom: 10px;
                margin-bottom: 20px;
                font-weight: bold;
            }

            table {
                width: 100%;
                border-collapse: collapse;
                margin-top: 20px;
            }

            tr {
                display: flex;
                align-items: center;
                margin-bottom: 15px;
            }

            td {
                width: 70%;
                padding: 10px;
                font-size: 1em;
            }

            select {
                width: 100%;
                padding: 10px;
                margin-top: 8px;
                border: 1px solid #ddd;
                border-radius: 5px;
                font-size: 1em;
                transition: border-color 0.3s ease;
            }
            button {
                background-color: #4CAF50;
                color: #fff;
                padding: 12px 20px;
                border: none;
                border-radius: 5px;
                cursor: pointer;
                font-size: 1em;
                font-weight: bold;
                transition: background-color 0.3s ease, transform 0.1s ease;
            }

            button:hover:enabled {
                background-color: #45a049;
                transform: scale(1.03);
            }

            button:disabled {
                background-color: #ccc;
                cursor: not-allowed;
            }

            img {
                max-width: 100%;
                height: auto;
                border-radius: 5px;
            }
        </style>

    </head>
    <jsp:include page="./common/common-homepage-header.jsp"></jsp:include>

        <body>
            <section class="container-fluid">
                <div class="bread_crumb">
                    <nav aria-label="breadcrumb">
                        <ol class="breadcrumb">
                            <li class="breadcrumb-item"><a href="HomeServlet">Home</a></li>
                            <li class="breadcrumb-item"><a href="./profile">Profile</a></li>
                            <li class="breadcrumb-item"><a href="./managerFeedbackList">Feedback List</a></li>
                            <li class="breadcrumb-item active" aria-current="page">Feedback Detail</li>
                        </ol>
                    </nav>
                </div>
                <div class="feedback-detail">
                    <h2>Feedback Detail</h2>
                    <table style="border: 1px">
                        <tbody>
                            <tr>
                                <td class="bold">Contact FullName:</td>
                                <td>${user.getFullName()}</td>
                            <td class="bold">Email:</td>
                            <td>${user.getEmail()}</td>
                        </tr>
                        <tr>
                            <td class="bold">Mobile:</td>
                            <td>${user.getMobile()}</td>
                            <td class="bold">Service Name:</td>
                            <td>${service.getServiceById(feedback.getService_id()).getFullname()}</td>
                        </tr>
                        <tr> 
                            <td class="bold">Rated Star:</td>
                            <td>${feedback.getRated_star()}</td>
                            <td class="bold">Image Link:</td>
                            <td><img src="${feedback.getImage_link()}" alt="Feedback Image" style="max-width: 100%; height: auto;"/></td>
                        </tr>
                        <tr>
                            <td class="bold">Status:</td>
                            <td>
                                <select id="status" onchange="checkStatusChange()">
                                    <option value="Processing" ${feedback.getStatus() == 'Processing' ? 'selected' : ''}>Processing</option>
                                    <option value="Public" ${feedback.getStatus() == 'Processed'&&feedback.getRated_star() > 0 ? 'selected' : ''}>Public</option>
                                    <option value="Hidden" ${feedback.getStatus() == 'Processed'&&feedback.getRated_star() <= 0 ? 'selected' : ''}>Hidden</option>
                                </select>
                            </td>
                            <td class="bold">Content Feedback:</td>
                            <td>${feedback.getContent()}</td>
                        </tr>
                    </tbody>
                </table>
                <button id="editStatusButton" onclick="editStatus()" disabled>Edit Status</button>
            </div>
        </section>

        <script>
            function checkStatusChange() {
                const ratedStar = ${feedback.getRated_star()};
                const currentStatus = "${feedback.getStatus()}";
                const selectedStatus = document.getElementById('status').value;
                const button = document.getElementById('editStatusButton');

                const isPublic = ratedStar > 0;
                const isHidden = ratedStar <= 0;

                if (currentStatus === 'Processed') {
                    button.disabled = (selectedStatus === 'Public' && isPublic) || (selectedStatus === 'Hidden' && isHidden)||selectedStatus === 'Processing';
                } else {
                    button.disabled = true; 
                }
                console.log("checkstatus" + selectedStatus);
            }

            function editStatus() {
                const feedbackId = ${feedback.getId()};
                const status = document.getElementById('status').value;

                window.location.href = "managerFeedbackList?action=change&status=" + encodeURIComponent(status) + "&id=" + feedbackId;
            }

            document.addEventListener('DOMContentLoaded', checkStatusChange);
        </script>


    </body>
    <jsp:include page="./common/common-homepage-footer.jsp"></jsp:include>
</html>
