package com.sp.app.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sp.app.domain.User;
import com.sp.app.mapper.LoginMapper;

@Service
public class LoginServiceImpl implements LoginService {
	
	@Autowired
	private LoginMapper mapper;

	@Override
	public User loginUser(String userId) {
		User dto = null;
	    try {
	        System.out.println("입력된 userId: " + userId);
	        dto = mapper.loginUser(userId);
	        System.out.println("MyBatis 쿼리 실행 결과: " + dto);
	        if (dto != null) {
	            System.out.println("조회된 사용자 정보: " + dto.getUserId() 
	            							 + ", " + dto.getUserName() 
	            							 + ", " + dto.getUserPwd());
	        } else {
	            System.out.println("조회된 사용자 없음");
	        }
	    } catch (Exception e) {
	        System.out.println("로그인 처리 중 예외 발생: " + e.getMessage());
	        e.printStackTrace();
	    }
	    return dto;
	}

	
}
