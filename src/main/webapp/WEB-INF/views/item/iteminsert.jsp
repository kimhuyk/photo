<%@ page contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>상품 등록</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@400;500&family=DM+Sans:wght@300;400;500&display=swap" rel="stylesheet">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/home.css">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/iteminsert.css">
    <link rel="icon" href="data:;base64,iVBORw0KGgo=">

    <script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/home.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/itemInsert.js"></script>

</head>

<body>
<jsp:include page="/WEB-INF/views/layout/header.jsp" />

<!-- 페이지 헤더 -->
    <div class="page-header">
        <div class="page-header-left">
            <h1>상품 등록</h1>
            <p>사진과 정보를 입력하고 판매를 시작하세요</p>
        </div>
        <div class="step-indicator">
            <div class="step active">
                <div class="step-num">1</div>
                <span>사진 &amp; 정보</span>
            </div>
            <div class="step-line"></div>
            <div class="step">
                <div class="step-num">2</div>
                <span>가격 설정</span>
            </div>
            <div class="step-line"></div>
            <div class="step">
                <div class="step-num">3</div>
                <span>검토 &amp; 등록</span>
            </div>
        </div>
    </div>

<!-- 폼 -->
<form class="register-form" id="registerForm" name="registerForm" method="POST" action="${pageContext.request.contextPath}/admin/insertShop"
      enctype="multipart/form-data">

    <!-- 좌측 컬럼 -->
    <div class="left-col">

        <!-- 사진 업로드 카드 -->
        <div class="form-card">
            <div class="card-label">사진 업로드</div>

            <!-- 메인 사진 -->
            <div class="main-upload-zone" id="mainZone">
                <span class="upload-badge">대표 사진</span>
                <input type="file" name="selectFile" id="mainImageInput" accept="image/*">
                <button type="button" class="main-remove-btn" id="mainRemoveBtn" title="삭제">
                    <i class="fas fa-times"></i>
                </button>
                <img id="mainPreviewImg" alt="메인 사진 미리보기">
                <div class="upload-icon"><i class="fas fa-plus"></i></div>
                <div class="upload-hint">
                    <strong>대표 사진을 드래그하거나 클릭하여 업로드</strong>
                    <span>JPG, PNG, WEBP · 최대 10MB · 권장 600×800px</span>
                </div>
            </div>

            <!-- 추가 사진 -->
            <div class="sub-photos-grid" id="subGrid">
                <!-- JS로 4개 슬롯 렌더 -->
            </div>
            <p class="sub-photo-count" id="subCount">추가 사진 0 / 4</p>
        </div>

        <!-- 상품 기본 정보 -->
        <div class="form-card">
            <div class="card-label">기본 정보</div>

            <div class="form-group">
                <label class="form-label">상품명 <span class="required">*</span></label>
                <input type="text" class="form-input" name="itemName" id="itemNameInput"
                       placeholder="예) Misty Mountain — Photo Bundle" maxlength="100">
            </div>

            <div class="form-group">
                <label class="form-label">카테고리 <span class="required">*</span></label>
                <select class="form-select" name="category" id="categoryInput">
                    <option value="">카테고리 선택</option>
                    <option value="nature">Nature</option>      <!-- 자연 -->
                    <option value="urban">Urban</option>        <!-- 도시 -->
                    <option value="portrait">Portrait</option>  <!-- 초상화 -->
                    <option value="abstract">Abstract</option>  <!-- 추상적인 -->
                    <option value="minimal">Minimal</option>    <!-- 미니멀 -->
                </select>
            </div>

            <div class="form-group">
                <label class="form-label">상품 설명</label>
                <textarea class="form-textarea" name="itemDesc" id="itemDescInput"
                          placeholder="사진의 분위기, 촬영 장소, 포함 내용 등을 설명해주세요">
                </textarea>
            </div>

            <div class="form-group">
                <label class="form-label">태그</label>
                <div class="tags-wrap" id="tagsWrap">
                    <input type="text" id="tagInput" placeholder="태그 입력 후 Enter">
                </div>
                <input type="hidden" name="tags" id="tagsHidden">
            </div>
        </div>

        <!-- 가격 & 재고 -->
        <div class="form-card">
            <div class="card-label">가격 &amp; 재고</div>

            <div class="two-col">
                <div class="form-group">
                    <label class="form-label">판매가 <span class="required">*</span></label>
                    <div class="price-wrap">
                        <span class="currency">₩</span>
                        <input type="number" class="form-input" name="itemPrice" id="itemPriceInput"
                               placeholder="0" min="0" step="100">
                    </div>
                </div>
                <div class="form-group">
                    <label class="form-label">파일 수량</label>
                    <input type="number" class="form-input" name="itemStock" id="itemStockInput"
                           placeholder="예) 32" min="1">
                </div>
            </div>

            <div class="two-col">
<%--                <div class="form-group">--%>
<%--                    <label class="form-label">할인가</label>--%>
<%--                    <div class="price-wrap">--%>
<%--                        <span class="currency">₩</span>--%>
<%--                        <input type="number" class="form-input" name="discountPrice" id="discountInput"--%>
<%--                               placeholder="0" min="0" step="100">--%>
<%--                    </div>--%>
<%--                </div>--%>
<%--                <div class="form-group">--%>
<%--                    <label class="form-label">파일 형식</label>--%>
<%--                    <select class="form-select" name="fileType">--%>
<%--                        <option value="">선택</option>--%>
<%--                        <option value="JPG">JPG</option>--%>
<%--                        <option value="PNG">PNG</option>--%>
<%--                        <option value="RAW">RAW</option>--%>
<%--                        <option value="WEBP">WEBP</option>--%>
<%--                        <option value="JPG+RAW">JPG + RAW</option>--%>
<%--                    </select>--%>
<%--                </div>--%>
            </div>
        </div>

    </div><!-- /left-col -->

    <!-- 우측 패널 -->
    <div class="side-panel">

        <!-- 가격 요약 -->
        <div class="price-summary">
            <div class="price-summary-label">가격 요약</div>
            <div class="price-row">
                <span>판매가</span>
                <span id="summaryPrice">₩ —</span>
            </div>
<%--        <div class="price-row">
                <span>할인가</span>
                <span id="summaryDiscount" style="color:#e05c5c;">—</span>
            </div>
            <div class="price-row total">
                <span>최종 금액</span>
                <span id="summaryFinal">₩ —</span>
            </div> --%>
        </div>

        <!-- 등록 버튼 -->
        <input type="hidden" name="status" id="statusInput" value="1"> <!-- 기본값 등록 -->

        <div class="form-card" style="padding:20px;">
            <!-- 등록 버튼  status=1 -->
            <button type="button" class="btn-submit" onclick="shopOk()">
                <i class="fas fa-check"></i> 상품 등록하기
            </button>
            <div style="height:8px;"></div>
            <!-- 임시저장 버튼 status=0 -->
            <button type="button" class="btn-draft" onclick="saveDraft()">
                임시저장
            </button>
        </div>

        <!-- 유의사항 -->
        <div class="form-card" style="padding:20px 22px;">
            <div class="card-label">등록 유의사항</div>
            <ul class="insert-notice-list">
                <li>대표 사진은 상품 목록에 노출되는 커버 이미지입니다.</li>
                <li>최소 1장, 최대 5장(대표+추가)까지 등록 가능합니다.</li>
                <li>저작권이 없는 이미지는 등록이 거부될 수 있습니다.</li>
                <li>파일 크기는 장당 최대 10MB입니다.</li>
                <li>등록 후 24시간 이내 검토가 진행됩니다.</li>
            </ul>
        </div>

    </div>

</form>

<script>
    (function () {

        /* 메인 사진 */
        const mainInput  = document.getElementById('mainImageInput');
        const mainZone   = document.getElementById('mainZone');
        const mainImg    = document.getElementById('mainPreviewImg');
        const mainRemove = document.getElementById('mainRemoveBtn');

        function setMainPreview(file) {
            if (!file || !file.type.startsWith('image/')) return;
            const reader = new FileReader();
            reader.onload = e => {
                mainImg.src = e.target.result;
                mainZone.classList.add('main-preview-active');
            };
            reader.readAsDataURL(file);
        }

        mainInput.addEventListener('change', function () {
            if (this.files[0]) setMainPreview(this.files[0]);
        });

        mainRemove.addEventListener('click', function (e) {
            e.stopPropagation();
            mainImg.src = '';
            mainZone.classList.remove('main-preview-active');
            mainInput.value = '';
        });

        /* 드래그&드롭 */
        mainZone.addEventListener('dragover', e => {
            e.preventDefault(); mainZone.classList.add('dragover');
        });
        mainZone.addEventListener('dragleave', () => mainZone.classList.remove('dragover'));
        mainZone.addEventListener('drop', e => {
            e.preventDefault();
            mainZone.classList.remove('dragover');
            const file = e.dataTransfer.files[0];
            if (file) setMainPreview(file);
        });

        /* 추가 사진 슬롯 */
        const subGrid  = document.getElementById('subGrid');
        const subCount = document.getElementById('subCount');
        const MAX_SUB  = 4;
        let subFiles   = new Array(MAX_SUB).fill(null);

        for (let i = 0; i < MAX_SUB; i++) {
            const slot = document.createElement('div');
            slot.className = 'sub-photo-slot';
            slot.dataset.index = i;
            slot.innerHTML = `
            <input type="file" name="subImage${i}" accept="image/*" data-idx="${i}">
            <img alt="추가사진 ${i+1}">
            <button type="button" class="sub-remove" data-idx="${i}" title="삭제">
                <i class="fas fa-times"></i>
            </button>
            <span class="slot-plus"><i class="fas fa-plus"></i></span>
        `;
            subGrid.appendChild(slot);
        }

        subGrid.addEventListener('change', function (e) {
            const input = e.target;
                if (input.tagName !== 'INPUT') return;

            const idx  = +input.dataset.idx;
            const file = input.files[0];
                if (!file || !file.type.startsWith('image/')) return;

            const reader = new FileReader();
            reader.onload = ev => {
            const slot = subGrid.querySelector(`.sub-photo-slot[data-index="${idx}"]`);
                slot.querySelector('img').src = ev.target.result;
                slot.classList.add('has-img');
                subFiles[idx] = file;
                updateSubCount();
            };
            reader.readAsDataURL(file);
        });

        subGrid.addEventListener('click', function (e) {
            const btn = e.target.closest('.sub-remove');
                if (!btn) return;
                e.stopPropagation();

            const idx  = +btn.dataset.idx;
            const slot = subGrid.querySelector(`.sub-photo-slot[data-index="${idx}"]`);
                slot.querySelector('img').src = '';
                slot.classList.remove('has-img');
                slot.querySelector('input').value = '';
                subFiles[idx] = null;

                updateSubCount();
        });

        function updateSubCount() {
            const n = subFiles.filter(Boolean).length;
            subCount.textContent = `추가 사진 ${n} / ${MAX_SUB}`;
        }

        /* 태그 입력 */
        const tagsWrap  = document.getElementById('tagsWrap');
        const tagInput  = document.getElementById('tagInput');
        const tagsHidden= document.getElementById('tagsHidden');
        let tags = [];

        tagsWrap.addEventListener('click', () => tagInput.focus());

        tagInput.addEventListener('keydown', function (e) {
            if ((e.key === 'Enter' || e.key === ',') && this.value.trim()) {
                e.preventDefault();
                addTag(this.value.trim().replace(/,/g, ''));
                this.value = '';
            }
            if (e.key === 'Backspace' && !this.value && tags.length) {
                removeTag(tags.length - 1);
            }
        });

        function addTag(val) {
            if (!val || tags.includes(val) || tags.length >= 8) return;
            tags.push(val);
            renderTags();
        }

        function removeTag(idx) {
            tags.splice(idx, 1);
            renderTags();
        }

        function renderTags() {
            tagsWrap.querySelectorAll('.tag-chip').forEach(c => c.remove());
            tags.forEach((t, i) => {
                const chip = document.createElement('div');
                chip.className = 'tag-chip';
                chip.innerHTML = `${t}<button type="button" data-idx="${i}"><i class="fas fa-times"></i></button>`;
                chip.querySelector('button').addEventListener('click', () => removeTag(i));
                tagsWrap.insertBefore(chip, tagInput);
            });
            tagsHidden.value = tags.join(',');
        }

        /* 가격 요약 */
        const itemPriceInput    = document.getElementById('itemPriceInput');
        //const discountInput = document.getElementById('discountInput');

        const summaryPrice  = document.getElementById('summaryPrice');
        // const summaryFinal  = document.getElementById('summaryFinal');
        //const summaryDiscount = document.getElementById('summaryDiscount');

        function fmt(n) {
            return '₩ ' + Number(n).toLocaleString('ko-KR');
        }
        itemPriceInput.addEventListener('input', function() {
            const price = parseInt(this.value) || 0;
            summaryPrice.textContent = price ? fmt(price) : '₩ —';
        });
         /* 할인 계산 */
/*         function updateSummary() {
             const price    = parseInt(priceInput.value) || 0;
             const discount = parseInt(discountInput.value) || 0;
             summaryPrice.textContent    = price    ? fmt(price)    : '₩ —';
             summaryDiscount.textContent = discount ? '-' + fmt(discount) : '—';
             const final = Math.max(0, price - discount);
             summaryFinal.textContent    = (price || discount) ? fmt(final) : '₩ —';
         }

         priceInput.addEventListener('input', updateSummary);
         discountInput.addEventListener('input', updateSummary); */

    })();

   </script>

</body>
</html>
