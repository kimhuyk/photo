<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<title>검색</title>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/search.css">   
<jsp:include page="/WEB-INF/views/layout/header.jsp" />
</head>
<body>
    <!-- 검색 페이지 메인 -->
    <div class="search-page">
        <!-- 검색 상단 영역 -->
        <div class="search-header">
            <!-- 검색창 -->
            <div class="search-box">
                <input type="text" id="searchInput" class="search-input" 
                       placeholder="검색어를 입력하세요" autocomplete="off">
                <button id="clearBtn" class="clear-btn">
                    <i class="fas fa-times"></i>
                </button>
                <i class="fas fa-search search-icon"></i>
            </div>

            <!-- 필터 탭 -->
            <div class="search-tabs">
                <div class="tab-item active" data-filter="all">전체</div>
                <div class="tab-item" data-filter="image">이미지</div>
                <div class="tab-item" data-filter="notice">공지사항</div>
            </div>
        </div>
        
        <!-- 검색 결과 영역 -->
        <div class="search-results">
            <!-- 결과 헤더 -->
            <div class="results-header">
                <h3 id="resultsHeader">검색어를 입력하여 결과를 찾아보세요</h3>
            </div>
            
            <!-- 검색 결과 컨테이너 -->
            <div id="searchResults">
                <!-- 초기 상태 -->
                <div class="initial-state">
                    <i class="fas fa-search"></i>
                    <p>검색어를 입력하여 결과를 찾아보세요</p>
                </div>
                
                <!-- 이미지 결과 예시 (나중에 제거) -->
                <div class="image-results">
                    <div class="image-item">
                        <img src="https://picsum.photos/300/200?random=1" alt="예시 이미지 1">
                        <div class="image-info">
                            <div class="image-title">예시 이미지 제목 1</div>
                            <div class="image-source">example.com</div>
                        </div>
                    </div>
                    <div class="image-item">
                        <img src="https://picsum.photos/300/200?random=2" alt="예시 이미지 2">
                        <div class="image-info">
                            <div class="image-title">예시 이미지 제목 2</div>
                            <div class="image-source">example.com</div>
                        </div>
                    </div>
                    <div class="image-item">
                        <img src="https://picsum.photos/300/200?random=3" alt="예시 이미지 3">
                        <div class="image-info">
                            <div class="image-title">예시 이미지 제목 3</div>
                            <div class="image-source">example.com</div>
                        </div>
                    </div>
                </div>
                
                <!-- 텍스트 결과 예시 (나중에 제거) -->

                <div class="result-item">
                    <a href="#" class="result-title">예시 검색 결과 제목</a>
                    <div class="result-url">https://example.com</div>
                    <div class="result-description">이것은 예시 검색 결과의 설명입니다. 실제 검색 결과가 여기에 표시됩니다.</div>
                </div>
                <div class="result-item">
                    <a href="#" class="result-title">또 다른 검색 결과</a>
                    <div class="result-url">https://example2.com</div>
                    <div class="result-description">두 번째 예시 검색 결과입니다. 실제 데이터로 교체됩니다.</div>
                </div>

            </div>
        </div>
    </div>
    
    
    
<script>

</script>
</body>
</html>
