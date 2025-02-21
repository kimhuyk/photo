package com.sp.app.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.sp.app.domain.User;

@Mapper
public interface SearchMapper {
	List<User> searchList(Map<String, Object> map);
}
