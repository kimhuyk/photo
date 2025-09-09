<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<title>검색 테스트</title>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/search.css">
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

<script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
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
        const textResultsContainer = $('<div></div>');
        let imageFound = false;
        let noticeFound = false;

        results.forEach(item => {
            if (item.category === 'image') {
                imageFound = true;
                const imageItem = `
                    <div class="image-item">
                        <img src="${item.filePath}" alt="${item.originalFileName}" onerror="this.onerror=null; this.src='https://placehold.co/300x200/cccccc/333333?text=Image+Not+Found';">
                        <div class="image-info">
                            <div class="image-title">\${item.title}</div>
                            <div class="image-source">업로더: \${item.userName}</div>
                        </div>
                    </div>
                `;
                imageResultsContainer.append(imageItem);
            } else if (item.category === 'notice') {
                noticeFound = true;
                const noticeItem = `
                    <div class="result-item">
                        <a href="/notice/\${item.seq}" class="result-title">\${item.title}</a>
                        <div class="result-url">공지사항 | 작성자: \${item.userName}</div>
                        <div class="result-description">\${item.contents}</div>
                    </div>
                `;
                textResultsContainer.append(noticeItem);
            }
        });

        if (filter === 'all') {
            if (noticeFound) resultsContainer.append(textResultsContainer);
            if (imageFound) resultsContainer.append(imageResultsContainer);
        } else if (filter === 'image') {
            resultsContainer.append(imageResultsContainer);
        } else if (filter === 'notice') {
            resultsContainer.append(textResultsContainer);
        }

        if (!imageFound && filter === 'image') {
            resultsContainer.html('<div class="initial-state"><i class="fas fa-search"></i><p>이미지 검색 결과가 없습니다.</p></div>');
        }
        if (!noticeFound && filter === 'notice') {
            resultsContainer.html('<div class="initial-state"><i class="fas fa-search"></i><p>공지사항 검색 결과가 없습니다.</p></div>');
        }
    }

    // --- 검색 실행 함수 ---
    function performSearch() {
        const keyword = $('#searchInput').val();

        if (keyword.trim() === '') {
            $('#resultsHeader').text('검색어를 입력하여 결과를 찾아보세요');
            $('#searchResults').html('<div class="initial-state"><i class="fas fa-search"></i><p>검색어를 입력하여 결과를 찾아보세요</p></div>');
            return;
        }

        $('#resultsHeader').text(`'\${keyword}'에 대한 검색 결과`);

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
    const urlParams = new URLSearchParams(window.location.search);
    const urlKeyword = urlParams.get('keyword');
    if (urlKeyword) {
        $('#searchInput').val(decodeURIComponent(urlKeyword));
        performSearch();
    }

    $('#searchInput').on('keypress', function(e) {
        if (e.which === 13) {
            performSearch();
        }
    });

    $('#searchIcon').on('click', performSearch);
    
    let activeTab = localStorage.getItem('activeSearchTab');
    if (!activeTab) {
        activeTab = 'all';
    }
    $('.tab-item').removeClass('active');
    $(`.tab-item[data-filter="${activeTab}"]`).addClass('active');

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