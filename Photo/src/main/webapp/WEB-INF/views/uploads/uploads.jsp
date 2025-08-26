<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>

<title>Photo Uploads</title>
<style>	

</style>

<!-- css Link -->
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/resources/css/home.css">
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/resources/css/uploads.css">	

<!-- 스크립트 Link -->
<script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/home.js"></script>
<jsp:include page="/WEB-INF/views/layout/header.jsp" />
</head>

<body style="background-color: #1c1c1c;">
<!-- 사진 업로드 UI -->
<div class="upload-container">
	<h2 style="margin-top: 20px;">${sessionScope.loginUser.userName}님의 사진 업로드</h2>
		<form id="insertForm" name="insertForm" action="${pageContext.request.contextPath}/photouploads/insertPhoto" 
				method="POST" enctype="multipart/form-data">
			<!--<input type="hidden" id="userSeq" name="userSeq" value="${sessionScope.loginUser.userSeq}"> -->
	        <div class="upload-box">
	            <div id="drop-file" class="drag-file">
	                <img src="https://img.icons8.com/pastel-glyph/2x/image-file.png" alt="파일 아이콘" class="image">
	                	<p class="message">사진을 드래그해서 업로드하거나 클릭하여 파일을 선택하세요</p>
	                <img src="" alt="미리보기 이미지" class="preview" id="preview">
	            </div>
	
	            <label class="file-label" for="chooseFile">파일 선택</label>
	            <input class="file" id="chooseFile" type="file" name="selectFile" onchange="FileSelect(this.files)" accept="image/png, image/jpeg, image/gif">
	
	            <p class="file-name" id="fileName"></p>
	
	            <!-- 업로드 버튼 -->
	            <button type="submit" class="upload-btn">업로드</button>
	        </div>
	    </form>
	</div>   
	
<div class="related-images">
    <h3>추천 사진</h3>
	    <div class="image-gallery" style="color: white;">
	        <a href="${pageContext.request.contextPath}/photo">
			    <img src="resources/images/uploads/cloud.jpg" alt="추천 이미지">
			</a>
			<a href="${pageContext.request.contextPath}/photo">
	        	<img src="resources/images/uploads/roadtree.jpg" alt="추천 이미지">
	        </a>
	        <a href="${pageContext.request.contextPath}/photo">
	       		<img src="resources/images/uploads/tree.jpg" alt="추천 이미지">
	        </a>
	        <a href="${pageContext.request.contextPath}/photo">
	        	<img src="resources/images/uploads/turtle.jpg" alt="">
	        </a>
	    </div>
	    <div class="image-gallery" style="color: white; margin-top: 20px;">
		    <a href="${pageContext.request.contextPath}/photo">	
		        <img src="resources/images/uploads/land.jpg" alt="추천 이미지">
		    </a> 
		        <img src="resources/images/uploads/mountain.jpg" alt="추천 이미지">
		    <a href="${pageContext.request.contextPath}/photo"> 
		        <img src="resources/images/uploads/japan.jpg" alt="추천 이미지">
		    </a>
		    <a href="${pageContext.request.contextPath}/photo">
		        <img src="resources/images/uploads/monkey.jpg" alt="">
		    </a>
	    </div>
		</div>

<script>
function FileSelect(files) {
    if (files.length > 0) {
        var file = files[0]; // 첫 번째 파일 선택
        var reader = new FileReader();

        reader.onload = function(e) {
            document.getElementById("preview").src = e.target.result; // 미리보기 이미지 설정
            document.getElementById("fileName").textContent = file.name; // 파일 이름 표시
        };

        reader.readAsDataURL(file);
    }
}

// 폼 제출 시 파일이 선택되었는지 확인
window.addEventListener("DOMContentLoaded", function () {
    const insertForm = document.getElementById("insertForm");
    const fileInput = document.getElementById('chooseFile');
    const fileName = document.getElementById("fileName");

    // JSTL을 이용해 로그인 여부 판단 (자바스크립트 변수로)
    const uploadsButton = ${sessionScope.loginUser == null ? "false" : "true"};

    insertForm.addEventListener("submit", function (e) {
        // 1. 로그인 체크
        if (!uploadsButton) {
            e.preventDefault();
            alert("로그인이 필요합니다.");
            location.href = "${pageContext.request.contextPath}/home";
            return;
        }

        // 2. 파일 선택 체크
        if (!fileInput.files.length) {
            e.preventDefault();
            alert("파일을 선택해주세요.");
            fileName.textContent = "";
            return;
        }
    });
});


</script>
</body>
</html>