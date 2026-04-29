<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
    <title>Checkout</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@400;500&family=DM+Sans:wght@300;400;500&display=swap" rel="stylesheet">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/home.css">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/checkout.css">
    <link rel="icon" href="data:;base64,iVBORw0KGgo=">
    <script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/home.js"></script>
    <!-- 토스페이먼츠 SDK -->
    <script src="https://js.tosspayments.com/v1/payment"></script>
</head>
<body>
<jsp:include page="/WEB-INF/views/layout/header.jsp"/>

<div class="checkout-page">

    <!-- 헤더 -->
    <div class="checkout-header">
        <div>
            <p class="checkout-label">(Confirm your order)</p>
            <h1 class="checkout-title">Checkout</h1>
        </div>
        <a href="${pageContext.request.contextPath}/cart/cartList" class="btn-back-cart">
            <i class="fas fa-arrow-left"></i> Back to Cart
        </a>
    </div>

    <div class="checkout-body">

        <!-- 좌측: 담긴 상품 목록 -->
        <div class="checkout-items-wrap">
            <p class="checkout-section-title">Order Items</p>
            <div id="checkoutItems">
                <div class="checkout-empty" id="checkoutEmpty">
                    <i class="fas fa-shopping-bag"></i>
                    <p>No items in cart</p>
                </div>
            </div>
        </div>

        <!-- 우측: 결제 패널 -->
        <div class="checkout-panel">

            <!-- 배송지 선택 -->
            <div class="checkout-card">
                <div class="checkout-card-title">Delivery Address</div>
                <div class="delivery-radio-list" id="deliveryList">
                    <div style="font-size:12px; color:rgba(255,255,255,0.3); text-align:center; padding:16px 0;">
                        배송지를 불러오는 중...
                    </div>
                </div>
                <button class="btn-add-delivery" onclick="goAddDelivery()">
                    <i class="fas fa-plus"></i> 새 배송지 추가
                </button>
            </div>

            <!-- 주문 요약 -->
            <div class="checkout-card">
                <div class="checkout-card-title">Order Summary</div>
                <div class="co-summary-row">
                    <span>Subtotal</span>
                    <span id="coSubtotal">₩ —</span>
                </div>
                <div class="co-summary-row">
                    <span>VAT (10%)</span>
                    <span id="coVat">₩ —</span>
                </div>
                <div class="co-summary-row total">
                    <span>Total</span>
                    <span id="coTotal">₩ —</span>
                </div>
            </div>

            <!-- 결제 버튼 -->
            <button class="btn-pay" id="btnPay" onclick="submitOrder()" disabled>
                <i class="fas fa-lock"></i> Pay Now
            </button>
            <p class="pay-note">
                <i class="fas fa-shield-alt"></i> Secure · Digital download after payment
            </p>

        </div>
    </div>
</div>

<script>
    let contextPath = '${pageContext.request.contextPath}';
    let selectedDeNum = null;
    let cartItems = [];

    function fmt(n) {
        return '₩ ' + Number(n).toLocaleString('ko-KR');
    }

    /* 카트 목록 불러오기 */
    function loadCartItems() {
        $.ajax({
            url     : contextPath + '/cart/cartListJson',
            type    : 'GET',
            dataType: 'json',
            success : function(data) {
                cartItems = data || [];
                renderItems(cartItems);
                updateSummary(cartItems);
            },
            error: function() {
                $('#checkoutItems').html('<div class="checkout-empty"><i class="fas fa-exclamation-circle"></i><p>불러오기 실패</p></div>');
            }
        });
    }

    function renderItems(items) {
        let container = $('#checkoutItems');
        container.empty();

        if (!items || items.length === 0) {
            container.append('<div class="checkout-empty" id="checkoutEmpty"><i class="fas fa-shopping-bag"></i><p>No items in cart</p></div>');
            return;
        }

        items.forEach(function(item) {
            let imgUrl = contextPath + '/shop/image?saveFileName=' + encodeURIComponent(item.saveFileName || '');
            let html =
                '<div class="checkout-item">' +
                    '<img class="checkout-item-thumb" src="' + imgUrl + '" alt="' + item.itemName + '">' +
                    '<div class="checkout-item-info">' +
                        '<div class="checkout-item-name">' + item.itemName + '</div>' +
                        '<div class="checkout-item-category">' + (item.category || 'Photo Bundle') + '</div>' +
                    '</div>' +
                    '<div class="checkout-item-price">' + fmt(item.itemPrice) + '</div>' +
                '</div>';
            container.append(html);
        });
    }

    function updateSummary(items) {
        let subtotal = (items || []).reduce(function(sum, i) { return sum + Number(i.itemPrice); }, 0);
        let vat      = Math.round(subtotal * 0.1);
        let total    = subtotal + vat;
        $('#coSubtotal').text(subtotal ? fmt(subtotal) : '₩ —');
        $('#coVat').text(vat ? fmt(vat) : '₩ —');
        $('#coTotal').text(total ? fmt(total) : '₩ —');
        checkPayReady();
    }

    /* 배송지 목록 불러오기 */
    function loadDelivery() {
        $.ajax({
            url     : contextPath + '/delivery/listData',
            type    : 'POST',
            dataType: 'json',
            success : function(res) {
                let list = res.data || [];
                let container = $('#deliveryList');
                container.empty();

                if (list.length === 0) {
                    container.html('<div style="font-size:12px;color:rgba(255,255,255,0.3);text-align:center;padding:16px 0;">등록된 배송지가 없습니다</div>');
                    return;
                }

                list.forEach(function(d) {
                    let isDefault = d.dlvrpl === 'Y';
                    if (isDefault && selectedDeNum === null) selectedDeNum = d.deNum;

                    let item =
                        '<div class="delivery-radio-item' + (isDefault ? ' selected' : '') + '" data-denum="' + d.deNum + '" onclick="selectDelivery(this, ' + d.deNum + ')">' +
                            '<input type="radio" name="deNum" value="' + d.deNum + '"' + (isDefault ? ' checked' : '') + '>' +
                            '<div class="delivery-radio-info">' +
                                '<div class="delivery-radio-name">' +
                                    d.deName + (isDefault ? '<span class="delivery-default-tag">기본</span>' : '') +
                                '</div>' +
                                '<div class="delivery-radio-addr">' + d.address + ' ' + (d.detailAddress || '') + '</div>' +
                                '<div class="delivery-radio-phone">' + d.phone1 + '</div>' +
                            '</div>' +
                        '</div>';
                    container.append(item);
                });

                checkPayReady();
            },
            error: function() {
                $('#deliveryList').html('<div style="font-size:12px;color:rgba(255,100,100,0.5);text-align:center;padding:16px 0;">배송지 불러오기 실패</div>');
            }
        });
    }

    function selectDelivery(el, deNum) {
        $('.delivery-radio-item').removeClass('selected');
        $(el).addClass('selected');
        $(el).find('input[type=radio]').prop('checked', true);
        selectedDeNum = deNum;
        checkPayReady();
    }

    function checkPayReady() {
        let ready = cartItems.length > 0 && selectedDeNum !== null;
        $('#btnPay').prop('disabled', !ready);
    }

    function goAddDelivery() {
        location.href = contextPath + '/delivery/insert';
    }

    /* 토스 결제창 오픈 */
    function submitOrder() {
        if (!selectedDeNum) { alert('배송지를 선택해주세요.'); return; }
        if (!cartItems || cartItems.length === 0) { alert('장바구니가 비어있습니다.'); return; }

        // 총 금액 계산 (VAT 포함)
        let subtotal = cartItems.reduce(function(sum, i) { return sum + Number(i.itemPrice); }, 0);
        let totalAmount = subtotal + Math.round(subtotal * 0.1);

        // orderId: 유저세션+배송지+타임스탬프 (토스 orderId 중복 불가)
        let orderId = 'order_' + selectedDeNum + '_' + Date.now();

        let toss = TossPayments('${tossClientKey}');

        toss.requestPayment('카드', {
            amount        : totalAmount,
            orderId       : orderId,
            orderName     : cartItems.length === 1
                            ? cartItems[0].itemName
                            : cartItems[0].itemName + ' 외 ' + (cartItems.length - 1) + '건',
            customerName  : '구매자',
            successUrl    : location.origin + contextPath + '/toss/success',
            failUrl       : location.origin + contextPath + '/toss/fail',
        }).catch(function(error) {
            if (error.code !== 'USER_CANCEL') {
                alert('결제 오류: ' + error.message);
            }
        });
    }

    $(document).ready(function() {
        loadCartItems();
        loadDelivery();
    });
</script>
</body>
</html>
