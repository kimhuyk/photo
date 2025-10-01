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
	href="${pageContext.request.contextPath}/resources/css/noticeUpdate.css">	
	
<!-- 스크립트 링크 -->
<script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/home.js"></script>
<jsp:include page="/WEB-INF/views/layout/header.jsp" />
</head>
<body>
		<!-- 여기부터 글쓰기 jsp -->
		
		<div class="notice-write-container">
		    <h3 class="notice-write-title">| 공지사항 작성</h3>
		    <form class="notice-write-form" id="updateForm" name="updateForm" method="POST" 
		    	action="${pageContext.request.contextPath}/notice/update">
		    	<input type="hidden" name="noticeSeq" id="noticeSeq" value="${notice.noticeSeq}">
		        <table>
		            <tr>
		                <td><label for="noticeTitle">제목</label></td>
		                <td><input type="text" id="noticeTitle" name="noticeTitle" value="${notice.noticeTitle}"></td>
		            </tr>
		            <tr>
		                <td><label for="userName">작성자</label></td>
		                <td><input type="text" id="userName" name="userName" value="${notice.userName}" readonly></td>
		            </tr>
		            <tr>
		                <td><label for="boardContents">내용</label></td>
		                <td>
		                	<textarea id="noticeContents" name="noticeContents">${notice.noticeContents}</textarea>
		                </td>
		            </tr>
		        </table>
		

		            <div class="notice-write-buttons">
		                <button type="submit" class="submit-btn">수정하기</button>
		                <button type="button" class="cancel-btn" onclick="location.href='${pageContext.request.contextPath}/notice/list';">수정취소</button>
		            </div>

		    </form>
		</div>

		
</body>
</html>