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
    <%-- <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/photo.css"> --%>
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

    <div class="home-grid">
        <!-- home.js -->
    </div>
</div>

<!-- Photo Modal (photo.jsp에서 공통 사용) -->
<div id="photoModal" class="modalpicture" style="display: none;">
    <div class="modalpicture-content">
        <span class="closepicture" onclick="closepictureModal()">&times;</span>
        <img id="modalImage" src="" alt="">-
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
