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
    // upload로 사진 등록하게 되면 /app/photo 사이트 photo dream 밑으로 불러오는
    // 가로로 3개씩 채우면서 가로로 3개가 차면 다음줄로 자동 줄생성되서 3 3 3 만들수있게 하는 스크립트
	//loadPhoto 함수를 전역에서 정의
	function loadPhoto() {
        let url = (typeof contextPath !== "undefined") ? contextPath : "/app";

        $.ajax({
            url: url + '/photo/loadPhoto.do',
            type: 'GET',
            data: { fileNum: 1 },
            dataType: 'json',
            success: function(results) {
                $('#insertPhotoContainer').empty();

                // 변수를 루프 밖에서 미리 선언합니다.
                let $currentRow;

                results.forEach(function(photo, index) {
                    // 3개마다 새로운 행(Grid)을 생성합니다.
                    if (index % 3 === 0) {
                        $currentRow = $('<div>').addClass('photo-grid');
                        $('#insertPhotoContainer').append($currentRow);
                    }

                    // 이미지 경로 설정 (콘솔에 찍힌 정상 경로 사용)
                    let imgPath = url + '/uploads/photo/' + photo.savefileName;

                    // figure 엘리먼트 생성 및 속성 설정
                    const figure = $('<figure>').addClass('photo-item')
                        .attr('onclick'
                            , `event.preventDefault(); openpictureModal(
                                '${photo.fileNum}'
                                , '${imgPath}'
                                , '${photo.originalfileName}'
                                , '${photo.userName}')`)
                        .append(
                            $('<img>').attr({
                                src: imgPath,
                                alt: photo.originalfileName
                            }),
                            $('<figcaption>').addClass('caption').text(photo.originalfileName)
                        );
                    $currentRow.append(figure);
                });
            },
            error: function(xhr, status, error) {
                console.error("Error loading photos:", error);
            }
        });
    }
	//$(document).ready() 안에서 함수 정의
	$(document).ready(function() {

		// 페이지 로드 시 loadPhoto 실행
		loadPhoto();
	});


