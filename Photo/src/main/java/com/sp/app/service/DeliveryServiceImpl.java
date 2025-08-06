package com.sp.app.service;

import java.sql.SQLException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sp.app.domain.Delivery;
import com.sp.app.mapper.DeliveryMapper;

@Service
public class DeliveryServiceImpl implements DeliveryService{
	@Autowired
	private DeliveryMapper mapper;
	
	@Override
	public void insertDelivery(Delivery dto) throws SQLException {
		try {
			long seq = mapper.deNum();
			dto.setDeNum(seq);
			mapper.insertDelivery(dto);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		
	}

}
