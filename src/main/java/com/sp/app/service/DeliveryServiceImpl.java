package com.sp.app.service;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

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
	@Transactional(rollbackFor = Exception.class)// unchecked exception이 발생하면 롤백하고, checked exception이 발생하면 커밋한다.
	public void insertDelivery(Delivery dto) throws SQLException {
		try {
			
			if (dto.getDlvrpl() == null || dto.getDlvrpl().isEmpty()) {
	            dto.setDlvrpl("N"); // 기본배송지가 비어있으면 n으로 체크
	        }
			if ("Y".equals(dto.getDlvrpl())) { // 기본배송지가 y면 기존 기본배송지 초기화
				mapper.defaultDelivery(dto.getUserSeq());
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
    @Transactional(rollbackFor = Exception.class)
	public void updateDelivery(Delivery dto) throws SQLException {
		try {
			if("Y".equals(dto.getDlvrpl())) {
				mapper.defaultDelivery(dto.getUserSeq()); // insert 초기화와 동일
			}
			mapper.updateDelivery(dto);
		} catch (Exception e) {
			e.printStackTrace();
            throw e;
		}
		
	}

	@Override
	public void deleteDelivery(long deNum) throws SQLException {
		try {
			mapper.deleteDelivery(deNum);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		
	}

	@Override
	public Delivery findByAddress(long deNum) {
		Delivery dto = null;
		try {
			dto = mapper.findByAddress(deNum);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return dto;
	}

}
