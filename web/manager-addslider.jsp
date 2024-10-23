<%-- 
    Document   : manager-addslider
    Created on : Oct 20, 2024, 9:08:12 PM
    Author     : admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Form Create Slider</title>
    </head>
    <jsp:include page="./common/common-homepage-header.jsp"></jsp:include>
        <body>
            <section class="container-fluid" style="width: 80%">
                <div class="bread_crumb">
                    <nav aria-label="breadcrumb">
                        <ol class="breadcrumb">
                            <li class="breadcrumb-item"><a href="HomeServlet">Home</a></li>
                            <li class="breadcrumb-item"><a href="./profile">Profile</a></li>
                            <li class="breadcrumb-item"><a href="./managerSliderList">Slider List</a></li>
                            <li class="breadcrumb-item active" aria-current="page">Create Form</li>
                        </ol>
                    </nav>
                </div>
                <div class="create-form">
                    <div>
                        <h2 style="text-align: center; margin-bottom: 20px;">Create Slider</h2>
                        <form id="addForm" method="post" action="managerSliderList" enctype="multipart/form-data">
                            <div style="margin-bottom: 10px;">
                                <label for="sliderTitle" style="width: 100px; font-weight: bold">Title</label>
                                <input style="width: 80%; height: 80px;" type="text" name="sliderTitle" id="sliderTitle" required>
                            </div>
                            <div style="display: flex; align-items: center; margin-bottom: 10px;">
                                <label for="sliderImage" style="width: 100px; font-weight: bold">Image</label>
                                <input type="file" id="sliderImageInput" name="sliderImage" accept="image/*" >
                            </div>
                            <div style="display: flex; align-items: center; margin-bottom: 10px;">
                                <label for="sliderBacklink" style="width: 100px; font-weight: bold">Back Link</label>
                                <input type="text" name="sliderBacklink" id="sliderBacklink" required>
                            </div>
                            <div style="display: flex; align-items: center; margin-bottom: 10px;">
                                <label for="sliderNote" style="width: 100px; font-weight: bold">Notes</label>
                                <input style="width: 80%; height: 80px;" type="text" name="sliderNote" id="sliderNote" required>
                            </div>
                            <div style="display: flex; align-items: center; margin-bottom: 10px;">
                                <label for="sliderStatus" style="width: 100px; font-weight: bold">Status</label>
                                <select name="sliderStatus" id="sliderStatus" required>
                                    <option value="1" >Public</option>
                                    <option value="0">Hidden</option>
                                </select>
                            </div>
                            <button style="text-align: center !important; margin-bottom: 20px;" type="submit" name="submit" value="add" class="btn btn-edit" onclick="return confirmCreate()">Create</button>
                        </form>
                    </div>
                </div>

            </section>
        </body>
    <jsp:include page="./common/common-homepage-footer.jsp"></jsp:include>
    <script>    
        function confirmCreate()() {
            return confirm("Are you sure you want to create this sliders?");
        }
    </script>
</html>
