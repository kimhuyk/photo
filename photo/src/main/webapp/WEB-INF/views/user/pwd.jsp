<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

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
</style>

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