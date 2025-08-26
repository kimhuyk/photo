<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<html>
<head>
<meta charset="UTF-8">
<title>프라이버시 센터</title>
<style>

</style>
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/resources/css/home.css">
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/resources/css/privacy.css">
</head>
<body style="background-color: #121212;">
    <!-- 헤더 -->
    <header class="header-top">
        <!-- 왼쪽 로고 -->
        <div class="logo">
            <img src="${pageContext.request.contextPath}/resources/images/logo/logo.png" alt="Logo" 
                 onclick="location.href='${pageContext.request.contextPath}/home';">
            <a class="policy_link" href="/">프라이버시 센터</a>
        </div>
    </header>

    <!-- 메인 콘텐츠 -->
    <div class="main-content">
        <h1 class="main-title">개인정보 이용현황</h1>
        
        <p class="intro-text">
            개인정보 이용현황은 ID별 맞춤 서비스로 제공됩니다. 
            서비스 이용 및 동의 이력에 따라 수집·이용, 제3자 제공, 처리위탁 현황을 확인할 수 있습니다.
        </p>

        <!-- 탭 네비게이션 -->
        <div class="tab-container">
            <button class="tab-button active" onclick="showTab('collection')">수집 및 이용</button>
            <button class="tab-button" onclick="showTab('third-party')">제3자 제공</button>
            <button class="tab-button" onclick="showTab('consignment')">처리위탁</button>
        </div>

        <!-- 탭 콘텐츠 -->
        <div class="tab-content">
            <!-- 수집 및 이용 탭 -->
            <div id="collection" class="tab-panel active">
                <div class="info-section">
                    <h3>기본(필수)</h3>
                    <div class="info-item">
                        <div class="info-title">개인정보 항목</div>
                        <div class="info-details">
                            <strong>&lt;회원가입&gt;</strong><br>
                            [필수] 아이디, 비밀번호, 이름, 생년월일, 성별, 휴대폰번호, CI(본인확인기관의 실명확인 시 암호화된 동일인 식별정보), DI(중복가입확인정보), 내/외국인 정보, 만14세 미만 아동의 법정대리인 정보(이름, 생년월일, 성별, DI, 휴대폰번호)<br>
                            [선택] 개인 이메일주소, 프로필 정보(선택 항목 미입력 시에도 회원가입 가능)
                        </div>
                        <div class="consent-date">동의일: 2008.10.16</div>
                    </div>
                    
                    <div class="info-item">
                        <div class="info-title">개인정보 항목</div>
                        <div class="info-details">
                            <strong>&lt;비밀번호 없이 회원가입&gt;</strong><br>
                            [필수] 아이디, 생년월일, 휴대폰번호<br>
                            [선택] 비밀번호
                        </div>
                        <div class="consent-date">동의일: 2008.10.16</div>
                    </div>
                    
                    <div class="info-item">
                        <div class="info-title">개인정보 항목</div>
                        <div class="info-details">
                            <strong>&lt;단체아이디 회원가입&gt;</strong><br>
                            [필수] 단체아이디, 비밀번호, 단체명, 이메일주소, 휴대폰번호(회원가입 인증용)<br>
                            [선택] 단체 대표자명
                        </div>
                        <div class="consent-date">동의일: 2008.10.16</div>
                    </div>
                </div>

                <div class="info-section">
                    <h3>자동생성정보</h3>
                    <div class="info-item">
                        <div class="info-title">개인정보 항목</div>
                        <div class="info-details">
                            서비스 이용 과정에서 자동으로 생성되어 수집될 수 있는 정보: IP Address, 쿠키, 서비스 이용기록, 접속 로그, 방문 일시, 서비스 이용정지 기록, 이용정지 처리 시 필요한 최소한의 정보, 기기정보, 위치정보, 이미지 또는 음성 정보(이미지 및 음성을 활용한 검색 서비스 이용 시)
                        </div>
                        <div class="consent-date">동의일: 2008.10.16</div>
                    </div>
                </div>

                <div class="info-section">
                    <h3>본인확인</h3>
                    <div class="info-item">
                        <div class="info-title">개인정보 항목</div>
                        <div class="info-details">
                            이름, 생년월일, 성별, DI, CI, 휴대폰번호 및 통신사(휴대폰 인증 시), 내/외국인 정보
                        </div>
                        <div class="consent-date">동의일: 2015.08.09</div>
                    </div>
                </div>
    
                <div></div>
                <p class="out_information" >
                	<span class="user_name">${sessionScope.loginUser.userId}님</span>
                	"은 Photo 서비스 이용을 위해 '위치정보 수집 및 이용' 에 동의하신 이용자입니다."
                	<br>
                	<span class="caution">※이용 내역이 잘 보이지 않는 경우, 잠시 후 다시 확인(Refresh)해 주세요.</span>            
                </p>
            </div>
            
		<footer class="footer">
		    <div class="footer-content">
		        <div class="footer-center">
		            <div class="footer-links">
		                <a href="#">이용약관</a>
		                <span class="separator">|</span>
		                <a class="footer_link" href="#">개인정보처리방침</a>
		                <span class="separator">|</span>
		                <a class="footer_link" href="#">책임의 한계와 법적고지</a>
		                <span class="separator">|</span>
		                <a class="footer_link" href="#">개인정보 이용현황</a>
		                <span class="separator">|</span>
		                <a class="footer_link" href="#">고객센터</a>
		            </div>
		        </div>
		        <div class="footer-right">
		            <button class="scroll-top" onclick="scrollToTop()">
		                <span class="arrow">↑</span>
		            </button>
		        </div>
		    </div>
		    <div class="copyright-container">
		        <div class="copyright">
		            © Photo All Right Reserved.
		        </div>
		    </div>
		</footer>

            <!-- 제3자 제공 탭 -->
            <div id="third-party" class="tab-panel">
                <p>제3자 제공 정보가 없습니다.</p>
            </div>

            <!-- 처리위탁 탭 -->
            <div id="consignment" class="tab-panel">
                <p>처리위탁 정보가 없습니다.</p>
            </div>
        </div>
    </div>

    <script>
        function showTab(tabName) {
            document.querySelectorAll('.tab-button').forEach(button => {
                button.classList.remove('active');
            });
            
            // 모든 탭 패널 숨기기
            document.querySelectorAll('.tab-panel').forEach(panel => {
                panel.classList.remove('active');
            });
            
            // 클릭된 탭 버튼에 active 클래스 추가
            event.target.classList.add('active');
            
            // 해당 탭 패널 보이기
            document.getElementById(tabName).classList.add('active');
        }
        
        
        function scrollToTop() {  
            window.scrollTo({
                top: 0,
                behavior: 'smooth'
            });
        }
    </script>
</body>
</html>