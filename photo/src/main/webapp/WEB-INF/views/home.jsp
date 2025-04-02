<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<html>
<head>
    <title>Home</title>
<style>
.area-1 {
	background-image: url('resources/images/main/car.jpg');
}

.area-2 {
	background-image: url('resources/images/main/clothes.jpg');
}

.area-2-1 {
	background-image: url('resources/images/main/build.jpg');
	margin-left: 10px;
}

.area-3 {
	background-image: url('resources/images/main/tennis.jpg');
	margin-left: 10px;
}

.area-3-1 {
	background-image: url('resources/images/main/sky.jpg');
	margin-left: 20px;
}

/* SEARCH 텍스트 스타일 */

</style>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">

<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/resources/css/home.css">    
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/resources/css/search.css"> 

<script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/home.js"></script>
   
</head>
<body style="background-color: #1c1c1c;">

<!-- 헤더 영역 -->
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
		<a href="${pageContext.request.contextPath}/notice/story">Story</a>    
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

<!-- 메인 섹션 -->
<section class="section-1" style="height: 200px;">
    <div class="top">
        <div class="area-1"> 
            <div class="area1-content">
                <form id="searchForm" name="searchForm" method="POST"
                	action="${pageContext.request.contextPath}/search">
                    <div class="search-group">
	                    <input type="text" name="keyword" class="search-input" placeholder="어떤걸 찾으세요?">
                    	<span id="searchspan">SEARCH</span>
                    	<button type="submit" class="search-icon">
                            <i class="fa fa-search"></i> <!-- Font Awesome 돋보기 아이콘 -->
                        </button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</section>

<!-- 이미지 섹션 -->
<section class="section-2">
	<div class="center">
		<div class="area-2">
			<div class="area-2-write">
	        	<span>&nbsp;&nbsp;Clothes</span>
	    	</div>
	    	
		</div>
		<div class="area-2-1">
		    <div class="area-2-write">
		        <span>&nbsp;&nbsp;Traveler</span>
		    </div>
		</div>
    </div>
</section>

<section class="section-3">
    <div class="bottom">
        <div class="area-3">
        	<div class="area-3-write">
				<span>&nbsp;&nbsp;&nbsp;Sports</span>
            </div>
        </div>

        <div class="area-3-1">
        	<div class="area-3-write">
				<span>&nbsp;&nbsp;&nbsp;Dream</span>
            </div>
        </div>
    </div>
</section>

<section class="section-4">
	<div class="under">
		<div>
		
		</div>
	</div>
</section>




</body>
</html>
