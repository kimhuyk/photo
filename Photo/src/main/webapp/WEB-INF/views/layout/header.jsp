<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<style>
.header-top {
    background-color: black;
    display: flex;
    justify-content: space-between;
    align-items: center;
    padding: 10px 20px;
    position: relative; /* 추가 */
}

.logo img {
	cursor: pointer;
	height: 40px; /* 로고 크기 조정 */
}

.nav-items {
    display: flex;
    justify-content: center;
    gap: 20px;
    position: absolute;
    left: 50%;
    transform: translateX(-50%);
    top: 23px;  /* 기존보다 더 아래로 */
}

.nav-items a, .login-button a {
	color: white;
	text-decoration: none;
	font-size: 18px;
}

.login-button {
	display: flex;
	justify-content: flex-end;
}
/* 로그인 모달창 */
.modal {
	position: fixed;
	top: 0;
	left: 0;
	width: 100%;
	height: 100%;
	background: rgba(0, 0, 0, 0.6); /* 어두운 배경 */
	display: flex;
	justify-content: center;
	align-items: center;
	z-index: 9999; /* 최상위 레이어 */
}

/* 모달 내부 스타일 */
.modal-content {
	background-color: black; /* 검은색 배경 */
	color: white; /* 하얀색 글씨 */
	padding: 40px;
	width: 400px; /* 크기 키움 */
	border-radius: 10px;
	text-align: center;
	box-shadow: 0px 4px 10px rgba(255, 255, 255, 0.3); /* 살짝 빛나는 효과 */
	position: relative; /* 중앙 정렬을 유지하기 위한 설정 */
}

/* 닫기 버튼 스타일 */
.close {
	position: absolute;
	top: 10px;
	right: 15px;
	font-size: 28px;
	font-weight: bold;
	cursor: pointer;
	color: white;
}

/* 로그인 제목 (h2) 스타일 */
.modal-content h2 {
	font-size: 24px;
	margin-bottom: 20px;
}

/* 입력 필드 스타일 */
.modal-content input {
	width: 90%;
	padding: 12px;
	margin: 10px 0;
	background-color: #333;
	border: none;
	border-radius: 5px;
	color: white;
	font-size: 16px;
	text-align: center;
}

/* 로그인 버튼 스타일 */
.modal-content button {
	width: 100%;
	padding: 12px;
	background-color: white;
	color: black;
	font-weight: bold;
	border: none;
	border-radius: 5px;
	cursor: pointer;
	font-size: 24px;
	margin-top: 20px;
}

.modal-content button:hover {
	background-color: gray;
}
</style>
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
