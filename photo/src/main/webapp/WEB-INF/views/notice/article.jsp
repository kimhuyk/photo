<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<title>Notice</title>
<style>

</style>

<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/resources/css/home.css">
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/resources/css/noticeArticle.css">
	
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
		    <ul class="ultag">
		        <c:if test="${not empty prevDto}">
		            <li class="prev-notice">
		                이전 : <a href="${pageContext.request.contextPath}/notice/article?${query}&noticeSeq=${prevDto.noticeSeq}">
		                    ${prevDto.noticeTitle}
		                </a>
		            </li>
		        </c:if>
		
		        <c:if test="${not empty nextDto}">
		            <li class="next-notice">
		                다음 : <a href="${pageContext.request.contextPath}/notice/article?${query}&noticeSeq=${nextDto.noticeSeq}">
		                    ${nextDto.noticeTitle}
		                </a>
		            </li>
		        </c:if>
		    </ul>
		    <c:if test="${sessionScope.loginUser.userSeq == 1}">
		        <button type="button" class="delete-btn" onclick="deleteNotice(${dto.noticeSeq});">삭제하기</button>
				<button type="button" class="update-btn" onclick="updateNotice(${dto.noticeSeq});">수정하기</button>
			</c:if>
	</div>
</div>
		
<script>
function deleteNotice(noticeSeq) {
    if (confirm("공지사항을 삭제하시겠습니까?")) {
        // 현재 페이지의 컨텍스트 패스를 가져와서 삭제 URL을 만듦
        const url = '${pageContext.request.contextPath}/notice/deleteNotice?noticeSeq=' + noticeSeq + '&page=' + ${page};
        
        // 페이지 이동 방식으로 삭제 요청
        location.href = url;
    }
}


function updateNotice(noticeSeq) {
    if (!noticeSeq) {
        alert("공지사항 번호가 없습니다.");
        return;
    }
    const url = '${pageContext.request.contextPath}/notice/findbyNotice?noticeSeq=' + noticeSeq;
    location.href = url;
}
</script>
</body>
</html>