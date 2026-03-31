(function () {

    /* 메인 사진 */
    const mainInput  = document.getElementById('mainImageInput');
    const mainZone   = document.getElementById('mainZone');
    const mainImg    = document.getElementById('mainPreviewImg');
    const mainRemove = document.getElementById('mainRemoveBtn');

    function setMainPreview(file) {
        if (!file || !file.type.startsWith('image/')) return;
        const reader = new FileReader();
        reader.onload = function(e) {
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
    mainZone.addEventListener('dragover', function(e) {
        e.preventDefault(); mainZone.classList.add('dragover');
    });
    mainZone.addEventListener('dragleave', function() { mainZone.classList.remove('dragover'); });
    mainZone.addEventListener('drop', function(e) {
        e.preventDefault();
        mainZone.classList.remove('dragover');
        let file = e.dataTransfer.files[0];
        if (file) setMainPreview(file);
    });

    /* 추가 사진 슬롯 */
    let subGrid  = document.getElementById('subGrid');
    let subCount = document.getElementById('subCount');
    let MAX_SUB  = 4;
    let subFiles = new Array(MAX_SUB).fill(null);

    for (let i = 0; i < MAX_SUB; i++) {
        (function(idx) {
            let slot = document.createElement('div');
                slot.className = 'sub-photo-slot';
                slot.dataset.index = idx;
                slot.innerHTML =
                    '<input type="file" name="subImages" accept="image/*" data-idx="' + idx + '">' +
                    '<img alt="추가사진 ' + (idx + 1) + '">' +
                    '<button type="button" class="sub-remove" data-idx="' + idx + '" title="삭제">' +
                    '<i class="fas fa-times"></i>' +
                    '</button>' +
                    '<span class="slot-plus"><i class="fas fa-plus"></i></span>';
            subGrid.appendChild(slot);

            let input = slot.querySelector('input[type="file"]');

            input.addEventListener('change', function () {
                let file = this.files[0];
                    if (!file || !file.type.startsWith('image/')) return;
                let reader = new FileReader();
                reader.onload = function(ev) {
                    slot.querySelector('img').src = ev.target.result;
                    slot.classList.add('has-img');
                    subFiles[idx] = file;
                    updateSubCount();
                };
                reader.readAsDataURL(file);
            });

            slot.addEventListener('click', function (e) {
                if (e.target.closest('.sub-remove')) return;
                if (e.target.tagName.toLowerCase() === 'input') return; // 버블링 방지(억까)
                input.click();
            });
        })(i);
    }

    subGrid.addEventListener('click', function (e) {
        let btn = e.target.closest('.sub-remove');
        if (!btn) return;
        e.stopPropagation();
        let idx  = +btn.dataset.idx;
        let slot = subGrid.querySelector('.sub-photo-slot[data-index="' + idx + '"]');

            slot.querySelector('img').src = '';
            slot.classList.remove('has-img');
            slot.querySelector('input').value = '';
        subFiles[idx] = null;
        updateSubCount();
    });1134567

    function updateSubCount() {
        let n = subFiles.filter(Boolean).length;
        subCount.textContent = '추가 사진 ' + n + ' / ' + MAX_SUB;
    }

    /* 태그 입력 */
    let tagsWrap   = document.getElementById('tagsWrap');
    let tagInput   = document.getElementById('tagInput');
    let tagsHidden = document.getElementById('tagsHidden');
    let tags = [];

    tagsWrap.addEventListener('click', function() { tagInput.focus(); });

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
        tagsWrap.querySelectorAll('.tag-chip').forEach(function(c) { c.remove(); });
        tags.forEach(function(t, i) {
            let chip = document.createElement('div');
            chip.className = 'tag-chip';
            chip.innerHTML = t + '<button type="button" data-idx="' + i + '"><i class="fas fa-times"></i></button>';
            chip.querySelector('button').addEventListener('click', function() { removeTag(i); });
            tagsWrap.insertBefore(chip, tagInput);
        });
        tagsHidden.value = tags.join(',');
    }

    /* 가격 요약 */
    let itemPriceInput = document.getElementById('itemPriceInput');
    let summaryPrice   = document.getElementById('summaryPrice');

    function fmt(n) {
        return '₩ ' + Number(n).toLocaleString('ko-KR');
    }

    itemPriceInput.addEventListener('input', function() {
        let price = parseInt(this.value) || 0;
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
