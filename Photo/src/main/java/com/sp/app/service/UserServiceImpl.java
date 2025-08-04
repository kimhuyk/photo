package com.sp.app.service;

import java.sql.SQLException;
import java.util.Map;

import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sp.app.domain.User;
import com.sp.app.mapper.UserMapper;



@Service
public class UserServiceImpl implements UserService{
	@Autowired
	private UserMapper mapper;
	
	
	@Override
	public void insertUser(User dto) throws SQLException {
		try {
			// 시퀀스번호훔쳐오기
			long seq = mapper.UserSeq();
			dto.setUserSeq(seq);
			
			mapper.insertUser1(dto);
			mapper.insertUser2(dto);
			
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		
	}
	@Transactional
	@Override
	public void updateUser(User dto) throws Exception {
		try {
			mapper.updateUser1(dto);
			mapper.updateUser2(dto);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		
	}

	@Override
	public User findById(String userId) {
		User dto = null;
		try {
			dto = mapper.findById(userId);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return dto;
	}

	@Override
	public void deleteUser(Map<String, Object> map) throws Exception {
		try {
			mapper.deleteUser(map);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

}
