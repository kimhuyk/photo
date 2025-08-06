<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>배송지 관리</title>
<style>

</style>
<link rel="stylesheet" type="text/css" 
	href="${pageContext.request.contextPath}/resources/css/delivery.css">
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
        <a href="${pageContext.request.contextPath}/notice/list">Notice?</a>
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
<body>
    <!-- 메인 콘텐츠 -->
    <div class="container-delivery">
        <h1 class="main-title">배송지 관리</h1>
        
        <!-- 탭 네비게이션 -->
        <div class="tab-container">
            <button class="tab-button active" onclick="showTab('list')">배송지 목록</button>
            <button class="tab-button" onclick="showTab('recent')">최근 배송지</button>
        </div>

        <!-- 탭 콘텐츠 -->
        <div class="tab-content">
            <!-- 배송지 목록 탭 -->
            <div id="list" class="tab-panel active">
                <div class="address-list">
                    <!-- 등록된 배송지가 없을 때 -->
                    <div class="empty-state">
                        <div class="empty-icon">📦</div>
                        <div class="empty-message">배송지를 등록해주세요</div>
                        <div class="empty-desc">첫 번째 배송지를 등록하시면 여기에 표시됩니다.</div>
                    </div>
                    
                    <!-- 예시 배송지 (숨김 처리) -->
                    <div class="address-item example-address" style="display: none;">
                        <div class="address-info">
                            <div class="address-header">
                                <span class="address-name">우리집</span>
                                <span class="default-tag">기본배송지</span>
                            </div>
                            <div class="address-phone">010-1234-5678</div>
                            <div class="address-detail">
                                서울시 강남구 테헤란로 123
                            </div>
                        </div>
                        <div class="address-actions">
                            <button class="action-btn delete-btn">삭제</button>
                            <button class="action-btn edit-btn">수정</button>
                        </div>
                    </div>
                </div>
                
                <!-- 정보 메시지 -->
                <div class="info-message">
                    <span class="info-icon">ℹ️</span>
                    배송지는 최대 15개까지 등록하실 수 있습니다.
                </div>
            </div>

            <!-- 최근 배송지 탭 -->
            <div id="recent" class="tab-panel">
                <div class="empty-state">
                    <div class="empty-icon">🕒</div>
                    <div class="empty-message">최근 배송지가 없습니다</div>
                    <div class="empty-desc">배송지를 등록하고 사용하시면 최근 배송지에 표시됩니다.</div>
                </div>
            </div>
        </div>

        <!-- 배송지 등록 버튼 -->
        <div class="register-section">
            <button class="register-btn" onclick="addAddress()">배송지 등록</button>
        </div>
    </div>

    <script>
        function showTab(tabName) {
            // 모든 탭 버튼에서 active 클래스 제거
            document.querySelectorAll('.tab-button').forEach(button => {
                button.classList.remove('active');
            });
            
            // 모든 탭 패널 숨기기
            document.querySelectorAll('.tab-panel').forEach(panel => {
                panel.classList.remove('active');
            });
            
            // 클릭된 탭 버튼에 active 클래스 추가
            event.target.classList.add('active');
            
            // 해당 탭 패널 보이기
            document.getElementById(tabName).classList.add('active');
        }

        function addAddress() {
            alert('배송지 등록 기능이 개발 중입니다.');
            // 실제로는 배송지 등록 페이지로 이동하거나 모달을 띄움
        }
    </script>
</body>
</html>