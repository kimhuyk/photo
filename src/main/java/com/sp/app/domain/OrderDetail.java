package com.sp.app.domain;

import lombok.NoArgsConstructor;
import lombok.ToString;

@NoArgsConstructor
@ToString
public class OrderDetail {
    private long detailSeq;  // 주문 상세 고유 번호
    private long orderSeq;   // 부모 주문 번호
    private long itemSeq;    // 구매한 상품 번호
    private int quantity;    // 구매 수량
    private int unitPrice;   // 구매 당시 단가 (할인시 필요)

    private String itemName;     // 구매한 상품명
    private String saveFileName; // 구매한 상품 이미지

    public long getDetailSeq() {
        return detailSeq;
    }

    public void setDetailSeq(long detailSeq) {
        this.detailSeq = detailSeq;
    }

    public long getOrderSeq() {
        return orderSeq;
    }

    public void setOrderSeq(long orderSeq) {
        this.orderSeq = orderSeq;
    }

    public long getItemSeq() {
        return itemSeq;
    }

    public void setItemSeq(long itemSeq) {
        this.itemSeq = itemSeq;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public int getUnitPrice() {
        return unitPrice;
    }

    public void setUnitPrice(int unitPrice) {
        this.unitPrice = unitPrice;
    }

    public String getItemName() {
        return itemName;
    }

    public void setItemName(String itemName) {
        this.itemName = itemName;
    }

    public String getSaveFileName() {
        return saveFileName;
    }

    public void setSaveFileName(String saveFileName) {
        this.saveFileName = saveFileName;
    }
}
