// 사진 리스트
//////////////////////////////////////
// 삭제
function deletePhoto() {
    var userName = $('#userName').val();
    var fileNum = $('#fileNum').val();
    var userSeq = Number($('#loginUser').val()); // el값 안가져오면 깨짐
  	// jsp랑 js 확실히 구분해서 하라는뜻 
  	
  	console.log("fileNum: " + fileNum);
  	console.log("userName: " + userName);
    console.log("userSeq: " + userSeq);
  
  	if (userSeq == 1) {
      alert("삭제 권한이 없습니다.");
     return;
    }
    
    if (!fileNum) {
        alert("삭제할 파일이 없습니다.");
        return;
    }

    if (confirm("삭제하시겠습니까?")) {
        $.ajax({
            url : "/app/photo/deletePhoto",
            type : "POST",
            data : { fileNum : fileNum },
            success : function(response) {
                alert("삭제 완료!");
                window.location.href = "/app/photo";
            },
            error : function(xhr, status, error) {
                console.error("Error:", error);
                alert("삭제에 실패했습니다.");
            }
        });
    }
}


//////////////////////////////////////

	// 모달창 이미지랑 열수잇게하는거 이름 넣고싶으면 이름컬럼도 넣어야댐
	function openpictureModal(fileNum, imgSrc, caption, userName) {
		console.log("이미지 경로:", imgSrc); // 확인용

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
//////////////////////////////////////
	// 다운로드
	function downloadPhoto() {
		const fileNum = document.getElementById("fileNum").value;
		if (!fileNum || fileNum.trim() === '') {
			alert("다운로드할 수 있는 사진이 없습니다.");
			return;
		}
		window.location.href = contextPath + "/photo/download?fileNum=" + fileNum;
	}
//////////////////////////////////////
	// 모달창 밖에 클릭하면 모달창이 꺼지는 스크립트
	window.onclick = function(event) {
		if (event.target == document.getElementById('photoModal')) {
			closepictureModal();
		}
	}
	
//////////////////////////////////////
// upload로 사진 등록하게 되면 /app/photo 사이트 photo dream 밑으로 불러오는
// 가로로 3개씩 채우면서 가로로 3개가 차면 다음줄로 자동 줄생성되서 3 3 3 만들수있게 하는 스크립트
	//loadPhoto 함수를 전역에서 정의
	function loadPhoto() {
		$.ajax({
			url : '/app/photo/loadPhoto.do',
			type : 'GET',
			data : { fileNum : 1 }, // 이거 안하면 컨트롤러에 null이라고 나오는데 이유는 모르겠음 뭐지? 예상으론 1장씩 등업 이런느낌인것같다
			contentType : 'application/x-www-form-urlencoded; charset=UTF-8',
			dataType : 'json',
			success : function(results) {
				$('#insertPhotoContainer').empty(); // 기존 데이터 초기화
				let currentRow;

				results.forEach(function(photo, index) {
					if (index % 3 === 0) {
						// 새로운 행 시작
						currentRow = $('<div>').addClass('photo-grid');
						$('#insertPhotoContainer').append(currentRow);
					}

					let imgPath = '/app/uploads/photo/' + photo.savefileName; // 주소 이상해서 위에다선
					console.log("리스트에서 불러오는 이미지 경로:", imgPath); // 확인용

					// figure 엘리먼트 생성 및 속성 설정
					const figure = $('<figure>').addClass('photo-item')
						.attr(
							'onclick',
							'event.preventDefault(); openpictureModal('
									+ photo.fileNum + ',"'
									+ photo.filePath.replace(/\\/g, '/') + '/'
									+ photo.savefileName + '","'
									+ photo.originalfileName + '","'
									+ photo.userName + '")') // 경로에서 역슬래시를 슬래시로 변경 안바꾸면 알지?
					.append(
							$('<img>').attr({
								src : imgPath, // 서버 경로수정했는데 위에 let imgpath으로 값줌
								alt : photo.originalfileName
							}),
							$('<figcaption>').addClass('caption').text(
									photo.originalfileName));

					currentRow.append(figure);
				});
			},
			error : function(xhr, status, error) {
				console.error("Error loading photos:", error);
			}
		});
	}
	//$(document).ready() 안에서 함수 정의
	$(document).ready(function() {

		// 페이지 로드 시 loadPhoto 실행
		loadPhoto();
	});


