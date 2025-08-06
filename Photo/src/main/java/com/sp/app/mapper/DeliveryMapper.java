package com.sp.app.mapper;

import java.sql.SQLException;

import org.apache.ibatis.annotations.Mapper;

import com.sp.app.domain.Delivery;

@Mapper
public interface DeliveryMapper {
	// 배송지번호 시퀀스
	public long deNum();
	// 배송지 등록
	public void insertDelivery(Delivery dto) throws SQLException;
	
	
}
