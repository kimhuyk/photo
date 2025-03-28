<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<title>Notice</title>
<style>
button {
	padding: 6px 10px;
	background-color: #4CAF50;
	color: white;
	border: none;
	border-radius: 4px;
	cursor: pointer;
}

</style>

<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/resources/css/home.css">
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/resources/css/noticeList.css">
	
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
	    	<form name="searchForm" action="${pageContext.request.contextPath}/notice/list" method="POST">
		        <input type="text" id="searchInput" name="kwd" value="${kwd}"placeholder="제목, 내용">
		        <button type="submit">검색</button>
	        </form>
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
			 <c:if test="${sessionScope.loginUser.userSeq == 1}">
				<button class="button" type="button" style="float: right;"
					onclick="location.href='${pageContext.request.contextPath}/notice/write';">글쓰기</button>
			</c:if>
		</div>
	</div>

<script>


</script>

