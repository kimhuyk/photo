<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<title>Notice</title>
<style>

</style>

<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/resources/css/home.css">
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/resources/css/noticeArticle.css">
	
<!-- 스크립트 링크 -->
<script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/home.js"></script>
<jsp:include page="/WEB-INF/views/layout/header.jsp" />
</head>
<body>
	<!--  여기부터 notice 글보기 화면단 만들기 -->
		<div class="notice-container">
		    <div class="notice-top">${dto.noticeTitle}</div>
		    <div class="notice-meta" style="margin-top: 10px;">${dto.noticeRegdate}</div>
		
		    <div class="notice-separator"></div>
		
		    <div class="notice-content">
		        ${dto.noticeContents}
		    </div>
		
		    <div class="notice-separator"></div>
		
        	<div class="notice-navigation">
		    <ul class="ultag">
		        <c:if test="${not empty prevDto}">
		            <li class="prev-notice">
		                이전 : <a href="${pageContext.request.contextPath}/notice/article?${query}&noticeSeq=${prevDto.noticeSeq}">
		                    ${prevDto.noticeTitle}
		                </a>
		            </li>
		        </c:if>
		
		        <c:if test="${not empty nextDto}">
		            <li class="next-notice">
		                다음 : <a href="${pageContext.request.contextPath}/notice/article?${query}&noticeSeq=${nextDto.noticeSeq}">
		                    ${nextDto.noticeTitle}
		                </a>
		            </li>
		        </c:if>
		    </ul>
		    <c:if test="${sessionScope.loginUser.userSeq == 1}">
		        <button type="button" class="delete-btn" onclick="deleteNotice(${dto.noticeSeq});">삭제하기</button>
				<button type="button" class="update-btn" onclick="updateNotice(${dto.noticeSeq});">수정하기</button>
			</c:if>
	</div>
</div>
		
<script>
function deleteNotice(noticeSeq) {
    if (confirm("공지사항을 삭제하시겠습니까?")) {
        // 현재 페이지의 컨텍스트 패스를 가져와서 삭제 URL을 만듦
        const url = '${pageContext.request.contextPath}/notice/deleteNotice?noticeSeq=' + noticeSeq + '&page=' + '${page}';
        
        // 페이지 이동 방식으로 삭제 요청
        location.href = url;
    }
}


function updateNotice(noticeSeq) {
    if (!noticeSeq) {
        alert("공지사항 번호가 없습니다.");
        return;
    }
    const url = '${pageContext.request.contextPath}/notice/findbyNotice?noticeSeq=' + noticeSeq;
    location.href = url;
}
</script>
</body>
</html>