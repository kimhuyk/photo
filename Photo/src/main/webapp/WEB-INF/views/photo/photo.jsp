<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<title>Photo</title>
	<style>
		body {
	font-family: Arial, sans-serif;
}

.gallery-container {
	text-align: center;
	margin: 20px auto;
}

.slideshow {
	width: 800px;
	height: 600px;
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

.prev {
	left: 10px;
}

.next {
	right: 10px;
}

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
<!-- CSS 링크 -->
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/resources/css/login.css">
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/resources/css/photo.css">
<%-- <link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/resources/css/photoStory.css"> --%>

<script type="text/javascript">
    var contextPath = "${pageContext.request.contextPath}";
</script>	
<!-- 스크립트 링크 -->
<script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/home.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/photo.js"></script>
<jsp:include page="/WEB-INF/views/layout/header.jsp" />
</head>
<body style="background-color: #1c1c1c;">>
<!-- 사진 리스트 영역 (아래로 이동됨) -->
 <section class="gallery-container">
    <h1>PHOTO GALLERY</h1>

    <!-- 다운로드 폼 (한 개만 선언) -->
    <form id="downloadForm" action="download" method="GET">
        <input type="hidden" name="fileNum" id="fileNum">
    </form>

    <!-- 첫 번째 행 -->
    <div class="photo-grid">
        <figure class="photo-item" onclick="openpictureModal(1, 'resources/images/main/car.jpg', 'Car Pictures', '김혁')">
            <img src="resources/images/main/car.jpg" alt="Car Pictures">
            <figcaption class="caption">Car Pictures</figcaption>
        </figure>
        <figure class="photo-item" onclick="openpictureModal(2, 'resources/images/main/clothes.jpg', 'Clothes Pictures', '김혁')">
            <img src="resources/images/main/clothes.jpg" alt="Clothes Pictures">
            <figcaption class="caption">Clothes Pictures</figcaption>
        </figure>
        <figure class="photo-item" onclick="openpictureModal(3, 'resources/images/main/build.jpg', 'Build Pictures', '김혁')">
            <img src="resources/images/main/build.jpg" alt="Build Pictures">
            <figcaption class="caption">Build Pictures</figcaption>
        </figure>
    </div>

    <!-- 두 번째 행 -->
    <div class="photo-grid">
        <figure class="photo-item" onclick="openpictureModal(4, 'resources/images/main/tennis.jpg', 'Tennis Pictures', '김혁')">
            <img src="resources/images/main/tennis.jpg" alt="Tennis Pictures">
            <figcaption class="caption">Tennis Pictures</figcaption>
        </figure>
        <figure class="photo-item" onclick="openpictureModal(5, 'resources/images/main/chair.jpg', 'Chair Pictures', '김혁')">
            <img src="resources/images/main/chair.jpg" alt="Chair Pictures">
            <figcaption class="caption">Chair Pictures</figcaption>
        </figure>
        <figure class="photo-item" onclick="openpictureModal(6, 'resources/images/main/sky.jpg', 'Sky Pictures', '김혁')">
            <img src="resources/images/main/sky.jpg" alt="Sky Pictures">
            <figcaption class="caption">Sky Pictures</figcaption>
        </figure>
        
	
    </div>
         <h2>PHOTO DREAM</h2>
		<div id="insertPhotoContainer"></div>
	
	<br><br><br><br>
	<!-- 세 번째 행 -->
		<div id="insertPhotoContainer"></div>
    <div class="slideshow">
    	<button class="prev" onclick="changeSlide(-1)">&#10094;</button>
    	<c:forEach var="image" items="${imageList}" varStatus="status">
			<div class="slide">
				<img src="${pageContext.request.contextPath}/resources/images/uploads/${image}" alt="사진 ${status.index}">
			</div>
		</c:forEach>
    	<button class="next" onclick="changeSlide(1)">&#10095;</button>
    </div>

    <!-- 썸네일 갤러리 -->
    <div id="galleryView" class="grid-view">
    	<c:forEach var="image" items="${imageList}">
		<img src="${pageContext.request.contextPath}/resources/images/uploads/${image}" alt="${image}"onclick="showSlide(${imageList.indexOf(image)})">
    	</c:forEach>
    </div>	

</section>

<!-- 모달창 모달창 모달창 모달창 모달창 모달창 모달창 모달창 모달창 모달창 모달창 모달창 모달창 -->
<div id="photoModal" class="modalpicture" style="display: none;">
    <div class="modalpicture-content">
        <span class="closepicture" onclick="closepictureModal()">&times;</span>
        <!-- 사진 영역 -->
        <img id="modalImage" src="" alt="Selected Photo">
        <p id="modalCaption" style="margin-top: 15px; font-size: 17px;"></p>
        <p id="userName"></p>
        <!-- 로그인한 유저의 userSeq 값을 data 속성에 저장 -->
        <div id="userInfo" data-user-seq="${sessionScope.loginUser.userSeq}"></div>
        <!-- 삭제버튼 -->
        <c:choose>
			<c:when test="${sessionScope.loginUser.userSeq == 1}">
	    		<button id="deleteButton" onclick="deletePhoto()" class="btn btn-danger">삭제</button>
			</c:when>
		</c:choose>
		<!-- 다운로드버튼 -->
			<button onclick="downloadPhoto()" class="btn btn-primary">Download</button>
    </div>
</div>
	<script>
	// photo 밑단 사진 자동 넘기기
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

</body>

</html>