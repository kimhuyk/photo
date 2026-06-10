<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<title>회원톡톡</title>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
<link rel="preconnect" href="https://fonts.googleapis.com">
<link href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@400;500&family=DM+Sans:wght@300;400;500&display=swap" rel="stylesheet">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/home.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/mypage.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/userTalk.css">
<link rel="icon" href="data:;base64,iVBORw0KGgo=">
<script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/home.js"></script>
</head>
<body>
<jsp:include page="/WEB-INF/views/layout/header.jsp"/>

<div class="container-mypage">
    <h1>회원톡톡</h1>
    <div class="mypage-layout">

        <jsp:include page="/WEB-INF/views/mypage/sidebar.jsp"/>

        <!-- 메인: 톡톡 UI -->
        <div class="mypage-main">
            <div class="talk-wrap">

                <!-- 채팅방 목록 (좌측) -->
                <div class="talk-sidebar">
                    <div class="talk-sidebar-header">
                        <span class="talk-sidebar-title">대화방</span>
                        <div class="talk-search-wrap">
                            <i class="fas fa-search"></i>
                            <input type="text" id="roomSearch" placeholder="프로필명 검색" autocomplete="off">
                        </div>
                    </div>

                    <div class="talk-room-tabs">
                        <div class="talk-tab active" data-tab="all">전체</div>
                        <div class="talk-tab" data-tab="unread">
                            <i class="fas fa-check-circle" style="margin-right:4px;"></i>안읽음
                            <span class="unread-badge" id="unreadBadge">0</span>
                        </div>
                    </div>

                    <div class="talk-room-list" id="roomList">
                        <!-- 데모 채팅방 목록 -->
                        <div class="talk-room-item active" data-room="1" onclick="selectRoom(this, 1, '고객센터', 'cs')">
                            <div class="room-avatar cs-avatar">
                                <i class="fas fa-headset"></i>
                            </div>
                            <div class="room-info">
                                <div class="room-name-row">
                                    <span class="room-name">고객센터</span>
                                    <span class="room-time">오전 0:52</span>
                                </div>
                                <div class="room-last-msg">포인트 더 받기 &gt;</div>
                            </div>
                        </div>
                        <div class="talk-room-item" data-room="2" onclick="selectRoom(this, 2, 'photoID 공식', 'official')">
                            <div class="room-avatar official-avatar">
                                <i class="fas fa-camera"></i>
                            </div>
                            <div class="room-info">
                                <div class="room-name-row">
                                    <span class="room-name">
                                        photoID 공식
                                        <i class="fas fa-check-circle verified-icon"></i>
                                    </span>
                                    <span class="room-time">5월 10일</span>
                                </div>
                                <div class="room-last-msg">구매하신 상품이 5일 뒤 자동...</div>
                            </div>
                            <span class="unread-dot">3</span>
                        </div>
                        <div class="talk-room-item" data-room="3" onclick="selectRoom(this, 3, '배송 알림', 'delivery')">
                            <div class="room-avatar delivery-avatar">
                                <i class="fas fa-truck"></i>
                            </div>
                            <div class="room-info">
                                <div class="room-name-row">
                                    <span class="room-name">배송 알림</span>
                                    <span class="room-time">5월 3일</span>
                                </div>
                                <div class="room-last-msg">주문하신 상품이 출발했습니다.</div>
                            </div>
                        </div>
                    </div>

                    <div class="talk-sidebar-footer">
                        <a href="#" class="channel-manage">채널관리 하러가기 &gt;</a>
                    </div>
                </div>

                <!-- 채팅창 (우측) -->
                <div class="talk-chat-area" id="chatArea">

                    <!-- 채팅 헤더 -->
                    <div class="chat-header" id="chatHeader">
                        <div class="chat-header-info">
                            <span class="chat-header-name" id="chatHeaderName">고객센터</span>
                            <i class="fas fa-check-circle" id="chatVerifiedIcon" style="display:none;"></i>
                        </div>
                        <div class="chat-header-actions">
                            <i class="fas fa-bars"></i>
                        </div>
                    </div>

                    <!-- 메시지 목록 -->
                    <div class="chat-messages" id="chatMessages">
                        <!-- 날짜 구분선 -->
                        <div class="chat-date-divider">오전 0:52</div>

                        <!-- 상대방 메시지 (포인트 카드) -->
                        <div class="chat-msg received">
                            <div class="msg-avatar cs-avatar"><i class="fas fa-headset"></i></div>
                            <div class="msg-bubble-wrap">
                                <div class="msg-sender">고객센터</div>
                                <div class="msg-card">
                                    <div class="msg-card-title">포인트가 <span style="color:#03c75a;">적립</span>되었습니다.</div>
                                    <div class="msg-card-body">
                                        <div>
                                            <div class="msg-card-point">구매적립 <strong style="color:#03c75a;">122원</strong></div>
                                            <div class="msg-card-sub">[photoID Shop]<br>최근 구매 상품</div>
                                        </div>
                                        <img src="https://placehold.co/56x56/1c1c1c/555?text=P" alt="상품" class="msg-card-img">
                                    </div>
                                    <div class="msg-card-divider"></div>
                                    <div class="msg-card-row">
                                        <span>나의 포인트</span>
                                        <span>146원</span>
                                    </div>
                                    <a href="#" class="msg-card-link">포인트 더 받기 &gt;</a>
                                </div>
                                <div class="msg-time">오전 0:52</div>
                            </div>
                        </div>

                        <div class="chat-date-divider">오전 11:17</div>

                        <!-- 일반 텍스트 메시지 -->
                        <div class="chat-msg received">
                            <div class="msg-avatar cs-avatar"><i class="fas fa-headset"></i></div>
                            <div class="msg-bubble-wrap">
                                <div class="msg-sender">고객센터</div>
                                <div class="msg-bubble">안녕하세요! photoID 고객센터입니다. 무엇을 도와드릴까요?</div>
                                <div class="msg-time">오전 11:17</div>
                            </div>
                        </div>

                        <!-- 내 메시지 -->
                        <div class="chat-msg sent">
                            <div class="msg-bubble-wrap">
                                <div class="msg-bubble">구매한 사진 다운로드가 안돼요.</div>
                                <div class="msg-time">오전 11:20</div>
                            </div>
                        </div>

                        <div class="chat-msg received">
                            <div class="msg-avatar cs-avatar"><i class="fas fa-headset"></i></div>
                            <div class="msg-bubble-wrap">
                                <div class="msg-sender">고객센터</div>
                                <div class="msg-bubble">불편을 드려서 죄송합니다. 마이페이지 → 구매한 사진에서 다운로드 버튼을 눌러보세요!</div>
                                <div class="msg-time">오전 11:21</div>
                            </div>
                        </div>
                    </div>

                    <!-- 메시지 입력창 -->
                    <div class="chat-input-area">
                        <div class="chat-input-wrap">
                            <button class="chat-action-btn" title="파일 첨부">
                                <i class="fas fa-paperclip"></i>
                            </button>
                            <input type="text" class="chat-input" id="chatInput" placeholder="메시지를 입력하세요" autocomplete="off">
                            <button class="chat-action-btn" title="이모지"><i class="fas fa-smile"></i></button>
                            <button class="chat-send-btn" id="sendBtn" onclick="sendMessage()">
                                <i class="fas fa-paper-plane"></i>
                            </button>
                        </div>
                        <div class="chat-input-footer">
                            <span>톡톡 서비스 이용정책</span>
                            <span class="sep">·</span>
                            <span>개인정보 처리방침</span>
                            <span class="sep">·</span>
                            <span>로그아웃</span>
                        </div>
                    </div>

                </div>
            </div>
        </div>
    </div>
</div>

<script>
let myName = '${sessionScope.loginUser.userName}';

/* 채팅방 선택 */
function selectRoom(el, roomId, name, type) {
    document.querySelectorAll('.talk-room-item').forEach(function(r) {
        r.classList.remove('active');
    });
    el.classList.add('active');
        let dot = el.querySelector('.unread-dot');
        if (dot) dot.remove();

    document.getElementById('chatHeaderName').textContent = name;
        let verified = document.getElementById('chatVerifiedIcon');
        verified.style.display = (type === 'official' || type === 'cs') ? 'inline' : 'none';
        updateUnreadBadge();
        scrollToBottom();
}

/*  메시지 전송 */
function sendMessage() {
    let input = document.getElementById('chatInput');
    let text  = input.value.trim();
    if (!text) return;

    let now = new Date();
    let timeStr = now.getHours() < 12
        ? '오전 ' + now.getHours() + ':' + String(now.getMinutes()).padStart(2, '0')
        : '오후 ' + (now.getHours() - 12) + ':' + String(now.getMinutes()).padStart(2, '0');

    let msgEl = document.createElement('div');
    msgEl.className = 'chat-msg sent';
    msgEl.innerHTML =
        '<div class="msg-bubble-wrap">' +
            '<div class="msg-bubble">' + escapeHtml(text) + '</div>' +
            '<div class="msg-time">' + timeStr + '</div>' +
        '</div>';
    document.getElementById('chatMessages').appendChild(msgEl);
    input.value = '';
    scrollToBottom();

    // 자동 응답 (데모용)
    setTimeout(function() {
        let autoEl = document.createElement('div');
        autoEl.className = 'chat-msg received';
        autoEl.innerHTML =
            '<div class="msg-avatar cs-avatar"><i class="fas fa-headset"></i></div>' +
            '<div class="msg-bubble-wrap">' +
                '<div class="msg-sender">고객센터</div>' +
                '<div class="msg-bubble">문의 감사합니다. 담당자가 확인 후 답변드리겠습니다.</div>' +
                '<div class="msg-time">' + timeStr + '</div>' +
            '</div>';
        document.getElementById('chatMessages').appendChild(autoEl);
        scrollToBottom();
    }, 1000);
}

function escapeHtml(str) {
    return str.replace(/&/g,'&amp;').replace(/</g,'&lt;').replace(/>/g,'&gt;');
}

function scrollToBottom() {
    let el = document.getElementById('chatMessages');
    el.scrollTop = el.scrollHeight;
}

function updateUnreadBadge() {
    let dots = document.querySelectorAll('.unread-dot');
    document.getElementById('unreadBadge').textContent = dots.length;
}

/* 엔터 전송 */
document.getElementById('chatInput').addEventListener('keypress', function(e) {
    if (e.key === 'Enter') sendMessage();
});

/* ── 채팅방 검색 ── */
document.getElementById('roomSearch').addEventListener('input', function() {
    let kw = this.value.toLowerCase();
    document.querySelectorAll('.talk-room-item').forEach(function(item) {
    let name = item.querySelector('.room-name').textContent.toLowerCase();
    item.style.display = name.includes(kw) ? '' : 'none';
    });
});

/* 탭 */
document.querySelectorAll('.talk-tab').forEach(function(tab) {
    tab.addEventListener('click', function() {
        document.querySelectorAll('.talk-tab').forEach(function(t) { t.classList.remove('active'); });
        this.classList.add('active');
        let filter = this.dataset.tab;
        document.querySelectorAll('.talk-room-item').forEach(function(item) {
            if (filter === 'all') {
                item.style.display = '';
            } else {
                item.style.display = item.querySelector('.unread-dot') ? '' : 'none';
            }
        });
    });
});

updateUnreadBadge();
scrollToBottom();
</script>

</body>
</html>
