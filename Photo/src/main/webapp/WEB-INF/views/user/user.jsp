<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<title>${mode=="user"?"회원가입":"정보수정"}</title>
<style>
.id_ok{
color:#008000;
display: none;
}

.id_already{
color:#6A82FB; 
display: none;
}
</style>
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/resources/css/user.css"> 
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/resources/css/home.css">

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/user.js"></script>
<jsp:include page="/WEB-INF/views/layout/header.jsp" />
</head>
<body>	
<div class="features-1">
    <div class="body-container">
        <form id="userForm" name="userForm" method="POST" action="${pageContext.request.contextPath}/user/user">
            <div class="user-group">
                <label for="userId">아이디</label>
                <input type="text" id="userId" name="userId" placeholder="아이디 입력" onchange="checkId()" value="${dto.userId}" ${mode=="update" ? "readonly" : ""}>
                <span class="userId_ok" style="display:none;">사용 가능한 아이디입니다.</span>
				<span class="userId_already" style="display:none; color: red;">누군가 이 아이디를 사용하고 있어요.</span>                
            </div>

            <div class="user-group">
                <label for="userPwd">패스워드</label>
                <input type="password" id="userPwd" name="userPwd" autocomplete="off" placeholder="패스워드">
				<!--<button type="button" onclick="togglePassword()">보기</button>-->
                <small class="password-check">패스워드는 5~10자이며 하나 이상의 숫자나 특수문자가 포함되어야 합니다.</small>
            </div>

            <div class="user-group">
                <label for="userPwd2">패스워드 확인</label>
                <input type="password" name="userPwd2" id="userPwd2" class="form-control" autocomplete="off" placeholder="패스워드 확인">
                <small class="form-control-plaintext">패스워드를 한번 더 입력해주세요.</small>
            </div>

            <div class="user-group">
                <label for="userName">이름</label>
                <input type="text" name="userName" id="userName" class="form-control" placeholder="이름" value="${dto.userName}">
            </div>


            <div class="user-group">
			    <label for="email">이메일</label>
			    <input type="text" name="email" class="form-control" maxlength="60" placeholder="예: example@naver.com" value="${dto.email}" required>
			</div>
			
			<div class="user-group">
			    <label for="tel">전화번호</label>
			    <input type="text" name="tel" id="tel" class="form-control" maxlength="13" placeholder="010-1234-5678" value="${dto.tel}">
			</div>

            <div class="user-group">
                <label for="birth">생년월일</label>
                <input type="text" name="birth" id="birth" placeholder="생년월일 8자리" value="${dto.birth}">
                <small class="form-control-plaintext">생년월일은 2000-01-01 형식으로 입력합니다.</small>
            </div>
            <button type="button" id="submitButton" onclick="userOk();">${mode=="user"?"회원가입": "정보수정"}</button>
        </form>
    </div>
</div>

<script>
    //서버에 모델에 담아 보낸 mode 값을 JS 변수에 저장
    const mode = "${mode}";
    const contextPath = "${pageContext.request.contextPath}";

    // 페이지 로드 바로실행
    window.onload = function() {
        const form = document.getElementById('userForm');
        const submitButton = document.getElementById('submitButton');
        const title = document.querySelector('title');

        //서버가 보내준 mode가 update인지 확인합니다.
        if (mode === 'update') {
            //정보 수정 모드에 맞게 변경
            
            //폼의 목적지를 /user/update'로 변경
            form.action = contextPath + '/user/update'; 
            
            // 페이지와 버튼의 텍스트 변경
            title.innerText = '정보수정';
            submitButton.innerText = '정보 수정';
            
            // 아이디는 수정할 수 없도록 막기
            document.getElementById('userId').readOnly = true;
        } else {
            // 회원가입 모드일 때의 처리
            title.innerText = '회원가입';
            submitButton.innerText = '회원 가입';
            form.action = contextPath + '/user/user';
        }
    };
    
    // 폼 유효성 검사 및 전송 함수
    function submitForm() {
        //유효성 검사 로직
        document.getElementById('userForm').submit();
    }
</script>


</body>
</html>