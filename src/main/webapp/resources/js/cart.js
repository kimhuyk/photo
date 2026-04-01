var contextPath = (function() {
    var base = document.querySelector('base');
    if (base) return base.href.replace(/\/$/, '');
    // cart.css href에서 contextPath 추출
    var links = document.querySelectorAll('link[href*="/resources/css/cart.css"]');
    if (links.length > 0) {
        return links[0].href.replace('/resources/css/cart.css', '');
    }
    return '';
})();

function fmt(n) {
    return '₩ ' + Number(n).toLocaleString('ko-KR');
}

function loadCartFromServer() {
    $.ajax({
        url     : contextPath + '/cart/cartListJson',
        type    : 'GET',
        dataType: 'json',
        success : function(data) { renderCart(data); },
        error   : function() { renderCart([]); }
    });
}

function renderCart(cartItems) {
    var container = document.getElementById('cartItems');
    var empty     = document.getElementById('cartEmpty');
    var checkout  = document.getElementById('btnCheckout');

    container.querySelectorAll('.cart-item').forEach(function(el) { el.remove(); });

    if (!cartItems || cartItems.length === 0) {
        empty.style.display = 'flex';
        checkout.disabled = true;
        updateSummary(0);
        return;
    }

    empty.style.display = 'none';
    checkout.disabled = false;

    cartItems.forEach(function(item) {
        var imgUrl = contextPath + '/shop/image?saveFileName=' + encodeURIComponent(item.saveFileName || '');
        var row = document.createElement('div');
        row.className = 'cart-item';
        row.innerHTML =
            '<img class="cart-item-thumb" src="' + imgUrl + '" alt="' + item.itemName + '">' +
            '<div class="cart-item-info">' +
                '<div class="cart-item-name">' + item.itemName + '</div>' +
                '<div class="cart-item-price">' + fmt(item.itemPrice) + ' (VAT 별도)</div>' +
            '</div>' +
            '<div class="cart-item-actions">' +
                '<button class="cart-item-remove" data-cartseq="' + item.cartSeq + '" title="삭제"><i class="fas fa-times"></i></button>' +
                '<span class="cart-item-subtotal">' + fmt(item.itemPrice) + '</span>' +
            '</div>';
        container.insertBefore(row, empty);
    });

    // 삭제 버튼 — DB에서 삭제
    container.querySelectorAll('.cart-item-remove').forEach(function(btn) {
        btn.addEventListener('click', function() {
            var cartSeq = this.dataset.cartseq;
            $.ajax({
                url     : contextPath + '/cart/deleteCart?cartSeq=' + cartSeq,
                type    : 'POST',
                success : function() { loadCartFromServer(); },
                error   : function() { alert('삭제 중 오류가 발생했습니다.'); }
            });
        });
    });

    var subtotal = cartItems.reduce(function(sum, item) { return sum + Number(item.itemPrice); }, 0);
    updateSummary(subtotal);
}

function updateSummary(subtotal) {
    var vat   = Math.round(subtotal * 0.1);
    var total = subtotal + vat;
    document.getElementById('summarySubtotal').textContent = subtotal ? fmt(subtotal) : '₩ —';
    document.getElementById('summaryVat').textContent      = vat      ? fmt(vat)      : '₩ —';
    document.getElementById('summaryTotal').textContent    = total    ? fmt(total)    : '₩ —';
}

function checkout() {
    alert('결제 기능은 준비 중입니다.');
}

$(document).ready(function() {
    loadCartFromServer();
});
