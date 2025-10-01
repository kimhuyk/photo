<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>배송지 관리</title>
<style>

</style>
<link rel="stylesheet" type="text/css" 
	href="${pageContext.request.contextPath}/resources/css/delivery.css">
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/resources/css/home.css">
<!-- 스크립트 링크 -->
<script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/home.js"></script>
<jsp:include page="/WEB-INF/views/layout/header.jsp" />
</head>
<body>
    <!-- 메인 콘텐츠 -->
   <div class="container-delivery">
        <h1 class="main-title">배송지 관리</h1>

        <div class="tab-container">
            <button class="tab-button active" onclick="showTab('list')">배송지 목록</button>
            <button class="tab-button" onclick="showTab('recent')">최근 배송지</button>
        </div>

        <div class="tab-content">
            <div id="list" class="tab-panel active">
                <div class="address-list" id="addressListContainer">
                    <div class="empty-state">
                        <div class="empty-icon">📦</div>
                        <div class="empty-message">배송지를 등록해주세요</div>
                        <div class="empty-desc">첫 번째 배송지를 등록하시면 여기에 표시됩니다.</div>
                    </div>
                    
                </div>
                
                <div class="info-message">
                    <span class="info-icon">ℹ️</span>
                    배송지는 최대 15개까지 등록하실 수 있습니다.
                </div>
            </div>

            <div id="recent" class="tab-panel">
            	<div class="empty-state">
                    <div class="empty-icon">🕒</div>
                    <div class="empty-message">최근 배송지가 없습니다</div>
                    <div class="empty-desc">배송지를 등록하고 사용하시면 최근 배송지에 표시됩니다.</div>
                </div>
                
                <div class="info-message">
                    <span class="info-icon">ℹ️</span>
                    <strong>확인해주세요</strong>
                    <div>
	                    <p>각 주소 옆 저장 버튼 클릭 시 배송지 목록에 등록됩니다.</p>
					</div>
					<div>	
						<p>저장 버튼이 보이지 않는 경우 이미 등록된 배송지입니다.</p>
                	</div>
                </div>
	        </div>
	
	        <div class="register-section">
	            <button class="register-btn" onclick="addAddress()">배송지 등록</button>
	        </div>
	    </div>
    </div>
    <script>
    	// 배송지 목록, 최근 배송지
        function showTab(tabName) {
            document.querySelectorAll('.tab-button').forEach(button => { // 배송지 목록
                button.classList.remove('active');
            });
            
            // 모든 탭 패널 숨기기
            document.querySelectorAll('.tab-panel').forEach(panel => { // 최근 배송지
                panel.classList.remove('active');
            });
            ////////////////////////////////////////////////////////////////////////
            event.target.classList.add('active');
            
            document.getElementById(tabName).classList.add('active');
        }
		// 배송지 입력 페이지
        function addAddress() {
            location.href = " ${pageContext.request.contextPath}/delivery/insert ";
        }
		
		// 등록된 배송지 불러오기
        // 페이지가 로딩되면 배송지 목록을 불러오는 함수를 실행
        $(document).ready(function() {
            loadDeliveryList();
        });

// 서버에서 배송지 목록을 불러와 화면뽑기
function loadDeliveryList() {
    $.ajax({
        url: "${pageContext.request.contextPath}/delivery/listData",
        type: "POST",
        dataType: "json",
        success: function(response) {
            const container = $('#addressListContainer');
            container.empty();

            const list = response.data || [];

            if (list.length > 0) {
                list.forEach(function(item) {
                    const addressItemHTML = `
                        <div class="address-item">
                            <div class="address-info">
                                <div class="address-header">
                                    <span class="address-name">${'$'}{item.deName}</span>
                                    ${'$'}{item.dlvrpl === 'Y' ? '<span class="default-tag">기본배송지</span>' : ''}
                                </div>
                                <div class="address-phone">${'$'}{item.phone1}</div>
                                <div class="address-detail">
                                    ${'$'}{item.address} ${'$'}{item.detailAddress} (${ '$'}{item.addressZip })
                                </div>
                            </div>
                            <div class="address-actions">
                                <button class="action-btn edit-btn" onclick="editAddress(${ '$'}{item.deNum})">수정</button>
                                <button class="action-btn delete-btn" onclick="deleteAddress(${ '$'}{item.deNum})">삭제</button>
                            </div>
                        </div>
                    `;
                    container.append(addressItemHTML);
                });
            } else {
                container.append(`
                    <div class="empty-state">
                        <div class="empty-icon">📦</div>
                        <div class="empty-message">배송지를 등록해주세요</div>
                        <div class="empty-desc">첫 번째 배송지를 등록하시면 여기에 표시됩니다.</div>
                    </div>
                `);
            }
        },
        error: function(xhr, status, error) {
            console.error("배송지 목록을 불러오는 중 오류:", error);
            $('#addressListContainer').empty().append(`
                <div class="empty-state">
                    <div class="empty-message">오류가 발생했습니다.</div>
                </div>
            `);
        }
    });
}
// 배송지 삭제 스크립트
function deleteAddress(deNum){
	if(confirm ("주소를 삭제 하시겠습니까?")) {
		$.ajax({
			url: '${pageContext.request.contextPath}/delivery/delete',
			type: 'POST',
			data: { deNum: deNum},
			success: function(response) {
				console.log("주소 삭제 성공")
				alert("주소가 삭제 되었습니다.");
				loadDeliveryList();	// 목록 재갱신
			},
			error: function(xhr, status, error) {
				alert("주소 삭제 중 오류가 발생하였습니다.")
				console.error("주소 삭제 요청 실패", status, error);
				console.error("서버 응답:", xhr.responseText);
			}
		});
	} else {
		alert("주소 삭제가 취소되었습니다.");
	}
}
// 등록된 배송지 정보 불러오기 (button click)
function editAddress(deNum) {
    // 폼을 동적으로 생성하여 POST
    const form = document.createElement('form');
    form.method = 'POST';
    form.action = '${pageContext.request.contextPath}/delivery/updateForm';

    // hidden input 필드를 생성하여 deNum 값을 담기
    const hiddenField = document.createElement('input');
    hiddenField.type = 'hidden';
    hiddenField.name = 'deNum';
    hiddenField.value = deNum;

    // hidden input 필드를 폼에 추가합니다
    form.appendChild(hiddenField);

    document.body.appendChild(form);
    form.submit();
}
		
        
        
    </script>
</body>
</html>