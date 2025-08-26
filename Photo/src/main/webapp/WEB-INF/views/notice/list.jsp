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
<jsp:include page="/WEB-INF/views/layout/header.jsp" />
</head>
<body>
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
document.addEventListener("DOMContentLoaded", function () {
    let currentPage = ${page}; // 현재 페이지 번호
    let maxPage = ${total_page}; // 총 페이지 개수

    // 이전 버튼 클릭 시
    document.querySelector(".prev-page").addEventListener("click", function (event) {
        if (currentPage <= 1) {
            event.preventDefault(); 
            alert("첫 페이지입니다.");
        }
    });

    // 다음 버튼 클릭 시
    document.querySelector(".next-page").addEventListener("click", function (event) {
        if (currentPage >= maxPage) {
            event.preventDefault(); 
            alert("마지막 페이지입니다.");
        }
    });
});

</script>
</body>
</html>
