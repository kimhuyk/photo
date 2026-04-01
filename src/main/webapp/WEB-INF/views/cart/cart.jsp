<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
    <title>Cart</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@400;500&family=DM+Sans:wght@300;400;500&display=swap" rel="stylesheet">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/home.css">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/cart.css">
    <link rel="icon" href="data:;base64,iVBORw0KGgo=">
    <script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/home.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/modal.js"></script>
</head>
<body>
<jsp:include page="/WEB-INF/views/layout/header.jsp"/>

<div class="cart-page">

    <!-- 페이지 타이틀 -->
    <div class="cart-header">
        <div class="cart-header-left">
            <p class="cart-label">(Your selections)</p>
            <h1 class="cart-title">Cart</h1>
        </div>
        <a href="${pageContext.request.contextPath}/shop/shoplist" class="btn-continue">
            <i class="fas fa-arrow-left"></i> Continue Shopping
        </a>
    </div>

    <div class="cart-body">

        <!-- 카트 아이템 목록 -->
        <div class="cart-items" id="cartItems">

            <!-- 빈 카트 상태 -->
            <div class="cart-empty" id="cartEmpty">
                <i class="fas fa-shopping-bag"></i>
                <p>Your cart is empty</p>
                <a href="${pageContext.request.contextPath}/shop/shoplist" class="btn-shop-now">Browse bundles</a>
            </div>

            <!-- 아이템 예시 (JS로 동적 렌더링 예정) -->
        </div>

        <!-- 주문 요약 -->
        <div class="cart-summary">
            <div class="summary-card">
                <div class="summary-title">Order Summary</div>

                <div class="summary-row">
                    <span>Subtotal</span>
                    <span id="summarySubtotal">₩ —</span>
                </div>
                <div class="summary-row">
                    <span>VAT (10%)</span>
                    <span id="summaryVat">₩ —</span>
                </div>
                <div class="summary-divider"></div>
                <div class="summary-row total">
                    <span>Total</span>
                    <span id="summaryTotal">₩ —</span>
                </div>

                <button class="btn-checkout" id="btnCheckout" onclick="checkout()">
                    <i class="fas fa-lock"></i> Checkout
                </button>

                <p class="summary-note">
                    <i class="fas fa-shield-alt"></i> Secure payment · Digital download
                </p>
            </div>
        </div>

    </div>
</div>

<script src="${pageContext.request.contextPath}/resources/js/cart.js"></script>
</body>
</html>
