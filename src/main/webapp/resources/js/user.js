// ID 중복 검사
function checkId() {
    var userId = $('#userId').val();  // #userId 요소에서 값 가져오기

    // 아이디 길이가 4글자 이상일 때만 검사
    if (userId.length < 2) {
        $('.userId_ok').css("display", "none");
        $('.userId_already').css("display", "none");
        return;  // 길이가 4자 미만이면 검사하지 않음
    }

    // AJAX 요청을 통해 아이디 중복 검사
    $.ajax({
        url: '/app/user/user_idCheck',  // 컨트롤러에서 url 직접받기
        type: 'post',  // POST 방식으로 전송
        data: { userId: userId },  
        success: function(response) {
            if (response.passed === "true") {  // 사용 가능한 아이디
                $('.userId_ok').css("display", "inline-block");
                $('.userId_already').css("display", "none");
            } else {  // 이미 존재할때
                $('.userId_already').css("display", "inline-block");
                $('.userId_ok').css("display", "none");
                alert("아이디를 다시 입력해주세요");
                //$('#userId').val('');  // 아이디 입력란 초기화
            }
        },
        error: function() {
            alert("에러가 발생했습니다.");
        }
    });
}

// input에 값이 입력될 때마다 실시간으로 checkId() 함수 호출
$(document).ready(function() {
    $('#userId').on('input', function() {
        checkId();
    });
});


function userOk() {
		const f = document.userForm;
		let str;
		
		str = f.userId.value;
		if (!/^[a-z0-9][a-z0-9_]{4,9}$/i.test(str)) {
			alert("아이디는 5자 이상 10자 이하로 입력해주세요.");
			f.userId.focus();
			return;
		}
		
		str = f.userPwd.value;
		if (!/^(?=.*[a-z])(?=.*[!@#$%^*+=-]|.*[0-9]).{5,10}$/i.test(str)) {
			alert("패스워드를 다시 입력 하세요. ");
			f.userPwd.focus();
			return;
		}

		if (str !== f.userPwd2.value) {
			alert("패스워드가 일치하지 않습니다. ");
			f.userPwd.focus();
			return;
		}
		
		str = f.userName.value;
		if (!/^[가-힣]{2,5}$/.test(str)) {
			alert("이름을 다시 입력하세요. ");
			f.userName.focus();
			return;
		}
		// 이메일
		str = f.email.value.trim();
		if (!str) {
		    alert("이메일을 입력하세요.");
		    f.email.focus();
		    return;
		}
//	// 이메일 검사
//	if (!/^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/.test(str)) {
//	    alert("올바른 이메일 형식으로 입력해주세요. (예: example@naver.com)");
//	    f.email.focus();
//	    return;
//	}

		// 생년월일
		str = f.birth.value.trim(); // 생년월일 입력값 가져오기
		if (!str) {
		    alert("생년월일을 입력하세요.");
		    f.birth.focus();
		    return;
		}
		
		// 생년월일 확인
		if (!/^\d{4}-\d{2}-\d{2}$/.test(str)) {
		    alert("생년월일 형식이 잘못되었습니다. (예: 1999-12-11)");
		    f.birth.focus();
		    return;
		}
		
		// 전화번호
		str = f.tel.value; 
		if (!/^\d{3}-\d{4}-\d{4}$/.test(str)) {
		    alert("전화번호 형식에 맞게 입력해주세요. (예: 010-1234-5678)");
		    f.tel.focus();
		    return;
		}
		//f.action = "${pageContext.request.contextPath}/user/${mode}"
		f.submit();
}



