<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<title>회원가입</title>
<style>
.id_ok{
color:#008000;
display: none;
}

.id_already{
color:#6A82FB; 
display: none;
}
</style>
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/resources/css/user.css"> 
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/resources/css/home.css">

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/user.js"></script>

</head>
<body>
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
        <a href="${pageContext.request.contextPath}/home">Notice?</a>
        <a href="${pageContext.request.contextPath}/story/story.do">Story</a>
		</div>

		<!-- 오른쪽 로그인 버튼 -->
		<div class="login-button">
			<c:choose>
				<c:when test="${not empty sessionScope.loginUser}">
					<!-- 로그인된 사용자의 ID 표시 -->
					<span>${sessionScope.loginUser.userName}</span>
				</c:when>
				<c:otherwise>
					<!-- 로그인되지 않은 경우 로그인 버튼 -->
					<a type="button" onclick="openModal()">Login</a>
				</c:otherwise>
			</c:choose>
		</div>
	</header>

<div class="features-1">
    <div class="body-container">
        <form id="userForm" name="userForm" method="POST" action="${pageContext.request.contextPath}/user/user">
            <div class="user-group">
                <label for="userId">아이디</label>
                <input type="text" id="userId" name="userId" placeholder="아이디 입력" onchange="checkId()">
                <span class="userId_ok" style="display:none;">사용 가능한 아이디입니다.</span>
				<span class="userId_already" style="display:none; color: red;">누군가 이 아이디를 사용하고 있어요.</span>                
            </div>

            <div class="user-group">
                <label for="userPwd">패스워드</label>
                <input type="password" id="userPwd" name="userPwd" autocomplete="off" placeholder="패스워드">
                <small class="password-check">패스워드는 5~10자이며 하나 이상의 숫자나 특수문자가 포함되어야 합니다.</small>
            </div>

            <div class="user-group">
                <label for="userPwd2">패스워드 확인</label>
                <input type="password" name="userPwd2" id="userPwd2" class="form-control" autocomplete="off" placeholder="패스워드 확인">
                <small class="form-control-plaintext">패스워드를 한번 더 입력해주세요.</small>
            </div>

            <div class="user-group">
                <label for="userName">이름</label>
                <input type="text" name="userName" id="userName" class="form-control" placeholder="이름">
            </div>


            <div class="user-group">
			    <label for="email">이메일</label>
			    <input type="text" name="email" class="form-control" maxlength="60" placeholder="예: example@naver.com" value="${dto.email}" required>
			</div>
			
			<div class="user-group">
			    <label for="tel">전화번호</label>
			    <input type="text" name="tel" id="tel" class="form-control" maxlength="13" placeholder="010-1234-5678" required>
			</div>

            <div class="user-group">
                <label for="birth">생년월일</label>
                <input type="date" name="birth" id="birth" placeholder="생년월일">
                <small class="form-control-plaintext">생년월일은 2000-01-01 형식으로 입력합니다.</small>
            </div>
            <button type="button" onclick="userOk();">회원 가입</button>
        </form>
    </div>
</div>


</body>
</html>