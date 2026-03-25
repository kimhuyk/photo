package com.sp.app.domain;

import lombok.NoArgsConstructor;
import lombok.ToString;
import org.springframework.web.multipart.MultipartFile;

@NoArgsConstructor
@ToString
public class Item {
    private long itemSeq;            // 상품 번호
    private Integer itemPrice;       // 상품 가격
    private Integer itemStock;       // 재고 수량
    private int status;              // 상태(임시저장(0) , 등록(1) 구분)
    private String itemDesc;         // 상품 상세 설명
    private String regDate;          // 상품 등록일
    private String category;         // 상품 카테고리
    private String itemName;         // 상품명
    private String saveFileName;     // 실제 저장된 사진 파일명
    private String originalFileName; // 사용자가 올린 원본 파일명
    private String filePath;         // 사진저장위치

    private MultipartFile selectFile;

    // 추가 정보
    private long userSeq;
    private String userName;         // 사진 업로더 이름

    public int getStatus() {
        return status;
    }

    public void setStatus(int status) {
        this.status = status;
    }

    public long getItemSeq() {
        return itemSeq;
    }

    public void setItemSeq(long itemSeq) {
        this.itemSeq = itemSeq;
    }

    public String getItemName() {
        return itemName;
    }

    public void setItemName(String itemName) {
        this.itemName = itemName;
    }

    public Integer getItemPrice() {
        return itemPrice;
    }

    public void setItemPrice(Integer itemPrice) {
        this.itemPrice = itemPrice;
    }

    public Integer getItemStock() {
        return itemStock;
    }

    public void setItemStock(Integer itemStock) {
        this.itemStock = itemStock;
    }

    public String getItemDesc() {
        return itemDesc;
    }

    public void setItemDesc(String itemDesc) {
        this.itemDesc = itemDesc;
    }

    public String getRegDate() {
        return regDate;
    }

    public void setRegDate(String regDate) {
        this.regDate = regDate;
    }

    public String getSaveFileName() {
        return saveFileName;
    }

    public void setSaveFileName(String saveFileName) {
        this.saveFileName = saveFileName;
    }

    public String getOriginalFileName() {
        return originalFileName;
    }

    public void setOriginalFileName(String originalFileName) {
        this.originalFileName = originalFileName;
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public String getCategory() {
        return category;
    }

    public void setCategory(String category) {
        this.category = category;
    }

    public long getUserSeq() {
        return userSeq;
    }

    public void setUserSeq(long userSeq) {
        this.userSeq = userSeq;
    }

    public String getFilePath() {
        return filePath;
    }

    public void setFilePath(String filePath) {
        this.filePath = filePath;
    }

    public MultipartFile getSelectFile() {
        return selectFile;
    }

    public void setSelectFile(MultipartFile selectFile) {
        this.selectFile = selectFile;
    }
}