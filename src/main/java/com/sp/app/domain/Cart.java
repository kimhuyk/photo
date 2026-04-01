package com.sp.app.domain;

import lombok.NoArgsConstructor;
import lombok.ToString;

@NoArgsConstructor
@ToString
public class Cart {
    private long cartSeq;   // 장바구니 번호
    private long userSeq;   // 사용자 번호
    private long itemSeq;   // 상품 번호
    private int quantity;   // 담은 수량
    private String regDate; // 장바구니에 담은 날짜

    private String itemName;        // 상품명
    private String saveFileName;    // 상품 이미지 파일명
    private int itemPrice;          // 개당 가격
    private int totalPrice;         // 합계 금액 (itemPrice X quantity)

    public long getCartSeq() {
        return cartSeq;
    }

    public void setCartSeq(long cartSeq) {
        this.cartSeq = cartSeq;
    }

    public long getUserSeq() {
        return userSeq;
    }

    public void setUserSeq(long userSeq) {
        this.userSeq = userSeq;
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

    public String getRegDate() {
        return regDate;
    }

    public void setRegDate(String regDate) {
        this.regDate = regDate;
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

    public int getItemPrice() {
        return itemPrice;
    }

    public void setItemPrice(int itemPrice) {
        this.itemPrice = itemPrice;
    }

    public int getTotalPrice() {
        return totalPrice;
    }

    public void setTotalPrice(int totalPrice) {
        this.totalPrice = totalPrice;
    }
}
