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
	href="${pageContext.request.contextPath}/resources/css/noticeWrite.css">	
	
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
		
		<!-- 여기부터 글쓰기 jsp -->
		
		<div class="notice-write-container">
		    <h3 class="notice-write-title">| 공지사항 작성</h3>
		    <form class="notice-write-form" id="insertForm" name="insertForm" method="POST" 
		    	action="${pageContext.request.contextPath}/notice/write">
		    	
		        <table>
		            <tr>
		                <td><label for="noticeTitle">제목</label></td>
		                <td><input type="text" id="noticeTitle" name="noticeTitle"></td>
		            </tr>
		            <tr>
		                <td><label for="userName">작성자</label></td>
		                <td><input type="text" id="userName" name="userName" value="${sessionScope.loginUser.userName}" readonly></td>
		            </tr>
		            <tr>
		                <td><label for="boardContents">내용</label></td>
		                <td><textarea id="noticeContents" name="noticeContents"></textarea></td>
		            </tr>
		        </table>
		

		            <div class="notice-write-buttons">
		                <button type="submit" class="submit-btn">등록하기</button>
		                <button type="button" class="cancel-btn" onclick="location.href='${pageContext.request.contextPath}/notice/list';">등록취소</button>
		            </div>

		    </form>
		</div>

		
</body>
</html>