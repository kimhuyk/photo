<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<title>마이페이지</title>
<style>
/* 추가된 마이페이지 CSS (적당한 스타일) */
.container-mypage {
    background-color: #fff;
    padding: 30px;
    margin: 30px auto; /* 가운데 정렬 */
    border-radius: 8px;
    box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
    width: 80%;
    max-width: 700px; /* 최대 너비 조정 */
}

.container-mypage h1 {
    color: #333;
    text-align: center;
    margin-bottom: 30px;
}

.profile-section {
    display: flex;
    align-items: center;
    margin-bottom: 20px;
    padding-bottom: 20px;
    border-bottom: 1px solid #eee;
}

.profile-image {
    width: 80px;
    height: 80px;
    border-radius: 50%;
    overflow: hidden;
    margin-right: 20px;
    border: 2px solid #ddd;
}

.profile-image img {
    width: 100%;
    height: 100%;
    object-fit: cover;
}

.profile-info h2 {
    color: #333;
    margin-top: 0;
    margin-bottom: 5px;
    font-size: 1.5em;
}

.profile-info .user-id {
    color: #777;
    font-size: 0.9em;
}

.info-list {
    margin-bottom: 25px;
}

.info-item {
    display: flex;
    padding: 8px 0;
    border-bottom: 1px solid #f0f0f0;
    align-items: center; /* 라벨과 내용 가운데 정렬 */
}

.info-item label {
    font-weight: bold;
    width: 100px; /* 라벨 너비 고정 */
    color: #555;
    margin-right: 15px;
}

.info-item div {
    color: #333;
    flex-grow: 1; /* 남은 공간 모두 차지 */
}

.info-item:last-child {
    border-bottom: none;
}

.action-buttons {
    display: flex;
    gap: 10px;
    justify-content: center;
}

.action-buttons button, .action-buttons a.button {
    padding: 10px 15px;
    border: none;
    border-radius: 5px;
    cursor: pointer;
    font-size: 0.9em;
    text-decoration: none;
    text-align: center;
    transition: background-color 0.3s ease;
}

.action-buttons button {
    background-color: #007bff;
    color: white;
}

.action-buttons button:hover {
    background-color: #0056b3;
}

.action-buttons a.button {
    background-color: #28a745;
    color: white;
}

.action-buttons a.button:hover {
    background-color: #1e7e34;
}

.action-buttons button.secondary {
    background-color: #6c757d;
    color: white;
}

.action-buttons button.secondary:hover {
    background-color: #545b62;
}

.action-buttons button.danger {
    background-color: #dc3545;
    color: white;
}

.action-buttons button.danger:hover {
    background-color: #c82333;
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
        <a href="${pageContext.request.contextPath}/story/story.do">story</a>
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
	
	<div class="container-mypage">
    <h1>마이페이지</h1>

    <div class="profile-section">
        <div class="profile-info">
            <h2>${sessionScope.loginUser.userName}님의 정보</h2>
            
        </div>
    </div>

    <form id="mypageForm" name="mypageForm" method="POST" 
    	action="${pageContext.request.contextPath}/"> 
        <div class="info-list">
 
            <div class="info-item">
                <label for="mypageUserId">아이디</label>

                <input type="text" id="mypageUserId" name="userId" value="${user.userId}" readonly>
            </div>


            <div class="info-item">
                <label for="mypageUserName">이름</label>
                <input type="text" id="mypageUserName" name="userName" value="${user.userName}">
            </div>


            <div class="info-item">
                <label for="mypageEmail">이메일</label>
                <input type="email" id="mypageEmail" name="email" value="${user.email}" placeholder="예: example@naver.com">
            </div>


            <div class="info-item">
                <label for="mypageTel">연락처</label>
                <input type="tel" id="mypageTel" name="tel" value="${user.tel}" placeholder="010-1234-5678" pattern="[0-9]{3}-[0-9]{3,4}-[0-9]{4}">
            </div>


            <div class="info-item">
                <label for="mypageBirth">생년월일</label>

                <fmt:formatDate value="${user.birth}" pattern="yyyy-MM-dd" var="birthDateStr" />
                <input type="date" id="mypageBirth" name="birth" value="${birthDateStr}">
            </div>


            <div class="info-item">
                <label>가입일</label>

                <div class="display-value"><fmt:formatDate value="${user.regDate}" pattern="yyyy-MM-dd HH:mm:ss"/></div>
            </div>
        </div>

        <div class="action-buttons">

            <button type="submit">정보 수정</button>

            <button type="button" onclick="location.href='<c:url value="/member/changePassword"/>'" class="secondary">비밀번호 변경</button>

            <a href="<c:url value="/photo/myList?userId=${user.userId}"/>" class="button">내 사진 보기</a>

            <button type="button" onclick="location.href='<c:url value="/member/logout"/>'" class="danger">로그아웃</button>
        </div>
    </form> 
</div>

	
	
	</body>
	</html>
	
	
	
	
