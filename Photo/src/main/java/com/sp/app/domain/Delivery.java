package com.sp.app.domain;

import lombok.Data;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@Data
public class Delivery {
	private long deNum;	// 배송지 번호
	private long userSeq;	// 사용자 번호
	private String de_name;	// 배송지명
	private String receiverName;	// 수령인
	private String address;	// 주소
	private String addressZip;	// 우편번호
	private String detailAddress;	// 상세주소
	private String phone1;	// 배송지 번호
	private String phone2;	// 배송지 번호
	private String dlvrpl;	// 기본배송지
	
	
	
	public long getDeNum() {
		return deNum;
	}
	public void setDeNum(long deNum) {
		this.deNum = deNum;
	}
	public long getUserSeq() {
		return userSeq;
	}
	public void setUserSeq(long userSeq) {
		this.userSeq = userSeq;
	}
	public String getDe_name() {
		return de_name;
	}
	public void setDe_name(String de_name) {
		this.de_name = de_name;
	}
	public String getReceiverName() {
		return receiverName;
	}
	public void setReceiverName(String receiverName) {
		this.receiverName = receiverName;
	}
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	public String getAddressZip() {
		return addressZip;
	}
	public void setAddressZip(String addressZip) {
		this.addressZip = addressZip;
	}
	public String getDetailAddress() {
		return detailAddress;
	}
	public void setDetailAddress(String detailAddress) {
		this.detailAddress = detailAddress;
	}
	public String getPhone1() {
		return phone1;
	}
	public void setPhone1(String phone1) {
		this.phone1 = phone1;
	}
	public String getPhone2() {
		return phone2;
	}
	public void setPhone2(String phone2) {
		this.phone2 = phone2;
	}
	public String getDlvrpl() {
		return dlvrpl;
	}
	public void setDlvrpl(String dlvrpl) {
		this.dlvrpl = dlvrpl;
	}
	
}
