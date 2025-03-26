<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<title>Notice</title>
<style>
.notice-container {
	width: 80%;
	margin: 50px auto;
	background: #2c2c2c;
	padding: 20px;
	border-radius: 8px;
	color: white;
}

.notice-top {
	font-size: 24px;
    text-align: center;
    padding-bottom: 10px;
    border-bottom: 2px solid #444;
}

.notice-title {
    font-size: 24px;
    font-weight: bold;
    text-align: center;
    margin-bottom: 5px;
}

.notice-meta {
    font-size: 20px;
    color: #bbb;
    text-align: right;
    margin-bottom: 15px;
}

.notice-content {
    font-size: 21px;
    line-height: 1.6;
    color: #ddd;
    padding: 15px;
    background-color: #3c3c3c;
    border-radius: 5px;
    margin-top: 10px;
}

.separator {
    border-top: 2px solid #444;
    margin: 20px 0;
}

.notice-navigation {
    margin-top: 20px;
    text-align: left;
}

.notice-navigation div {
    font-size: 20px;  /* 글씨 크기 */
    font-weight: bold;
    color: white;
    display: flex;
    align-items: center;
}

.notice-navigation a {
    color: #ffcc00;
    text-decoration: none;
    margin-left: 5px;
}

.notice-navigation a:hover {
    text-decoration: underline;
}
</style>

<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/resources/css/home.css">
	
	
<!-- 스크립트 링크 -->
<script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/home.js"></script>
</head>
<body style="background-color: #1c1c1c;">
<header class="header-top">
	<!-- 왼쪽 로고 -->
    <div class="logo">
        <img src="${pageContext.request.contextPath}/resources/images/logo/logo.png" alt="Logo" 
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

	<!--  여기부터 notice 글보기 화면단 만들기 -->
		<div class="notice-container">
		    <div class="notice-top">${dto.noticeTitle}</div>
		    <div class="notice-meta">${dto.noticeRegdate}</div>
		
		    <div class="notice-separator"></div>
		
		    <div class="notice-content">
		        ${dto.noticeContents}
		    </div>
		
		    <div class="notice-separator"></div>
		
        	<div class="notice-navigation">
			    <c:if test="${not empty prevDto}">
			        <div class="prev-notice">
			            이전 : <a href="${pageContext.request.contextPath}/notice/article?${query}&noticeSeq=${prevDto.noticeSeq}">
			                ${prevDto.noticeTitle}
			            </a>
			        </div>
			    </c:if>
			
			    <c:if test="${not empty nextDto}">
			        <div class="next-notice">
			            다음 : <a href="${pageContext.request.contextPath}/notice/article?${query}&noticeSeq=${nextDto.noticeSeq}">
			                ${nextDto.noticeTitle}
			            </a>
			        </div>
			    </c:if>
			</div>
		</div>
</body>
</html>