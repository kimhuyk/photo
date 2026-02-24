<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<html>
<head>
    <title>Home</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/home.css?v=masonry">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/homesearch.css">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/photo.css">
    <script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
    <script type="text/javascript">
        var contextPath = "${pageContext.request.contextPath}";
    </script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/photo.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/home.js"></script>
    <jsp:include page="/WEB-INF/views/layout/header.jsp" />
</head>
<body style="background-color: #121212;">
<div class="home-wrap">
    <!-- Hero -->
    <section class="home-hero">
        <h1>아름다운 무료 스톡 사진</h1>
        <p class="hero-sub">매일 추가되는 무료 이미지, 저작권 제한 없이 사용하세요.</p>
        <form id="searchForm" name="searchForm" method="GET" action="${pageContext.request.contextPath}/search/list">
            <div class="home-search-wrap">
                <div class="search-group">
                    <input type="text" name="keyword" class="search-input" placeholder="어떤 걸 찾으세요?">
                    <button type="submit" class="search-icon" aria-label="검색">
                        <i class="fa fa-search"></i>
                    </button>
                </div>
            </div>
        </form>
        <div class="home-trending">
            <div class="trend-label">Trending</div>
            <div class="home-tags">
                <a href="${pageContext.request.contextPath}/search/list?keyword=자연">자연</a>
                <a href="${pageContext.request.contextPath}/search/list?keyword=사람">사람</a>
                <a href="${pageContext.request.contextPath}/search/list?keyword=도시">도시</a>
                <a href="${pageContext.request.contextPath}/search/list?keyword=스포츠">스포츠</a>
                <a href="${pageContext.request.contextPath}/search/list?keyword=패션">패션</a>
                <a href="${pageContext.request.contextPath}/search/list?keyword=풍경">풍경</a>
                <a href="${pageContext.request.contextPath}/search/list?keyword=건축">건축</a>
                <a href="${pageContext.request.contextPath}/search/list?keyword=자동차">자동차</a>
            </div>
        </div>
    </section>
    <form id="downloadForm" action="download" method="GET">
        <input type="hidden" name="fileNum" id="fileNum">
    </form>
    <!-- Photo Grid (Kaboompics Masonry: 3열, 다양한 높이) -->
    <div class="home-grid">
        <!-- 1~4: 자동차 / 도로 -->
        <div class="home-card thumb-car size-wide">
            <a href="#" onclick="event.preventDefault(); openpictureModal(1, '${pageContext.request.contextPath}/resources/images/main/backgroundflower.jpg', 'City car at night', '관리자');">
                <div class="home-card-overlay">
                    <p class="home-card-title">City car at night</p>
                    <span class="home-card-meta">자동차 · 도시</span>
                </div>
            </a>
        </div>
        <div class="home-card thumb-car size-tall">
            <a href="#" onclick="event.preventDefault(); openpictureModal(2, '${pageContext.request.contextPath}/resources/images/main/flowertable.jpg', 'Highway road trip', '관리자');">
                <div class="home-card-overlay">
                    <p class="home-card-title">Highway road trip</p>
                    <span class="home-card-meta">여행 · 드라이브</span>
                </div>
            </a>
        </div>
        <div class="home-card thumb-car size-square">
            <a href="#" onclick="event.preventDefault(); openpictureModal(3, '${pageContext.request.contextPath}/resources/images/main/hand.jpg', 'Vintage car close-up', '관리자');">
                <div class="home-card-overlay">
                    <p class="home-card-title">Vintage car close-up</p>
                    <span class="home-card-meta">빈티지 · 디테일</span>
                </div>
            </a>
        </div>
        <div class="home-card thumb-car size-xtall">
            <a href="#" onclick="event.preventDefault(); openpictureModal(4, '${pageContext.request.contextPath}/resources/images/main/redcake.jpg', 'Sunset on the road', '관리자');">
                <div class="home-card-overlay">
                    <p class="home-card-title">Sunset on the road</p>
                    <span class="home-card-meta">노을 · 풍경</span>
                </div>
            </a>
        </div>

        <!-- 5~8: 패션 / 의류 -->
        <div class="home-card thumb-clothes size-xwide">
            <a href="#" onclick="event.preventDefault(); openpictureModal(5, '${pageContext.request.contextPath}/resources/images/main/vage.jpg', 'Minimal fashion flatlay', '관리자');">
                <div class="home-card-overlay">
                    <p class="home-card-title">Minimal fashion flatlay</p>
                    <span class="home-card-meta">패션 · 미니멀</span>
                </div>
            </a>
        </div>
        <div class="home-card thumb-clothes size-wide">
            <a href="#" onclick="event.preventDefault(); openpictureModal(6, '${pageContext.request.contextPath}/resources/images/main/ring.jpg', 'Casual outfit on chair', '관리자');">
                <div class="home-card-overlay">
                    <p class="home-card-title">Casual outfit on chair</p>
                    <span class="home-card-meta">데일리룩 · 캐주얼</span>
                </div>
            </a>
        </div>
        <div class="home-card thumb-clothes size-tall">
            <a href="#" onclick="event.preventDefault(); openpictureModal(7, '${pageContext.request.contextPath}/resources/images/main/clothes.jpg', 'Cozy winter clothes', '관리자');">
                <div class="home-card-overlay">
                    <p class="home-card-title">Cozy winter clothes</p>
                    <span class="home-card-meta">겨울 · 니트</span>
                </div>
            </a>
        </div>
        <div class="home-card thumb-clothes size-square">
            <a href="#" onclick="event.preventDefault(); openpictureModal(8, '${pageContext.request.contextPath}/resources/images/main/clothes.jpg', 'Streetwear collection', '관리자');">
                <div class="home-card-overlay">
                    <p class="home-card-title">Streetwear collection</p>
                    <span class="home-card-meta">스트릿 · 스타일</span>
                </div>
            </a>
        </div>

        <!-- 9~12: 건축 / 도시 -->
        <div class="home-card thumb-build size-xtall">
            <a href="#" onclick="event.preventDefault(); openpictureModal(9, '${pageContext.request.contextPath}/resources/images/main/build.jpg', 'Modern city skyline', '관리자');">
                <div class="home-card-overlay">
                    <p class="home-card-title">Modern city skyline</p>
                    <span class="home-card-meta">도시 · 빌딩</span>
                </div>
            </a>
        </div>
        <div class="home-card thumb-build size-xwide">
            <a href="#" onclick="event.preventDefault(); openpictureModal(10, '${pageContext.request.contextPath}/resources/images/main/build.jpg', 'Architecture close-up', '관리자');">
                <div class="home-card-overlay">
                    <p class="home-card-title">Architecture close-up</p>
                    <span class="home-card-meta">건축 · 패턴</span>
                </div>
            </a>
        </div>
        <div class="home-card thumb-build size-wide">
            <a href="#" onclick="event.preventDefault(); openpictureModal(11, '${pageContext.request.contextPath}/resources/images/main/build.jpg', 'Glass office building', '관리자');">
                <div class="home-card-overlay">
                    <p class="home-card-title">Glass office building</p>
                    <span class="home-card-meta">오피스 · 비즈니스</span>
                </div>
            </a>
        </div>
        <div class="home-card thumb-build size-tall">
            <a href="#" onclick="event.preventDefault(); openpictureModal(12, '${pageContext.request.contextPath}/resources/images/main/build.jpg', 'City night lights', '관리자');">
                <div class="home-card-overlay">
                    <p class="home-card-title">City night lights</p>
                    <span class="home-card-meta">야경 · 라이트</span>
                </div>
            </a>
        </div>

        <!-- 13~16: 스포츠 / 라이프 -->
        <div class="home-card thumb-tennis size-square">
            <a href="#" onclick="event.preventDefault(); openpictureModal(13, '${pageContext.request.contextPath}/resources/images/main/tennis.jpg', 'Tennis court lines', '관리자');">
                <div class="home-card-overlay">
                    <p class="home-card-title">Tennis court lines</p>
                    <span class="home-card-meta">스포츠 · 코트</span>
                </div>
            </a>
        </div>
        <div class="home-card thumb-tennis size-xtall">
            <a href="#" onclick="event.preventDefault(); openpictureModal(14, '${pageContext.request.contextPath}/resources/images/main/tennis.jpg', 'Outdoor tennis match', '관리자');">
                <div class="home-card-overlay">
                    <p class="home-card-title">Outdoor tennis match</p>
                    <span class="home-card-meta">경기 · 액션</span>
                </div>
            </a>
        </div>
        <div class="home-card thumb-tennis size-xwide">
            <a href="#" onclick="event.preventDefault(); openpictureModal(15, '${pageContext.request.contextPath}/resources/images/main/tennis.jpg', 'Sports lifestyle', '관리자');">
                <div class="home-card-overlay">
                    <p class="home-card-title">Sports lifestyle</p>
                    <span class="home-card-meta">라이프스타일 · 운동</span>
                </div>
            </a>
        </div>
        <div class="home-card thumb-tennis size-wide">
            <a href="#" onclick="event.preventDefault(); openpictureModal(16, '${pageContext.request.contextPath}/resources/images/main/tennis.jpg', 'Tennis net detail', '관리자');">
                <div class="home-card-overlay">
                    <p class="home-card-title">Tennis net detail</p>
                    <span class="home-card-meta">디테일 · 패턴</span>
                </div>
            </a>
        </div>

        <!-- 17~20: 하늘 / 풍경 / 의자 -->
        <div class="home-card thumb-sky size-tall">
            <a href="#" onclick="event.preventDefault(); openpictureModal(17, '${pageContext.request.contextPath}/resources/images/main/sky.jpg', 'Golden sunset sky', '관리자');">
                <div class="home-card-overlay">
                    <p class="home-card-title">Golden sunset sky</p>
                    <span class="home-card-meta">노을 · 하늘</span>
                </div>
            </a>
        </div>
        <div class="home-card thumb-sky size-square">
            <a href="#" onclick="event.preventDefault(); openpictureModal(18, '${pageContext.request.contextPath}/resources/images/main/sky.jpg', 'Cloudy afternoon', '관리자');">
                <div class="home-card-overlay">
                    <p class="home-card-title">Cloudy afternoon</p>
                    <span class="home-card-meta">구름 · 풍경</span>
                </div>
            </a>
        </div>
        <div class="home-card thumb-chair size-xtall">
            <a href="#" onclick="event.preventDefault(); openpictureModal(19, '${pageContext.request.contextPath}/resources/images/main/chair.jpg', 'Cozy chair corner', '관리자');">
                <div class="home-card-overlay">
                    <p class="home-card-title">Cozy chair corner</p>
                    <span class="home-card-meta">인테리어 · 의자</span>
                </div>
            </a>
        </div>
        <div class="home-card thumb-chair size-xwide">
            <a href="#" onclick="event.preventDefault(); openpictureModal(20, '${pageContext.request.contextPath}/resources/images/main/chair.jpg', 'Reading time', '관리자');">
                <div class="home-card-overlay">
                    <p class="home-card-title">Reading time</p>
                    <span class="home-card-meta">라이프스타일 · 휴식</span>
                </div>
            </a>
        </div>
    </div>
</div>

<!-- Photo Modal (photo.jsp에서 공통 사용) -->
<div id="photoModal" class="modalpicture" style="display: none;">
    <div class="modalpicture-content">
        <span class="closepicture" onclick="closepictureModal()">&times;</span>
        <img id="modalImage" src="" alt="Selected Photo">
        <p id="modalCaption" style="margin-top: 15px; font-size: 17px;"></p>
        <p id="userName"></p>
        <div id="userInfo" data-user-seq="${sessionScope.loginUser.userSeq}"></div>
        <c:choose>
            <c:when test="${sessionScope.loginUser.userSeq == 1}">
                <button id="deleteButton" onclick="deletePhoto()" class="btn btn-danger">삭제</button>
            </c:when>
        </c:choose>
        <button onclick="downloadPhoto()" class="btn btn-primary">Download</button>
    </div>
</div>

</body>
</html>
