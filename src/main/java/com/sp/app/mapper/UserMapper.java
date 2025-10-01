package com.sp.app.mapper;

import java.sql.SQLException;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.sp.app.domain.User;

@Mapper
public interface UserMapper {
	public long UserSeq();
	
	public void insertUser1(User dto) throws SQLException; //
	public void insertUser2(User dto) throws SQLException; //
	public void insertUser12(User dto) throws SQLException; // insert all 
	
	public User findById(String userId);
	
	public void updateUser1(User dto) throws SQLException; 
	public void updateUser2(User dto) throws SQLException; 
	
//	public void deleteUser1(Map<String, Object> map) throws SQLException;
//	public void deleteUser2(Map<String, Object> map) throws SQLException;

	public void deleteUser(Map<String, Object> map) throws SQLException;
}
