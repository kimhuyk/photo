package com.sp.app.service;

import java.sql.SQLException;
import java.util.Map;

import com.sp.app.domain.User;



public interface UserService {
	// 등록
	public void insertUser(User dto) throws SQLException;
	// 업데이트
	public void updateUser(User dto) throws Exception;
	// 아디찾기? 뭐에다 쓸랬지
	public User findById(String userId);
	// 삭제
	public void deleteUser(Map<String, Object> map) throws Exception;
}
