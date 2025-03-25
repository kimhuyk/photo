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
        <img src="resources/images/logo/logo.png" alt="Logo" 
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
	            <c:when test="${not empty noticeList}">
	                <c:forEach var="notice" items="${noticeList}">
	                    <li>
	                        <a href="${pageContext.request.contextPath}/notice/view?id=${notice.id}">
	                            ${notice.title}
	                        </a>
	                        <span class="notice-separator">ㅇㅇ</span>
	                        <span class="notice-date">
	                            <fmt:formatDate value="${notice.date}" pattern="yyyy-MM-dd"/>
	                        </span>
	                    </li>
	                </c:forEach>
	            </c:when>
	            <c:otherwise>
	                <!-- 더미 데이터 -->
	                <li>
	                    <a href="#">Photo 검색 중단 오류를 알려드립니다 어쩌구저쩌구입니다~ </a>
	                    <span class="notice-date">2024-03-25</span>
	                </li>
	                 <li>
	                    <a href="#">Photo 검색 중단 오류를 알려드립니다 어쩌구저쩌구입니다~ </a>
	                    <span class="notice-date">2024-03-26</span>
	                </li>
	                 <li>
	                    <a href="#">Photo 검색 중단 오류를 알려드립니다 어쩌구저쩌구입니다~ </a>
	                    <span class="notice-date">2024-03-25</span>
	                </li>
	                 <li>
	                    <a href="#">Photo 검색 중단 오류를 알려드립니다 어쩌구저쩌구입니다~ </a>
	                    <span class="notice-date">2024-03-25</span>
	                </li>
	                 <li>
	                    <a href="#">Photo 검색 중단 오류를 알려드립니다 어쩌구저쩌구입니다~ </a>
	                    <span class="notice-date">2024-03-25</span>
	                </li>
	                 <li>
	                    <a href="#">Photo 검색 중단 오류를 알려드립니다 어쩌구저쩌구입니다~ </a>
	                    <span class="notice-date">2024-03-25</span>
	                </li>
	            </c:otherwise>
	            
	        </c:choose>
	    </ul>

		<div class="page-navigation">${dataCount == 0 ? "등록된 게시물이 없습니다." : paging}
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

