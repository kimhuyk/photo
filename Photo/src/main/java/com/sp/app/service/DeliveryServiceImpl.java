package com.sp.app.service;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sp.app.domain.Delivery;
import com.sp.app.mapper.DeliveryMapper;

@Service
public class DeliveryServiceImpl implements DeliveryService{
	@Autowired
	private DeliveryMapper mapper;
	
	@Override
	public List<Delivery> listDelivery(Map<String, Object> map) {
		List<Delivery> list = null;
		try {
			list = mapper.listDelivery(map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}
	
	@Override
	public void insertDelivery(Delivery dto) throws SQLException {
		try {
			
			if (dto.getDlvrpl() == null || dto.getDlvrpl().isEmpty()) {
	            dto.setDlvrpl("N");
	        }
			
		//	long seq = mapper.deNum();
		//	dto.setDeNum(seq);
			
			mapper.insertDelivery(dto);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		
	}


	@Override
	public void updateDelivery(Delivery dto) throws SQLException {
		
		
	}

	@Override
	public void deleteDelivery(long deNum) throws SQLException {
		// TODO Auto-generated method stub
		
	}

}
