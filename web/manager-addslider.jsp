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
                                        <small id="backlinkError" style="color: red; display: none;">Please enter a valid URL.</small>
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
        </body>
    <jsp:include page="./common/common-homepage-footer.jsp"></jsp:include>
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

            const backlink = document.getElementById("sliderBacklink").value.trim();
            const backlinkError = document.getElementById("backlinkError");
            if (!isValidURL(backlink)) {
                backlinkError.style.display = "block";
                isValid = false;
            } else {
                backlinkError.style.display = "none";
            }

            if (!isValid) {
                alert("Please input correct information in the form.");
            }
            return isValid; 
        }

        function isValidURL(url) {
            const urlPattern = /^(http|https):\/\/[^\s$.?#].[^\s]*$/gm;
            return urlPattern.test(url);
        }
    </script>
</html>
