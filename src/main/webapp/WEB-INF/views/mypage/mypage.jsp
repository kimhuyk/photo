<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<title>마이페이지</title>
<style>

</style>
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/resources/css/home.css">
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/resources/css/mypage.css">
	
<!-- 스크립트 링크 -->
<script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/home.js"></script>
<jsp:include page="/WEB-INF/views/layout/header.jsp" />
</head>
<body>

<div class="container-mypage">
    <h1>마이페이지</h1>

    <!-- 통합 레이아웃 -->
    <div class="mypage-layout">
        <!-- 왼쪽 사이드바 -->
        <div class="mypage-sidebar">
            <!-- photo ID 로고 -->
            <div class="sidebar-header">
                <div class="photo-logo">
                    <span class="logo-text">P</span>
                    <span class="logo-title">photoID</span>
                </div>
            </div>

            <!-- 프로필 섹션 -->
            <div class="profile-section">
                <div class="profile-image-container">
                    <img src="${pageContext.request.contextPath}/resources/images/story/sajin3.jpg" alt="프로필" class="profile-image">
                    <div class="edit-icon">✏️</div>
                </div>
                <div class="profile-info">
                    <div class="nickname">${sessionScope.loginUser.userName}</div>
                    <div class="email">${sessionScope.loginUser.email}</div>
                </div>
                <button class="passkey-btn">
                    <span class="new-tag">NEW</span>
                    비밀번호 대신 패스키 로그인
                </button>
                <div class="passkey-desc">지문, 얼굴인식으로 간편하게 로그인하세요.</div>
            </div>

            <!-- 네비게이션 메뉴 -->
            <nav class="sidebar-nav">
                <a href="#" class="nav-item active">
                    <span class="nav-icon">◆</span>
                    내프로필
                </a>
                <a href="#" class="nav-item">
                    <span class="nav-icon">◆</span>
                    보안설정
                </a>
                <a href="#" class="nav-item">
                    <span class="nav-icon">◆</span>
                    이력관리
                </a>
                
                <div class="nav-divider"></div>
                
                <a href="#" class="nav-item">
                    <span class="nav-icon">◆</span>
                    스마트봇 상담
                </a>
                <a href="#" class="nav-item">
                    <span class="nav-icon">◆</span>
                    회원톡톡
                </a>
            </nav>

            <!-- 프로모션 배너 -->
            <div class="promo-banner">
                <div class="banner-content">
                    <div class="banner-icon">🔔</div>
                    <div class="banner-text">
                        새벽 4시에 로그인?<br>
                        2단계 인증, 늦기 전에 미리 설정!
                    </div>
                </div>
            </div>

            <!-- 하단 링크 -->
            <div class="bottom-links">
                <a href="#" class="bottom-link">로그아웃</a>
                <span class="separator">|</span>
                <a href="#" class="bottom-link">고객센터</a>
                <span class="separator">|</span>
                <a href="#" class="bottom-link">한국어</a>
            </div>

            <!-- 하단 로고 -->
            <div class="bottom-logo">
                <span class="photo-text">Photo</span>
            </div>
        </div>

        <!-- 오른쪽 메인 콘텐츠 -->
        <div class="mypage-main">
            <div class="profile-section">
                <div class="profile-info">
                    <h2>${sessionScope.loginUser.userName}님의 정보</h2>
                </div>
            </div>

<!-- 회원정보 -->
  <form id="pwdForm" name="pwdForm" method="POST" action="${pageContext.request.contextPath}/user/pwd"> 
	<div class="card profile-card">
    	<div class="profile-header">
            <img src="${pageContext.request.contextPath}/resources/images/story/sajin3.jpg" class="profile-img">
            <div>
                <h3 style="text-align: left">${sessionScope.loginUser.userName}</h3>
            </div>
			<a href="${pageContext.request.contextPath}/user/pwd" class="edit-btn">수정</a>       
		</div>
		
        <div class="info-row">
            <span class="masked-char">📱${sessionScope.loginUser.tel}</span>
            <!-- <button class="edit-btn">수정</button> -->
        </div>
        
        <div class="info-row">
            <span>이 번호로 로그인하기</span>
            <label class="switch">
                <input type="checkbox" checked>
                <span class="slider"></span>
            </label>
        </div>
        
        <div class="divider-line"></div>
        
        <div class="info-row">
            <span class="masked-char">${sessionScope.loginUser.email}</span>
        </div>
        	<div class="divider-line"></div>  
    </div>
</form>
    <!-- 프로모션 수신 동의 -->
    <div class="card">
        <h4>프로모션 정보수신 동의</h4>
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
        <div class="info-row">
            <span>휴대전화(문자메시지)</span>
            <label class="switch"><input type="checkbox"><span class="slider"></span></label>
        </div>
        
        <div class="divider-line"></div>
        
    </div>

    <!-- 부가 정보 관리 -->
    <div class="card">
        <h4>부가 정보 관리</h4>
        <div class="info-row">
            <span>배송지 관리</span>
            <a href="${pageContext.request.contextPath}/delivery/list" class="confirm-btn">확인</a>
        </div>
        
        <div class="divider-line"></div>
        
        <div class="info-row">
            <span>개인정보 이용내역</span>
            <a href="${pageContext.request.contextPath}/mypage/privacy" class="confirm-btn">확인</a>
        </div>
        
        <div class="divider-line"></div>
    </div>
    <button style="float: right;" class="confirm-btn" type="button" onclick="deleteUser()">회원 탈퇴</button>
</div>

</div></div>	
<script>
function deleteUser() {
    if (confirm("정말 회원 탈퇴를 하시겠습니까? 탈퇴하시면 모든 정보가 삭제됩니다.")) {
        $.ajax({
            url: '${pageContext.request.contextPath}/user/delete',
            type: 'POST',
            success: function(response) {
                console.log("회원 탈퇴 요청 성공. 페이지 이동 중...");
                alert("회원 탈퇴되었습니다.");
                location.href = '${pageContext.request.contextPath}/user/complete';
            },
            error: function(xhr, status, error) {
                alert("회원 탈퇴 중 오류가 발생했습니다. 다시 시도해주세요.");
                console.error("회원 탈퇴 요청 실패:", status, error);
                console.error("서버 응답:", xhr.responseText);
            }
        });
    } else {
        alert("회원 탈퇴가 취소되었습니다.");
    }
}



</script>
	
</body>
</html>
	
	
	
	
