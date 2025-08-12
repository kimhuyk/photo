<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>배송지 등록</title>
<style>

</style>
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/resources/css/home.css">
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/resources/css/user.css">
	
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/user.js"></script>
</head>
<body style="background-color: #1c1c1c;">
	<!-- 헤더 영역 -->
	<header class="header-top">
		<!-- 왼쪽 로고 -->
		<div class="logo">
			<img src="${pageContext.request.contextPath}/resources/images/logo/logo.png" alt="Logo"
				onclick="location.href='${pageContext.request.contextPath}/home';">
		</div>

		<!-- 가운데 메뉴 -->
		<div class="nav-items">
			<a href="${pageContext.request.contextPath}/photo">- ̗̀ෆ⎛˶'ᵕ'˶ ⎞ෆ ̖́-</a>
        <a href="${pageContext.request.contextPath}/photo">Photo</a>
        <a href="${pageContext.request.contextPath}/photouploads">Uploads</a>
        <a href="${pageContext.request.contextPath}/home">Notice?</a>
        <a href="${pageContext.request.contextPath}/story/story.do">Story</a>
		</div>

		<!-- 오른쪽 로그인 버튼 -->
		<div class="login-button">
			<c:choose>
				<c:when test="${not empty sessionScope.loginUser}">
					<!-- 로그인된 사용자의 ID 표시 -->
					<span>${sessionScope.loginUser.userName}</span>
				</c:when>
				<c:otherwise>
					<!-- 로그인되지 않은 경우 로그인 버튼 -->
					<a type="button" onclick="openModal()">Login</a>
				</c:otherwise>
			</c:choose>
		</div>
	</header>
	<!-- 배송지 등록 form -->
	<div class="features-1">
		<div class="body-container">
			<form id="deliveryForm" name="deliveryForm" method="POST" action="${pageContext.request.contextPath}/delivery/insert">
				<h2 style="text-align: center; color: white;">배송지 등록</h2>

				<div class="delivery-group">
					<label for="deName">배송지명</label> 
					<input type="text" id="deName" name="deName" placeholder="예: 우리집, 회사" required>
				</div>

				<div class="delivery-group">
					<label for="receiver_name">수령인</label> 
					<input type="text" id="receiverName" name="receiverName" placeholder="수령인 이름" required>
				</div>

				<div class="delivery-group">
					<label for="phone1">연락처</label> 
					<input type="text" id="phone1" name="phone1" placeholder="예: 010-1234-5678" required>
				</div>
				
				<div class="delivery-group">
					<label for="phone2">추가 연락처(선택)</label> 
					<input type="text" id="phone2" name="phone2" placeholder="예: 02-1234-5678">
				</div>

				<div class="delivery-group address-group">
					<label for="address">주소</label>
					<div style="display: flex; gap: 10px;">
						<input type="text" id="address" name="address" placeholder="주소" readonly required>
						<!-- 주소 검색 버튼에 클래스 추가 -->
						<button type="button" onclick="daumPostcode()" class="address-search-button">주소검색</button>
					</div>
				</div>
			
				<div class="delivery-group address-group">
					<label for="addressZip">우편번호</label>
					<div style="display: flex;">
						<input type="text" id="addressZip" name="addressZip" placeholder="우편번호" readonly required>
					</div>
				</div>
				
				<div class="delivery-group">
					<label for="detail_address">상세주소</label> 
					<input type="text" id="detailAddress" name="detailAddress" placeholder="예: 101동 101호" required>
				</div>

				<div class="delivery-group checkbox-group">
					<label for="dlvrpl">기본 배송지로 설정</label> 
					<input type="checkbox" id="dlvrpl" name="dlvrpl" value="Y">
				</div>

				<button type="button" id="submitButton" onclick="deliveryOk()">등록하기</button>
			</form>
		</div>
	</div>




<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
<script>
function daumPostcode() {
	new daum.Postcode(
			{
				oncomplete : function(data) {
					// 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

					// 각 주소의 노출 규칙에 따라 주소를 조합한다.
					// 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
					var fullAddr = ''; // 최종 주소 변수
					var extraAddr = ''; // 조합형 주소 변수

					// 사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
					if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
						fullAddr = data.roadAddress;

					} else { // 사용자가 지번 주소를 선택했을 경우(J)
						fullAddr = data.jibunAddress;
					}

					// 사용자가 선택한 주소가 도로명 타입일때 조합한다.
					if (data.userSelectedType === 'R') {
						//법정동명이 있을 경우 추가한다.
						if (data.bname !== '') {
							extraAddr += data.bname;
						}
						// 건물명이 있을 경우 추가한다.
						if (data.buildingName !== '') {
							extraAddr += (extraAddr !== '' ? ', '
									+ data.buildingName
									: data.buildingName);
						}
						// 조합형주소의 유무에 따라 양쪽에 괄호를 추가하여 최종 주소를 만든다.
						fullAddr += (extraAddr !== '' ? ' ('
								+ extraAddr + ')' : '');
					}

					// 우편번호와 주소 정보를 해당 필드에 넣는다
					document.getElementById('address').value = fullAddr;
					document.getElementById('addressZip').value = data.zonecode;

				}
			}).open();
}



function deliveryOk() {
	  const f = document.deliveryForm;

	f.submit();	  
}
</script>

</body>
</html>