package com.sp.app.service;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import com.sp.app.domain.Delivery;

public interface DeliveryService {
	//등록된 배송지 리스트
	public List<Delivery> listDelivery(Map<String, Object> map);
	// 배송지 등록, 수정, 삭제
	public void insertDelivery(Delivery dto) throws SQLException;
	public void updateDelivery(Delivery dto) throws SQLException;
	public void deleteDelivery(long deNum) throws SQLException;

	public Delivery findByAddress(long deNum);
}
