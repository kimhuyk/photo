<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>무지개호텔</title>
</head>
<link rel="stylesheet" type="text/css"
    href="${pageContext.request.contextPath}/resources/css/hotel.css">
<body>
    <!-- =======================
         메인 비주얼(해변 영상, 호텔명, 예약버튼)
    ======================== -->
    <header class="main-visual">
        <video autoplay loop muted playsinline class="bg-video">
            <source src="https://www.w3schools.com/howto/sea.mp4" type="video/mp4">
            <!-- 대체 이미지 -->
        </video>
            <img style="margin-right: 15%;" src="https://images.unsplash.com/photo-1507525428034-b723cf961d3e?auto=format&fit=crop&w=1200&q=80" alt="해변 배경">
        <div class="visual-content">
            <h1>무지개호텔</h1>
            <button class="reserve-btn">예약하기</button>
        </div>
    </header>

    <!-- =======================
         객실 안내 섹션
    ======================== -->
    <section id="rooms" class="section rooms">
        <h2>객실 안내</h2>
        <div class="room-gallery">
            <!-- 객실 카드들 -->
            <div class="room">
                <img src="https://images.unsplash.com/photo-1512918728675-ed5a9ecdebfd?auto=format&fit=crop&w=400&q=80" alt="스위트룸">
                <h3>스위트룸</h3>
                <p>럭셔리한 공간과 최고의 전망을 자랑하는 스위트룸</p>
            </div>
            <div class="room">
                <img src="https://images.unsplash.com/photo-1464983953574-0892a716854b?auto=format&fit=crop&w=400&q=80" alt="디럭스룸">
                <h3>디럭스룸</h3>
                <p>편안함과 실용성을 모두 갖춘 디럭스룸</p>
            </div>
            <div class="room">
                <img src="https://images.unsplash.com/photo-1500534314209-a25ddb2bd429?auto=format&fit=crop&w=400&q=80" alt="스탠다드룸">
                <h3>스탠다드룸</h3>
                <p>합리적인 가격의 깔끔한 스탠다드룸</p>
            </div>
            <div class="room">
                <img src="https://images.unsplash.com/photo-1506744038136-46273834b3fb?auto=format&fit=crop&w=400&q=80" alt="패밀리룸">
                <h3>패밀리룸</h3>
                <p>가족 단위 여행객을 위한 넓은 패밀리룸</p>
            </div>
            <div class="room">
                <img src="https://images.unsplash.com/photo-1519125323398-675f0ddb6308?auto=format&fit=crop&w=400&q=80" alt="오션뷰룸">
                <h3>오션뷰룸</h3>
                <p>바다 전망이 아름다운 오션뷰룸</p>
            </div>
            <div class="room">
                <img src="https://images.unsplash.com/photo-1522708323590-d24dbb6b0267?auto=format&fit=crop&w=400&q=80" alt="테라스룸">
                <h3>테라스룸</h3>
                <p>프라이빗 테라스가 있는 테라스룸</p>
            </div>
        </div>
    </section>
    <!-- =======================
         객실 안내 섹션 끝
    ======================== -->

    <!-- =======================
         주변 여행지 섹션
    ======================== -->
    <section id="travel" class="section travel">
        <h2>주변 여행지</h2>
        <div class="travel-gallery">
            <div>
                <img src="https://images.unsplash.com/photo-1465101046530-73398c7f28ca?auto=format&fit=crop&w=400&q=80" alt="무지개공원">
                <p>무지개공원</p>
            </div>
            <div>
                <img src="https://images.unsplash.com/photo-1502082553048-f009c37129b9?auto=format&fit=crop&w=400&q=80" alt="무지개쇼핑몰">
                <p>무지개쇼핑몰</p>
            </div>
            <div>
				<img src="https://images.unsplash.com/photo-1506744038136-46273834b3fb?auto=format&fit=crop&w=400&q=80" alt="카페거리">                <p>카페거리</p>
            </div>
            <div>
                <img src="https://images.unsplash.com/photo-1506744038136-46273834b3fb?auto=format&fit=crop&w=400&q=80" alt="해변 산책로">
                <p>해변 산책로</p>
            </div>
            <div>
                <img src="https://images.unsplash.com/photo-1465101046530-73398c7f28ca?auto=format&fit=crop&w=400&q=80" alt="수목원">
                <p>수목원</p>
            </div>
            <div>
                <img src="https://images.unsplash.com/photo-1502082553048-f009c37129b9?auto=format&fit=crop&w=400&q=80" alt="전통시장">
                <p>전통시장</p>
            </div>
        </div>
    </section>
    <!-- =======================
         주변 여행지 섹션 끝
    ======================== -->

    <!-- =======================
         푸터(사이트 하단 정보)
    ======================== -->
    <footer class="main-footer">
        <div>
            <strong>무지개호텔</strong> | 문의전화 : 02-1234-5678 | 주소 : 서울특별시 강남구 무지개로 123<br>
            대표자 : 홍길동 | 사업자등록번호 : 101-31-12345<br>
            <a href="#">이용약관</a> | <a href="#">개인정보처리방침</a>
        </div>
    </footer>
</body>
</html> 