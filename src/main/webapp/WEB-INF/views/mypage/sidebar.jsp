<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<div class="mypage-sidebar">
    <div class="sidebar-header">
        <div class="photo-logo">
            <span class="logo-text">P</span>
            <span class="logo-title">photoID</span>
        </div>
    </div>
    <div class="profile-section">
        <div class="profile-image-container">
            <img src="${pageContext.request.contextPath}/resources/images/story/sajin3.jpg" alt="프로필" class="profile-image">
            <label class="edit-icon" for="profileFileInput" title="프로필 사진 변경">
                ✏️
                <input type="file" id="profileFileInput" accept="image/*"
                       style="display:none;">
            </label>
        </div>
        <div class="profile-info">
            <div class="nickname">${sessionScope.loginUser.userName}</div>
            <div class="email">${sessionScope.loginUser.email}</div>
        </div>
        <button class="passkey-btn">
            <span class="new-tag">NEW</span>
            비밀번호 대신 패스키 로그인
        </button>
        <div class="passkey-desc">지문, 얼굴인식으로 간편하게 로그인하세요.</div>
    </div>
    <nav class="sidebar-nav">
        <a href="${pageContext.request.contextPath}/mypage"
           class="nav-item ${activeMenu == 'mypage' ? 'active' : ''}">
            <span class="nav-icon">◆</span> 내프로필
        </a>
        <a href="${pageContext.request.contextPath}/mypage/security"
           class="nav-item ${activeMenu == 'security' ? 'active' : ''}">
            <span class="nav-icon">◆</span> 보안설정
        </a>
        <a href="${pageContext.request.contextPath}/mypage/buyPhoto"
           class="nav-item ${activeMenu == 'buyPhoto' ? 'active' : ''}">
            <span class="nav-icon">◆</span> 구매한 사진
        </a>
        <div class="nav-divider"></div>
        <a href="${pageContext.request.contextPath}/smartchat"
           class="nav-item ${activeMenu == 'smartChat' ? 'active' : ''}">
            <span class="nav-icon">◆</span> 스마트봇 상담
        </a>
        <a href="${pageContext.request.contextPath}/mypage/userTalk"
           class="nav-item ${activeMenu == 'userTalk' ? 'active' : ''}">
            <span class="nav-icon">◆</span> 회원톡톡
        </a>
    </nav>
    <div class="promo-banner">
        <div class="banner-content">
            <div class="banner-icon">🔔</div>
            <div class="banner-text">
                새벽 4시에 로그인?<br>
                2단계 인증, 늦기 전에 미리 설정!
            </div>
        </div>
    </div>
    <div class="bottom-links">
        <a href="${pageContext.request.contextPath}/login/logout" class="bottom-link">로그아웃</a>
        <span class="separator">|</span>
        <a href="#" class="bottom-link">고객센터</a>
        <span class="separator">|</span>
        <a href="#" class="bottom-link">한국어</a>
    </div>
    <div class="bottom-logo">
        <span class="photo-text">Photo</span>
    </div>
</div>
