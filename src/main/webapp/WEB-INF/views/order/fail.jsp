<%@ page contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Payment Failed</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@400;500&family=DM+Sans:wght@300;400;500&display=swap" rel="stylesheet">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/home.css">
    <link rel="icon" href="data:;base64,iVBORw0KGgo=">
    <script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/home.js"></script>
    <style>
        .fail-wrap {
            max-width: 600px;
            margin: 120px auto;
            text-align: center;
            padding: 0 32px;
        }
        .fail-icon { font-size: 52px; color: rgba(255,100,100,0.7); margin-bottom: 28px; }
        .fail-title {
            font-family: 'Playfair Display', serif;
            font-size: clamp(28px, 4vw, 40px);
            font-weight: 400;
            color: #fff;
            margin-bottom: 14px;
        }
        .fail-desc { font-size: 13px; color: rgba(255,255,255,0.4); line-height: 1.8; margin-bottom: 12px; }
        .fail-code { font-size: 11px; color: rgba(255,100,100,0.4); margin-bottom: 36px; }
        .btn-retry {
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
        .btn-retry:hover { background: #e8e8e8; }
    </style>
</head>
<body>
<jsp:include page="/WEB-INF/views/layout/header.jsp"/>
<div class="fail-wrap">
    <div class="fail-icon"><i class="fas fa-times-circle"></i></div>
    <h1 class="fail-title">Payment Failed</h1>
    <p class="fail-desc">${errorMsg}</p>
    <p class="fail-code">${errorCode}</p>
    <a href="${pageContext.request.contextPath}/order/checkout" class="btn-retry">
        <i class="fas fa-redo"></i> 다시 시도
    </a>
</div>
</body>
</html>
