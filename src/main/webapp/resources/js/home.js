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
        error: function(xhr) {
            alert("로그인 처리 중 오류가 발생했습니다.");
            console.error(xhr.status);
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

// ==============================
// Home 메인 Masonry 카드 동적 생성 (서버 연동형)
// ==============================
$(function() {
    const $grid = $(".home-grid");
    if ($grid.length === 0) {
        return; // 그리드 영역이 없으면 실행 안 함
    }

    const base = (typeof contextPath !== "undefined") ? contextPath : "";

    // AJAX를 이용해 PhotoController에서 데이터 가져오기
    $.ajax({
        url: '/app/photo/loadPhoto.do',
        type: 'GET',
        dataType: "json",
        success: function(data) {
            if (!data || data.length === 0) {
                $grid.html("<p style='text-align:center; padding:50px;'>등록된 사진이 없습니다.</p>");
                return;
            }

            let sizePatterns = [
                "size-wide", "size-tall", "size-square", "size-xtall", "size-xwide",
                "size-tall", "size-wide", "size-xwide", "size-square", "size-xtall"
            ];

            let html = "";
            $.each(data, function(index, photo) {
                // 사이즈 패턴 결정
                let sizeClass = sizePatterns[index % sizePatterns.length];

                let imgPath = base + "/uploads/photo/" + photo.savefileName;

                // 카드 요소 생성
                html += `
                    <div class="home-card ${sizeClass}" style="background-image: url('${imgPath}');">
                      <a href="javascript:void(0);" onclick="openpictureModal('${photo.fileNum}', '${imgPath}', '${photo.originalfileName}', '${photo.userName}')">
                        <div class="home-card-overlay">
                          <p class="home-card-title">${photo.originalfileName}</p>
                          <span class="home-card-meta">${photo.userName} · ${(photo.regDate ? photo.regDate.substring(0, 10) : "")}</span>
                        </div>
                      </a>
                    </div>`;
            });

            // 그리드에 한꺼번에 삽입
            $grid.html(html);
        },
        error: function(e) {
            console.error("사진 목록 로딩 실패:", e.responseText);
        }
    });
});