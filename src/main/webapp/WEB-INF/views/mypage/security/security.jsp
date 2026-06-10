<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<title>마이페이지</title>
<style>

</style>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/home.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/mypage.css">
<script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/home.js"></script>
</head>
<body>
<jsp:include page="/WEB-INF/views/layout/header.jsp" />
<div class="container-mypage">
	<h1>보안설정</h1>
	
	<div class="mypage-layout">
        <jsp:include page="/WEB-INF/views/mypage/sidebar.jsp"/>
        	
        	<!-- 오른쪽 메인 콘텐츠 -->
			<div class="mypage-main">
				<div class="profile-section">
                <div class="profile-info">
                    <h2>${sessionScope.loginUser.userName}님의 정보</h2>
                </div>
            </div>
				
				<div class="card">
					<h4>게시물 조치 알림 수신 동의</h4>
					<div class="info-row">
						<span>휴대전화(문자메시지)</span> <label class="switch"><input
							type="checkbox"><span class="slider"></span></label>
					</div>

					<div class="divider-line"></div>

				</div>

				<!-- 게시물 조치 알림 수신 동의 -->
				<div class="card">
					<h4>게시물 조치 알림 수신 동의</h4>
					<div class="info-row">
						<span>휴대전화(문자메시지)</span> <label class="switch"><input
							type="checkbox"><span class="slider"></span></label>
					</div>

					<div class="divider-line"></div>

				</div>

				<!-- 부가 정보 관리 -->
				<div class="card">
					<h4>부가 정보 관리</h4>
					<div class="info-row">
						<span>배송지 관리</span> <a
							href="${pageContext.request.contextPath}/delivery/list"
							class="confirm-btn">확인</a>
					</div>

					<div class="divider-line"></div>

					<div class="info-row">
						<span>개인정보 이용내역</span> <a
							href="${pageContext.request.contextPath}/mypage/privacy"
							class="confirm-btn">확인</a>
					</div>

					<div class="divider-line"></div>
				</div>
				<button style="float: right;" class="confirm-btn" type="button"
					onclick="deleteUser()">회원 탈퇴</button>
			</div>
			<!--  -->
		
























		</div>

</div>

</body>
</html>