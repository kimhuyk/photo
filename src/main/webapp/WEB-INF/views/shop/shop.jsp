<%@ page contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Photo Shop</title>
    <script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>

    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@400;500&family=DM+Sans:wght@300;400;500&display=swap" rel="stylesheet">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/home.css?v=masonry">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/homesearch.css">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/shop.css">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/shopDetail.css">
    <link rel="icon" href="data:;base64,iVBORw0KGgo=">
    <script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/home.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/modal.js"></script>
</head>

<body>
<jsp:include page="/WEB-INF/views/layout/header.jsp" />

<!-- 섹션 라벨 -->
<div class="shop-section-label">
    <p>(Stock photo bundles)</p>
</div>

<!-- 툴바 -->
<div class="shop-toolbar">
    <div class="filter-tabs" id="filterTabs">
        <button class="filter-tab active" data-filter="all">All</button>
        <button class="filter-tab" data-filter="nature">Nature</button>
        <button class="filter-tab" data-filter="urban">Urban</button>
        <button class="filter-tab" data-filter="portrait">Portrait</button>
        <button class="filter-tab" data-filter="abstract">Abstract</button>
        <button class="filter-tab" data-filter="minimal">Minimal</button>
    </div>
    <select class="sort-select" id="sortSelect">
        <option value="default">Default</option>
        <option value="price-asc">Price: Low → High</option>
        <option value="price-desc">Price: High → Low</option>
        <option value="newest">Newest</option>
    </select>
</div>

<div class="shop-container">
    <ul class="product-grid" id="productGrid">
        <li class="empty-state" id="emptyState">등록된 상품이 없습니다</li>
    </ul>
</div>

<div class="see-all-wrap">
    <button class="btn-see-all">
        <i class="fas fa-arrow-right"></i> See all bundles
    </button>
</div>

<!-- ── 상품 상세 모달 ── -->
<div class="sd-overlay" id="sdOverlay">
    <div class="sd-modal" id="sdModal">
        <button class="sd-close" id="sdClose"><i class="fas fa-times"></i></button>

        <!-- 좌측: 사진 -->
        <div class="sd-photos">
            <img class="sd-main-photo" id="sdMainPhoto" src="" alt="">
            <div class="sd-sub-photos" id="sdSubPhotos"></div>
        </div>

        <!-- 우측: 정보 -->
        <div class="sd-info">
            <div class="sd-category" id="sdCategory"></div>
            <div class="sd-title"    id="sdTitle"></div>
            <div class="sd-price-wrap">
                <div class="sd-price" id="sdPrice"></div>
                <div class="sd-price-note">VAT 별도 · 디지털 다운로드</div>
            </div>
            <hr class="sd-divider">
            <div class="sd-desc" id="sdDesc"></div>
            <div class="sd-meta" id="sdMeta"></div>
            <hr class="sd-divider">
            <button class="sd-btn-cart" id="sdBtnCart">
                <i class="fas fa-shopping-bag"></i> Add to Cart
            </button>
            <button class="sd-btn-cart" id="goBtnCart">
                <i class="fas fa-shopping-bag"></i> Go to Cart
            </button>
            <p class="sd-btn-cart-note"><i class="fas fa-shield-alt"></i> Secure · Instant download after purchase</p>
        </div>
    </div>
</div>

<script>
    const contextPath = '${pageContext.request.contextPath}';
    let allCards = [];
    let currentItem = null; // 현재 모달에 열린 상품

    function loadShopList() {
        $.ajax({
            url     : contextPath + '/shop/shopListJson',
            type    : 'GET',
            dataType: 'json',
            success : function(data) { renderCards(data); },
            error   : function() { alert('상품 목록을 불러오는 데 실패했습니다.'); }
        });
    }

    function renderCards(items) {
        const grid  = document.getElementById('productGrid');
        const empty = document.getElementById('emptyState');
        $('#productGrid .product-card').remove();
        allCards = [];

        if (!items || items.length === 0) { empty.style.display = 'list-item'; return; }
        empty.style.display = 'none';

        $.each(items, function(i, item) {
            const imgPath = contextPath + '/shop/image?saveFileName=' + encodeURIComponent(item.saveFileName || '');
            const price   = Number(item.itemPrice).toLocaleString('ko-KR');
            const dateStr = (item.regDate || '').replace(/[^0-9]/g, '').substring(0, 8);

            const li = document.createElement('li');
            li.className        = 'product-card';
            li.dataset.category = item.category  || '';
            li.dataset.price    = item.itemPrice  || 0;
            li.dataset.date     = dateStr;
            li.dataset.title    = item.itemName   || '';

            li.innerHTML =
                '<div class="card-cover">' +
                    '<img loading="lazy" src="' + imgPath + '" alt="' + item.itemName + '">' +
                    '<div class="card-cover-text">' +
                        '<span class="cover-collection">Photo Collection</span>' +
                        '<div class="cover-bottom">' +
                            '<div class="cover-title">' + item.itemName + '</div>' +
                            '<div class="cover-tags">' +
                                '<span class="cover-tag">' + (item.category || '') + '</span>' +
                                '<span class="cover-tag">JPG</span>' +
                            '</div>' +
                        '</div>' +
                    '</div>' +
                '</div>' +
                '<div class="card-bottom">' +
                    '<div class="card-bottom-title">' + item.itemName + '</div>' +
                    '<div class="card-bottom-price">₩' + price + ' (VAT 별도)</div>' +
                    '<div class="card-bottom-actions">' +
                        '<button class="btn-detail" onclick="openDetail(event, ' + item.itemSeq + ')">See details</button>' +
                        '<button class="btn-cart"   onclick="openDetail(event, ' + item.itemSeq + ')">Add to cart</button>' +
                    '</div>' +
                '</div>';

            // 카드 전체 클릭도 모달 오픈
            li.addEventListener('click', function(e) {
                if (e.target.closest('.btn-detail') || e.target.closest('.btn-cart')) return;
                openDetail(e, item.itemSeq);
            });

            grid.insertBefore(li, empty);
            allCards.push(li);
        });

        applyAll();
    }

    /* 상세 모달 */
    function openDetail(e, itemSeq) {
        e.stopPropagation();
        $.ajax({
            url     : contextPath + '/shop/shopDetailJson?itemSeq=' + itemSeq,
            type    : 'GET',
            dataType: 'json',
            success : function(item) {
                currentItem = item;
                renderModal(item);
                document.getElementById('sdOverlay').classList.add('active');
                document.body.style.overflow = 'hidden';
            },
            error : function() { alert('상품 정보를 불러오지 못했습니다.'); }
        });
    }

    function renderModal(item) {
        const mainImgUrl = contextPath + '/shop/image?saveFileName=' + encodeURIComponent(item.saveFileName || '');

        // 메인 사진
        document.getElementById('sdMainPhoto').src = mainImgUrl;

        // 추가 사진 썸네일
        const subGrid = document.getElementById('sdSubPhotos');
        subGrid.innerHTML = '';

        // 메인도 썸네일에 포함
        const allImgs = [item.saveFileName].concat(
            item.subFileNames ? item.subFileNames.split(',') : []
        ).filter(Boolean);

        allImgs.forEach(function(fn, idx) {
            const img = document.createElement('img');
            img.className = 'sd-sub-thumb' + (idx === 0 ? ' active' : '');
            img.src = contextPath + '/shop/image?saveFileName=' + encodeURIComponent(fn);
            img.addEventListener('click', function() {
                document.getElementById('sdMainPhoto').src = this.src;
                subGrid.querySelectorAll('.sd-sub-thumb').forEach(function(t) { t.classList.remove('active'); });
                this.classList.add('active');
            });
            subGrid.appendChild(img);
        });

        // 텍스트 정보
        document.getElementById('sdCategory').textContent = (item.category || '').toUpperCase();
        document.getElementById('sdTitle').textContent    = item.itemName || '';
        document.getElementById('sdPrice').textContent    = '₩ ' + Number(item.itemPrice).toLocaleString('ko-KR');
        document.getElementById('sdDesc').textContent     = item.itemDesc || '상품 설명이 없습니다.';

        // 메타
        document.getElementById('sdMeta').innerHTML =
            '<div class="sd-meta-row"><span>Stock</span><span>' + (item.itemStock || 0) + ' files</span></div>' +
            '<div class="sd-meta-row"><span>Format</span><span>JPG / PNG</span></div>' +
            '<div class="sd-meta-row"><span>Registered</span><span>' + (item.regDate || '').substring(0, 10) + '</span></div>';

        // 카트 장바구니 담기 버튼
        const btn = document.getElementById('sdBtnCart');
        btn.classList.remove('added');
        btn.innerHTML = '<i class="fas fa-shopping-bag"></i> Add to Cart';
        btn.onclick = function() {
            addToCart(item);
        };
        // 카트 장바구니 이동 버튼
        const goBtn = document.getElementById('goBtnCart');
        if (goBtn) {
            goBtn.onclick = function() {
                goToCart();
            };
        }
    }

    function closeModal() {
        document.getElementById('sdOverlay').classList.remove('active');
        document.body.style.overflow = '';
        currentItem = null;
    }

    document.getElementById('sdClose').addEventListener('click', closeModal);
    document.getElementById('sdOverlay').addEventListener('click', function(e) {
        if (e.target === this) closeModal();
    });
    document.addEventListener('keydown', function(e) {
        if (e.key === 'Escape') closeModal();
    });

    /* 카트 담기 */
    function addToCart(item) {
        $.ajax({
            url        : contextPath + '/cart/addCart',
            type       : 'POST',
            contentType: 'application/json',
            data       : JSON.stringify({ itemSeq: item.itemSeq, quantity: 1 }),
            success    : function(res) {
                const btn = document.getElementById('sdBtnCart');
                if (res.status === 'ok') {
                    btn.classList.add('added');
                    alert('장바구니에 담겼습니다.')
                    btn.innerHTML = '<i class="fas fa-check"></i> Added to Cart';
                } else if (res.status === 'exists') {
                    alert('이미 장바구니에 담긴 상품입니다.');
                } else if (res.status === 'login') {
                    alert('로그인이 필요합니다.');
                } else {
                    alert('오류가 발생했습니다.');
                }
            },
            error: function() { alert('서버 오류가 발생했습니다.'); }
        });
    }
    // 장바구니 이동 — 담기 없이 바로 이동
    function goToCart() {
        location.href = contextPath + '/cart/cartList';
    }

    /* 필터 & 정렬 */
    let currentFilter = 'all';
    let currentSort   = 'default';

    document.getElementById('filterTabs').addEventListener('click', function(e) {
        const tab = e.target.closest('.filter-tab');
        if (!tab) return;
        document.querySelectorAll('.filter-tab').forEach(t => t.classList.remove('active'));
        tab.classList.add('active');
        currentFilter = tab.dataset.filter;
        applyAll();
    });

    document.getElementById('sortSelect').addEventListener('change', function() {
        currentSort = this.value;
        applyAll();
    });

    function applyAll() {
        const grid  = document.getElementById('productGrid');
        const empty = document.getElementById('emptyState');

        let visible = allCards.filter(card =>
            currentFilter === 'all' || card.dataset.category === currentFilter
        );
        const sorted = [...visible];
        if (currentSort === 'price-asc')  sorted.sort((a, b) => +a.dataset.price - +b.dataset.price);
        if (currentSort === 'price-desc') sorted.sort((a, b) => +b.dataset.price - +a.dataset.price);
        if (currentSort === 'newest')     sorted.sort((a, b) => +b.dataset.date  - +a.dataset.date);

        allCards.forEach(c => { c.classList.add('hidden'); grid.removeChild(c); });
        sorted.forEach(c  => { c.classList.remove('hidden'); grid.appendChild(c); });
        allCards.filter(c => !visible.includes(c)).forEach(c => { c.classList.add('hidden'); grid.appendChild(c); });
        empty.style.display = visible.length === 0 ? 'list-item' : 'none';
    }

    $(document).ready(function() {
        let message = '${message}';
        if (message) alert(message);
        loadShopList();
    });
</script>

</body>
</html>
