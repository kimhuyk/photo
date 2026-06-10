<%@ page contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>스마트봇 상담</title>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
<link rel="preconnect" href="https://fonts.googleapis.com">
<link href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@400;500&family=DM+Sans:wght@300;400;500&display=swap" rel="stylesheet">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/home.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/mypage.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/smartChat.css">
<link rel="icon" href="data:;base64,iVBORw0KGgo=">
<script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/home.js"></script>
</head>
<body>
<jsp:include page="/WEB-INF/views/layout/header.jsp"/>

<div class="container-mypage">
    <h1>마이페이지</h1>
    <div class="mypage-layout">

        <jsp:include page="/WEB-INF/views/mypage/sidebar.jsp"/>

        <div class="mypage-main">
            <div class="sc-wrap">

                <!-- 헤더 -->
                <div class="sc-header">
                    <div class="sc-header-left">
                        <div class="sc-bot-avatar"><i class="fas fa-robot"></i></div>
                        <div>
                            <div class="sc-bot-name">photoID 스마트봇</div>
                            <div class="sc-bot-status"><span class="sc-online-dot"></span> 온라인</div>
                        </div>
                    </div>
                    <button class="sc-clear-btn" onclick="clearHistory()" title="대화 초기화">
                        <i class="fas fa-trash-alt"></i> 초기화
                    </button>
                </div>

                <!-- 메시지 영역 -->
                <div class="sc-messages" id="scMessages">
                    <!-- 환영 메시지 -->
                    <div class="sc-msg bot">
                        <div class="sc-msg-avatar"><i class="fas fa-robot"></i></div>
                        <div class="sc-msg-wrap">
                            <div class="sc-msg-bubble">
                                안녕하세요! photoID 스마트봇입니다. 😊<br><br>
                                주문, 다운로드, 환불, 상품 등 무엇이든 물어보세요!
                            </div>
                            <div class="sc-msg-time">지금</div>
                        </div>
                    </div>
                </div>

                <!-- 빠른 질문 버튼 -->
                <div class="sc-quick-btns" id="scQuickBtns">
                    <button onclick="quickSend('다운로드 방법이 궁금해요')">다운로드 방법</button>
                    <button onclick="quickSend('환불 정책이 어떻게 되나요?')">환불 정책</button>
                    <button onclick="quickSend('주문 내역은 어디서 보나요?')">주문 내역</button>
                    <button onclick="quickSend('상품 가격이 궁금해요')">상품 가격</button>
                </div>

                <!-- 입력창 -->
                <div class="sc-input-area">
                    <div class="sc-input-wrap">
                        <input type="text" id="scInput" class="sc-input"
                               placeholder="메시지를 입력하세요..." autocomplete="off">
                        <button class="sc-send-btn" id="scSendBtn" onclick="sendMessage()">
                            <i class="fas fa-paper-plane"></i>
                        </button>
                    </div>
                    <div class="sc-input-note">AI 기반 자동응답 서비스입니다. 복잡한 문의는 고객센터를 이용해주세요.</div>
                </div>
            </div>
        </div>
    </div>
</div>

<script>
let contextPath = '${pageContext.request.contextPath}';
let isLoading = false;

/* 대화 내역 불러오기 */
function loadHistory() {
    $.ajax({
        url     : contextPath + '/smartchat/history',
        type    : 'GET',
        dataType: 'json',
        success : function(data) {
            if (!data || data.length === 0) return;
            $('#scMessages').find('.sc-msg.bot:first').remove(); // 환영메시지 제거
            data.forEach(function(chat) {
                appendMessage(chat.sender, chat.message, chat.regDate);
            });
            scrollToBottom();
        }
    });
}

/* 메시지 전송 */
function sendMessage() {
    if (isLoading) return;
    let input = document.getElementById('scInput');
    let text  = input.value.trim();
    if (!text) return;

    // 빠른 질문 버튼 숨기기
    $('#scQuickBtns').hide();

    // 사용자 메시지 표시
    appendMessage('user', text, now());
    input.value = '';

    // 로딩 표시
    isLoading = true;
    let loadingId = appendLoading();
    scrollToBottom();

    $.ajax({
        url        : contextPath + '/smartchat/send',
        type       : 'POST',
        contentType: 'application/json',
        data       : JSON.stringify({ message: text }),
        success    : function(res) {
            removeLoading(loadingId);
            isLoading = false;
            if (res.status === 'ok') {
                appendMessage('bot', res.response, now());
            } else if (res.status === 'login') {
                appendMessage('bot', '로그인이 필요합니다.', now());
            } else {
                appendMessage('bot', '오류가 발생했습니다. 잠시 후 다시 시도해주세요.', now());
            }
            scrollToBottom();
        },
        error: function() {
            removeLoading(loadingId);
            isLoading = false;
            appendMessage('bot', '서버 오류가 발생했습니다.', now());
            scrollToBottom();
        }
    });
}

/* 빠른 질문 */
function quickSend(text) {
    document.getElementById('scInput').value = text;
    sendMessage();
}

/* 메시지 DOM 추가 */
function appendMessage(sender, message, time) {
    let isBot = sender === 'bot';
    let msgHtml =
        '<div class="sc-msg ' + (isBot ? 'bot' : 'user') + '">' +
            (isBot ? '<div class="sc-msg-avatar"><i class="fas fa-robot"></i></div>' : '') +
            '<div class="sc-msg-wrap">' +
                '<div class="sc-msg-bubble">' + escapeHtml(message).replace(/\n/g, '<br>') + '</div>' +
                '<div class="sc-msg-time">' + (time || '') + '</div>' +
            '</div>' +
        '</div>';
    $('#scMessages').append(msgHtml);
}

/* 로딩 표시 */
function appendLoading() {
    let id = 'loading_' + Date.now();
    let html =
        '<div class="sc-msg bot" id="' + id + '">' +
            '<div class="sc-msg-avatar"><i class="fas fa-robot"></i></div>' +
            '<div class="sc-msg-wrap">' +
                '<div class="sc-msg-bubble sc-loading">' +
                    '<span></span><span></span><span></span>' +
                '</div>' +
            '</div>' +
        '</div>';
    $('#scMessages').append(html);
    return id;
}

function removeLoading(id) {
    $('#' + id).remove();
}

/* 대화 초기화 */
function clearHistory() {
    if (!confirm('대화 내역을 모두 삭제하시겠습니까?')) return;
    $.ajax({
        url    : contextPath + '/smartchat/clear',
        type   : 'POST',
        success: function(res) {
            if (res.status === 'ok') {
                $('#scMessages').empty();
                appendMessage('bot', '대화 내역이 초기화되었습니다. 무엇을 도와드릴까요? 😊', now());
                $('#scQuickBtns').show();
                scrollToBottom();
            }
        }
    });
}

function scrollToBottom() {
    let el = document.getElementById('scMessages');
    el.scrollTop = el.scrollHeight;
}

function now() {
    let d = new Date();
    let h = d.getHours(), m = d.getMinutes();
    return (h < 12 ? '오전 ' : '오후 ') + (h % 12 || 12) + ':' + String(m).padStart(2, '0');
}

function escapeHtml(str) {
    return String(str)
        .replace(/&/g, '&amp;')
        .replace(/</g, '&lt;')
        .replace(/>/g, '&gt;')
        .replace(/"/g, '&quot;');
}

/* 엔터 전송 */
document.getElementById('scInput').addEventListener('keypress', function(e) {
    if (e.key === 'Enter' && !e.shiftKey) { e.preventDefault(); sendMessage(); }
});

$(document).ready(function() {
    loadHistory();
});
</script>
</body>
</html>
