<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<title>구매한 사진</title>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
<link rel="preconnect" href="https://fonts.googleapis.com">
<link href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@400;500&family=DM+Sans:wght@300;400;500&display=swap" rel="stylesheet">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/home.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/mypage.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/buyPhoto.css">
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

        <!-- 오른쪽 메인 콘텐츠 -->
        <div class="mypage-main">

            <!-- 헤더 -->
            <div class="buyphoto-header">
                <div>
                    <p class="buyphoto-label">(My purchases)</p>
                    <h2 class="buyphoto-title">구매한 사진</h2>
                </div>
                <a href="${pageContext.request.contextPath}/shop/shoplist" class="btn-go-shop">
                    <i class="fas fa-arrow-left"></i> Shop 둘러보기
                </a>
            </div>

            <!-- 주문 목록 -->
            <div id="orderListWrap">
                <div class="bp-empty" id="bpEmpty">
                    <i class="fas fa-shopping-bag"></i>
                    <p>구매 내역이 없습니다</p>
                    <a href="${pageContext.request.contextPath}/shop/shoplist" class="btn-go-shop-empty">Browse bundles</a>
                </div>
            </div>

        </div>
    </div>
</div>

<!-- 주문 상세 모달 -->
<div class="bp-overlay" id="bpOverlay">
    <div class="bp-modal">
        <button class="bp-modal-close" id="bpClose"><i class="fas fa-times"></i></button>
        <div class="bp-modal-title" id="bpModalTitle">주문 상세</div>
        <div class="bp-modal-date"  id="bpModalDate"></div>
        <div class="bp-modal-items" id="bpModalItems"></div>
        <div class="bp-modal-total" id="bpModalTotal"></div>
    </div>
</div>

<script>
    var contextPath = '${pageContext.request.contextPath}';

    function fmt(n) {
        return '₩ ' + Number(n).toLocaleString('ko-KR');
    }

    /* 주문 목록 불러오기 */
    function loadOrderList() {
        $.ajax({
            url     : contextPath + '/order/orderListJson',
            type    : 'GET',
            dataType: 'json',
            success : function(data) { renderOrderList(data); },
            error   : function() { $('#orderListWrap').html('<p style="color:rgba(255,255,255,0.3);text-align:center;padding:60px 0;">불러오기 실패</p>'); }
        });
    }

    function renderOrderList(orders) {
        var wrap  = $('#orderListWrap');
        var empty = $('#bpEmpty');

        if (!orders || orders.length === 0) {
            empty.show();
            return;
        }
        empty.hide();
        wrap.empty();

        orders.forEach(function(order) {
            var statusClass = order.orderStatus === '결제완료' ? 'status-paid'
                            : order.orderStatus === '배송중'   ? 'status-shipping'
                            : 'status-done';
            var html =
                '<div class="bp-order-card" onclick="openDetail(' + order.orderSeq + ', \'' + order.orderDate + '\')">' +
                    '<div class="bp-order-top">' +
                        '<div class="bp-order-seq">Order #' + order.orderSeq + '</div>' +
                        '<span class="bp-status ' + statusClass + '">' + order.orderStatus + '</span>' +
                    '</div>' +
                    '<div class="bp-order-meta">' +
                        '<span><i class="fas fa-calendar-alt"></i> ' + order.orderDate + '</span>' +
                        '<span><i class="fas fa-map-marker-alt"></i> ' + (order.address || '') + '</span>' +
                    '</div>' +
                    '<div class="bp-order-bottom">' +
                        '<span class="bp-order-total">' + fmt(order.totalPrice) + '</span>' +
                        '<span class="bp-order-detail-btn">상세보기 <i class="fas fa-chevron-right"></i></span>' +
                    '</div>' +
                '</div>';
            wrap.append(html);
        });
    }

    /* 주문 상세 모달 */
    function openDetail(orderSeq, orderDate) {
        $.ajax({
            url     : contextPath + '/order/orderDetailJson?orderSeq=' + orderSeq,
            type    : 'GET',
            dataType: 'json',
            success : function(items) {
                $('#bpModalTitle').text('Order #' + orderSeq);
                $('#bpModalDate').text(orderDate);
                var container = $('#bpModalItems');
                container.empty();
                var total = 0;
                (items || []).forEach(function(item) {
                    var imgUrl = contextPath + '/shop/image?saveFileName=' + encodeURIComponent(item.saveFileName || '');
                    var dlUrl  = contextPath + '/shop/download?saveFileName=' + encodeURIComponent(item.saveFileName || '') +
                                 '&originalFileName=' + encodeURIComponent(item.itemName || item.saveFileName || '');
                    total += Number(item.unitPrice) * Number(item.quantity);
                    container.append(
                        '<div class="bp-detail-item">' +
                            '<img src="' + imgUrl + '" alt="' + item.itemName + '">' +
                            '<div class="bp-detail-info">' +
                                '<div class="bp-detail-name">' + item.itemName + '</div>' +
                                '<div class="bp-detail-price">' + fmt(item.unitPrice) + ' × ' + item.quantity + '</div>' +
                                '<a href="' + dlUrl + '" class="bp-btn-download" download>' +
                                    '<i class="fas fa-download"></i> 다운로드' +
                                '</a>' +
                            '</div>' +
                            '<div class="bp-detail-subtotal">' + fmt(item.unitPrice * item.quantity) + '</div>' +
                        '</div>'
                    );
                });
                $('#bpModalTotal').html('Total <strong>' + fmt(total) + '</strong>');
                $('#bpOverlay').addClass('active');
                $('body').css('overflow', 'hidden');
            },
            error: function() { alert('상세 정보를 불러오지 못했습니다.'); }
        });
    }

    $('#bpClose').on('click', closeDetail);
    $('#bpOverlay').on('click', function(e) { if (e.target === this) closeDetail(); });
    $(document).on('keydown', function(e) { if (e.key === 'Escape') closeDetail(); });

    function closeDetail() {
        $('#bpOverlay').removeClass('active');
        $('body').css('overflow', '');
    }

    $(document).ready(function() { loadOrderList(); });
</script>

</body>
</html>
