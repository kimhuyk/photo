package com.sp.app.mapper;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.sp.app.domain.Delivery;

@Mapper
public interface DeliveryMapper {
	// 배송지번호 시퀀스
	public long deNum();
	// 등록된 배송지 리스트
	public List<Delivery> listDelivery(Map<String, Object> map);
	// 배송지 등록, 수정, 삭제
	public void insertDelivery(Delivery dto) throws SQLException;
	public void updateDelivery(Delivery dto) throws SQLException;
	public void deleteDelivery(long deNum) throws SQLException;
}
