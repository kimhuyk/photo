<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<title>사진 슬라이드쇼</title>
    <style>
        body {
            font-family: Arial, sans-serif;
        }
        .gallery-container {
            text-align: center;
            margin: 20px auto;
        }
        .slideshow {
            width: 600px;
            height: 400px;
            position: relative;
            margin: auto;
            overflow: hidden;
            border: 3px solid #333;
            border-radius: 10px;
        }
        .slide {
            display: none;
            width: 100%;
            height: 100%;
        }
        .slide img {
            width: 100%;
		    height: 100%;
		    object-fit: contain; /* 이미지를 축소해서 비율 유지 */
		    background-color: black; /* 이미지가 비지 않는 부분을 검정색으로 채우기 */
        }
        .prev, .next {
            position: absolute;
            top: 50%;
            transform: translateY(-50%);
            background-color: rgba(0, 0, 0, 0.5);
            color: white;
            border: none;
            padding: 10px;
            cursor: pointer;
            font-size: 18px;
        }
        .prev { left: 10px; }
        .next { right: 10px; }
        
        /* 그리드 & 리스트 뷰 스타일 */
        .grid-view, .list-view {
            display: flex;
            flex-wrap: wrap;
            justify-content: center;
            margin-top: 20px;
        }
        .grid-view img, .list-view img {
            width: 150px;
            height: 100px;
            object-fit: cover;
            margin: 10px;
            border-radius: 5px;
            cursor: pointer;
        }
        .list-view {
            flex-direction: column;
            align-items: center;
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
        <a href="${pageContext.request.contextPath}/notice/list">Notice?</a>
        <a href="${pageContext.request.contextPath}/story/story.do">story</a>
    </div>
    <!-- 오른쪽 로그인 버튼 -->
      <div class="login-button">
        <c:choose>
            <c:when test="${not empty sessionScope.loginUser}">
                 <a href="${pageContext.request.contextPath}/mypage">
                	★${sessionScope.loginUser.userName}★님
            	</a>
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

	<!--  여기부터 story jsp 화면단 만들기 -->
	<div class="notice-container">
	    <div class="notice-title">📢 스토리만들기</div>
	    
	    <div class="gallery-container">

        <!-- 슬라이드쇼 -->
        <div class="slideshow">
            <button class="prev" onclick="changeSlide(-1)">&#10094;</button>
            <c:forEach var="image" items="${imageList}" varStatus="status">
		        <div class="slide">
		            <img src="${pageContext.request.contextPath}/resources/images/uploads/${image}" alt="사진 ${status.index}">
		        </div>
		    </c:forEach>
            <button class="next" onclick="changeSlide(1)">&#10095;</button>
        </div>

        <!-- 그리드/리스트 전환 버튼 -->
        <!-- <button onclick="toggleView('grid')">그리드 뷰</button>
        <button onclick="toggleView('list')">리스트 뷰</button> -->

        <!-- 썸네일 갤러리 -->
        <div id="galleryView" class="grid-view">
            <c:forEach var="image" items="${imageList}">
		        <img src="${pageContext.request.contextPath}/resources/images/uploads/${image}" alt="${image}"onclick="showSlide(${imageList.indexOf(image)})">
    		</c:forEach>
        </div>
        
    </div>

    <script>
	    let slides = document.querySelectorAll(".slide");
	    let currentSlide = 0;
	    let slideInterval;
	
	    function showSlide(index) {
	        slides.forEach(slide => slide.style.display = "none"); // 모든 슬라이드 숨기기
	        slides[index].style.display = "block"; // 현재 슬라이드 표시
	    }
	
	    function changeSlide(step) {
	        slides[currentSlide].style.display = "none";
	        currentSlide = (currentSlide + step + slides.length) % slides.length;
	        slides[currentSlide].style.display = "block";
	    }
	
	    function autoSlide() {
	        slideInterval = setInterval(() => {
	            changeSlide(1);
	        }, 3000); // 3초마다 변경
	    }
	
	    // DOM 로드 후 슬라이드 개수 갱신
	    document.addEventListener("DOMContentLoaded", function () {
	        slides = document.querySelectorAll(".slide"); // 슬라이드 개수 업데이트
	        if (slides.length > 0) {
	            showSlide(0);
	            autoSlide();
	        }
	    });
	    
	    /* function toggleView(viewType) {
            let gallery = document.getElementById("galleryView");
            if (viewType === 'grid') {
                gallery.className = "grid-view";
            } else {
                gallery.className = "list-view";
            }
        } */

        // 초기 슬라이드 설정 & 자동 실행
        /* showSlide(0);
        autoSlide(); */

    </script>
	</div>

<script>


</script>

