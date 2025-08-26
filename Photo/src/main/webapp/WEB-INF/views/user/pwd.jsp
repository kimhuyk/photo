<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<html>
<head>
<style type="text/css">
.features-1 {
	height: auto; /* 수정 시 auto로 바꾸고 해야함 */
	display: flex;
	justify-content: center;
}
.body-container {
	padding: 130px 0 60px 0;
	max-width: 800px;
}
.row {
	width:auto;
}

.justify-content-md-center {
    background-color: var(--container-color);
    padding: 2rem;
    border-radius: 0.8rem;
    box-shadow: 0 8px 32px hsla(230, 75%, 15%, .2);
}

.div-form {
	margin: 30px;
}

/* 비밀번호 재확인 */
.justify-content-md-center {
	background-color: black; /* 검은색 배경 */
	color: white; /* 하얀색 글씨 */
	padding: 40px;
	width: 400px; /* 크기 키움 */
	border-radius: 10px;
	text-align: center;
	box-shadow: 0px 4px 10px rgba(255, 255, 255, 0.3); /* 살짝 빛나는 효과 */
	position: relative; /* 중앙 정렬을 유지하기 위한 설정 */
}

/* 입력 필드 스타일 */
.justify-content-md-center input {
	width: 90%;
	padding: 12px;
	margin: 10px 0;
	background-color: #333;
	border: none;
	border-radius: 5px;
	color: white;
	font-size: 16px;
	text-align: center;
}

/* 재확인 버튼 스타일 */
.justify-content-md-center button {
	width: 100%;
	padding: 12px;
	background-color: white;
	color: black;
	font-weight: bold;
	border: none;
	border-radius: 5px;
	cursor: pointer;
	font-size: 24px;
	margin-top: 20px;
}

.justify-content-md-center button:hover {
	background-color: gray;
}


</style>
<!-- CSS 링크 -->
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/resources/css/home.css">
<%-- <link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/resources/css/photoStory.css"> --%>
	
<script type="text/javascript">
    var contextPath = "${pageContext.request.contextPath}";
</script>

<!-- 스크립트 링크 -->
<script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/home.js"></script>
<script type="text/javascript">
function sendOk() {
	const f = document.pwdForm;

	let str = f.userPwd.value.trim();
	if(!str) {
		alert("패스워드를 입력하세요. ");
		f.userPwd.focus();
		return;
	}

	f.action = "${pageContext.request.contextPath}/user/pwd";
	f.submit();
}
</script>
<jsp:include page="/WEB-INF/views/layout/header.jsp" />
</head>
<body style="background-color: #1c1c1c;">
<div class="features-1">
	<div class="body-container">	

        <div class="row justify-content-md-center">
            <div class="">
                <div class="div-form">
                    <form name="pwdForm" method="post" class="row g-3">
                        <h3 class="text-center fw-bold">패스워드 재확인</h3>
                        
		                <div class="d-grid">
							<p class="form-control-plaintext text-center">정보보호를 위해 패스워드를 다시 한 번 입력해주세요.</p>
		                </div>
                        
                        <div class="d-grid">
                            <input type="text" name="userId" class="form-control form-control-lg" placeholder="아이디"
                            		value="${sessionScope.loginUser.userId}"
                            		readonly>
                        </div>
                        <div class="d-grid">
                            <input type="password" name="userPwd" class="form-control form-control-lg" autocomplete="off" placeholder="패스워드">
                        </div>
                        <div class="d-grid">
                            <button type="button" class="login__button" onclick="sendOk();">확인</button>
                            <input type="hidden" name="mode" value="${mode}">
                        </div>
                    </form>
                </div>

                <div class="d-grid">
					<p class="form-control-plaintext text-center">${message}</p>
                </div>
            </div>
        </div>
	        
	</div>
</div>

</body>
</html>