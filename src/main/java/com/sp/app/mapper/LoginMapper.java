package com.sp.app.mapper;

import org.apache.ibatis.annotations.Mapper;

import com.sp.app.domain.User;

@Mapper
public interface LoginMapper {
	public User loginUser(String userId);
	public long UserSeq();
	
	
}
