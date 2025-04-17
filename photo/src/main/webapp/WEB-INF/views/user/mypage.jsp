<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<title>마이페이지</title>
<style>
/* 공통 스타일 */
body {
    font-family: Arial, sans-serif;
    background-color: #121212;
    color: #fff;
}

h1, h2, h3, h4 {
    color: white;
    margin-bottom: 20px;
}

/* 마이페이지 메인 컨테이너 */
.container-mypage {
    max-width: 750px;
    margin: 0 auto;
    padding: 30px;
    background-color: #1c1c1c;
    border-radius: 10px;
    box-shadow: 0 4px 10px rgba(0, 0, 0, 0.6);
}

/* 카드 공통 */
.card {
    background-color: #1c1c1c;
    border: 1px solid #4CAF50;
    border-radius: 12px;
    box-shadow: 0 0 10px rgba(0,0,0,0.05);
    padding: 20px;
    margin-bottom: 20px;
}

/* 프로필 카드 상단 */
.profile-card .profile-header {
    display: flex;
    align-items: center;
    justify-content: space-between;
}

.profile-img {
    width: 60px;
    height: 60px;
    border-radius: 50%;
    margin-right: 15px;
}

/* 이름, 이메일 출력 */
.profile-info h2 {
    font-size: 1.5em;
    margin: 0;
}

.profile-info .user-id {
    font-size: 0.9em;
    color: #777;
}

/* 정보 라인 */
.info-row {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-top: 10px;
    font-size: 14px;
}

/* 버튼 공통 */
.edit-btn, .confirm-btn {
    background: #f2f2f2;
    color: #000;
    border: none;
    padding: 5px 10px;
    border-radius: 6px;
    cursor: pointer;
}

/* 스위치 토글 */
.switch {
    position: relative;
    display: inline-block;
    width: 44px;
    height: 24px;
}

.switch input {
    opacity: 0;
    width: 0;
    height: 0;
}

.slider {
    position: absolute;
    cursor: pointer;
    top: 0; left: 0;
    right: 0; bottom: 0;
    background-color: #ccc;
    transition: .4s;
    border-radius: 24px;
}

.slider:before {
    position: absolute;
    content: "";
    height: 18px; width: 18px;
    left: 3px;
    bottom: 3px;
    background-color: white;
    transition: .4s;
    border-radius: 50%;
}

input:checked + .slider {
    background-color: #4caf50;
}

input:checked + .slider:before {
    transform: translateX(20px);
}

/* 사진 리스트 영역 */
.main2-2 {
    max-width: 750px;
    margin: 0 auto;
    padding: 20px;
}

.main3-2 {
    display: flex;
    justify-content: space-between;
    align-items: center;
    padding: 10px 0;
}

.main4-2 {
    display: flex;
    align-items: center;
}

.q1-3 img.img5 {
    width: 60px;
    height: 60px;
    object-fit: cover;
    border-radius: 8px;
    margin-right: 10px;
}

.q2-3 span {
    display: block;
    color: #fff;
}

.q3-3 button {
    padding: 5px 10px;
    border: none;
    background-color: #4CAF50;
    color: white;
    border-radius: 4px;
    cursor: pointer;
}

.q3-3 button:hover {
    background-color: #45a049;
}
.divider-line {
    width: 100%;
    border-bottom: 1px solid #ccc;
    margin: 5px 0;
}
</style>
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/resources/css/home.css">
	
<!-- 스크립트 링크 -->
<script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/home.js"></script>
</head>
<body>
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

<!--   <form id="mypageForm" name="mypageForm" method="POST" action="${pageContext.request.contextPath}/">   --> 
	<div class="card profile-card">
    	<div class="profile-header">
            <img src="${pageContext.request.contextPath}/resources/images/story/sajin3.jpg" class="profile-img">
            <div>
                <h3 style="text-align: left">김혁</h3>
                <p style="text-align: left">rlagur1659@naver.com</p>
            </div>
            <button class="edit-btn">실명수정</button>
        </div>
        
        <div class="divider-line"></div>
        
        <div class="info-row">
            <span>+82 10-6***-9***</span>
            <button class="edit-btn">수정</button>
        </div>
        
        <div class="divider-line"></div>
        
        <div class="info-row">
            <span>이 번호로 로그인하기</span>
            <label class="switch">
                <input type="checkbox" checked>
                <span class="slider"></span>
            </label>
        </div>
        
        <div class="divider-line"></div>
        
        <div class="info-row">
            <span>rl******@n*******.com</span>
            <button class="edit-btn">수정</button>
        </div>
        
        <div class="divider-line"></div>
        
        <div class="info-row">
            <span>ca******@n*******.com</span>
            <button class="edit-btn">수정</button>
        </div>
        <div class="divider-line"></div>
        
    </div>

    <!-- 프로모션 수신 동의 -->
    <div class="card">
        <h4>프로모션 정보수신 동의</h4>
        
        <div class="divider-line"></div>
        
        <div class="info-row">
            <span>휴대전화</span>
            <label class="switch"><input type="checkbox"><span class="slider"></span></label>
        </div>
        
        <div class="divider-line"></div>
        
        <div class="info-row">
            <span>이메일</span>
            <label class="switch"><input type="checkbox"><span class="slider"></span></label>
        </div>
        <div class="divider-line"></div>
    </div>

    <!-- 게시물 조치 알림 수신 동의 -->
    <div class="card">
        <h4>게시물 조치 알림 수신 동의</h4>
        
        <div class="divider-line"></div>
        
        <div class="info-row">
            <span>휴대전화(문자메시지)</span>
            <label class="switch"><input type="checkbox"><span class="slider"></span></label>
        </div>
        
        <div class="divider-line"></div>
        
    </div>

    <!-- 부가 정보 관리 -->
    <div class="card">
        <h4>부가 정보 관리</h4>
       
        <div class="divider-line"></div>
       
        <div class="info-row">
            <span>배송지 관리</span>
            <button class="confirm-btn">확인</button>
        </div>
        
        <div class="divider-line"></div>
        
        <div class="info-row">
            <span>개인정보 이용내역</span>
            <button class="confirm-btn">확인</button>
        </div>
        
        <div class="divider-line"></div>
    </div>

</div>
 <!--</form>   --> 

    <!--  여기가 사진 리스트 들어갈 영역 -->
    <h2 style="margin-left: 80px; color: white; margin-top: 50px;">내 사진 리스트</h2>
    <div class="main2-2">
        <c:forEach var="photo" items="${photoList}">
            <div class="main3-2">
                <div class="main4-2">
                    <div class="q1-3">
                        <img class="img5" src="${pageContext.request.contextPath}/resources/uploads/${photo.filename}">
                    </div>
                    <div class="q2-3">
                        <span style="font-size: 13px;">${photo.title}</span><br>
                        <span style="font-size: 12px; color: gray;">${photo.uploadDate}</span>
                    </div>
                </div>
                <div class="q3-3"><button onclick="location.href='<c:url value='/photo/view?num=${photo.num}'/>'">보기</button></div>
            </div>
            <hr>
        </c:forEach>
    </div>


	
	
	</body>
	</html>
	
	
	
	
