// 로그인 
function sendLogin() {
    const userId = document.getElementById("userId").value.trim();
    const userPwd = document.getElementById("userPwd").value.trim();

    if (!userId) {
        alert("아이디를 입력하세요.");
        document.getElementById("userId").focus();
        return;
    }

    if (!userPwd) {
        alert("비밀번호를 입력하세요.");
        document.getElementById("userPwd").focus();
        return;
    }

    $.ajax({
        type: "POST",
        url: "/app/login/login",  // 컨트롤러 매핑에 맞춰 URL 설정
        data: {
            userId: userId,
            userPwd: userPwd
        },
        success: function(response) {
            if (response === "success") {
                window.location.href = "/app/home";
            } else {
                alert("아아디 또는 비밀번호가 일치하지 않습니다"); // 서버에서 전달한 메시지 출력
            }
        },
        error: function(xhr, status, error) {
            alert("로그인 처리 중 오류가 발생했습니다.");
            console.error(xhr.responseText);
        }
    });
}


// 로그인 모달 창
function openModal() {
    document.getElementById("loginModal").style.display = "flex";
}

function closeModal() {
	document.getElementById("loginModal").style.display = "none";
}
