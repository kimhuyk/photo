// 모달창 이미지랑 열수잇게하는거 이름 넣고싶으면 이름컬럼도 넣어야댐
function openpictureModal(fileNum, imgSrc, caption, userName) {

    if (!imgSrc || imgSrc.trim() === '') {
        alert("사진이 없습니다.");
        return;
    }

    document.getElementById("modalImage").src = imgSrc;
    document.getElementById("modalCaption").innerText = caption;
    document.getElementById("fileNum").value = fileNum; // 폼의 hidden input 업데이트
    document.getElementById("userName").innerText = "등록자: " + userName; // 작성자 이름 추가
    // 모달
    document.getElementById("photoModal").style.display = "block"; // 모달 표시
}

// 모달닫기
function closepictureModal() {
    document.getElementById("photoModal").style.display = "none"; // 모달 숨기기
}

// 모달 밖 클릭시 모달 닫기
window.onclick = function (event) {
    if (event.target == document.getElementById('photoModal')) {
        closepictureModal();
    }
}

// 다운로드
function downloadPhoto() {
    const fileNum = document.getElementById("fileNum").value;
    if (!fileNum || fileNum.trim() === '') {
        alert("다운로드할 수 있는 사진이 없습니다.");
        return;
    }
    window.location.href = contextPath + "/photo/download?fileNum=" + fileNum;
}