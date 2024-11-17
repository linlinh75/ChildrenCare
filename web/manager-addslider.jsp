<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Form Create Slider</title>
        <!-- favicon -->
        <link rel="shortcut icon" href="img/favicon.png">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
        <!-- Bootstrap -->
        <link href="${pageContext.request.contextPath}/assets/css/bootstrap.min.css" rel="stylesheet" type="text/css" />
        <!-- simplebar -->
        <link href="${pageContext.request.contextPath}/assets/css/simplebar.css" rel="stylesheet" type="text/css" />
        <!-- Icons -->
        <link href="${pageContext.request.contextPath}/assets/css/materialdesignicons.min.css" rel="stylesheet" type="text/css" />
        <link href="${pageContext.request.contextPath}/assets/css/remixicon.css" rel="stylesheet" type="text/css" />
        <link href="https://unicons.iconscout.com/release/v3.0.6/css/line.css"  rel="stylesheet">
        <!-- Css -->
        <link href="${pageContext.request.contextPath}/assets/css/style.min.css" rel="stylesheet" type="text/css" id="theme-opt" />
    </head>

    <body>
        <div class="page-wrapper doctris-theme toggled">
            <jsp:include page="./common/admin/side_bar_admin.jsp"></jsp:include>
                <main class="page-content bg-light">
                <jsp:include page="./common/common-homepage-header.jsp"></jsp:include>
                    <section class="container-fluid" style="padding: 20px; margin-top: 30px; margin-bottom: 30px">
                        <div class="bread_crumb">
                            <nav aria-label="breadcrumb" >
                                <ol class="breadcrumb" style="background-color: white; box-shadow: 0 0 2px 2px rgba(128, 128, 128, 0.1);">
                                    <li class="breadcrumb-item"><a href="HomeServlet">Home</a></li>
                                    <li class="breadcrumb-item"><a href="./profile">Profile</a></li>
                                    <li class="breadcrumb-item"><a href="./managerSliderList">Slider List</a></li>
                                    <li class="breadcrumb-item active" aria-current="page">Create Form</li>
                                </ol>
                            </nav>
                        </div>
                        <a id="close-sidebar" class="btn btn-icon btn-pills btn-soft-primary ms-2" href="#" style="margin-bottom:20px">
                            <i class="uil uil-bars"></i>
                        </a>
                        <ul class="nav nav-pills nav-justified flex-column flex-sm-row rounded-0 shadow overflow-hidden bg-white mb-0" id="pills-tab" role="tablist">
                            <li class="nav-item">
                                <a class="nav-link rounded-0 active" id="overview-tab" data-bs-toggle="pill" href="#pills-overview" role="tab" aria-controls="pills-overview" aria-selected="false">
                                    <div class="text-center pt-1 pb-1">
                                        <h4 class="title fw-normal mb-0" style="height: 20px"></h4>
                                    </div>
                                </a><!--end nav link-->
                            </li><!--end nav item-->
                        </ul>
                        <div class="create-form" style="background-color: white; padding: 10px;box-shadow: 0 0 2px 2px rgba(128, 128, 128, 0.1);">
                            <div>
                                <h2 style="text-align: center; margin-bottom: 20px;">Create Slider</h2>
                                <form id="addForm" method="post" action="managerSliderList" enctype="multipart/form-data" onsubmit="return validateForm()">
                                    <table style="width: 100%; border-collapse: collapse;">
                                        <tr style="padding-bottom: 15px;">
                                            <td style="width: 150px; font-weight: bold;">
                                                <label for="sliderTitle">Title <span style="color: red;">*</span></label>
                                                <small id="titleError" style="color: red; display: none;">Please enter a title.</small>
                                            </td>
                                            <td>
                                                <input style="width: 90%; height: 50px;" type="text" name="sliderTitle" id="sliderTitle" required>
                                            </td>
                                        </tr>
                                        <tr style="padding-bottom: 15px;">
                                            <td style="width: 150px; font-weight: bold;">
                                                <label for="sliderImage">Image<span style="color: red;">*</span></label>
                                            </td>
                                            <td>
                                                <input type="file" id="sliderImageInput" name="sliderImage" accept="image/*" required>
                                                <small id="imageError" style="color: red; display: none;">Please select a valid image file.</small>
                                            </td>
                                        </tr>
                                        <tr style="padding-bottom: 15px;">
                                            <td style="width: 150px; font-weight: bold;">
                                                <label for="sliderBacklink">Back Link<span style="color: red;">*</span></label>
                                            </td>
                                            <td>
                                                <input style="width: 90%;" type="url" name="sliderBacklink" id="sliderBacklink" required>
                                            </td>
                                        </tr>
                                        <tr style="padding-bottom: 15px;">
                                            <td style="width: 150px;height: 50px; font-weight: bold;">
                                                <label for="sliderNote">Notes</label>
                                            </td>
                                            <td>
                                                <input style="width: 90%; height: 30px;" type="text" name="sliderNote" id="sliderNote">
                                            </td>
                                        </tr>
                                        <tr style="padding-bottom: 15px;">
                                            <td style="width: 150px; font-weight: bold;">
                                                <label for="sliderStatus">Status</label>
                                            </td>
                                            <td>
                                                <select name="sliderStatus" id="sliderStatus" required>
                                                    <option value="1">Public</option>
                                                    <option value="0">Hidden</option>
                                                </select>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td colspan="2" style="text-align: center; padding-top: 15px;">
                                                <button type="submit" name="submit" value="add" class="btn btn-edit">Create</button>
                                            </td>
                                        </tr>
                                    </table>
                                </form>
                            </div>
                        </div>
                    </section>
                <jsp:include page="./common/common-homepage-footer.jsp"></jsp:include>
            </main>
        </div>
    </body>

    <script>
        function validateForm() {
            let isValid = true;

            const title = document.getElementById("sliderTitle").value.trim();
            const titleError = document.getElementById("titleError");
            if (title === "") {
                titleError.style.display = "block";
                isValid = false;
            } else {
                titleError.style.display = "none";
            }

            const image = document.getElementById("sliderImageInput").value;
            const imageError = document.getElementById("imageError");
            if (image === "") {
                imageError.style.display = "block";
                isValid = false;
            } else {
                imageError.style.display = "none";
            }

     
            
            if (!isValid) {
                alert("Please input correct information in the form.");
            }
            return isValid;
        }


    </script>
</html>
