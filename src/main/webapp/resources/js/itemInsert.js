// 사진등록 관리자페이지 JS
function shopOk() {
    const f = document.registerForm;
    if (!document.getElementById('mainImageInput').files[0]) {
        alert('대표 사진을 등록해주세요.');
        return;
    }

    if (!f.itemName.value.trim()) {
        alert('상품명을 입력해주세요.');
        f.itemName.focus();
        return;
    }

    if (!f.category.value) {
        alert('카테고리를 선택해주세요.');
        return;
    }

    if (!f.itemPrice.value || f.itemPrice.value <= 0) {
        alert('판매가를 입력해주세요.');
        f.itemPrice.focus();
        return;
    }

    if (!f.itemStock.value || f.itemStock.value <= 0) {
        alert('수량을 입력해주세요.');
        f.itemStock.focus();
        return;
    }
    document.getElementById('statusInput').value = 1;
    localStorage.removeItem('shopDraft');
    f.submit();
}

// 임시저장
function saveDraft() {
    const draft = {
        itemName  : document.getElementById('itemNameInput').value,
        category  : document.getElementById('categoryInput').value,
        itemPrice : document.getElementById('itemPriceInput').value,
        itemStock : document.getElementById('itemStockInput').value,
        itemDesc  : document.getElementById('itemDescInput').value
    };

    localStorage.setItem('shopDraft', JSON.stringify(draft));
    alert('임시저장 되었습니다.');
}
function shopOk() {
    // 등록 성공 시 임시저장 데이터 삭제
    localStorage.removeItem('shopDraft');

    document.getElementById('statusInput').value = 1;
    document.registerForm.submit();
}

window.onload = function() {
    const draft = localStorage.getItem('shopDraft');
    if (draft) {
        const d = JSON.parse(draft);
        // 사진 복원 제거
        document.getElementById('itemNameInput').value = d.itemName || '';
        document.getElementById('categoryInput').value = d.category || '';
        document.getElementById('itemPriceInput').value = d.itemPrice || '';
        document.getElementById('itemStockInput').value = d.itemStock || '';
        document.getElementById('itemDescInput').value = d.itemDesc || '';

        alert('임시저장된 데이터를 불러왔습니다.\n사진은 다시 올려주세요!');
    }

}