<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<title>검색 테스트</title>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/search.css">
<script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/home.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/modal.js"></script>
<jsp:include page="/WEB-INF/views/layout/header.jsp" />
</head>
<body>
    <div class="search-page">
        <div class="search-header">
            <div class="search-box">
                <input type="text" id="searchInput" class="search-input"
                       placeholder="검색어를 입력하세요" autocomplete="off">
                <button id="clearBtn" class="clear-btn"></button>
                <i class="fas fa-search search-icon" id="searchIcon"></i>
            </div>
            <div class="search-tabs">
                <div class="tab-item active" data-filter="all">전체</div>
                <div class="tab-item" data-filter="image">이미지</div>
                <div class="tab-item" data-filter="notice">공지사항</div>
                <div class="tab-item" data-filter="shop">Shop</div>
            </div>
        </div>

        <div class="search-results">
            <div class="results-header">
                <h3 id="resultsHeader">검색어를 입력하여 결과를 찾아보세요</h3>
            </div>
            <div id="searchResults">
                <div class="initial-state">
                    <i class="fas fa-search"></i>
                    <p>검색어를 입력하여 결과를 찾아보세요</p>
                </div>
            </div>
        </div>
    </div>
    <div id="photoModal" class="modalpicture" style="display: none;">
        <div class="modalpicture-content">
            <span class="closepicture" onclick="closepictureModal()">&times;</span>
            <img id="modalImage" src="" alt="" loading="lazy">
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

<script>
	let searchData = ${searchMainJson};	//home에서 검색했을시 파라미터를 같이 넘겨야 검색했을대 바로 결과 값 출력
    let searchKeyword = '${keyword}';	// 원래 하던방식은 검색해서 페이지 이동 후 탭을바꿔야 값 출력해서 수정
    let contextPath = '${pageContext.request.contextPath}';
</script>
<script>
$(document).ready(function() {
    function renderResults(results, filter) {
        const resultsContainer = $('#searchResults');
        resultsContainer.empty();

        if (!results || results.length === 0) {
            resultsContainer.html('<div class="initial-state"><i class="fas fa-search"></i><p>검색 결과가 없습니다.</p></div>');
            return;
        }

        const imageResultsContainer = $('<div class="image-results"></div>');
        const textResultsContainer  = $('<div class="notice-results"></div>');
        const shopResultsContainer  = $('<div class="shop-results"></div>');
        let imageFound  = false;
        let noticeFound = false;
        let shopFound   = false;

        results.forEach(item => {
            const cat = (item.category || '').toLowerCase();
            if (cat === 'image') {
                imageFound = true;
                const imageUrl = '${pageContext.request.contextPath}/uploads/photo/' + item.saveFileName;
                imageResultsContainer.append(
                    '<div class="image-item">' +
                        '<img loading="lazy" src="' + imageUrl + '" alt="' + item.originalFileName + '" ' +
                             'onerror="this.onerror=null;this.src=\'https://placehold.co/300x200/1a1a1a/555?text=No+Image\';">' +
                        '<div class="image-info">' +
                            '<div class="image-title">' + item.title + '</div>' +
                            '<div class="image-source"><i class="fas fa-user"></i> ' + item.userName + '</div>' +
                        '</div>' +
                    '</div>'
                );
            } else if (cat === 'notice') {
                noticeFound = true;
                textResultsContainer.append(
                    '<div class="result-item">' +
                        '<a href="' + contextPath + '/notice/article?page=1&noticeSeq=' + item.seq + '" class="result-title">' +
                            '<i class="fas fa-bullhorn" style="font-size:14px;margin-right:8px;opacity:0.5;"></i>' + item.title +
                        '</a>' +
                        '<div class="result-url"><i class="fas fa-user" style="margin-right:4px;"></i>' + item.userName + ' · ' + item.regDate + '</div>' +
                        '<div class="result-description">' + (item.contents || '') + '</div>' +
                    '</div>'
                );
            } else if (cat === 'shop') {
                shopFound = true;
                const imgUrl  = contextPath + '/shop/image?saveFileName=' + encodeURIComponent(item.saveFileName || '');
                const price   = '₩ ' + Number(item.itemPrice).toLocaleString('ko-KR');
                shopResultsContainer.append(
                    '<div class="shop-result-item" onclick="location.href=\'' + contextPath + '/shop/shoplist\'">' +
                        '<img src="' + imgUrl + '" alt="' + item.title + '" ' +
                             'onerror="this.onerror=null;this.src=\'https://placehold.co/88x104/1a1a1a/555?text=No+Image\';">' +
                        '<div class="shop-result-info">' +
                            '<div class="shop-result-name">' + item.title + '</div>' +
                            '<div class="shop-result-price"><i class="fas fa-tag" style="margin-right:5px;"></i>' + price + ' (VAT 별도)</div>' +
                            '<div class="shop-result-desc">' + (item.itemDesc || '') + '</div>' +
                        '</div>' +
                        '<i class="fas fa-chevron-right shop-result-arrow"></i>' +
                    '</div>'
                );
            }
        });

        if (filter === 'all') {
            if (noticeFound) {
                resultsContainer.append('<div class="section-label"><i class="fas fa-bullhorn"></i> 공지사항</div>');
                resultsContainer.append(textResultsContainer);
            }
            if (imageFound) {
                resultsContainer.append('<div class="section-label"><i class="fas fa-image"></i> 이미지</div>');
                resultsContainer.append(imageResultsContainer);
            }
            if (shopFound) {
                resultsContainer.append('<div class="section-label"><i class="fas fa-shopping-bag"></i> Shop</div>');
                resultsContainer.append(shopResultsContainer);
            }
            if (!noticeFound && !imageFound && !shopFound) {
                resultsContainer.html('<div class="initial-state"><i class="fas fa-search"></i><p>검색 결과가 없습니다</p></div>');
            }
        } else if (filter === 'image') {
            if (imageFound) resultsContainer.append(imageResultsContainer);
            else resultsContainer.html('<div class="initial-state"><i class="fas fa-image"></i><p>이미지 검색 결과가 없습니다</p></div>');
        } else if (filter === 'notice') {
            if (noticeFound) resultsContainer.append(textResultsContainer);
            else resultsContainer.html('<div class="initial-state"><i class="fas fa-bullhorn"></i><p>공지사항 검색 결과가 없습니다</p></div>');
        } else if (filter === 'shop') {
            if (shopFound) resultsContainer.append(shopResultsContainer);
            else resultsContainer.html('<div class="initial-state"><i class="fas fa-shopping-bag"></i><p>Shop 검색 결과가 없습니다</p></div>');
        }
    }

    // 검색 실행 함수
    function searchForm() {
        const keyword = $('#searchInput').val();

        if (keyword.trim() === '') {
            $('#resultsHeader').text('검색어를 입력하여 결과를 찾아보세요');
            $('#searchResults').html('<div class="initial-state"><i class="fas fa-search"></i><p>검색어를 입력하여 결과를 찾아보세요</p></div>');
            return;
        }
	
        $('#resultsHeader').text("'" + keyword + "'에 대한 검색 결과");

        $.ajax({
            url: '${pageContext.request.contextPath}/search/results',
            method: 'GET',
            data: { keyword: keyword },
            dataType: 'json',
            success: function(response) {
                $('#searchResults').data('results', response);
                const activeFilter = $('.tab-item.active').data('filter');
                renderResults(response, activeFilter);
            },
            error: function(xhr, status, error) {
                console.error('검색 실패:', status, error);
                $('#searchResults').html('<p>검색 중 오류가 발생했습니다. 다시 시도해 주세요.</p>');
            }
        });
    }

	    // URL에서 검색어 읽어와서 바로 검색하기
	    if (searchKeyword) {
	    $('#searchInput').val(searchKeyword);
	    $('#resultsHeader').text("'" + searchKeyword + "'에 대한 검색 결과");
	    $('#searchResults').data('results', searchData);
	    
	    const activeFilter = $('.tab-item.active').data('filter');
	    renderResults(searchData, activeFilter);
	    
	    if ($('#searchInput').val().length > 0) {
	        $('#clearBtn').show();
	    }
	}

    $('#searchInput').on('keypress', function(e) {
        if (e.which === 13) {
        	searchForm();
        }
    });

    $('#searchIcon').on('click', searchForm);
    
    let activeTab = localStorage.getItem('activeSearchTab');
    if (!activeTab) {
        activeTab = 'all';
    }
    $('.tab-item').removeClass('active');
    $('.tab-item[data-filter="' + activeTab + '"]').addClass('active');

    $('.tab-item').on('click', function() {
        const filter = $(this).data('filter');
        localStorage.setItem('activeSearchTab', filter);

        $('.tab-item').removeClass('active');
        $(this).addClass('active');

        const currentResults = $('#searchResults').data('results');
        if (currentResults) {
            renderResults(currentResults, filter);
        }
    });

    $('#searchInput').on('input', function() {
        if ($(this).val().length > 0) {
            $('#clearBtn').show();
        } else {
            $('#clearBtn').hide();
        }
    });

    $('#clearBtn').on('click', function() {
        $('#searchInput').val('');
        $(this).hide();
        $('#resultsHeader').text('검색어를 입력하여 결과를 찾아보세요');
        $('#searchResults').html('<div class="initial-state"><i class="fas fa-search"></i><p>검색어를 입력하여 결과를 찾아보세요</p></div>');
    });
});
</script>
</body>
</html>