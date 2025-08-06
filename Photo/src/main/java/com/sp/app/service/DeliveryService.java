package com.sp.app.service;

import java.sql.SQLException;

import com.sp.app.domain.Delivery;

public interface DeliveryService {
	// 배송지 등록
	public void insertDelivery(Delivery dto) throws SQLException;
}
