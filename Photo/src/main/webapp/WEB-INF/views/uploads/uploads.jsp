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
</head>

<body style="background-color: #1c1c1c;">
<header class="header-top">
    <!-- 왼쪽 로고 -->
    <div class="logo">
        <img src="resources/images/logo/logo.png" alt="Logo" 
             onclick="location.href='${pageContext.request.contextPath}/home';">
    </div>

    <!-- 가운데 메뉴 -->
    <div class="nav-items">
    	<a href="${pageContext.request.contextPath}/photo">- ̗̀ෆ⎛˶'ᵕ'˶ ⎞ෆ ̖́-</a>
        <a href="${pageContext.request.contextPath}/photo">Photo</a>
        <a href="${pageContext.request.contextPath}/photouploads">Uploads</a>
		<a href="${pageContext.request.contextPath}/notice/list">Notice?</a>
		<a href="${pageContext.request.contextPath}/story/story.do">Story</a>
        
    </div>

    <!-- 오른쪽 로그인 버튼 -->
      <div class="login-button">
        <c:choose>
            <c:when test="${not empty sessionScope.loginUser}">
                 <a href="${pageContext.request.contextPath}/mypage">
                	★${sessionScope.loginUser.userName}★님
            	</a>
                <a href="${pageContext.request.contextPath}/login/logout">&nbsp;&nbsp;&nbsp;⏻Logout</a>
            </c:when>
            <c:otherwise>
                <a type="button" onclick="openModal()">Login</a>
            </c:otherwise>
        </c:choose>
    </div>

	<!-- 로그아웃 했을시 메세지 보내기 컨트롤러에서 던져서 jsp로 받기 -->
		<c:if test="${not empty logoutMessage}">
			<script>
				alert("${logoutMessage}");
			</script>
		</c:if>
	</header>
<div id="loginModal" class="modal" style="display: none;">
    <div class="modal-content">
        <div class="close" onclick="closeModal()">&times;</div>
	        <h1>로그인</h1>
	        <form id="loginForm" name="loginForm" method="POST">
	            <input type="text" id="userId" name="userId" placeholder="UserId" required>
	            <input type="password" id="userPwd" name="userPwd" placeholder="Password" required>
	            <button type="button" onclick="sendLogin()" style="margin-bottom: 10px;">Login</button>
	        </form>
	    <div>
			<p class="login_signup">
				아직 계정이 없으신가요? 
			</p>
			<p>
			<a style="color: white; text-decoration: none; "
				href="${pageContext.request.contextPath}/user">
				 *회원가입 하러가기*</a>
			</p>
	    </div>
	</div>
</div>

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