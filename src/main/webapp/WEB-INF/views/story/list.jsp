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
<jsp:include page="/WEB-INF/views/layout/header.jsp" />
</head>
<body style="background-color: #1c1c1c;">
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

