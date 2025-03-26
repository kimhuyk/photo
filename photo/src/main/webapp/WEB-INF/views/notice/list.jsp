<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<title>Notice</title>
<style>
body {
	background-color: #1c1c1c;
	color: white;
	font-family: Arial, sans-serif;
}

.notice-container {
	width: 80%;
	margin: 50px auto;
	background: #2c2c2c;
	padding: 20px;
	border-radius: 8px;
}

.notice-title {
	font-size: 24px;
	font-weight: bold;
	text-align: left;
	border-bottom: 2px solid #4CAF50;
	padding-bottom: 10px;
}

.search-box {
	text-align: right;
	margin-bottom: 10px;
	margin-top: 10px;
}

.search-box input {
	padding: 5px;
	width: 200px;
	border: 1px solid #ccc;
	border-radius: 4px;
}

.search-box button {
	padding: 6px 10px;
	background-color: #4CAF50;
	color: white;
	border: none;
	border-radius: 4px;
	cursor: pointer;
}

/* ✅ ul li 공지사항 리스트 스타일 */
.notice-list {
	list-style: none;
	padding: 0;
}

.notice-list li {
	display: flex;
	justify-content: space-between;
	align-items: center;
	padding: 12px;
	border-bottom: 1px solid #444;
	font-size: 18px;
}

.notice-list li a {
	text-decoration: none;
	color: white;
	flex-grow: 1;
}

.notice-list li a:hover {
	color: #white;
	font-weight: bold; /* 🔹 강조 */
}

.notice-separator {
	flex-grow: 1;
	text-align: center;
	color: #777;
}

.notice-date {
	color: #bbb;
	font-size: 18px;
}

.notice-list li:hover {
	background-color: #555;
}

.page-navigation {
    text-align: center; /* 가운데 정렬 */
    margin-top: 20px; /* 위쪽 여백 */
    font-size: 20px; /* 글씨 크기 키움 */
}

.page-navigation .no-notice {
    color: white; /* 텍스트 흰색 */
    font-weight: bold;
    padding: 10px 15px;
    display: inline-block;
    background: rgba(255, 255, 255, 0.2); /* 투명한 흰색 느낌 */
    border: 1px solid white;
    border-radius: 5px;
}

/* 기본 페이지 버튼 스타일 */
.page-navigation a {
    color: white; /* 기본 텍스트 색 */
    text-decoration: none; /* 밑줄 제거 */
    padding: 8px 12px;
    margin: 1px 6px; /* 숫자 간격을 더 넓게 */
    display: inline-block;
    transition: all 0.3s ease-in-out;
    border-radius: 50%; /* 원형으로 만들기 */
    background-color: transparent; /* 배경색 제거 */
}

/* 페이지 버튼 hover 효과 */
.page-navigation a:hover {
    background: rgba(255, 255, 255, 0.3); /* 배경을 살짝 하얗게 */
    color: white; /* 텍스트 색상 유지 */
    transform: scale(1.1); /* 크기 살짝 커짐 */
}

/* prev, next 버튼을 강조하고 크기 조정 */
.page-navigation .prev-page,
.page-navigation .next-page {
    padding: 6px 12px;
    font-size: 18px;
    border-radius: 50%;
    transition: background-color 0.3s ease, transform 0.3s ease;
    background-color: transparent; /* 배경색 제거 */
}

.page-navigation .prev-page:hover, .page-navigation .next-page:hover {
    background: rgba(255, 255, 255, 0.3); /* hover 시 배경 색상 */
    transform: scale(1.1); /* hover 시 크기 살짝 커짐 */
}

/* 현재 페이지 스타일 (원형 강조) */
.page-navigation .active {
    background: white;
    color: black;
    font-weight: bold;
    padding: 8px 12px;
    border-radius: 50%;
}

/* prev와 next 버튼을 숫자들 양옆에 배치 */
.page-navigation .prev-page {
    margin-right: 15px; /* 이전 버튼과 숫자 사이 간격 */
}

.page-navigation .next-page {
    margin-left: 15px; /* 다음 버튼과 숫자 사이 간격 */
}

/* 숫자 페이지를 감싸는 영역 */
.page-navigation .page-numbers {
    display: inline-block;
    margin: 0 15px; /* 숫자들 간격 */
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

	<!--  여기부터 notice jsp 화면단 만들기 -->
	<div class="notice-container">
	    <div class="notice-title">📢 공지사항</div>
	    
	    <div class="search-box">
	        <input type="text" id="searchInput" placeholder="제목, 내용">
	        <button onclick="searchNotice()">검색</button>
	    </div>
	
	    <ul class="notice-list">
	        <c:choose>
	            <c:when test="${not empty list}">
	                <c:forEach var="notice" items="${list}">
	                    <li>
	                        <a href="${articleUrl}&noticeSeq=${notice.noticeSeq}">
                            	${notice.noticeTitle}
                        	</a>
	                        <span class="notice-date">
							<span class="date">${notice.noticeRegdate}</span>
	                        </span>
	                    </li>
	                </c:forEach>
	            </c:when>
	          
	        </c:choose>
	    </ul>
	<!-- < > 누를떄마다 다음줄 11로 갈수있게 스크립트 작성 해야됌 -->
		<div class="page-navigation">
		    <!-- 이전 버튼 -->
		    <a href="${listUrl}?page=${page-1}" class="prev-page">&lt;&lt;</a>
		
		    <!-- 페이지 번호 -->
		    <div class="page-numbers">
		        ${dataCount == 0 ? "등록된 공지사항이 없습니다." : paging}
		    </div>
		
		    <!-- 다음 버튼 -->
		    <a href="${listUrl}?page=${page+1}" class="next-page">&gt;&gt;</a>
		</div>

	</div>

	<script>
function searchNotice() {
    var keyword = document.getElementById("").value.trim();
    if (keyword === "") {
        alert("검색어를 입력해주세요.");
        return;
    }
    location.href = "${pageContext.request.contextPath}/notice?search=" + encodeURIComponent(keyword);
}

</script>

