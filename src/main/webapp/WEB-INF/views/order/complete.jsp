<%@ page contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Order Complete</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@400;500&family=DM+Sans:wght@300;400;500&display=swap" rel="stylesheet">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/home.css">
    <link rel="icon" href="data:;base64,iVBORw0KGgo=">
    <script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/home.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/modal.js"></script>
    <style>
        .complete-wrap {
            max-width: 600px;
            margin: 120px auto;
            text-align: center;
            padding: 0 32px;
        }
        .complete-icon {
            font-size: 52px;
            color: rgba(255,255,255,0.7);
            margin-bottom: 28px;
        }
        .complete-title {
            font-family: 'Playfair Display', serif;
            font-size: clamp(28px, 4vw, 42px);
            font-weight: 400;
            color: #fff;
            margin-bottom: 14px;
        }
        .complete-desc {
            font-size: 13px;
            color: rgba(255,255,255,0.4);
            line-height: 1.8;
            margin-bottom: 40px;
        }
        .complete-order-num {
            font-size: 11px;
            letter-spacing: 2px;
            text-transform: uppercase;
            color: rgba(255,255,255,0.25);
            margin-bottom: 40px;
        }
        .complete-actions {
            display: flex;
            justify-content: center;
            gap: 14px;
            flex-wrap: wrap;
        }
        .btn-to-shop {
            background: #fff;
            border: none;
            color: #121212;
            font-family: 'DM Sans', sans-serif;
            font-size: 11px;
            font-weight: 500;
            letter-spacing: 2px;
            text-transform: uppercase;
            padding: 14px 28px;
            cursor: pointer;
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            gap: 8px;
            transition: background 0.2s;
        }
        .btn-to-shop:hover { background: #e8e8e8; }
        .btn-to-mypage {
            background: transparent;
            border: 1px solid rgba(255,255,255,0.2);
            color: rgba(255,255,255,0.5);
            font-family: 'DM Sans', sans-serif;
            font-size: 11px;
            letter-spacing: 2px;
            text-transform: uppercase;
            padding: 14px 28px;
            cursor: pointer;
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            gap: 8px;
            transition: all 0.2s;
        }
        .btn-to-mypage:hover { border-color: rgba(255,255,255,0.45); color: rgba(255,255,255,0.8); }
    </style>
</head>
<body>
<jsp:include page="/WEB-INF/views/layout/header.jsp"/>

<div class="complete-wrap">
    <div class="complete-icon">
        <i class="fas fa-check-circle"></i>
    </div>
    <h1 class="complete-title">Order Confirmed</h1>
    <p class="complete-desc">
        주문이 정상적으로 접수되었습니다.<br>
        결제 완료 후 마이페이지에서 다운로드하실 수 있습니다.
    </p>
    <p class="complete-order-num">Order No. #${orderSeq}</p>
    <div class="complete-actions">
        <a href="${pageContext.request.contextPath}/shop/shoplist" class="btn-to-shop">
            <i class="fas fa-arrow-left"></i> Continue Shopping
        </a>
        <a href="${pageContext.request.contextPath}/mypage/buyPhoto" class="btn-to-mypage">
            <i class="fas fa-user"></i> My Orders
        </a>
    </div>
</div>

</body>
</html>
