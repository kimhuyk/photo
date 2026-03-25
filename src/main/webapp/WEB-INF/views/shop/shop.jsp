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

<!-- 그리드 -->
<div class="shop-container">
    <ul class="product-grid" id="productGrid">

        <li class="product-card" data-category="nature" data-price="15000" data-date="20250301" data-title="Misty Mountain Collection">
            <div class="card-cover">
                <img loading="lazy" src="https://images.unsplash.com/photo-1464822759023-fed622ff2c3b?w=600&q=80" alt="Misty Mountain">
                <div class="card-cover-text">
                    <span class="cover-collection">Photo Collection</span>
                    <div class="cover-bottom" <%-- onclick="${pageContext.request.contextPath}/ --%> >
                        <div class="cover-title">Misty<br>Mountain<br>Collection</div>
                        <div class="cover-tags">
                            <span class="cover-tag">32 photos</span>
                            <span class="cover-tag">vertical</span>
                            <span class="cover-tag">JPG</span>
                        </div>
                    </div>
                </div>
            </div>
            <div class="card-bottom">
                <div class="card-bottom-title">Misty Mountain — Photo Bundle (32 Clips)</div>
                <div class="card-bottom-price">₩15,000 (VAT 별도)</div>
                <div class="card-bottom-actions">
                    <button class="btn-detail">See details</button>
                    <button class="btn-cart">Add to cart</button>
                </div>
            </div>
        </li>

        <li class="product-card" data-category="urban" data-price="20000" data-date="20250310" data-title="Neon City Nights">
            <div class="card-cover">
                <img loading="lazy" src="https://images.unsplash.com/photo-1477959858617-67f85cf4f1df?w=600&q=80" alt="Neon City">
                <div class="card-cover-text">
                    <span class="cover-collection">Photo Collection</span>
                    <div class="cover-bottom">
                        <div class="cover-title">Neon<br>City<br>Nights</div>
                        <div class="cover-tags">
                            <span class="cover-tag">13 photos</span>
                            <span class="cover-tag">vertical</span>
                            <span class="cover-tag">JPG</span>
                        </div>
                    </div>
                </div>
            </div>
            <div class="card-bottom">
                <div class="card-bottom-title">Neon City Nights — Photo Bundle (13 Clips)</div>
                <div class="card-bottom-price">₩20,000 (VAT 별도)</div>
                <div class="card-bottom-actions">
                    <button class="btn-detail">See details</button>
                    <button class="btn-cart">Add to cart</button>
                </div>
            </div>
        </li>

        <li class="product-card" data-category="minimal" data-price="25000" data-date="20250205" data-title="Modern Minimalist Home">
            <div class="card-cover">
                <img loading="lazy" src="https://images.unsplash.com/photo-1586023492125-27b2c045efd7?w=600&q=80" alt="Modern Minimalist">
                <div class="card-cover-text">
                    <span class="cover-collection">Photo Collection</span>
                    <div class="cover-bottom">
                        <div class="cover-title">Modern<br>Minimalist<br>Home</div>
                        <div class="cover-tags">
                            <span class="cover-tag">62 photos</span>
                            <span class="cover-tag">vertical</span>
                            <span class="cover-tag">JPG</span>
                        </div>
                    </div>
                </div>
            </div>
            <div class="card-bottom">
                <div class="card-bottom-title">Modern Minimalist Home — Photo Bundle (62 Clips)</div>
                <div class="card-bottom-price">₩25,000 (VAT 별도)</div>
                <div class="card-bottom-actions">
                    <button class="btn-detail">See details</button>
                    <button class="btn-cart">Add to cart</button>
                </div>
            </div>
        </li>

        <li class="product-card" data-category="portrait" data-price="18000" data-date="20250228" data-title="Warm Portrait Scenes">
            <div class="card-cover">
                <img loading="lazy" src="https://images.unsplash.com/photo-1531746020798-e6953c6e8e04?w=600&q=80" alt="Warm Portrait">
                <div class="card-cover-text">
                    <span class="cover-collection">Photo Collection</span>
                    <div class="cover-bottom">
                        <div class="cover-title">Warm<br>Stylish<br>Scenes</div>
                        <div class="cover-tags">
                            <span class="cover-tag">16 photos</span>
                            <span class="cover-tag">vertical</span>
                            <span class="cover-tag">JPG</span>
                        </div>
                    </div>
                </div>
            </div>
            <div class="card-bottom">
                <div class="card-bottom-title">Warm Stylish Scenes — Photo Bundle (16 Clips)</div>
                <div class="card-bottom-price">₩18,000 (VAT 별도)</div>
                <div class="card-bottom-actions">
                    <button class="btn-detail">See details</button>
                    <button class="btn-cart">Add to cart</button>
                </div>
            </div>
        </li>

        <li class="product-card" data-category="nature" data-price="22000" data-date="20250118" data-title="Forest Light Journey">
            <div class="card-cover">
                <img loading="lazy" src="https://images.unsplash.com/photo-1448375240586-882707db888b?w=600&q=80" alt="Forest Light">
                <div class="card-cover-text">
                    <span class="cover-collection">Photo Collection</span>
                    <div class="cover-bottom">
                        <div class="cover-title">Forest<br>Light<br>Journey</div>
                        <div class="cover-tags">
                            <span class="cover-tag">73 photos</span>
                            <span class="cover-tag">horizontal</span>
                            <span class="cover-tag">JPG</span>
                        </div>
                    </div>
                </div>
            </div>
            <div class="card-bottom">
                <div class="card-bottom-title">Forest Light Journey — Photo Bundle (73 Clips)</div>
                <div class="card-bottom-price">₩22,000 (VAT 별도)</div>
                <div class="card-bottom-actions">
                    <button class="btn-detail">See details</button>
                    <button class="btn-cart">Add to cart</button>
                </div>
            </div>
        </li>

        <li class="product-card" data-category="abstract" data-price="30000" data-date="20250101" data-title="Creative Color Burst">
            <div class="card-cover">
                <img loading="lazy" src="https://images.unsplash.com/photo-1541701494587-cb58502866ab?w=600&q=80" alt="Color Burst">
                <div class="card-cover-text">
                    <span class="cover-collection">Photo Collection</span>
                    <div class="cover-bottom">
                        <div class="cover-title">Creative<br>Color<br>Burst</div>
                        <div class="cover-tags">
                            <span class="cover-tag">30 photos</span>
                            <span class="cover-tag">vertical</span>
                            <span class="cover-tag">JPG</span>
                        </div>
                    </div>
                </div>
            </div>
            <div class="card-bottom">
                <div class="card-bottom-title">Creative Color Burst — Photo Bundle (30 Clips)</div>
                <div class="card-bottom-price">₩30,000 (VAT 별도)</div>
                <div class="card-bottom-actions">
                    <button class="btn-detail">See details</button>
                    <button class="btn-cart">Add to cart</button>
                </div>
            </div>
        </li>

        <li class="product-card" data-category="portrait" data-price="19000" data-date="20250220" data-title="Girlboss Everyday Aesthetic">
            <div class="card-cover">
                <img loading="lazy" src="https://images.unsplash.com/photo-1506794778202-cad84cf45f1d?w=600&q=80" alt="Girlboss">
                <div class="card-cover-text">
                    <span class="cover-collection">Photo Collection</span>
                    <div class="cover-bottom">
                        <div class="cover-title">Girlboss<br>Everyday<br>Aesthetic</div>
                        <div class="cover-tags">
                            <span class="cover-tag">28 photos</span>
                            <span class="cover-tag">vertical</span>
                            <span class="cover-tag">JPG</span>
                        </div>
                    </div>
                </div>
            </div>
            <div class="card-bottom">
                <div class="card-bottom-title">Girlboss Everyday Aesthetic — Photo Bundle (28 Clips)</div>
                <div class="card-bottom-price">₩19,000 (VAT 별도)</div>
                <div class="card-bottom-actions">
                    <button class="btn-detail">See details</button>
                    <button class="btn-cart">Add to cart</button>
                </div>
            </div>
        </li>

        <li class="product-card" data-category="nature" data-price="16000" data-date="20250308" data-title="Rainy Day Outdoor Elegance">
            <div class="card-cover">
                <img loading="lazy" src="https://images.unsplash.com/photo-1509316785289-025f5b846b35?w=600&q=80" alt="Rainy Day">
                <div class="card-cover-text">
                    <span class="cover-collection">Photo Collection</span>
                    <div class="cover-bottom">
                        <div class="cover-title">Rainy Day<br>Outdoor<br>Elegance</div>
                        <div class="cover-tags">
                            <span class="cover-tag">8 photos</span>
                            <span class="cover-tag">vertical</span>
                            <span class="cover-tag">JPG</span>
                        </div>
                    </div>
                </div>
            </div>
            <div class="card-bottom">
                <div class="card-bottom-title">Rainy Day Outdoor Elegance — Photo Bundle (8 Clips)</div>
                <div class="card-bottom-price">₩16,000 (VAT 별도)</div>
                <div class="card-bottom-actions">
                    <button class="btn-detail">See details</button>
                    <button class="btn-cart">Add to cart</button>
                </div>
            </div>
        </li>

        <li class="empty-state" id="emptyState">검색 결과가 없습니다</li>
    </ul>
</div>

<!-- See all 버튼 -->
<div class="see-all-wrap">
    <button class="btn-see-all">
        <i class="fas fa-arrow-right"></i> See all bundles
    </button>
</div>

<script>
    (function () {
        const grid       = document.getElementById('productGrid');
        const filterTabs = document.getElementById('filterTabs');
        const sortSelect = document.getElementById('sortSelect');
        const emptyState = document.getElementById('emptyState');

        let currentFilter = 'all';
        let currentSort   = 'default';

        const allCards = Array.from(grid.querySelectorAll('.product-card'));

        filterTabs.addEventListener('click', function (e) {
            const tab = e.target.closest('.filter-tab');
            if (!tab) return;
            filterTabs.querySelectorAll('.filter-tab').forEach(t => t.classList.remove('active'));
            tab.classList.add('active');
            currentFilter = tab.dataset.filter;
            applyAll();
        });

        sortSelect.addEventListener('change', function () {
            currentSort = this.value;
            applyAll();
        });

        function applyAll() {
            let visible = allCards.filter(card =>
                currentFilter === 'all' || card.dataset.category === currentFilter
            );

            const sorted = [...visible];
            if (currentSort === 'price-asc')  sorted.sort((a, b) => +a.dataset.price - +b.dataset.price);
            if (currentSort === 'price-desc') sorted.sort((a, b) => +b.dataset.price - +a.dataset.price);
            if (currentSort === 'newest')     sorted.sort((a, b) => +b.dataset.date  - +a.dataset.date);

            allCards.forEach(c => { c.classList.add('hidden'); grid.removeChild(c); });
            sorted.forEach(c  => { c.classList.remove('hidden'); grid.appendChild(c); });
            allCards.filter(c => !visible.includes(c)).forEach(c => {
                c.classList.add('hidden'); grid.appendChild(c);
            });

            emptyState.style.display = visible.length === 0 ? 'list-item' : 'none';
        }
    })();
</script>

</body>
</html>
