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

// ==============================
// Home 메인 Masonry 카드 동적 생성
// ==============================
document.addEventListener("DOMContentLoaded", function () {
    var grid = document.querySelector(".home-grid");
    if (!grid) {
        return; // home 화면이 아니면 패스
    }

    var base = (typeof contextPath !== "undefined") ? contextPath : "";

    // 카드 데이터 정의 (이미지 / 텍스트 / 비율 / 카테고리 등)
    var cards = [
        // 1~4: 자동차 / 도로
        { fileNum: 1,  img: "/resources/images/main/backgroundflower.jpg", title: "City car at night",      meta: "자동차 · 도시",       size: "size-wide"  },
        { fileNum: 2,  img: "/resources/images/main/flowertable.jpg",      title: "Highway road trip",      meta: "여행 · 드라이브",     size: "size-tall"  },
        { fileNum: 3,  img: "/resources/images/main/hand.jpg",             title: "Vintage car close-up",   meta: "빈티지 · 디테일",     size: "size-square"},
        { fileNum: 4,  img: "/resources/images/main/redcake.jpg",          title: "Sunset on the road",     meta: "노을 · 풍경",         size: "size-xtall" },

        // 5~8: 패션 / 의류
        { fileNum: 5,  img: "/resources/images/main/vage.jpg",             title: "Minimal fashion flatlay",meta: "패션 · 미니멀",       size: "size-xwide" },
        { fileNum: 6,  img: "/resources/images/main/ring.jpg",             title: "Casual outfit on chair", meta: "데일리룩 · 캐주얼",   size: "size-wide"  },
        { fileNum: 7,  img: "/resources/images/main/clothes.jpg",          title: "Cozy winter clothes",    meta: "겨울 · 니트",         size: "size-tall"  },
        { fileNum: 8,  img: "/resources/images/main/vage.jpg",             title: "Streetwear collection",  meta: "스트릿 · 스타일",     size: "size-square"},

        // 9~12: 건축 / 도시
        { fileNum: 9,  img: "/resources/images/main/redcake.jpg",          title: "Modern city skyline",    meta: "도시 · 빌딩",         size: "size-xtall" },
        { fileNum:10,  img: "/resources/images/main/clothes.jpg",          title: "Architecture close-up",  meta: "건축 · 패턴",         size: "size-xwide" },
        { fileNum:11,  img: "/resources/images/main/hand.jpg",             title: "Glass office building",  meta: "오피스 · 비즈니스",   size: "size-wide"  },
        { fileNum:12,  img: "/resources/images/main/build.jpg",            title: "City night lights",      meta: "야경 · 라이트",       size: "size-tall"  },

        // 13~16: 스포츠 / 라이프
        { fileNum:13,  img: "/resources/images/main/vage.jpg",             title: "Tennis court lines",     meta: "스포츠 · 코트",       size: "size-square"},
        { fileNum:14,  img: "/resources/images/main/redcake.jpg",          title: "Outdoor tennis match",   meta: "경기 · 액션",         size: "size-xtall" },
        { fileNum:15,  img: "/resources/images/main/partytable.jpg",       title: "Sports lifestyle",       meta: "라이프스타일 · 운동", size: "size-xwide" },
        { fileNum:16,  img: "/resources/images/main/sky.jpg",              title: "Tennis net detail",      meta: "디테일 · 패턴",       size: "size-wide"  },

        // 17~20: 하늘 / 풍경 / 의자
        { fileNum:17,  img: "/resources/images/main/ring.jpg",             title: "Golden sunset sky",      meta: "노을 · 하늘",         size: "size-tall"  },
        { fileNum:18,  img: "/resources/images/main/egg.jpg",              title: "Cloudy afternoon",       meta: "구름 · 풍경",         size: "size-square"},
        { fileNum:19,  img: "/resources/images/main/car.jpg",              title: "Cozy chair corner",      meta: "인테리어 · 의자",     size: "size-xtall" },
        { fileNum:20,  img: "/resources/images/main/build.jpg",            title: "Reading time",           meta: "라이프스타일 · 휴식", size: "size-xwide" }
    ];

    cards.forEach(function (card) {
        var cardEl = document.createElement("div");
        cardEl.className = "home-card " + card.size;
        cardEl.style.backgroundImage = "url('" + base + card.img + "')";

        var link = document.createElement("a");
        link.href = "#";
        link.addEventListener("click", function (e) {
            e.preventDefault();
            if (typeof openpictureModal === "function") {
                openpictureModal(card.fileNum, base + card.img, card.title, "관리자");
            }
        });

        var overlay = document.createElement("div");
        overlay.className = "home-card-overlay";

        var title = document.createElement("p");
        title.className = "home-card-title";
        title.textContent = card.title;

        var meta = document.createElement("span");
        meta.className = "home-card-meta";
        meta.textContent = card.meta;

        overlay.appendChild(title);
        overlay.appendChild(meta);
        link.appendChild(overlay);
        cardEl.appendChild(link);
        grid.appendChild(cardEl);
    });
});
