package com.sp.app.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.sp.app.domain.Search;
import com.sp.app.domain.User;

@Mapper
public interface SearchMapper {
	//리스트
	List<User> searchList(Map<String, Object> map);
	//검색
	List<Search> searchAll(Map<String, Object> map);
}
