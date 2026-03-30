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

<script>
    const contextPath = '${pageContext.request.contextPath}';
    let allCards = [];

    function loadShopList() {
        $.ajax({
            url     : contextPath + '/shop/shopListJson',
            type    : 'GET',
            dataType: 'json',
            success : function(data) {
                renderCards(data);
            },
            error : function(err) {
                console.log('목록 조회 실패', err);
                alert('상품 목록을 불러오는 데 실패했습니다.');
            }
        });
    }

    function renderCards(items) {
        const grid     = document.getElementById('productGrid');
        const empty    = document.getElementById('emptyState');

        console.log("전체 리스트 데이터:", items);

        /* 기존 카드 제거 */
        $('#productGrid .product-card').remove();
        allCards = [];

        if (!items || items.length === 0) {
            empty.style.display = 'list-item';
            return;
        }

        empty.style.display = 'none';

        $.each(items, function(i, item) {
            const imgPath = contextPath + '/shop/image?saveFileName=' + encodeURIComponent(item.saveFileName);
            const price   = Number(item.itemPrice).toLocaleString('ko-KR');
            /* regDate → yyyyMMdd 형태 */
            const dateStr = (item.regDate || '').replace(/[^0-9]/g, '').substring(0, 8);

            const li = document.createElement('li');
            li.className          = 'product-card';
            li.dataset.category   = item.category  || '';
            li.dataset.price      = item.itemPrice  || 0;
            li.dataset.date       = dateStr;
            li.dataset.title      = item.itemName   || '';

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
                        '<button class="btn-detail" onclick="goDetail(' + item.itemSeq + ')">See details</button>' +
                        '<button class="btn-cart" onclick="addToCart(event, ' + item.itemSeq + ', \'' + item.itemName.replace(/'/g,"&#39;") + '\', ' + item.itemPrice + ', \'' + (item.category||'') + '\', \'' + encodeURIComponent(item.saveFileName||'') + '\')">Add to cart</button>' +
                    '</div>' +
                '</div>';

            grid.insertBefore(li, empty);
            allCards.push(li);
        });

        /* 카드 렌더 후 현재 필터/정렬 상태 유지 */
        applyAll();
    }

    /* 상세 페이지 이동 */
    function goDetail(itemSeq) {
        location.href = contextPath + '/shop/shopdetail?itemSeq=' + itemSeq;
    }

    /* 카트 추가 */
    function addToCart(e, itemSeq, itemName, itemPrice, category, saveFileName) {
        e.stopPropagation();
        var cartItems = JSON.parse(localStorage.getItem('cartItems') || '[]');
        var exists = cartItems.some(function(i) { return i.itemSeq === itemSeq; });
        if (exists) {
            alert('이미 담긴 상품입니다.');
            return;
        }
        cartItems.push({
            itemSeq   : itemSeq,
            itemName  : itemName,
            itemPrice : itemPrice,
            category  : category,
            imgUrl    : contextPath + '/shop/image?saveFileName=' + saveFileName
        });
        localStorage.setItem('cartItems', JSON.stringify(cartItems));
        alert(itemName + '\n장바구니에 담았습니다.');
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
        const grid     = document.getElementById('productGrid');
        const empty    = document.getElementById('emptyState');

        let visible = allCards.filter(card =>
            currentFilter === 'all' || card.dataset.category === currentFilter
        );

        const sorted = [...visible];
        if (currentSort === 'price-asc')  sorted.sort((a, b) => +a.dataset.price - +b.dataset.price);
        if (currentSort === 'price-desc') sorted.sort((a, b) => +b.dataset.price - +a.dataset.price);
        if (currentSort === 'newest')     sorted.sort((a, b) => +b.dataset.date  - +a.dataset.date);

        allCards.forEach(c => {
            c.classList.add('hidden'); grid.removeChild(c);
        });
        sorted.forEach(c  => {
            c.classList.remove('hidden'); grid.appendChild(c);
        });
        allCards.filter(c => !visible.includes(c)).forEach(c => {
            c.classList.add('hidden'); grid.appendChild(c);
        });

        empty.style.display = visible.length === 0 ? 'list-item' : 'none';
    }

    /* 초기 실행 */
    $(document).ready(function() {
        var message = '${message}';
        if (message) alert(message);

        loadShopList();
    });
</script>

</body>
</html>
