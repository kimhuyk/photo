<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<title>Photo</title>
<style>

</style>
<!-- CSS 링크 -->
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/resources/css/home.css">
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/resources/css/photo.css">
	
<script type="text/javascript">
    var contextPath = "${pageContext.request.contextPath}";
</script>	
	
	
<!-- 스크립트 링크 -->
<script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/home.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/photo.js"></script>

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
        <a href="${pageContext.request.contextPath}/home">Notice?</a>
    </div>

    <!-- 오른쪽 로그인 버튼 -->
      <div class="login-button">
        <c:choose>
            <c:when test="${not empty sessionScope.loginUser}">
                <span style="color: white;">★${sessionScope.loginUser.userName}★님</span>
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
        <h2>로그인</h2>
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
		<a	style="color: white; text-decoration: none; "
			href="${pageContext.request.contextPath}/user">
			 *회원가입 하러가기*</a>
		</p>
    </div>
    </div>
</div>

<!-- 사진 리스트 영역 (아래로 이동됨) -->
 <section class="gallery-container">
    <h1>PHOTO GALLERY</h1>

    <!-- 다운로드 폼 (한 개만 선언) -->
    <form id="downloadForm" action="download" method="GET">
        <input type="hidden" name="fileNum" id="fileNum">
    </form>

    <!-- 첫 번째 행 -->
    <div class="photo-grid">
        <figure class="photo-item" onclick="openpictureModal(1, 'resources/images/main/car.jpg', 'Car Pictures', '김혁')">
            <img src="resources/images/main/car.jpg" alt="Car Pictures">
            <figcaption class="caption">Car Pictures</figcaption>
        </figure>
        <figure class="photo-item" onclick="openpictureModal(2, 'resources/images/main/clothes.jpg', 'Clothes Pictures', '김혁')">
            <img src="resources/images/main/clothes.jpg" alt="Clothes Pictures">
            <figcaption class="caption">Clothes Pictures</figcaption>
        </figure>
        <figure class="photo-item" onclick="openpictureModal(3, 'resources/images/main/build.jpg', 'Build Pictures', '김혁')">
            <img src="resources/images/main/build.jpg" alt="Build Pictures">
            <figcaption class="caption">Build Pictures</figcaption>
        </figure>
    </div>

    <!-- 두 번째 행 -->
    <div class="photo-grid">
        <figure class="photo-item" onclick="openpictureModal(4, 'resources/images/main/tennis.jpg', 'Tennis Pictures', '김혁')">
            <img src="resources/images/main/tennis.jpg" alt="Tennis Pictures">
            <figcaption class="caption">Tennis Pictures</figcaption>
        </figure>
        <figure class="photo-item" onclick="openpictureModal(5, 'resources/images/main/chair.jpg', 'Chair Pictures', '김혁')">
            <img src="resources/images/main/chair.jpg" alt="Chair Pictures">
            <figcaption class="caption">Chair Pictures</figcaption>
        </figure>
        <figure class="photo-item" onclick="openpictureModal(6, 'resources/images/main/sky.jpg', 'Sky Pictures', '김혁')">
            <img src="resources/images/main/sky.jpg" alt="Sky Pictures">
            <figcaption class="caption">Sky Pictures</figcaption>
        </figure>
    </div>

    <h2>PHOTO DREAM</h2>
		<div id="insertPhotoContainer"></div>
	</section>

<!-- 모달창 모달창 모달창 모달창 모달창 모달창 모달창 모달창 모달창 모달창 모달창 모달창 모달창 -->
<div id="photoModal" class="modalpicture" style="display: none;">
    <div class="modalpicture-content">
        <span class="closepicture" onclick="closepictureModal()">&times;</span>
        <!-- 사진 영역 -->
        <img id="modalImage" src="" alt="Selected Photo">
        <p id="modalCaption" style="margin-top: 15px; font-size: 17px;"></p>
        <p id="userName"></p>
        <!-- 로그인한 유저의 userSeq 값을 data 속성에 저장 -->
        <div id="userInfo" data-user-seq="${sessionScope.loginUser.userSeq}"></div>
        <!-- 삭제버튼 -->
        <c:choose>
			<c:when test="${sessionScope.loginUser.userSeq == 1}">
	    		<button id="deleteButton" onclick="deletePhoto()" class="btn btn-danger">삭제</button>
			</c:when>
		</c:choose>
		<!-- 다운로드버튼 -->
			<button onclick="downloadPhoto()" class="btn btn-primary">Download</button>
    </div>
</div>

</body>
</html>